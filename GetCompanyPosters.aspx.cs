using System;
using System.Web;
using System.Web.UI;
using MongoDB.Bson;
using MongoDB.Driver;
using System.Collections.Generic;

namespace workHub
{
    public partial class GetCompanyPosters : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.ContentType = "application/json";
            Response.Clear();

            try
            {
                var client = new MongoClient("mongodb://localhost:27017");
                var db = client.GetDatabase("JobPortalDB");
                var collection = db.GetCollection<BsonDocument>("companies");

                var filter = Builders<BsonDocument>.Filter.Eq("posterActive", true);
                var projection = Builders<BsonDocument>.Projection
                    .Include("companyName")
                    .Include("posterPath")
                    .Include("logoPath")
                    .Include("industry")
                    .Include("description")
                    .Exclude("_id");

                var companies = collection.Find(filter).Project(projection).ToList();

                // Convert BSON to dictionaries for JSON serialization
                var result = new List<Dictionary<string, object>>();
                foreach (var doc in companies)
                {
                    var dict = new Dictionary<string, object>();
                    foreach (var elem in doc.Elements)
                    {
                        dict[elem.Name] = elem.Value.ToString(); // Convert BsonValue to string
                    }
                    result.Add(dict);
                }

                Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(result));
            }
            catch (Exception ex)
            {
                // Return a valid JSON error object
                Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(new
                {
                    error = true,
                    message = ex.Message
                }));
            }

            Response.End();
        }
    }
}
