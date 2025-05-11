<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPasswordSeeker.aspx.cs" Inherits="workHub.ForgotPasswordSeeker" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reset Password - WorkHub</title>
    <link rel="stylesheet" href="CreAccCom.css" />
    <style>
        /* Same styles as ForgotPasswordCompany.aspx */
        .error-message {
            color: red;
            font-size: 12px;
            margin-top: 5px;
            display: none;
        }
        .input-error {
            border: 1px solid red !important;
        }
        #errorSummary {
            color: red;
            background-color: #ffeeee;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
            display: none;
        }
        .success-message {
            color: green;
            background-color: #eeffee;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
            display: none;
        }
        .button {
            background-color: white;
            color: #3f51b5;
            padding: 14px 24px;
            border: 2px solid #3f51b5;
            border-radius: 6px;
            cursor: pointer;
            font-size: 18px;
            display: block;
            margin: 25px auto;
            width: fit-content;
            transition: background-color 0.3s ease;
        }
        .button:hover {
            background-color: #3f51b5 !important;
            color: white;
        }
        .back-btn {
            padding: 4px 6px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            color:#283593;
            text-decoration:none;
            background-color:white;
            font-size:12px;
        }
        .back-btn:hover {
            background-color:#e3e3e3;
        }
    </style>
</head>
<body>
    <form id="forgotPasswordForm" runat="server">
        <div class="container">
            <div class="form-container">
                <div class="left-section">
                    <a class="back-btn" href="Login-Seekr.aspx">Back to Login</a>
                    <h1>Reset Your Password</h1>
                    <p>Enter your details to reset your password.</p>
                </div>
                <div class="right-section">
                    <h2>Forgot Password</h2>
                    
                    <div id="errorSummary" runat="server"></div>
                    <div id="successMessage" class="success-message" runat="server" style="display: none;"></div>
                    
                    <div class="form-group" id="emailSection" runat="server">
                        <label for="txtEmail">Email Address *</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Your email" />
                        <span id="emailError" class="error-message" runat="server"></span>
                    </div>

                    <div class="form-group" id="securityQuestionSection" runat="server" visible="false">
                        <asp:Label ID="lblSecurityQuestion" runat="server"></asp:Label>
                        <asp:HiddenField ID="hdnSecurityQuestion" runat="server" />
                        <asp:TextBox ID="txtSecurityAnswer" runat="server" CssClass="form-control" TextMode="Password" placeholder="Your answer" />
                        <span id="securityAnswerError" class="error-message" runat="server"></span>
                    </div>

                    <div class="form-group" id="newPasswordSection" runat="server" visible="false">
                        <label for="txtNewPassword">New Password *</label>
                        <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Minimum 8 characters" />
                        <span id="newPasswordError" class="error-message" runat="server"></span>
                    </div>

                    <div class="form-group" id="confirmPasswordSection" runat="server" visible="false">
                        <label for="txtConfirmPassword">Confirm New Password *</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Re-enter new password" />
                        <span id="confirmPasswordError" class="error-message" runat="server"></span>
                    </div>

                    <asp:Button ID="btnNext" runat="server" Text="Continue" CssClass="button" OnClick="btnNext_Click" />
                    <asp:Button ID="btnResetPassword" runat="server" Text="Reset Password" CssClass="button" OnClick="btnResetPassword_Click" Visible="false" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>