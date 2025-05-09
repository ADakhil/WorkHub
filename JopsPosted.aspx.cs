using System;
using System.Web.UI;
using MongoDB.Driver;
using MongoDB.Bson;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Diagnostics;

namespace workHub
{
    public partial class JopsPosted : System.Web.UI.Page
    {
        protected string companyName = "";
        protected string logoUrl = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCompanyJobs();
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

        private void LoadCompanyJobs()
        {
            try
            {
                companyName = Session["CompanyName"]?.ToString();
                string companyEmail = Session["CompanyEmail"]?.ToString();
                if (string.IsNullOrEmpty(companyEmail))
                {
                    Response.Redirect("LoginCompany.aspx");
                    return;
                }

                var client = new MongoClient("mongodb://localhost:27017");
                var database = client.GetDatabase("JobPortalDB");

                var companiesCollection = database.GetCollection<BsonDocument>("companies");
                var company = companiesCollection.Find(Builders<BsonDocument>.Filter.Eq("email", companyEmail)).FirstOrDefault();

                if (company == null)
                {
                    Response.Write("Company not found.");
                    return;
                }

                ObjectId companyId = company["_id"].AsObjectId;
                var jobsCollection = database.GetCollection<BsonDocument>("JobPosts");
                var applicationsCollection = database.GetCollection<BsonDocument>("JobApplications");

                var jobs = jobsCollection.Find(Builders<BsonDocument>.Filter.Eq("CompanyId", companyId)).ToList();
                var jobList = new List<dynamic>();

                foreach (var job in jobs)
                {
                    ObjectId jobId = job["_id"].AsObjectId;
                    int applicantCount = (int)applicationsCollection.CountDocuments(Builders<BsonDocument>.Filter.Eq("JobId", jobId));
                    

                    jobList.Add(new
                    {
                        id = jobId.ToString(),
                        title = job.GetValue("Title", "").ToString(),
                        status = job.GetValue("JobStatus", "Inactive").ToString(),
                        activationDate = job.GetValue("PostedOn", "").ToLocalTime().ToString("MMM dd, yyyy"),
                        applicants = applicantCount
                    });
                }

                JobsRepeater.DataSource = jobList;
                JobsRepeater.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("Error: " + ex.Message);
            }
        }




        protected void JobsRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string jobId = e.CommandArgument.ToString();
            var client = new MongoClient("mongodb://localhost:27017");
            var database = client.GetDatabase("JobPortalDB");
            var collection = database.GetCollection<BsonDocument>("JobPosts");
            var objectId = ObjectId.Parse(jobId);

            switch (e.CommandName)
            {
                case "UpdateJob":
                    Response.Redirect("companyPostJob.aspx?jobId=" + jobId);
                    break;

                case "DeleteJob":
                    // Delete job post
                    collection.DeleteOne(Builders<BsonDocument>.Filter.Eq("_id", objectId));

                    // Also delete related job applications
                    var applicationsCollection = database.GetCollection<BsonDocument>("JobApplications");
                    applicationsCollection.DeleteMany(Builders<BsonDocument>.Filter.Eq("JobId", objectId));

                    LoadCompanyJobs();
                    break;

                
            }
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
