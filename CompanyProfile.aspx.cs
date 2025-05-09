using System;
using System.IO;
using MongoDB.Bson;
using MongoDB.Driver;

namespace workHub
{
    public partial class CompanyProfile : System.Web.UI.Page
    {
        protected string companyName = "";
        protected string logoUrl = "";
        protected string posterUrl = "";
        protected bool posterActive = true;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["CompanyEmail"] == null)
            {
                Response.Redirect("loginCompany.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCompanyData();
            }

            var client = new MongoClient("mongodb://localhost:27017");
            var database = client.GetDatabase("JobPortalDB");
            var collection = database.GetCollection<BsonDocument>("companies");

            var filter = Builders<BsonDocument>.Filter.Eq("email", Session["CompanyEmail"].ToString());
            var company = collection.Find(filter).FirstOrDefault();

            if (company != null)
            {
                companyName = company.GetValue("companyName", "Company").AsString;
                logoUrl = company.Contains("logoPath") ? company["logoPath"].AsString : "";
                posterUrl = company.Contains("posterPath") ? company["posterPath"].AsString : "";
                posterActive = company.Contains("posterActive") ? company["posterActive"].AsBoolean : true;

                // Update session
                Session["CompanyName"] = companyName;
                Session["CompanyLogo"] = logoUrl;
            }
            else
            {
                companyName = "Company";
                logoUrl = "";
            }
        }

        private void LoadCompanyData()
        {
            companyName = Session["CompanyName"]?.ToString();
            var client = new MongoClient("mongodb://localhost:27017");
            var database = client.GetDatabase("JobPortalDB");
            var companiesCollection = database.GetCollection<BsonDocument>("companies");

            var filter = Builders<BsonDocument>.Filter.Eq("email", Session["CompanyEmail"].ToString());
            var company = companiesCollection.Find(filter).FirstOrDefault();

            if (company != null)
            {
                lblEmail.Text = company.GetValue("email", "").ToString();
                txtCompanyName.Text = company.GetValue("companyName", "").ToString();
                txtPhone.Text = company.GetValue("phone", "").ToString();
                txtWebsite.Text = company.GetValue("website", "").ToString();
                txtLocation.Text = company.GetValue("location", "").ToString();
                txtIndustry.Text = company.GetValue("industry", "").ToString();
                txtDescription.Text = company.GetValue("description", "").ToString();
                chkPosterActive.Checked = company.Contains("posterActive") ? company["posterActive"].AsBoolean : true;
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            var client = new MongoClient("mongodb://localhost:27017");
            var database = client.GetDatabase("JobPortalDB");
            var companiesCollection = database.GetCollection<BsonDocument>("companies");


            var filter = Builders<BsonDocument>.Filter.Eq("email", Session["CompanyEmail"].ToString());

            // Handle logo upload
            string logoPath = Session["CompanyLogo"]?.ToString() ?? "";
            string posterPath = Session["PosterPath"]?.ToString() ?? "";
            bool posterActive = chkPosterActive.Checked;

            if (posterUpload.HasFile)
            {
                try
                {
                    string fileName = Path.GetFileName(posterUpload.FileName);
                    string extension = Path.GetExtension(fileName).ToLower();

                    // Validate file type
                    if (extension != ".jpg" && extension != ".jpeg" && extension != ".png")
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Only JPG, JPEG, and PNG files are allowed for posters.');", true);
                        return;
                    }

                    // Validate file size (5MB max)
                    if (posterUpload.PostedFile.ContentLength > 5 * 1024 * 1024)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Poster file size must be less than 5MB.');", true);
                        return;
                    }

                    string uploadFolder = Server.MapPath("~/uploads/posters/");
                    if (!Directory.Exists(uploadFolder))
                        Directory.CreateDirectory(uploadFolder);

                    // Generate unique filename
                    string uniqueFileName = Guid.NewGuid().ToString() + extension;
                    string filePath = Path.Combine(uploadFolder, uniqueFileName);
                    posterUpload.SaveAs(filePath);
                    posterPath = "uploads/posters/" + uniqueFileName;
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        $"alert('Error uploading poster: {ex.Message}');", true);
                    return;
                }
            }

            if (logoUpload.HasFile)
            {

                string extension = Path.GetExtension(logoUpload.FileName).ToLower();
                if (extension != ".jpg" && extension != ".jpeg" && extension != ".png")
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Only JPG, JPEG, and PNG files are allowed.');", true);
                    return;
                }

                if (logoUpload.PostedFile.ContentLength > 2 * 1024 * 1024) // 2MB limit
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Logo file size must be less than 2MB.');", true);
                    return;
                }

                try
                {
                    string fileName = Path.GetFileName(logoUpload.FileName);
                    string uploadFolder = Server.MapPath("~/uploads/");

                    if (!Directory.Exists(uploadFolder))
                        Directory.CreateDirectory(uploadFolder);

                    string filePath = Path.Combine(uploadFolder, fileName);
                    logoUpload.SaveAs(filePath);
                    logoPath = "uploads/" + fileName;
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        $"alert('Error uploading logo: {ex.Message}');", true);
                    return;
                }
            }

            // Create update definition
            var update = Builders<BsonDocument>.Update
                .Set("companyName", txtCompanyName.Text.Trim())
                .Set("phone", txtPhone.Text.Trim())
                .Set("website", txtWebsite.Text.Trim())
                .Set("location", txtLocation.Text.Trim())
                .Set("industry", txtIndustry.Text.Trim())
                .Set("description", txtDescription.Text.Trim())
                .Set("posterActive", posterActive); ;


            // Only update logoPath if a new logo was uploaded
            if (logoUpload.HasFile)
            {
                update = update.Set("logoPath", logoPath);
            }
            if (posterUpload.HasFile)
            {
                update = update.Set("posterPath", posterPath);
            }

            try
            {
                var result = companiesCollection.UpdateOne(filter, update);

                if (result.ModifiedCount > 0)
                {
                    // Update session with new values
                    Session["CompanyName"] = txtCompanyName.Text.Trim();
                    Session["CompanyLogo"] = logoPath;
                    Session["PosterPath"] = posterPath;

                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Company profile updated successfully!'); window.location.href = window.location.href;", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('No changes were made to your profile.');", true);
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error updating profile: {ex.Message}');", true);
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("HomePage.aspx");
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear(); // or Session.Abandon();

            // Send script to redirect AND refresh the page to prevent back button access
            string script = @"
        <script type='text/javascript'>
            sessionStorage.clear(); // clear any frontend storage if used
            window.location.replace('LoginCompany.aspx');
        </script>";
            Response.Write(script);
            Response.End();
        }
    }
}