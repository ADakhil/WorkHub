using DocumentFormat.OpenXml.Math;
using MongoDB.Bson;
using MongoDB.Driver;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;

namespace workHub
{
    public partial class CompanyDetails : System.Web.UI.Page
    {
        protected IMongoCollection<BsonDocument> companiesCollection;
        protected IMongoCollection<BsonDocument> seekersCollection;
        protected IMongoCollection<BsonDocument> reviewsCollection;
        protected string companyId;
        protected string seekerId;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Initialize MongoDB collections
            var client = new MongoClient("mongodb://localhost:27017");
            var database = client.GetDatabase("JobPortalDB");
            companiesCollection = database.GetCollection<BsonDocument>("companies");
            seekersCollection = database.GetCollection<BsonDocument>("Seekers");
            reviewsCollection = database.GetCollection<BsonDocument>("reviews");

            // Get company ID from URL
            companyId = Request.QueryString["id"];
            if (string.IsNullOrEmpty(companyId))
            {
                Response.Redirect("jobsearch-seeker.aspx");
                return;
            }

            // Get seeker ID from session
            seekerId = Session["SeekerId"]?.ToString();

            if (!IsPostBack)
            {
                LoadCompanyDetails();
                LoadReviews();
            }
        }

        private void LoadCompanyDetails()
        {
            var company = companiesCollection.Find(new BsonDocument("_id", new ObjectId(companyId))).FirstOrDefault();
            if (company == null)
            {
                Response.Redirect("jobsearch-seeker.aspx");
                return;
            }

            litCompanyName.Text = company.GetValue("companyName", "").AsString;
            litLocation.Text = company.GetValue("location", "").AsString;
            litIndustry.Text = company.GetValue("industry", "").AsString;
            litDescription.Text = company.GetValue("description", "").AsString;

            // Set logo
            string logoPath = company.GetValue("logoPath", "").AsString;
            if (!string.IsNullOrEmpty(logoPath))
            {
                imgCompanyLogo.ImageUrl = logoPath;
            }
            else
            {
                imgCompanyLogo.ImageUrl = "images/default-company.png";
            }

            // Set website link
            string website = company.GetValue("website", "").AsString;
            if (!string.IsNullOrEmpty(website))
            {
                lnkWebsite.Text = website;
                lnkWebsite.NavigateUrl = website.StartsWith("http") ? website : "http://" + website;
            }
            else
            {
                lnkWebsite.Visible = false;
            }

            // Set poster if active
            bool posterActive = company.GetValue("posterActive", false).AsBoolean;
            string posterPath = company.GetValue("posterPath", "").AsString;
            if (posterActive && !string.IsNullOrEmpty(posterPath))
            {
                imgCompanyPoster.ImageUrl = posterPath;
                imgCompanyPoster.Visible = true;
            }
        }

        private void LoadReviews()
        {
            var reviews = reviewsCollection.Find(new BsonDocument("companyId", companyId)).ToList();

            // Calculate average rating
            if (reviews.Any())
            {
                double averageRating = reviews.Average(r =>
                {
                    var ratingValue = r.GetValue("rating", BsonValue.Create(0));
                    switch (ratingValue.BsonType)
                    {
                        case BsonType.Double:
                            return ratingValue.AsDouble;
                        case BsonType.Int32:
                            return (double)ratingValue.AsInt32;
                        case BsonType.Int64:
                            return (double)ratingValue.AsInt64;
                        default:
                            return 0;
                    }
                });

                litAverageRating.Text = averageRating.ToString("0.0");
                litReviewCount.Text = reviews.Count.ToString();
            }
            else
            {
                litAverageRating.Text = "No ratings yet";
                litReviewCount.Text = "0";
            }

            // Get seeker names for reviews and convert to dictionary
            var reviewList = new List<Dictionary<string, object>>();
            foreach (var review in reviews)
            {
                var seekerId = review.GetValue("seekerId", "").AsString;
                var seeker = seekersCollection.Find(new BsonDocument("_id", new ObjectId(seekerId))).FirstOrDefault();

                if (seeker != null)
                {
                    string name = seeker.Contains("name") ? seeker["name"].AsString : "User";

                    litUsername.Text = name;
                }

                var reviewData = new Dictionary<string, object>
        {
            { "_id", review["_id"] },
            { "companyId", review["companyId"] },
            { "seekerId", review["seekerId"] },
            { "rating", review["rating"].AsInt32 }, // Ensure this is int for GetStarRating
            { "comment", review["comment"].AsString },
            { "createdAt", review["createdAt"].ToUniversalTime() },
            { "seekerName", seeker?.GetValue("name", "Anonymous").AsString ?? "Anonymous" }
        };

                reviewList.Add(reviewData);
            }

            rptReviews.DataSource = reviewList.OrderByDescending(r => (DateTime)r["createdAt"]);
            rptReviews.DataBind();
        }

        protected string GetStarRating(int rating)
        {
            string stars = "";
            for (int i = 1; i <= 5; i++)
            {
                if (i <= rating)
                {
                    stars += "<i class='fas fa-star' style='color: #ffc107;'></i>";
                }
                else
                {
                    stars += "<i class='far fa-star' style='color: #ffc107;'></i>";
                }
            }
            return stars;
        }

        protected void btnSubmitReview_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(seekerId))
            {
                Response.Redirect("Login-Seekr.aspx");
                return;
            }

            int rating = int.Parse(hdnRating.Value);
            string comment = txtReview.Text.Trim();

            if (rating == 0)
            {
                // Show error - rating required
                return;
            }

            var review = new BsonDocument
            {
                { "companyId", companyId },
                { "seekerId", seekerId },
                { "rating", rating },
                { "comment", comment },
                { "createdAt", DateTime.UtcNow }
            };

            reviewsCollection.InsertOne(review);

            // Refresh reviews
            LoadReviews();

            // Clear form
            hdnRating.Value = "0";
            txtReview.Text = "";

            // Reset stars
            ScriptManager.RegisterStartupScript(this, GetType(), "resetStars",
                "document.querySelectorAll('.rating-star').forEach(star => star.classList.remove('active'));", true);
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