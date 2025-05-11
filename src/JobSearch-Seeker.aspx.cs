using System;
using System.Collections.Generic;
using MongoDB.Driver;
using MongoDB.Bson;
using MongoDB.Driver.Core.Configuration;
using System.Web;

namespace workHub
{
    public partial class JobSearch_Seeker : System.Web.UI.Page
    {
        public List<BsonDocument> jobPosts = new List<BsonDocument>();
        private readonly string connectionString = "mongodb://localhost:27017";

        protected void Page_Load(object sender, EventArgs e)
        {

            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            if (!IsPostBack)
            {
                LoadJobsFromDatabase();

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
                       
                        litUsername.Text = name;
                    }

                 
                }
                else
                {
                    Response.Redirect("Login-Seekr.aspx");
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadJobsFromDatabase(); // re-use the same method
        }


        private void LoadJobsFromDatabase()
        {
            try
            {
                var connectionString = "mongodb://localhost:27017";
                var client = new MongoClient(connectionString);
                var database = client.GetDatabase("JobPortalDB");

                var jobCollection = database.GetCollection<BsonDocument>("JobPosts");
                var companyCollection = database.GetCollection<BsonDocument>("companies");

                var filters = new List<FilterDefinition<BsonDocument>>
        {
            Builders<BsonDocument>.Filter.Eq("JobStatus", "Active")
        };

                // Apply keyword filter
                string keyword = txtKeyword.Text.Trim();
                if (!string.IsNullOrEmpty(keyword))
                {
                    var keywordFilter = Builders<BsonDocument>.Filter.Or(
                        Builders<BsonDocument>.Filter.Regex("Title", new BsonRegularExpression(keyword, "i")),
                        Builders<BsonDocument>.Filter.Regex("JobSummary", new BsonRegularExpression(keyword, "i")),
                        Builders<BsonDocument>.Filter.Regex("CompanyName", new BsonRegularExpression(keyword, "i"))
                    );
                    filters.Add(keywordFilter);
                }

                // Location filter
                string location = txtLocation.Text.Trim();
                if (!string.IsNullOrEmpty(location))
                {
                    filters.Add(Builders<BsonDocument>.Filter.Regex("Location", new BsonRegularExpression(location, "i")));
                }

                // Job Type
                if (!string.IsNullOrEmpty(ddlJobType.SelectedValue))
                {
                    filters.Add(Builders<BsonDocument>.Filter.Eq("JobType", ddlJobType.SelectedValue));
                }

                // Experience Level
                if (!string.IsNullOrEmpty(ddlExperience.SelectedValue))
                {
                    filters.Add(Builders<BsonDocument>.Filter.Eq("Experience", ddlExperience.SelectedValue));
                }

                // Salary Range
                if (!string.IsNullOrEmpty(ddlSalary.SelectedValue))
                {
                    switch (ddlSalary.SelectedValue)
                    {
                        case "under":
                            filters.Add(Builders<BsonDocument>.Filter.Lt("Salary", 50000));
                            break;
                        case "mid":
                            filters.Add(Builders<BsonDocument>.Filter.And(
                                Builders<BsonDocument>.Filter.Gte("Salary", 50000),
                                Builders<BsonDocument>.Filter.Lte("Salary", 100000)));
                            break;
                        case "over":
                            filters.Add(Builders<BsonDocument>.Filter.Gt("Salary", 100000));
                            break;
                    }
                }

                var finalFilter = Builders<BsonDocument>.Filter.And(filters);
                var jobs = jobCollection.Find(finalFilter).Limit(50).ToList();

                jobPosts.Clear();

                foreach (var job in jobs)
                {
                    var companyId = job.GetValue("CompanyId", BsonNull.Value).ToString();

                    if (!string.IsNullOrEmpty(companyId))
                    {
                        var companyFilter = Builders<BsonDocument>.Filter.Eq("_id", ObjectId.Parse(companyId));
                        var company = companyCollection.Find(companyFilter).FirstOrDefault();

                        if (company != null && company.Contains("companyName"))
                        {
                            job["CompanyName"] = company["companyName"];
                            if (company.Contains("logoPath") && !string.IsNullOrEmpty(company["logoPath"].AsString))
                            {
                                job["LogoPath"] = company["logoPath"];
                            }
                            else
                            {
                                job["LogoPath"] = "";
                            }
                        }
                        else
                        {
                            job["CompanyName"] = "Unknown Company";
                            job["LogoPath"] = "";
                        }
                    }
                    else
                    {
                        job["CompanyName"] = "Unknown Company";
                        job["LogoPath"] = "";
                    }

                    jobPosts.Add(job);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
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
