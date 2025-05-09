using System;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using MongoDB.Bson;
using MongoDB.Driver;

namespace workHub
{
    public partial class interview2 : System.Web.UI.Page
    {
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

            if (!IsPostBack)
            {
                LoadSeekerInfo();
                LoadInterviews();
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
                lblUserName.Text = seeker.GetValue("name", "User").ToString();
                
            }
        }

        private void LoadInterviews(string statusFilter = "All", string searchTerm = "")
        {
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

            // Base filter for seeker's applications with interview status
            var filter = Builders<BsonDocument>.Filter.Eq("SeekerEmail", seekerEmail);
            filter &= Builders<BsonDocument>.Filter.Eq("Status", "Interview");

            // Apply additional filters
            if (statusFilter == "Upcoming")
            {
                filter &= Builders<BsonDocument>.Filter.Gte("InterviewDate", DateTime.UtcNow);
            }
            else if (statusFilter == "Completed")
            {
                filter &= Builders<BsonDocument>.Filter.Lt("InterviewDate", DateTime.UtcNow);
            }

            if (!string.IsNullOrEmpty(searchTerm))
            {
                var jobFilter = Builders<BsonDocument>.Filter.Text(searchTerm);
                var matchingJobIds = jobsCollection.Find(jobFilter)
                    .Project<ObjectId>(Builders<BsonDocument>.Projection.Include("_id"))
                    .ToList();

                filter &= Builders<BsonDocument>.Filter.In("JobId", matchingJobIds);
            }

            var interviews = applicationsCollection.Find(filter).ToList();

            var interviewData = interviews.Select(interview =>
            {
                var jobId = interview["JobId"].AsObjectId;
                var job = jobsCollection.Find(Builders<BsonDocument>.Filter.Eq("_id", jobId)).FirstOrDefault();
                var companyId = job?["CompanyId"].AsObjectId;
                var company = companiesCollection.Find(Builders<BsonDocument>.Filter.Eq("_id", companyId)).FirstOrDefault();

                return new
                {
                    JobId = jobId.ToString(),
                    JobTitle = job?.GetValue("Title", "Unknown Position").ToString(),
                    CompanyName = company?.GetValue("companyName", "Unknown Company").ToString(),
                    CompanyLogo = company?.GetValue("logoPath", "").ToString(),
                    Location = job?.GetValue("Location", "Unknown Location").ToString(),
                    JobType = job?.GetValue("JobType", "").ToString(),
                    InterviewDate = interview["InterviewDate"].ToUniversalTime(),
                    InterviewTime = interview.GetValue("InterviewTime", "").ToString(),
                    InterviewLink = interview.GetValue("InterviewLink", "").ToString(),
                    Status = interview["InterviewDate"].ToUniversalTime() >= DateTime.UtcNow ? "Upcoming" : "Completed"
                };
            }).OrderBy(i => i.InterviewDate).ToList();

            rptInterviews.DataSource = interviewData;
            rptInterviews.DataBind();

            lblNoInterviews.Visible = !interviewData.Any();
        }

        protected void ddlStatusFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadInterviews(ddlStatusFilter.SelectedValue, txtSearch.Text);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadInterviews(ddlStatusFilter.SelectedValue, txtSearch.Text);
        }

        protected void btnJoinInterview_Click(object sender, EventArgs e)
        {
            var btn = (Button)sender;
            var interviewLink = btn.CommandArgument;

            if (!string.IsNullOrEmpty(interviewLink))
            {
                if (!interviewLink.StartsWith("http"))
                {
                    interviewLink = "https://" + interviewLink;
                }
                Response.Redirect(interviewLink);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "alert('Interview link not available.');", true);
            }
        }

        protected void btnViewJob_Click(object sender, EventArgs e)
        {
            var btn = (Button)sender;
            var jobId = btn.CommandArgument;
            Response.Redirect($"JobDetails.aspx?id={jobId}");
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