using MongoDB.Bson;
using MongoDB.Driver;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;


namespace workHub
{
    public partial class Dashboard_Seeker : System.Web.UI.Page
    {
        private readonly string connectionString = "mongodb://localhost:27017";

        protected void Page_Load(object sender, EventArgs e)
        {

            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Cache.SetExpires(DateTime.UtcNow.AddSeconds(-1));
            Response.Cache.SetRevalidation(HttpCacheRevalidation.AllCaches);
            Response.Cache.SetValidUntilExpires(false);
            Response.Cache.SetAllowResponseInBrowserHistory(false);

            if (Session["SeekerEmail"] == null)
            {
                Response.Redirect("Login-Seekr.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (Session["SeekerEmail"] != null)
                {
                    string email = Session["SeekerEmail"].ToString();
                    var client = new MongoClient(connectionString);
                    var database = client.GetDatabase("JobPortalDB");
                    var seekerCollection = database.GetCollection<BsonDocument>("Seekers");

                    var filter = Builders<BsonDocument>.Filter.Eq("email", email);
                    var seeker = seekerCollection.Find(filter).FirstOrDefault();

                    if (seeker != null)
                    {
                        string name = seeker.Contains("name") ? seeker["name"].AsString : "User";
                        litWelcome.Text = $"Welcome {name} to Your Dashboard";
                        litUsername.Text = name;
                    }

                    LoadJobs(); // Load job posts from updated schema
                }
                else
                {
                    Response.Redirect("Login-Seekr.aspx");
                }
            }
        }

        protected void LoadJobs()
        {
            var client = new MongoClient(connectionString);
            var db = client.GetDatabase("JobPortalDB");
            var jobPosts = db.GetCollection<BsonDocument>("JobPosts");

            var jobs = jobPosts.Find(new BsonDocument()).SortByDescending(j => j["PostedOn"]).Limit(10).ToList();
            var jobList = new List<object>();

            foreach (var job in jobs)
            {
                jobList.Add(new
                {
                    title = job.GetValue("Title", "Untitled").AsString,
                    location = job.GetValue("Location", "Unknown").AsString,
                    city = job.GetValue("City", "").AsString,
                    country = job.GetValue("Country", "").AsString,
                    status = job.GetValue("JobStatus", "Open").AsString,
                    postedOn = job.GetValue("PostedOn", DateTime.Now).ToLocalTime().ToString("dd MMM yyyy")
                });
            }

            rptJobs.DataSource = jobList;
            rptJobs.DataBind();
        }

        protected void btnUploadResume_Click(object sender, EventArgs e)
        {
            if (ResumeUpload.HasFile && Session["SeekerEmail"] != null)
            {
                try
                {
                    string email = Session["SeekerEmail"].ToString();

                    // Save the file to server
                    string folderPath = "~/Uploads/Resumes/";
                    string serverPath = Server.MapPath(folderPath);
                    System.IO.Directory.CreateDirectory(serverPath);

                    string filename = System.IO.Path.GetFileName(ResumeUpload.FileName);
                    string fullServerPath = System.IO.Path.Combine(serverPath, filename);
                    ResumeUpload.SaveAs(fullServerPath);

                    // Save virtual path to MongoDB (to use for display/download later)
                    string virtualPath = folderPath + filename;

                    // MongoDB connection and retrieval
                    var client = new MongoClient("mongodb://localhost:27017");
                    var database = client.GetDatabase("JobPortalDB");
                    var seekers = database.GetCollection<BsonDocument>("Seekers");

                    var filter = Builders<BsonDocument>.Filter.Eq("email", email);
                    var seeker = seekers.Find(filter).FirstOrDefault();

                    if (seeker != null)
                    {
                        if (!seeker.Contains("cv") || seeker["cv"].IsBsonNull || seeker["cv"].IsString && string.IsNullOrEmpty(seeker["cv"].AsString))
                        {
                            // Set cv as array with one item
                            var update = Builders<BsonDocument>.Update.Set("cv", new BsonArray { virtualPath });
                            seekers.UpdateOne(filter, update);
                        }
                        else if (seeker["cv"].IsString)
                        {
                            // Convert old string to array
                            var oldCvPath = seeker["cv"].AsString;
                            var update = Builders<BsonDocument>.Update.Set("cv", new BsonArray { oldCvPath, virtualPath });
                            seekers.UpdateOne(filter, update);
                        }
                        else if (seeker["cv"].IsBsonArray)
                        {
                            // Append to existing array
                            var update = Builders<BsonDocument>.Update.Push("cv", virtualPath);
                            seekers.UpdateOne(filter, update);
                        }

                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Resume uploaded and saved to profile successfully.');", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Seeker not found.');", true);
                    }
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message}');", true);
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please upload a file and make sure you are logged in.');", true);
            }
        }




        protected void btnUploadVideo_Click(object sender, EventArgs e)
        {
            if (VideoUpload.HasFile && Session["SeekerEmail"] != null)
            {
                try
                {
                    // Check file size: 5 MB max = 5 * 1024 * 1024 bytes
                    if (VideoUpload.PostedFile.ContentLength > 5 * 1024 * 1024)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Video must be less than 5 MB.');", true);
                        return;
                    }

                    string email = Session["SeekerEmail"].ToString();

                    string folderPath = "~/Uploads/Videos/";
                    string serverPath = Server.MapPath(folderPath);
                    System.IO.Directory.CreateDirectory(serverPath);

                    string filename = System.IO.Path.GetFileName(VideoUpload.FileName);
                    string fullServerPath = System.IO.Path.Combine(serverPath, filename);
                    VideoUpload.SaveAs(fullServerPath);

                    string virtualPath = folderPath + filename;

                    var client = new MongoClient("mongodb://localhost:27017");
                    var database = client.GetDatabase("JobPortalDB");
                    var seekers = database.GetCollection<BsonDocument>("Seekers");

                    var filter = Builders<BsonDocument>.Filter.Eq("email", email);
                    var update = Builders<BsonDocument>.Update.Set("video", virtualPath);
                    var result = seekers.UpdateOne(filter, update);

                    if (result.ModifiedCount > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('✅ Video CV uploaded successfully!');", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Video uploaded but not saved to your profile.');", true);
                    }
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('❌ Error: {ex.Message}');", true);
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('⚠️ Please upload a video file and make sure you are logged in.');", true);
            }
        }



        protected void btnCreateTemplate_Click(object sender, EventArgs e)
        {
            Response.Redirect("Resume-Templates.aspx");
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

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<object> GetReminders()
        {
            if (HttpContext.Current.Session["SeekerEmail"] == null)
                return new List<object>();

            var email = HttpContext.Current.Session["SeekerEmail"].ToString();
            var client = new MongoClient("mongodb://localhost:27017");
            var db = client.GetDatabase("JobPortalDB");
            var seekers = db.GetCollection<BsonDocument>("Seekers");

            var filter = Builders<BsonDocument>.Filter.Eq("email", email);
            var seeker = seekers.Find(filter).FirstOrDefault();

            if (seeker == null || !seeker.Contains("reminders"))
                return new List<object>();

            return seeker["reminders"].AsBsonArray
                .Select(r =>
                {
                    var doc = r.AsBsonDocument;
                    return new
                    {
                        date = doc["date"].AsString,
                        title = doc["title"].AsString,
                        description = doc.Contains("description") && !doc["description"].IsBsonNull ? doc["description"].AsString : "",
                        time = doc.Contains("time") && !doc["time"].IsBsonNull ? doc["time"].AsString : ""
                    };
                })
                .ToList<object>();
        }



        [System.Web.Services.WebMethod(EnableSession = true)]
        public static bool SaveReminder(string date, string title, string description, string time)
        {
            if (HttpContext.Current.Session["SeekerEmail"] == null)
                return false;

            var email = HttpContext.Current.Session["SeekerEmail"].ToString();
            var client = new MongoClient("mongodb://localhost:27017");
            var db = client.GetDatabase("JobPortalDB");
            var seekers = db.GetCollection<BsonDocument>("Seekers");

            var filter = Builders<BsonDocument>.Filter.Eq("email", email);

            var reminder = new BsonDocument
    {
        { "date", date },
        { "title", title },
        { "description", string.IsNullOrEmpty(description) ? BsonNull.Value : (BsonValue)description },
        { "time", string.IsNullOrEmpty(time) ? BsonNull.Value : (BsonValue)time },
        { "createdAt", DateTime.UtcNow }
    };

            var update = Builders<BsonDocument>.Update.Push("reminders", reminder);
            var result = seekers.UpdateOne(filter, update);

            return result.ModifiedCount > 0;
        }



    }
}

