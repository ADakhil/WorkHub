<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Notification-Seeker.aspx.cs" Inherits="workHub.Notification_Seeker" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Notifications | WorkHub</title>
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

    .notification-list {
      display: flex;
      flex-direction: column;
      gap: 15px;
    }

    .notification-card {
      background-color: white;
      border-radius: 8px;
      padding: 15px 20px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
      display: flex;
      justify-content: space-between;
      align-items: center;
      border-left: 4px solid var(--primary);
      transition: 0.2s ease;
      cursor: pointer;
    }

    .notification-card:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }

    .notification-card.viewed { border-left-color: #3498db; }
    .notification-card.interview { border-left-color: #2ecc71; }
    .notification-card.rejected { border-left-color: #e74c3c; }
    .notification-card.pending { border-left-color: #f39c12; }
    .notification-card.newjob { border-left-color: var(--accent); }

    .notification-content {
      flex: 1;
    }

    .notification-title {
      font-weight: 600;
      margin-bottom: 5px;
      color: var(--dark);
    }

    .notification-meta {
      display: flex;
      gap: 15px;
      font-size: 13px;
      color: var(--gray);
    }

    .notification-job {
      font-weight: 500;
      color: var(--accent);
    }

    .notification-time {
      font-size: 12px;
    }

    .dismiss-btn {
      background: none;
      border: none;
      color: #95a5a6;
      cursor: pointer;
      font-size: 18px;
      font-weight: bold;
      padding: 0 8px;
      transition: 0.2s ease;
    }

    .dismiss-btn:hover {
      color: #e74c3c;
      background: #f5f5f5;
      border-radius: 50%;
    }

    .no-notifications {
      text-align: center;
      padding: 40px;
      color: var(--gray);
      font-size: 16px;
      background: white;
      border-radius: 8px;
      box-shadow: 0 3px 10px rgba(0,0,0,0.05);
    }

    @media (max-width: 768px) {
      .container {
        grid-template-columns: 1fr;
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
          <a href="applications-seeker.aspx" class="nav-item"><i class="fas fa-file-alt"></i> Applications</a>
          <a href="Notification-Seeker.aspx" class="nav-item active"><i class="fas fa-bell"></i> Notifications</a>
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
          <h1>Notifications</h1>
          <p>Stay updated on your job applications and new job opportunities</p>
        </header>

        <asp:HiddenField ID="hdnNotificationId" runat="server" />

        <section class="notification-list">
          <asp:Repeater ID="rptNotifications" runat="server" OnItemCommand="rptNotifications_ItemCommand">
            <ItemTemplate>
              <div class="notification-card <%# Eval("Status").ToString().ToLower() %>" 
                  onclick="handleNotificationClick('<%# Eval("Status") %>', '<%# Eval("JobId") %>', '<%# Eval("_id") %>')">
                <div class="notification-content">
                  <div class="notification-title">
                    <%# GetNotificationMessage(Eval("Status").ToString()) %>
                  </div>
                  <div class="notification-meta">
                    <span class="notification-job"><%# Eval("JobTitle") %></span>
                    <span class="notification-time"><%# Eval("NotificationDate", "{0:MMM dd, hh:mm tt}") %></span>
                  </div>
                </div>
                <asp:LinkButton runat="server"
                  CommandName="DeleteNotification"
                  CommandArgument='<%# Eval("_id") %>'
                  CssClass="dismiss-btn"
                  OnClientClick="event.stopPropagation(); return confirm('Are you sure you want to dismiss this notification?');">
                  ×
                </asp:LinkButton>
              </div>
            </ItemTemplate>
          </asp:Repeater>

          <asp:Label ID="lblNoNotifications" runat="server" CssClass="no-notifications" Visible="false">
            You don't have any notifications yet.
          </asp:Label>
        </section>
      </main>
    </div>
  </form>

  <script>
    function handleNotificationClick(status, jobId, notificationId) {
      if (status === "NewJob") {
        // Redirect to job application page with job ID
        window.location.href = "ApplyJob.aspx?jobId=" + jobId;
      } else {
        // For other notification types, you might want to mark as read
        // and/or redirect to application details
        window.location.href = "applications-Seeker.aspx";
      }
      }

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