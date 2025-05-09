<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditProfileCompany.aspx.cs" Inherits="workHub.EditProfileCompany" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aramco Profile</title>
    <link rel="stylesheet" href="EditProfileCompany.css">
</head>
<body>
    <div class="profile-container">
        <h1>Aramco</h1>
        
        <div class="profile-section">
            <div class="profile-picture">
                <div class="picture-placeholder"></div>
                <span>Profile Picture</span>
            </div>
            
            <div class="profile-details">
                <div class="form-group">
                    <label>Company name</label>
                    <input type="text" value="Aramco" readonly>
                    <span class="optional">(Optional)</span>
                </div>
                
                <div class="form-group">
                    <label>Common Website</label>
                    <input type="text" placeholder="Enter website">
                    <span class="optional">(Optional)</span>
                </div>
                
                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" value="Aramco@gmail.com" readonly>
                </div>
                
                <div class="form-group">
                    <label>Industry</label>
                    <input type="text" value="Information technology" readonly>
                </div>
                
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" value="........">
                </div>
                
                <div class="form-group">
                    <label>Location</label>
                    <input type="text" value="Khobar, Saudi Arabia" readonly>
                </div>
                
                <div class="form-group">
                    <label>Phone Number</label>
                    <input type="tel" placeholder="Enter phone number">
                </div>
            </div>
        </div>
        
        <div class="actions">
            <button class="save-btn">Save Changes</button>
            <button class="cancel-btn">Cancel</button>
        </div>
    </div>

    <script src="EditProfileCompany.js"></script>
</body>
</html>
