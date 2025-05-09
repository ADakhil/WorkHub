using System;
using System.Web.UI.WebControls;
using MongoDB.Bson;
using MongoDB.Driver;

namespace workHub
{
    public partial class ApplyJob : System.Web.UI.Page
    {
        private readonly string connectionString = "mongodb://localhost:27017";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["SeekerEmail"] == null)
                {
                    Response.Redirect("Login-Seekr.aspx");
                    return;
                }

                string jobId = Request.QueryString["jobId"];
                if (!string.IsNullOrEmpty(jobId))
                {
                    // ... (Job details loading - remains the same) ...
                }

                // Seeker data
                string email = Session["SeekerEmail"].ToString();
                var seekerClient = new MongoClient(connectionString);
                var seekerDb = seekerClient.GetDatabase("JobPortalDB");
                var seekerCollection = seekerDb.GetCollection<BsonDocument>("Seekers");

                var filter = Builders<BsonDocument>.Filter.Eq("email", email);
                var seeker = seekerCollection.Find(filter).FirstOrDefault();

                if (seeker != null)
                {
                    txtName.Text = seeker.GetValue("name", "Your Name").ToString();
                    txtEmail.Text = seeker.GetValue("email", "example@email.com").ToString();

                    PopulateResumeDropdown(seeker);
                }
            }
        }

        private void PopulateResumeDropdown(BsonDocument seeker)
        {
            ddlResume.Items.Clear();
            ddlResume.Items.Add(new ListItem("Select your uploaded resume", ""));

            if (seeker.Contains("cv"))
            {
                if (seeker["cv"].IsBsonArray)
                {
                    var cvArray = seeker["cv"].AsBsonArray;
                    foreach (var cvPath in cvArray)
                    {
                        string fileName = System.IO.Path.GetFileName(cvPath.AsString);
                        ddlResume.Items.Add(new ListItem(fileName, cvPath.AsString));
                    }
                }
                else if (seeker["cv"].IsString && !string.IsNullOrEmpty(seeker["cv"].AsString))
                {
                    string fileName = System.IO.Path.GetFileName(seeker["cv"].AsString);
                    ddlResume.Items.Add(new ListItem(fileName, seeker["cv"].AsString));
                }
            }
            else
            {
                ddlResume.Items.Add(new ListItem("No CV uploaded yet", ""));
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string message = txtMessage.Text.Trim();
            string selectedResumeUrl = ddlResume.SelectedValue;

            if (string.IsNullOrEmpty(selectedResumeUrl))
            {
                lblCvError.Text = "Please select an existing CV.";
                lblCvError.Visible = true;
                return;
            }
            else
            {
                lblCvError.Visible = false;
            }

            string jobId = Request.QueryString["jobId"];
            if (string.IsNullOrEmpty(jobId))
            {
                Response.Write("<script>alert('Job ID is missing. Cannot apply.'); window.location='JobSearch-Seeker.aspx';</script>");
                return;
            }

            var client = new MongoClient(connectionString);
            var database = client.GetDatabase("JobPortalDB");
            var seekers = database.GetCollection<BsonDocument>("Seekers");
            var seekerFilter = Builders<BsonDocument>.Filter.Eq("email", email);
            var seeker = seekers.Find(seekerFilter).FirstOrDefault();

            if (seeker == null)
            {
                Response.Write("<script>alert('Seeker not found. Please log in again.'); window.location='Login-Seekr.aspx';</script>");
                return;
            }

            ObjectId seekerId = seeker["_id"].AsObjectId;

            // Check if the seeker already applied to this job
            var applications = database.GetCollection<BsonDocument>("JobApplications");
            var duplicateFilter = Builders<BsonDocument>.Filter.And(
                Builders<BsonDocument>.Filter.Eq("JobId", jobId),
                Builders<BsonDocument>.Filter.Eq("SeekerId", seekerId)
            );

            var existingApp = applications.Find(duplicateFilter).FirstOrDefault();
            if (existingApp != null)
            {
                Response.Write("<script>alert('You have already applied to this job.'); window.location='JobSearch-Seeker.aspx';</script>");
                return;
            }

            // Save the job application
            var application = new BsonDocument
            {
                { "SeekerId", seekerId },
                { "SeekerEmail", email },
                { "SeekerName", name },
                { "ResumeUrl", selectedResumeUrl },
                { "Message", message },
                { "JobId", ObjectId.Parse(jobId)},
                { "AppliedOn", DateTime.UtcNow },
                {"Status", "Pending" }
            };

            applications.InsertOne(application);

            Response.Write("<script>alert('Application submitted successfully!'); window.location='dashboard-seeker.aspx';</script>");
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("JobSearch-Seeker.aspx");
        }
    }
