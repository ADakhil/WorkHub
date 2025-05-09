using System;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;
using MongoDB.Bson;
using MongoDB.Driver;

namespace workHub
{
    public partial class Notification_Seeker : System.Web.UI.Page
    {
        protected string seekerName = "";

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
                LoadNotifications();
            }
        }

        protected void rptNotifications_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteNotification")
            {
                string notificationId = e.CommandArgument.ToString();
                DeleteNotificationFromDb(notificationId);
                // Reload the page to reflect changes
                Response.Redirect(Request.RawUrl);
            }
        }

        private void LoadSeekerInfo()
        {
            var client = new MongoClient("mongodb://localhost:27017");
            var database = client.GetDatabase("JobPortalDB");
            var seekersCollection = database.GetCollection<BsonDocument>("Seekers");

            var filter = Builders<BsonDocument>.Filter.Eq("email", Session["SeekerEmail"].ToString());
            var seeker = seekersCollection.Find(filter).FirstOrDefault();

            if (seeker != null)
            {
                seekerName = seeker.GetValue("name", "User").ToString();
            }
        }

        private void LoadNotifications()
        {
            var client = new MongoClient("mongodb://localhost:27017");
            var db = client.GetDatabase("JobPortalDB");

            var notificationsCollection = db.GetCollection<BsonDocument>("Notifications");
            var applicationsCollection = db.GetCollection<BsonDocument>("JobApplications");
            var jobsCollection = db.GetCollection<BsonDocument>("JobPosts");

            // Get notifications for this seeker (both read and unread)
            var filter = Builders<BsonDocument>.Filter.Eq("SeekerEmail", Session["SeekerEmail"].ToString());
            var notifications = notificationsCollection.Find(filter)
                .Sort(Builders<BsonDocument>.Sort.Descending("NotificationDate"))
                .ToList();

            var notificationData = notifications.Select(notif =>
            {
                string jobId = "";
                string jobTitle = "Unknown Position";

                if (notif["Status"].ToString() == "NewJob")
                {
                    // For new job notifications
                    jobId = notif["JobId"].ToString();
                    var job = jobsCollection.Find(
                        Builders<BsonDocument>.Filter.Eq("_id", ObjectId.Parse(jobId)))
                        .FirstOrDefault();
                    jobTitle = job?.GetValue("Title", "New Job Position").ToString();
                }
                else
                {
                    // For application status notifications
                    var application = applicationsCollection.Find(
                        Builders<BsonDocument>.Filter.Eq("_id", notif["ApplicationId"].AsObjectId))
                        .FirstOrDefault();

                    if (application != null && application.Contains("JobId"))
                    {
                        jobId = application["JobId"].ToString();
                        var job = jobsCollection.Find(
                            Builders<BsonDocument>.Filter.Eq("_id", ObjectId.Parse(jobId)))
                            .FirstOrDefault();
                        jobTitle = job?.GetValue("Title", "Unknown Position").ToString();
                    }
                }

                return new
                {
                    _id = notif["_id"].ToString(),
                    ApplicationId = notif.Contains("ApplicationId") ? notif["ApplicationId"].ToString() : "",
                    JobId = jobId,
                    Status = notif["Status"].ToString(),
                    JobTitle = jobTitle,
                    NotificationDate = notif.GetValue("NotificationDate", DateTime.UtcNow).ToUniversalTime(),
                    IsRead = notif.GetValue("IsRead", false)
                };
            }).ToList();

            rptNotifications.DataSource = notificationData;
            rptNotifications.DataBind();

            lblNoNotifications.Visible = !notificationData.Any();
        }

        public string GetNotificationMessage(string status)
        {
            switch (status)
            {
                case "Viewed": return "Your application has been viewed";
                case "Interview": return "Interview scheduled";
                case "Rejected": return "Application not selected";
                case "Pending": return "Application under review";
                case "NewJob": return "New job posted that matches your profile";
                default: return "Application update";
            }
        }

        [WebMethod]
        private void DeleteNotificationFromDb(string notificationId)
        {
            try
            {
                var client = new MongoClient("mongodb://localhost:27017");
                var db = client.GetDatabase("JobPortalDB");
                var notifications = db.GetCollection<BsonDocument>("Notifications");

                var result = notifications.DeleteOne(
                    Builders<BsonDocument>.Filter.Eq("_id", ObjectId.Parse(notificationId))
                );

                if (result.DeletedCount == 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Notification not found or already deleted.');", true);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error deleting notification: " + ex.Message);
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error deleting notification. Please try again.');", true);
            }
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