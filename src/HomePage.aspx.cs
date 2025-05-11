using System;
using MongoDB.Driver;
using MongoDB.Bson;
using System.Linq;

namespace workHub
{
    public partial class HomePage : System.Web.UI.Page
    {
        protected string companyName = "";
        protected string companyTitle = "";
        protected string logoUrl = "";

        private IMongoCollection<BsonDocument> jobPostsCollection;
        private IMongoCollection<BsonDocument> applicationsCollection;
        private IMongoCollection<BsonDocument> seekersCollection;
        private IMongoCollection<BsonDocument> companiesCollection;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["CompanyEmail"] == null)
            {
                Response.Redirect("LoginCompany.aspx");
            }

            if (!IsPostBack)
            {
                LoadDashboardData();
            }

            // Load company info - updated version
            var client = new MongoClient("mongodb://localhost:27017");
            var database = client.GetDatabase("JobPortalDB");
            var collection = database.GetCollection<BsonDocument>("companies");

            var filter = Builders<BsonDocument>.Filter.Eq("email", Session["CompanyEmail"].ToString());
            var company = collection.Find(filter).FirstOrDefault();

            if (company != null)
            {
                companyName = company.GetValue("companyName", "Company").AsString;
                companyTitle = company.GetValue("companyTitle", companyName).AsString;
                logoUrl = company.Contains("logoPath") ? company["logoPath"].AsString : "";

                // Update session
                Session["CompanyName"] = companyName;
                Session["CompanyTitle"] = companyTitle;
                Session["CompanyLogo"] = logoUrl;
            }
            else
            {
                companyName = "Company";
                logoUrl = "";
            }
        }

        private void LoadDashboardData()
        {
            // MongoDB setup
            var client = new MongoClient("mongodb://localhost:27017");
            var db = client.GetDatabase("JobPortalDB");

            // Collections
            jobPostsCollection = db.GetCollection<BsonDocument>("JobPosts");
            applicationsCollection = db.GetCollection<BsonDocument>("JobApplications");
            seekersCollection = db.GetCollection<BsonDocument>("Seekers");
            companiesCollection = db.GetCollection<BsonDocument>("companies");

            string companyEmail = Session["CompanyEmail"]?.ToString();
            if (string.IsNullOrEmpty(companyEmail))
            {
                Response.Redirect("LoginCompany.aspx");
                return;
            }

            // Get Company Document
            var company = companiesCollection.Find(Builders<BsonDocument>.Filter.Eq("email", companyEmail)).FirstOrDefault();
            if (company == null)
            {
                Response.Write("Company not found.");
                return;
            }

            ObjectId companyId = company["_id"].AsObjectId;

            // Get all JobPosts for this company
            var jobFilter = Builders<BsonDocument>.Filter.Eq("CompanyId", companyId);
            var jobPosts = jobPostsCollection.Find(jobFilter).ToList();
            var jobIds = jobPosts.Select(j => j["_id"].AsObjectId).ToList();

            // Job Post Count
            lblJobCount.Text = jobPosts.Count.ToString();

            // Get all Applications for this company's jobs
            var appFilter = Builders<BsonDocument>.Filter.In("JobId", jobIds);
            var applications = applicationsCollection.Find(appFilter).SortByDescending(a => a["AppliedOn"]).ToList();

            // Application Count
            lblAppCount.Text = applications.Count.ToString();

            // Scheduled Interviews
            var interviewApps = applications
    .Where(a => a.Contains("Status") && a["Status"] == "Interview")
    .OrderBy(a => a.Contains("InterviewDate") ? a["InterviewDate"].ToUniversalTime() : DateTime.MaxValue)
    .Take(3)
    .ToList();

            rptInterviews.DataSource = interviewApps.Select(a =>
            {
                var seeker = seekersCollection.Find(Builders<BsonDocument>.Filter.Eq("_id", a["SeekerId"].AsObjectId)).FirstOrDefault();
                var job = jobPostsCollection.Find(Builders<BsonDocument>.Filter.Eq("_id", ObjectId.Parse(a["JobId"].ToString()))).FirstOrDefault();

                return new
                {
                    SeekerName = seeker?.GetValue("name", "Unknown Candidate").ToString(),
                    JobTitle = job?.GetValue("Title", "Unknown Position").ToString(),
                    InterviewDate = a.Contains("InterviewDate") ? a["InterviewDate"].ToUniversalTime() : DateTime.MinValue,
                    InterviewTime = a.Contains("InterviewTime") ? a["InterviewTime"].ToString() : "Time not set",
                    InterviewLink = a.Contains("InterviewLink") && !string.IsNullOrEmpty(a["InterviewLink"].ToString())
        ? a["InterviewLink"].ToString()
        : "#"
                };
            }).ToList();

            rptInterviews.DataBind();

            // Latest Messages
            var latestMessages = applications.Take(3).Select(a =>
            {
                var seeker = seekersCollection.Find(Builders<BsonDocument>.Filter.Eq("_id", a["SeekerId"].AsObjectId)).FirstOrDefault();
                return new
                {
                    Email = seeker?.GetValue("email", "Unknown").ToString(),
                    Message = a.GetValue("Message", "No message").ToString()
                };
            }).ToList();
            rptMessages.DataSource = latestMessages;
            rptMessages.DataBind();
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
