<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="applications-Seeker.aspx.cs" Inherits="workHub.applications_Seeker" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>My Applications | WorkHub</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
  <style>
    :root {
      --primary: #4361ee;
      --secondary: #3f37c9;
      --accent: #4895ef;
      --light: #f8f9fa;
      --dark: #212529;
      --success: #4cc9f0;
      --warning: #f72585;
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

    .container {
      display: grid;
      grid-template-columns: 250px 1fr;
      min-height: 100vh;
    }

    .sidebar {
      background-color: white;
      box-shadow: 2px 0 10px rgba(0, 0, 0, 0.05);
      padding: 20px 0;
    }

    .sidebar-header {
      font-size: 24px;
      font-weight: bold;
      text-align: center;
      padding: 20px;
      color: var(--primary);
      border-bottom: 1px solid var(--light-gray);
      text-decoration: none;
      display: block;
    }

    .sidebar-nav {
      display: flex;
      flex-direction: column;
      padding: 20px;
    }

    .nav-item {
      color: var(--gray);
      text-decoration: none;
      padding: 12px 15px;
      border-radius: 8px;
      margin-bottom: 5px;
      transition: all 0.3s;
      display: flex;
      align-items: center;
    }

    .nav-item i {
      margin-right: 10px;
      width: 20px;
      text-align: center;
    }

    .nav-item.active {
      background-color: var(--primary);
      color: white;
    }

    .nav-item:hover:not(.active) {
      background-color: var(--light-gray);
      color: var(--dark);
    }

    .main-content {
      padding: 30px;
      background-color: var(--light);
    }

    header h1 {
      margin: 0 0 10px;
      color: var(--primary);
      font-size: 24px;
    }

    header p {
      margin: 0 0 25px;
      color: var(--gray);
    }

    .filters-section {
      background-color: white;
      padding: 15px;
      border-radius: 8px;
      margin-bottom: 20px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.05);
    }

    .filters-section label {
      font-weight: 500;
      margin-right: 10px;
      color: var(--gray);
    }

    .filters-section select {
      padding: 8px 12px;
      border-radius: 6px;
      border: 1px solid var(--light-gray);
      background-color: white;
      font-family: inherit;
    }

    .applications-list {
      display: grid;
      gap: 20px;
    }

    .application-card {
      background-color: white;
      border-radius: 10px;
      padding: 20px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
      border-left: 4px solid var(--primary);
      transition: 0.3s ease;
    }

    .application-card:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }

    .app-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 10px;
    }

    .app-header h3 {
      margin: 0;
      font-size: 18px;
    }

    .status-badge {
      padding: 4px 12px;
      border-radius: 12px;
      font-size: 12px;
      font-weight: 600;
    }

    .status-pending { background-color: #fff3cd; color: #856404; }
    .status-viewed { background-color: #cce5ff; color: #004085; }
    .status-rejected { background-color: #f8d7da; color: #721c24; }
    .status-interview { background-color: #d4edda; color: #155724; }
    .status-accepted { background-color: #d4edda; color: #155724; }

    .app-company {
      color: var(--accent);
      font-weight: 500;
      margin-bottom: 8px;
    }

    .app-meta {
      display: flex;
      gap: 15px;
      font-size: 14px;
      color: var(--gray);
      margin-bottom: 10px;
    }

    .interview-details {
      background-color: #e8f4fc;
      border-left: 4px solid var(--primary);
      padding: 10px;
      border-radius: 6px;
      margin-bottom: 10px;
      font-size: 14px;
    }

    .meeting-link {
      display: inline-block;
      margin-top: 8px;
      padding: 6px 10px;
      background-color: var(--primary);
      color: white;
      text-decoration: none;
      border-radius: 4px;
      font-size: 14px;
    }

    .app-message {
      font-size: 14px;
      color: var(--dark);
      border-top: 1px solid var(--light-gray);
      padding-top: 10px;
    }

    .no-results {
      text-align: center;
      padding: 40px;
      background: white;
      border-radius: 8px;
      color: var(--gray);
      font-size: 16px;
      box-shadow: 0 3px 10px rgba(0,0,0,0.05);
    }

    @media (max-width: 768px) {
      .container {
        grid-template-columns: 1fr;
      }
      .app-meta {
        flex-direction: column;
      }
    }

     .user-profile {
     display: flex;
     align-items: center;
     gap: 10px;
     padding: 15px 20px;
     margin-top: auto;
     border-top: 1px solid var(--light-gray);
     text-decoration: none;
     color: var(--dark);
     transition: background-color 0.3s;
 }

 .user-profile:hover {
     background-color: var(--light-gray);
 }

 .avatar {
     width: 36px;
     height: 36px;
     border-radius: 50%;
     background-color: var(--light-gray);
     display: flex;
     align-items: center;
     justify-content: center;
     color: var(--gray);
 }

 .username {
     font-weight: 500;
 }
 @media (max-width: 768px) {
    .dashboard-container {
        grid-template-columns: 1fr;
    }

    .sidebar {
        position: fixed;
        left: -250px;
        top: 0;
        height: 100%;
        z-index: 1000;
        transition: left 0.3s ease;
        width: 250px;
    }

        .sidebar.active {
            left: 0;
        }

    .mobile-header {
        display: flex !important; /* Force display on mobile */
        justify-content: space-between;
        align-items: center;
        padding: 15px;
        background-color: white;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        position: sticky;
        top: 0;
        z-index: 999;
    }

    .hamburger-btn {
        display: block !important; /* Force display on mobile */
        background: none;
        border: none;
        font-size: 24px;
        color: var(--primary);
        cursor: pointer;
    }

    .overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: rgba(0, 0, 0, 0.5);
        z-index: 999;
    }

        .overlay.active {
            display: block;
        }

    .page-header {
        flex-direction: column;
        align-items: flex-start;
        gap: 15px;
    }

    .resume-container {
        grid-template-columns: 1fr;
    }
}

/* Hide mobile header by default (will be shown via media query) */
.mobile-header {
    display: none;
}

.hamburger-btn {
    display: none;
}
  </style>
</head>
<body>
  <form id="form1" runat="server">

              <div class="mobile-header">
    <button type="button" class="hamburger-btn" id="sidebarToggle">
        <i class="fas fa-bars"></i>
    </button>
    <div class="logo-small">WorkHub</div>
    <div></div> <!-- Empty div for flex spacing -->
</div>

<!-- Overlay for mobile sidebar -->
<div class="overlay" id="overlay"></div>

    <div class="container">
      <aside class="sidebar" id="sidebar">
        <a href="HomePageF.aspx" class="sidebar-header">WorkHub</a>
        <nav class="sidebar-nav">
          <a href="dashboard-seeker.aspx" class="nav-item"><i class="fas fa-home"></i> Dashboard</a>
          <a href="jobsearch-seeker.aspx" class="nav-item"><i class="fas fa-briefcase"></i> Jobs</a>
          <a href="applications-seeker.aspx" class="nav-item active"><i class="fas fa-file-alt"></i> Applications</a>
          <a href="Notification-Seeker.aspx" class="nav-item"><i class="fas fa-bell"></i> Notifications</a>
          <a href="interview2.aspx" class="nav-item"><i class="fas fa-video"></i> Interviews</a>
             <a href="seeker-resumes.aspx" class="nav-item">
    <i class="fas fa-file-pdf"></i> My Resumes
</a>
        </nav>
          <a class="user-profile" href="SeekerProfile.aspx">
    <div class="avatar">
        <i class="fas fa-user"></i>
    </div>
    <span class="username"><%= seekerName %></span>
</a>
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="nav-item" Style=" background-color: #f72585; color: white; border: none; border-radius: 8px; padding: 10px; font-weight: bold; cursor: pointer; width:80%; margin:0 auto;" OnClick="btnLogout_Click" />
      </aside>
      <main class="main-content">
        <header>
          <h1>My Job Applications</h1>
          <p>Track and manage all your submitted applications</p>
        </header>

        <div class="filters-section">
          <label for="ddlStatusFilter">Filter by Status:</label>
          <asp:DropDownList ID="ddlStatusFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlStatusFilter_SelectedIndexChanged">
            <asp:ListItem Text="All Applications" Value="All" Selected="True" />
            <asp:ListItem Text="Pending Review" Value="Pending" />
            <asp:ListItem Text="Viewed by Employer" Value="Viewed" />
            <asp:ListItem Text="Not Selected" Value="Rejected" />
            <asp:ListItem Text="Interview Stage" Value="Interview" />
              <asp:ListItem Text="Accepted" Value="Accepted" />
          </asp:DropDownList>
        </div>

        <section class="applications-list">
          <asp:Repeater ID="rptApplications" runat="server">
            <ItemTemplate>
              <div class="application-card status-<%# Eval("Status").ToString().ToLower() %>">
                <div class="app-header">
                  <h3><%# Eval("JobTitle") %></h3>
                  <span class="status-badge"><%# Eval("Status") %></span>
                </div>
                <div class="app-company">at <%# Eval("CompanyName") %></div>
                <div class="app-meta">
                  <span>Applied on <%# Eval("AppliedOn", "{0:MMM dd, yyyy}") %></span>
                  <span><%# Eval("JobType") %></span>
                </div>

                <%# Eval("Status").ToString() == "Interview" ?
                    "<div class='interview-details'>" +
                    "<div><strong>Date:</strong> " + Eval("InterviewDate", "{0:MMM dd, yyyy}") + "</div>" +
                    "<div><strong>Time:</strong> " + Eval("InterviewTime") + "</div>" +
                    "<a href='" + Eval("InterviewLink") + "' target='_blank' class='meeting-link'>Join Interview</a>" +
                    "</div>" : "" %>

                <div class="app-message">
                  <strong>Message:</strong> <%# Eval("Message") %>
                </div>
              </div>
            </ItemTemplate>
          </asp:Repeater>
          <asp:Label ID="lblNoResults" runat="server" CssClass="no-results" Visible="false">
            No applications found matching your filter.
          </asp:Label>
        </section>
      </main>
    </div>
  </form>
    <script>
        document.addEventListener("DOMContentLoaded", () => {
            // Get DOM elements
            const sidebar = document.getElementById("sidebar")
            const sidebarToggle = document.getElementById("sidebarToggle")
            const overlay = document.getElementById("overlay")

            // Check if elements exist
            if (!sidebar || !sidebarToggle || !overlay) {
                console.error("Mobile navigation elements not found")
                return
            }

            // Toggle sidebar when hamburger button is clicked
            sidebarToggle.addEventListener("click", (e) => {
                e.preventDefault()
                sidebar.classList.toggle("active")
                overlay.classList.toggle("active")
                console.log("Sidebar toggle clicked")
            })

            // Close sidebar when overlay is clicked
            overlay.addEventListener("click", () => {
                sidebar.classList.remove("active")
                overlay.classList.remove("active")
                console.log("Overlay clicked, closing sidebar")
            })

            // Close sidebar when window is resized to desktop size
            window.addEventListener("resize", () => {
                if (window.innerWidth > 768) {
                    sidebar.classList.remove("active")
                    overlay.classList.remove("active")
                }
            })

            // Log that the mobile navigation is initialized
            console.log("Mobile navigation initialized")
        })
    </script>
</body>
</html>

