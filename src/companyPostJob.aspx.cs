using System;
using System.Web.UI;
using MongoDB.Bson;
using MongoDB.Driver;

namespace workHub
{
    public partial class companyPostJob : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["CompanyEmail"] == null)
            {
                Response.Redirect("LoginCompany.aspx");
                return;
            }

            if (!IsPostBack && Request.QueryString["jobId"] != null)
            {
                string jobId = Request.QueryString["jobId"];
                LoadJobData(jobId);
            }
        }

        private void LoadJobData(string jobId)
        {
            var client = new MongoClient("mongodb://localhost:27017");
            var database = client.GetDatabase("JobPortalDB");
            var jobsCollection = database.GetCollection<BsonDocument>("JobPosts");

            var job = jobsCollection.Find(Builders<BsonDocument>.Filter.Eq("_id", ObjectId.Parse(jobId))).FirstOrDefault();

            if (job != null)
            {
                txtTitle.Text = job.GetValue("Title", "").AsString;
                ddlJobStatus.SelectedValue = job.GetValue("JobStatus", "").AsString;
                txtDepartment.Text = job.GetValue("Department", "").AsString;
                ddlExperienceLevel.SelectedValue = job.GetValue("ExperienceLevel", "").AsString;
                txtCountry.Text = job.GetValue("Country", "").AsString;
                txtLocation.Text = job.GetValue("Location", "").AsString;
                txtCity.Text = job.GetValue("City", "").AsString;
                txtSalary.Text = job.GetValue("Salary", BsonNull.Value).IsBsonNull ? "" : job["Salary"].ToString();
                ddlJobType.SelectedValue = job.GetValue("JobType", "").AsString;
                txtJobSummary.Text = job.GetValue("JobSummary", "").AsString;
                txtKeyResponsibilities.Text = job.GetValue("KeyResponsibilities", "").AsString;
                txtRequiredQualifications.Text = job.GetValue("RequiredQualifications", "").AsString;
                txtPreferredQualifications.Text = job.GetValue("PreferredQualifications", "").AsString;
                txtSkillsNeeded.Text = job.GetValue("SkillsNeeded", "").AsString;
                txtWorkEnvironment.Text = job.GetValue("WorkEnvironment", "").AsString;
                txtBenefits.Text = job.GetValue("Benefits", "").AsString;
                txtApplicationSubmission.Text = job.GetValue("ApplicationSubmission", "").AsString;
                txtApplicationDeadline.Text = job.GetValue("ApplicationDeadline", "").AsString;
                txtOfferProcess.Text = job.GetValue("OfferProcess", "").AsString;
                txtInterviewProcess.Text = job.GetValue("InterviewProcess", "").AsString;
                txtAssessmentTasks.Text = job.GetValue("AssessmentTasks", "").AsString;
                txtAdditionalNotes.Text = job.GetValue("AdditionalNotes", "").AsString;
                chkTerms.Checked = job.GetValue("TermsAccepted", false).ToBoolean();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string companyEmail = Session["CompanyEmail"]?.ToString();
            if (string.IsNullOrEmpty(companyEmail))
            {
                Response.Redirect("LoginCompany.aspx");
                return;
            }

            var client = new MongoClient("mongodb://localhost:27017");
            var database = client.GetDatabase("JobPortalDB");

            // Get the company by email
            var companiesCollection = database.GetCollection<BsonDocument>("companies");
            var company = companiesCollection.Find(Builders<BsonDocument>.Filter.Eq("email", companyEmail)).FirstOrDefault();

            if (company == null)
            {
                lblMessage.Text = "Company not found.";
                return;
            }

            ObjectId companyId = company["_id"].AsObjectId;

            BsonValue salaryValue;
            if (int.TryParse(txtSalary.Text, out int parsedSalary))
            {
                salaryValue = new BsonInt32(parsedSalary);
            }
            else
            {
                salaryValue = BsonNull.Value;
            }

            var jobDocument = new BsonDocument
            {
                { "CompanyId", companyId },
                { "Title", txtTitle.Text },
                { "JobStatus", ddlJobStatus.SelectedValue },
                { "Department", txtDepartment.Text },
                { "ExperienceLevel", ddlExperienceLevel.SelectedValue },
                { "Country", txtCountry.Text },
                { "Location", txtLocation.Text },
                { "City", txtCity.Text },
                { "Salary", salaryValue },
                { "JobType", ddlJobType.SelectedValue },
                { "JobSummary", txtJobSummary.Text },
                { "KeyResponsibilities", txtKeyResponsibilities.Text },
                { "RequiredQualifications", txtRequiredQualifications.Text },
                { "PreferredQualifications", txtPreferredQualifications.Text },
                { "SkillsNeeded", txtSkillsNeeded.Text },
                { "WorkEnvironment", txtWorkEnvironment.Text },
                { "Benefits", txtBenefits.Text },
                { "ApplicationSubmission", txtApplicationSubmission.Text },
                { "ApplicationDeadline", txtApplicationDeadline.Text },
                { "OfferProcess", txtOfferProcess.Text },
                { "InterviewProcess", txtInterviewProcess.Text },
                { "AssessmentTasks", txtAssessmentTasks.Text },
                { "AdditionalNotes", txtAdditionalNotes.Text },
                { "TermsAccepted", chkTerms.Checked },
                { "PostedOn", DateTime.Now }
            };

            var jobsCollection = database.GetCollection<BsonDocument>("JobPosts");

            // Check if we're updating
            string jobId = Request.QueryString["jobId"];
            if (!string.IsNullOrEmpty(jobId))
            {
                // Update existing job
                var filter = Builders<BsonDocument>.Filter.Eq("_id", ObjectId.Parse(jobId));
                var update = new BsonDocument("$set", jobDocument);
                jobsCollection.UpdateOne(filter, update);

                Response.Redirect("JopsPosted.aspx?updated=true");
            }
            else
            {
                // Insert new job
               
                jobsCollection.InsertOne(jobDocument);
                var insertedJobId = jobDocument["_id"].AsObjectId;  // Get the ID from the document we just inserted
                lblMessage.Text = "Job posted successfully!";

         
                

                // Create job notifications for relevant seekers
                CreateJobNotifications(database, insertedJobId, txtTitle.Text);

                // Clear the form after successful submission
                ClearForm();
            }
        }

        private void ClearForm()
        {
            // Clear all text fields
            txtTitle.Text = string.Empty;
            txtDepartment.Text = string.Empty;
            txtCountry.Text = string.Empty;
            txtLocation.Text = string.Empty;
            txtCity.Text = string.Empty;
            txtSalary.Text = string.Empty;
            txtJobSummary.Text = string.Empty;
            txtKeyResponsibilities.Text = string.Empty;
            txtRequiredQualifications.Text = string.Empty;
            txtPreferredQualifications.Text = string.Empty;
            txtSkillsNeeded.Text = string.Empty;
            txtWorkEnvironment.Text = string.Empty;
            txtBenefits.Text = string.Empty;
            txtApplicationSubmission.Text = string.Empty;
            txtApplicationDeadline.Text = string.Empty;
            txtOfferProcess.Text = string.Empty;
            txtInterviewProcess.Text = string.Empty;
            txtAssessmentTasks.Text = string.Empty;
            txtAdditionalNotes.Text = string.Empty;

            // Reset dropdowns to default values
            ddlJobStatus.SelectedIndex = 0;
            ddlExperienceLevel.SelectedIndex = 0;
            ddlJobType.SelectedIndex = 0;

            // Uncheck terms checkbox
            chkTerms.Checked = false;

            // Scroll to the message
            ScriptManager.RegisterStartupScript(this, this.GetType(), "scrollToMessage",
                "window.scrollTo(0, 0);", true);
        }

        private void CreateJobNotifications(IMongoDatabase database, ObjectId jobId, string jobTitle)
        {
            try
            {
                var notificationsCollection = database.GetCollection<BsonDocument>("Notifications");
                var seekersCollection = database.GetCollection<BsonDocument>("Seekers");

                // Find seekers who might be interested in this job
                // (You can modify this query based on your matching criteria)
                var seekers = seekersCollection.Find(new BsonDocument()).ToList();

                foreach (var seeker in seekers)
                {
                    var notification = new BsonDocument
            {
                { "SeekerEmail", seeker["email"].AsString },
                { "JobId", jobId },
                { "JobTitle", jobTitle },
                { "Status", "NewJob" },
                { "NotificationDate", DateTime.Now },
                { "IsRead", false }
            };

                    notificationsCollection.InsertOne(notification);
                }
            }
            catch (Exception ex)
            {
                // Log error but don't prevent job posting
                System.Diagnostics.Trace.WriteLine($"Error creating job notifications: {ex.Message}");
            }
        }
    }
}