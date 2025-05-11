using System;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using MongoDB.Bson;
using MongoDB.Driver;

namespace workHub
{
    public partial class applications_Seeker : System.Web.UI.Page
    {
        protected string seekerName = "";
        private IMongoCollection<BsonDocument> applicationsCollection;
        private IMongoCollection<BsonDocument> jobsCollection;
        private IMongoCollection<BsonDocument> companiesCollection;
        private IMongoCollection<BsonDocument> seekersCollection;

        protected void Page_Load(object sender, EventArgs e)
        {

            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));

            if (Session["SeekerEmail"] == null)
            {
                Response.Redirect("Login-Seekr.aspx");
                return;
            }

            if (Session["SeekerName"] == null)
            {
                seekerName = Session["SeekerName"].ToString();
            }

            if (!IsPostBack)
            {
                LoadSeekerInfo();
                LoadApplications();
            }
        }

        private void LoadSeekerInfo()
        {
            var client = new MongoClient("mongodb://localhost:27017");
            var database = client.GetDatabase("JobPortalDB");
            seekersCollection = database.GetCollection<BsonDocument>("Seekers");

            var filter = Builders<BsonDocument>.Filter.Eq("email", Session["SeekerEmail"].ToString());
            var seeker = seekersCollection.Find(filter).FirstOrDefault();

            if (seeker != null)
            {
                seekerName = seeker.GetValue("name", "User").ToString();
            }
        }

        private void LoadApplications(string statusFilter = "All")
        {
            seekerName = Session["SeekerName"].ToString();
            var client = new MongoClient("mongodb://localhost:27017");
            var db = client.GetDatabase("JobPortalDB");

            applicationsCollection = db.GetCollection<BsonDocument>("JobApplications");
            jobsCollection = db.GetCollection<BsonDocument>("JobPosts");
            companiesCollection = db.GetCollection<BsonDocument>("companies");

            string seekerEmail = Session["SeekerEmail"]?.ToString();
            if (string.IsNullOrEmpty(seekerEmail))
            {
                Response.Redirect("loginSeeker.aspx");
                return;
            }

            var filter = Builders<BsonDocument>.Filter.Eq("SeekerEmail", seekerEmail);

            if (statusFilter != "All")
            {
                filter &= Builders<BsonDocument>.Filter.Eq("Status", statusFilter);
            }

            var applications = applicationsCollection.Find(filter).ToList();

            var applicationData = applications.Select(app =>
            {
                // Safely get JobId with null check
                ObjectId jobId = ObjectId.Empty;
                if (app.Contains("JobId") && !string.IsNullOrEmpty(app["JobId"].ToString()))
                {
                    ObjectId.TryParse(app["JobId"].ToString(), out jobId);
                }

                var job = jobId != ObjectId.Empty ?
                    jobsCollection.Find(Builders<BsonDocument>.Filter.Eq("_id", jobId)).FirstOrDefault() :
                    null;

                // Safely get CompanyId with null checks
                ObjectId companyId = ObjectId.Empty;
                if (job != null && job.Contains("CompanyId"))
                {
                    companyId = job["CompanyId"].AsObjectId;
                }

                var company = companyId != ObjectId.Empty ?
                    companiesCollection.Find(Builders<BsonDocument>.Filter.Eq("_id", companyId)).FirstOrDefault() :
                    null;

                return new
                {
                    _id = app["_id"].ToString(),
                    JobTitle = job?.GetValue("Title", "Unknown Position").ToString(),
                    CompanyName = company?.GetValue("companyName", "Unknown Company").ToString(),
                    JobType = job?.GetValue("JobType", "Not specified").ToString(),
                    Message = app.GetValue("Message", "No message provided").ToString(),
                    AppliedOn = app.GetValue("AppliedOn", BsonNull.Value).ToUniversalTime(),
                    Status = app.GetValue("Status", "Pending").ToString(),
                    InterviewDate = app.Contains("InterviewDate") ? app["InterviewDate"].ToUniversalTime() : (DateTime?)null,
                    InterviewTime = app.Contains("InterviewTime") ? app["InterviewTime"].ToString() : "",
                    InterviewLink = app.Contains("InterviewLink") ? app["InterviewLink"].ToString() : ""
                };
            }).Where(app => app.JobTitle != "Unknown Position").ToList(); // Filter out invalid applications

            rptApplications.DataSource = applicationData;
            rptApplications.DataBind();

            lblNoResults.Visible = !applicationData.Any();
        }

        protected void ddlStatusFilter_SelectedIndexChanged(object sender, EventArgs e)
        {

            LoadApplications(ddlStatusFilter.SelectedValue);
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear(); // or Session.Abandon();

            // Send script to redirect AND refresh the page to prevent back button access
            string script = @"
        <script type='text/javascript'>
            sessionStorage.clear(); // clear any frontend storage if used
            window.location.replace('Login-Seekr.aspx');
        </script>";
            Response.Write(script);
            Response.End();
        }
    }
}