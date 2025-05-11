using System;
using System.Web.UI.WebControls;
using MongoDB.Driver;
using MongoDB.Bson;
using System.IO;
using System.Net.Mail;
using System.Collections.Generic;
using System.Web.UI.HtmlControls;
using System.Web.UI;
using System.Security.Cryptography;
using System.Text;

namespace workHub
{
    public partial class CreAccCom : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is already logged in
                if (Session["CompanyEmail"] != null)
                {
                    Response.Redirect("HomePage.aspx");
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

            // Validate Company Name
            if (string.IsNullOrWhiteSpace(companyName.Text))
            {
                ShowError("companyNameError", "Company name is required");
                errorMessages.Add("Company name is required");
                isValid = false;
            }

            // Validate Email
            if (string.IsNullOrWhiteSpace(emailAddress.Text))
            {
                ShowError("emailAddressError", "Email is required");
                errorMessages.Add("Email is required");
                isValid = false;
            }
            else if (!IsValidEmail(emailAddress.Text))
            {
                ShowError("emailAddressError", "Please enter a valid email address");
                errorMessages.Add("Please enter a valid email address");
                isValid = false;
            }

            // Validate Password
            if (string.IsNullOrWhiteSpace(password.Text))
            {
                ShowError("passwordError", "Password is required");
                errorMessages.Add("Password is required");
                isValid = false;
            }
            else if (password.Text.Length < 8)
            {
                ShowError("passwordError", "Password must be at least 8 characters");
                errorMessages.Add("Password must be at least 8 characters");
                isValid = false;
            }

            // Validate Confirm Password
            if (string.IsNullOrWhiteSpace(confirmPassword.Text))
            {
                ShowError("confirmPasswordError", "Please confirm your password");
                errorMessages.Add("Please confirm your password");
                isValid = false;
            }
            else if (password.Text != confirmPassword.Text)
            {
                ShowError("confirmPasswordError", "Passwords do not match");
                errorMessages.Add("Passwords do not match");
                isValid = false;
            }

            // Validate Phone Number
            if (string.IsNullOrWhiteSpace(phoneNumber.Text))
            {
                ShowError("phoneNumberError", "Phone number is required");
                errorMessages.Add("Phone number is required");
                isValid = false;
            }
            else if (!IsValidPhoneNumber(phoneNumber.Text))
            {
                ShowError("phoneNumberError", "Please enter a valid phone number");
                errorMessages.Add("Please enter a valid phone number");
                isValid = false;
            }

            // Validate Website (optional)
            if (!string.IsNullOrWhiteSpace(website.Text) && !IsValidUrl(website.Text))
            {
                ShowError("websiteError", "Please enter a valid website URL");
                errorMessages.Add("Please enter a valid website URL");
                isValid = false;
            }

            // Validate Industry
            if (string.IsNullOrWhiteSpace(industry.Text))
            {
                ShowError("industryError", "Industry is required");
                errorMessages.Add("Industry is required");
                isValid = false;
            }

            // Validate Location
            if (string.IsNullOrWhiteSpace(location.Text))
            {
                ShowError("locationError", "Location is required");
                errorMessages.Add("Location is required");
                isValid = false;
            }

            // Validate Logo (optional)
            string logoPath = string.Empty;
            if (logoUpload.HasFile)
            {
                string fileName = Path.GetFileName(logoUpload.FileName);
                string extension = Path.GetExtension(fileName)?.ToLower();

                if (extension != ".jpg" && extension != ".jpeg" && extension != ".png")
                {
                    ShowError("logoUploadError", "Only JPG, JPEG, and PNG files are allowed");
                    errorMessages.Add("Only JPG, JPEG, and PNG files are allowed");
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

            // Proceed with registration if validation passes
            RegisterCompany();
        }

        private void RegisterCompany()
        {
            try
            {
                string company = companyName.Text.Trim();
                string email = emailAddress.Text.Trim();
                string pass = password.Text;
                string phone = countryCode.SelectedValue + phoneNumber.Text.Trim();
                string web = website.Text.Trim();
                string field = industry.Text.Trim();
                string city = location.Text.Trim();
                string logoPath = string.Empty;
                string securityQuestion = ddlSecurityQuestion.SelectedValue;
                string securityAnswer = txtSecurityAnswer.Text.Trim();

                if (securityQuestion == "custom")
                {
                    securityQuestion = txtCustomQuestion.Text.Trim();
                }

                string hashedPassword = HashPassword(password.Text);
                string hashedSecurityAnswer = HashSecurityAnswer(securityAnswer);

                // Handle logo upload
                if (logoUpload.HasFile)
                {
                    string fileName = Path.GetFileName(logoUpload.FileName);
                    string uploadFolder = Server.MapPath("~/uploads/");

                    if (!Directory.Exists(uploadFolder))
                        Directory.CreateDirectory(uploadFolder);

                    string filePath = Path.Combine(uploadFolder, fileName);
                    logoUpload.SaveAs(filePath);
                    logoPath = "uploads/" + fileName;
                }

                var client = new MongoClient("mongodb://localhost:27017");
                var database = client.GetDatabase("JobPortalDB");
                var collection = database.GetCollection<BsonDocument>("companies");

                // Check if email already exists
                var filter = Builders<BsonDocument>.Filter.Eq("email", email);
                var existingCompany = collection.Find(filter).FirstOrDefault();

                if (existingCompany != null)
                {
                    ShowError("emailAddressError", "A company with this email already exists");
                    errorSummary.Visible = true;
                    errorSummary.Text = "A company with this email already exists. Please log in instead.";
                    return;
                }

                // Create new company document
                var doc = new BsonDocument
                {
                    { "companyName", company },
                    { "email", email },
                   { "password", hashedPassword },
            { "securityQuestion", securityQuestion },
            { "securityAnswer", hashedSecurityAnswer }, // Note: In production, hash this password
                    { "phone", phone },
                    { "website", web },
                    { "industry", field },
                    { "location", city },
                    { "createdAt", DateTime.UtcNow }
                };

                if (!string.IsNullOrEmpty(logoPath))
                {
                    doc.Add("logoPath", logoPath);
                }

                collection.InsertOne(doc);

                // Create session
                Session["CompanyEmail"] = email;
                Session["CompanyName"] = company;
                Session["CompanyLogo"] = logoPath;
                Session["CompanyTitle"] = company;

                // Redirect to homepage
                Response.Redirect("HomePage.aspx");
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
            var controls = new List<Control> { companyNameError, emailAddressError, passwordError,
                confirmPasswordError, phoneNumberError, websiteError, industryError,
                locationError, logoUploadError };

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

        private bool IsValidUrl(string url)
        {
            return Uri.TryCreate(url, UriKind.Absolute, out Uri uriResult)
                && (uriResult.Scheme == Uri.UriSchemeHttp || uriResult.Scheme == Uri.UriSchemeHttps);
        }
    }
}