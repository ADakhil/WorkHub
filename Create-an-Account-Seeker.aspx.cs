using MongoDB.Bson;
using MongoDB.Driver;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net.Mail;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web.UI;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace workHub
{
    public partial class Create_an_Account_Seeker : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Cache.SetExpires(DateTime.MinValue);

            if (!IsPostBack)
            {
                // Check if user is already logged in
                if (Session["SeekerEmail"] != null)
                {
                    Response.Redirect("Dashboard-Seeker.aspx");
                }

                errorSummary.Visible = false;
            }
        }

        private string HashPassword(string password)
        {
            using (var sha256 = SHA256.Create())
            {
                var hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return BitConverter.ToString(hashedBytes).Replace("-", "").ToLower();
            }
        }

        private string HashSecurityAnswer(string answer)
        {
            // You might want to use a different hash for security answers
            using (var sha256 = SHA256.Create())
            {
                var hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(answer.ToLower().Trim()));
                return BitConverter.ToString(hashedBytes).Replace("-", "").ToLower();
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // Clear previous errors
            ClearErrors();

            bool isValid = true;
            var errorMessages = new List<string>();

            // Validate Name
            if (string.IsNullOrWhiteSpace(txtName.Text))
            {
                ShowError("nameError", "Full name is required");
                errorMessages.Add("Full name is required");
                isValid = false;
            }

            // Validate Email
            if (string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                ShowError("emailError", "Email is required");
                errorMessages.Add("Email is required");
                isValid = false;
            }
            else if (!IsValidEmail(txtEmail.Text))
            {
                ShowError("emailError", "Please enter a valid email address");
                errorMessages.Add("Please enter a valid email address");
                isValid = false;
            }

            // Validate Password
            if (string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                ShowError("passwordError", "Password is required");
                errorMessages.Add("Password is required");
                isValid = false;
            }
            else if (txtPassword.Text.Length < 8)
            {
                ShowError("passwordError", "Password must be at least 8 characters");
                errorMessages.Add("Password must be at least 8 characters");
                isValid = false;
            }

            // Validate Confirm Password
            if (string.IsNullOrWhiteSpace(txtConfirmPassword.Text))
            {
                ShowError("confirmPasswordError", "Please confirm your password");
                errorMessages.Add("Please confirm your password");
                isValid = false;
            }
            else if (txtPassword.Text != txtConfirmPassword.Text)
            {
                ShowError("confirmPasswordError", "Passwords do not match");
                errorMessages.Add("Passwords do not match");
                isValid = false;
            }

            // Validate Phone
            if (string.IsNullOrWhiteSpace(txtPhone.Text))
            {
                ShowError("phoneError", "Phone number is required");
                errorMessages.Add("Phone number is required");
                isValid = false;
            }
            else if (!IsValidPhoneNumber(txtPhone.Text))
            {
                ShowError("phoneError", "Please enter a valid phone number");
                errorMessages.Add("Please enter a valid phone number");
                isValid = false;
            }

            if (ddlSecurityQuestion.SelectedValue == "")
            {
                ShowError("securityQuestionError", "Security question is required");
                errorMessages.Add("Security question is required");
                isValid = false;
            }
            else if (ddlSecurityQuestion.SelectedValue == "custom" && string.IsNullOrWhiteSpace(txtCustomQuestion.Text))
            {
                ShowError("customQuestionError", "Custom question is required");
                errorMessages.Add("Custom question is required");
                isValid = false;
            }

            // Validate Security Answer
            if (string.IsNullOrWhiteSpace(txtSecurityAnswer.Text))
            {
                ShowError("securityAnswerError", "Security answer is required");
                errorMessages.Add("Security answer is required");
                isValid = false;
            }

            // Validate Location
            if (string.IsNullOrWhiteSpace(txtLocation.Text))
            {
                ShowError("locationError", "Location is required");
                errorMessages.Add("Location is required");
                isValid = false;
            }

            // Validate CV (optional)
            string cvRelativePath = string.Empty;
            if (fuCV.HasFile)
            {
                string fileName = Path.GetFileName(fuCV.FileName);
                string extension = Path.GetExtension(fileName)?.ToLower();

                if (extension != ".pdf" && extension != ".doc" && extension != ".docx")
                {
                    ShowError("cvError", "Only PDF, DOC, and DOCX files are allowed");
                    errorMessages.Add("Only PDF, DOC, and DOCX files are allowed");
                    isValid = false;
                }
            }

            if (!isValid)
            {
                errorSummary.Visible = true;
                errorSummary.Text = "<strong>Please correct the following errors:</strong><ul><li>" +
                    string.Join("</li><li>", errorMessages) + "</li></ul>";
                return;
            }



            // Proceed with registration if validation passes
            RegisterSeeker();
        }

        private void RegisterSeeker()
        {
            try
            {
                var client = new MongoClient("mongodb://localhost:27017");
                var database = client.GetDatabase("JobPortalDB");
                var collection = database.GetCollection<BsonDocument>("Seekers");

                string securityQuestion = ddlSecurityQuestion.SelectedValue;
                string securityAnswer = txtSecurityAnswer.Text.Trim();

                if (securityQuestion == "custom")
                {
                    securityQuestion = txtCustomQuestion.Text.Trim();
                }

                string hashedPassword = HashPassword(txtPassword.Text);
                string hashedSecurityAnswer = HashSecurityAnswer(securityAnswer);

                // Check if email already exists
                var filter = Builders<BsonDocument>.Filter.Eq("email", txtEmail.Text);
                var existingSeeker = collection.Find(filter).FirstOrDefault();

                if (existingSeeker != null)
                {
                    ShowError("emailError", "A seeker with this email already exists");
                    errorSummary.Visible = true;
                    errorSummary.Text = "A seeker with this email already exists. Please log in instead.";
                    return;
                }

                // Handle CV upload
                string cvPath = string.Empty;
                if (fuCV.HasFile)
                {
                    string fileName = Path.GetFileName(fuCV.FileName);
                    string uploadFolder = Server.MapPath("~/Uploads/CVs/");

                    if (!Directory.Exists(uploadFolder))
                        Directory.CreateDirectory(uploadFolder);

                    string filePath = Path.Combine(uploadFolder, fileName);
                    fuCV.SaveAs(filePath);
                    cvPath = "~/Uploads/CVs/" + fileName;
                }

                // Create new seeker document
                var doc = new BsonDocument
                {
                    { "name", txtName.Text.Trim() },
                    { "email", txtEmail.Text.Trim() },
                    { "password", hashedPassword },
            { "securityQuestion", securityQuestion },
            { "securityAnswer", hashedSecurityAnswer }, // Note: In production, hash this password
                    { "phone", ddlPhoneCode.SelectedValue + txtPhone.Text.Trim() },
                    { "location", txtLocation.Text.Trim() },
                    { "cv", cvPath },
                    { "createdAt", DateTime.UtcNow }
                };

                collection.InsertOne(doc);

                // Create session
                Session["SeekerEmail"] = txtEmail.Text;
                Session["SeekerName"] = txtName.Text;

                // Redirect to dashboard
                Response.Redirect("Dashboard-Seeker.aspx");
            }
            catch (Exception ex)
            {
                errorSummary.Visible = true;
                errorSummary.Text = "An error occurred during registration. Please try again.";
                // Log the error: ex.ToString()
            }
        }

        private void ClearErrors()
        {
            errorSummary.Visible = false;

            // Clear all error messages
            var controls = new List<Control> { nameError, emailError, passwordError,
                confirmPasswordError, phoneError, locationError, cvError };

            foreach (var control in controls)
            {
                if (control is HtmlGenericControl span)
                {
                    span.InnerText = "";
                    span.Style["display"] = "none";
                }
                else if (control is Label label)
                {
                    label.Text = "";
                    label.Visible = false;
                }
            }
        }

        private void ShowError(string controlId, string message)
        {
            Control control = FindControl(controlId);
            if (control != null)
            {
                if (control is HtmlGenericControl span)
                {
                    span.InnerText = message;
                    span.Style["display"] = "block";
                }
                else if (control is Label label)
                {
                    label.Text = message;
                    label.Visible = true;
                }
            }
        }

        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }

        private bool IsValidPhoneNumber(string phone)
        {
            return System.Text.RegularExpressions.Regex.IsMatch(phone, @"^[0-9]{8,15}$");
        }
    }
}