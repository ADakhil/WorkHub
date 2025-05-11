using System;
using System.Web.UI;
using MongoDB.Driver;
using MongoDB.Bson;
using System.Security.Cryptography;
using System.Text;

namespace workHub
{
    public partial class LoginCompany : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["CompanyEmail"] != null)
            {
                Response.Redirect("HomePage.aspx"); // Or company dashboard
                return;
            }

            if (!IsPostBack && Session["CompanyEmail"] != null)
            {
                Session.Remove("CompanyEmail");
                Session.Remove("CompanyName");
                Session.Remove("CompanyLogo");
                Session.Remove("CompanyTitle");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            try
            {
                var client = new MongoClient("mongodb://localhost:27017");
                var database = client.GetDatabase("JobPortalDB");
                var collection = database.GetCollection<BsonDocument>("companies");

                // Find company by email
                var filter = Builders<BsonDocument>.Filter.Eq("email", email);
                var company = collection.Find(filter).FirstOrDefault();

                if (company == null)
                {
                    ShowError("No account found with this email address.");
                    return;
                }

                // Verify password by comparing hashes
                string storedHash = company["password"].AsString;
                string inputHash = HashPassword(password);

                if (storedHash != inputHash)
                {
                    ShowError("Invalid password. Please try again.");
                    return;
                }

                // Login successful - set session variables
                string name = company.Contains("companyName") ? company["companyName"].AsString : "";
                string logo = company.Contains("logoPath") ? company["logoPath"].AsString : "";
                string title = company.Contains("companyTitle") ? company["companyTitle"].AsString : name;

                Session["CompanyEmail"] = email;
                Session["CompanyName"] = name;
                Session["CompanyLogo"] = logo;
                Session["CompanyTitle"] = title;

                // Redirect with cache prevention
                Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
                Response.Cache.SetNoStore();
                Response.Redirect("HomePage.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                ShowError("Login failed. Please try again later.");
                // Log the error: ex.ToString()
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

        private void ShowError(string message)
        {
            errorSummary.InnerText = message;
            errorSummary.Style["display"] = "block";
        }
    }
}