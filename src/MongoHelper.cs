using MongoDB.Driver;
using MongoDB.Bson;
using System;

public class MongoHelper
{
    private static readonly string connectionString = "mongodb://localhost:27017"; // or your MongoDB Atlas URI
    private static readonly string databaseName = "WorkhubDB";

    private static IMongoDatabase GetDatabase()
    {
        var client = new MongoClient(connectionString);
        return client.GetDatabase(databaseName);
    }

    public static void SaveJob(string companyName, string title, string description, string location)
    {
        var db = GetDatabase();
        var collection = db.GetCollection<BsonDocument>("JobPosts");

        var doc = new BsonDocument
        {
            { "CompanyName", companyName },
            { "Title", title },
            { "Description", description },
            { "Location", location },
            { "PostDate", DateTime.Now }
        };

        collection.InsertOne(doc);
    }
}
