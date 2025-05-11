<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplyJob.aspx.cs" Inherits="workHub.ApplyJob" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Apply for Job | WorkHub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --secondary: #3f37c9;
            --accent: #4895ef;
            --light: #f8f9fa;
            --dark: #212529;
            --gray: #6c757d;
            --light-gray: #e9ecef;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light);
            margin: 0;
            padding: 0;
            color: var(--dark);
        }

        .form-wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 40px 20px;
        }

        .form-container {
            background-color: white;
            border-radius: 12px;
            padding: 30px;
            width: 100%;
            max-width: 600px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .form-container h2 {
            text-align: center;
            color: var(--primary);
            margin-bottom: 30px;
        }

        .form-field {
            margin-bottom: 20px;
        }

        .form-field label {
            display: block;
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 5px;
        }

        .form-field input,
        .form-field textarea,
        .form-field select,
        .form-field .form-control {
            width: 100%;
            padding: 10px;
            font-size: 15px;
            border: 1px solid var(--light-gray);
            border-radius: 8px;
            outline: none;
            transition: border-color 0.3s;
        }

        .form-field input:focus,
        .form-field textarea:focus,
        .form-field select:focus,
        .form-field .form-control:focus {
            border-color: var(--primary);
        }

        .submit-btn {
            display: block;
            width: 100%;
            background-color: var(--primary);
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .submit-btn:hover {
            background-color: var(--secondary);
        }

        .job-details {
            padding: 15px;
            background-color: var(--light-gray);
            border-radius: 8px;
            margin-bottom: 30px;
            font-size: 14px;
            color: var(--dark);
        }

        @media (max-width: 600px) {
            .form-container {
                padding: 20px;
            }
        }
        .back-btn {
            margin-top: 15px;
            width: 100%;
            background-color: transparent;
            color: var(--primary);
            border: 2px solid var(--primary);
            padding: 10px;
            font-weight: 600;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .back-btn:hover {
            background-color: var(--primary);
            color: white;
        }

        .error-message {
            color: red;
            font-size: 0.9em;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-wrapper">
            <div class="form-container">
                <asp:Button ID="btnBack" runat="server" Text="← Back to Job Search" CssClass="back-btn" OnClick="btnBack_Click" />

                <h2>Apply for Job</h2>

                <div class="job-details">
                    <asp:Literal ID="litJobDetails" runat="server" />
                </div>

                <div class="form-field">
                    <label for="txtName">Full Name *</label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
                </div>

                <div class="form-field">
                    <label for="txtEmail">Email *</label>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" />
                </div>

                <div class="form-field">
                    <label for="ddlResume">Select Existing CV *</label>
                    <asp:DropDownList ID="ddlResume" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Select your uploaded resume" Value="" />
                    </asp:DropDownList>
                    <asp:Label ID="lblCvError" runat="server" Text="" CssClass="error-message" Visible="False"></asp:Label>
                </div>

                <div class="form-field">
                    <label for="txtMessage">Message to Employer</label>
                    <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" />
                </div>

                <asp:Button ID="btnSubmit" runat="server" CssClass="submit-btn" Text="Submit Application" OnClick="btnSubmit_Click" />
            </div>
        </div>
    </form>
</body>
</html>
