using System;
using System.Web.UI;
using MongoDB.Driver;
using MongoDB.Bson;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI.HtmlControls;

namespace workHub
{
    public partial class ForgotPasswordSeeker : System.Web.UI.Page
    {
        protected HtmlGenericControl successMessage; // Add this line

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                errorSummary.Visible = false;
                successMessage.Style["display"] = "none"; // Initialize as hidden
                btnResetPassword.Visible = false;
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            try
            {
                errorSummary.Visible = false;
                string email = txtEmail.Text.Trim();

                if (string.IsNullOrEmpty(email))
                {
                    ShowError("emailError", "Email is required");
                    return;
                }

                var client = new MongoClient("mongodb://localhost:27017");
                var database = client.GetDatabase("JobPortalDB");
                var collection = database.GetCollection<BsonDocument>("Seekers");

                var filter = Builders<BsonDocument>.Filter.Eq("email", email);
                var seeker = collection.Find(filter).FirstOrDefault();

                if (seeker == null)
                {
                    ShowError("emailError", "No account found with this email");
                    return;
                }

                // Show security question
                lblSecurityQuestion.Text = seeker.GetValue("securityQuestion", "Your security question").ToString();
                hdnSecurityQuestion.Value = lblSecurityQuestion.Text;

                emailSection.Visible = false;
                securityQuestionSection.Visible = true;
                newPasswordSection.Visible = true;
                confirmPasswordSection.Visible = true;
                btnNext.Visible = false;
                btnResetPassword.Visible = true;

                // Store email in view state for next step
                ViewState["Email"] = email;
            }
            catch (Exception ex)
            {
                errorSummary.Visible = true;
                errorSummary.InnerText = "An error occurred. Please try again.";
                // Log error: ex.ToString()
            }
        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            try
            {
                errorSummary.Visible = false;

                // Validate inputs
                bool isValid = true;

                if (string.IsNullOrEmpty(txtSecurityAnswer.Text))
                {
                    ShowError("securityAnswerError", "Security answer is required");
                    isValid = false;
                }

                if (string.IsNullOrEmpty(txtNewPassword.Text))
                {
                    ShowError("newPasswordError", "New password is required");
                    isValid = false;
                }
                else if (txtNewPassword.Text.Length < 8)
                {
                    ShowError("newPasswordError", "Password must be at least 8 characters");
                    isValid = false;
                }

                if (string.IsNullOrEmpty(txtConfirmPassword.Text))
                {
                    ShowError("confirmPasswordError", "Please confirm your password");
                    isValid = false;
                }
                else if (txtNewPassword.Text != txtConfirmPassword.Text)
                {
                    ShowError("confirmPasswordError", "Passwords do not match");
                    isValid = false;
                }

                if (!isValid) return;

                string email = ViewState["Email"].ToString();
                string securityAnswer = txtSecurityAnswer.Text.Trim();
                string newPassword = txtNewPassword.Text;

                var client = new MongoClient("mongodb://localhost:27017");
                var database = client.GetDatabase("JobPortalDB");
                var collection = database.GetCollection<BsonDocument>("Seekers");

                var filter = Builders<BsonDocument>.Filter.Eq("email", email);
                var seeker = collection.Find(filter).FirstOrDefault();

                if (seeker == null)
                {
                    ShowError("", "Account not found. Please try again.");
                    return;
                }

                // Verify security answer (compare hashes)
                string storedHashedAnswer = seeker.GetValue("securityAnswer", "").ToString();
                string inputHashedAnswer = HashSecurityAnswer(securityAnswer);

                if (storedHashedAnswer != inputHashedAnswer)
                {
                    ShowError("securityAnswerError", "Incorrect security answer");
                    return;
                }

                // Update password
                var hashedPassword = HashPassword(newPassword);
                var update = Builders<BsonDocument>.Update.Set("password", hashedPassword);
                collection.UpdateOne(filter, update);

                // Show success message
                successMessage.Style["display"] = "block";
                successMessage.InnerHtml = "<strong>Success!</strong> Password reset successfully! You can now login with your new password.";

                // Hide form
                securityQuestionSection.Visible = false;
                newPasswordSection.Visible = false;
                confirmPasswordSection.Visible = false;
                btnResetPassword.Visible = false;

                emailSection.Visible = false;

                ClientScript.RegisterStartupScript(this.GetType(), "redirect",
   "setTimeout(function(){ window.location.href = 'Login-Seekr.aspx'; }, 3000);", true);
            }
            catch (Exception ex)
            {
                errorSummary.Visible = true;
                errorSummary.InnerText = "An error occurred. Please try again.";
                // Log error: ex.ToString()
            }
        }

        private string HashSecurityAnswer(string answer)
        {
            using (var sha256 = SHA256.Create())
            {
                var hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(answer.ToLower().Trim()));
                return BitConverter.ToString(hashedBytes).Replace("-", "").ToLower();
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

        private void ShowError(string controlId, string message)
        {
            if (string.IsNullOrEmpty(controlId))
            {
                errorSummary.Visible = true;
                errorSummary.InnerText = message;
            }
            else
            {
                Control control = FindControl(controlId);
                if (control is HtmlGenericControl span)
                {
                    span.Style["display"] = "block";
                    span.InnerText = message;
                }
            }
        }
    }
}