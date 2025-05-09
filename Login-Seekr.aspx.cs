using MongoDB.Bson;
using MongoDB.Driver;
using System;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;

namespace workHub
{
    public partial class Login_Seekr : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Cache.SetExpires(DateTime.MinValue);

            if (Session["SeekerEmail"] != null)
            {
                Response.Redirect("Dashboard-Seeker.aspx");
                return;
            }

            if (!IsPostBack && Session["SeekerEmail"] != null)
            {
                Session.Remove("SeekerEmail");
                Session.Remove("SeekerName");
                
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
                var collection = database.GetCollection<BsonDocument>("Seekers");

                // Find company by email
                var filter = Builders<BsonDocument>.Filter.Eq("email", email);
                var seeker = collection.Find(filter).FirstOrDefault();

                if (seeker == null)
                {
                    ShowError("No account found with this email address.");
                    return;
                }

                // Verify password by comparing hashes
                string storedHash = seeker["password"].AsString;
                string inputHash = HashPassword(password);

                if (storedHash != inputHash)
                {
                    ShowError("Invalid password. Please try again.");
                    return;
                }

                // Login successful - set session variables
                Session["SeekerEmail"] = seeker["email"].AsString;
                Session["SeekerName"] = seeker["name"].AsString;
                Session["SeekerId"] = seeker["_id"].AsObjectId.ToString();

               

                // Redirect with cache prevention
                Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
                Response.Cache.SetNoStore();
                Response.Redirect("Dashboard-Seeker.aspx", false);
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