<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="workHub.HomePage" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | WorkHub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
            background-color: #f5f7fa;
            margin: 0;
            padding: 0;
            color: var(--dark);
            line-height: 1.6;
        }

        .dashboard-container {
            display: grid;
            grid-template-columns: 250px 1fr;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            background-color: white;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
            padding: 20px 0;
            display: flex;
            flex-direction: column;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            text-align: center;
            padding: 20px;
            color: var(--primary);
            border-bottom: 1px solid var(--light-gray);
            text-decoration: none;
            margin-bottom: 20px;
        }

        nav {
            display: flex;
            flex-direction: column;
            padding: 0 20px;
/*            flex-grow: 1;*/
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
            gap: 10px;
        }

        .nav-item.active {
            background-color: var(--primary);
            color: white;
        }

        .nav-item:hover:not(.active) {
            background-color: var(--light-gray);
            color: var(--dark);
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 15px 20px;
            margin-top: 20px;
            border-top: 1px solid var(--light-gray);
            text-decoration: none;
            color: var(--dark);
            transition: background-color 0.3s;
            cursor:pointer;
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

        /* Main Content Styles */
        .main-content {
            padding: 30px;
            background-color: var(--light);
        }

        header {
            margin-bottom: 30px;
        }

        header h1 {
            margin: 0 0 10px;
            color: var(--dark);
            font-size: 28px;
        }

        header p {
            margin: 0;
            color: var(--gray);
        }

        /* Stats Cards */
        .stats-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background-color: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .stat-card a {
            text-decoration: none;
            color: inherit;
            display: block;
        }

        .stat-icon {
            font-size: 24px;
            color: var(--primary);
            margin-bottom: 15px;
        }

        .stat-card h3 {
            margin: 0 0 10px;
            color: var(--gray);
            font-size: 16px;
        }

        .stat-value {
            font-size: 28px;
            font-weight: bold;
            color: var(--dark);
        }

        /* Two Column Layout */
        .two-column-layout {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        @media (max-width: 1200px) {
            .two-column-layout {
                grid-template-columns: 1fr;
            }
        }

        /* Dashboard Cards */
        .dashboard-card {
            background-color: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 20px;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .card-header h3 {
            margin: 0;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .see-all {
            color: var(--primary);
            text-decoration: none;
            font-size: 14px;
        }

        .see-all:hover {
            text-decoration: underline;
        }

        /* Interview Items */
        .interview-item {
            padding: 15px;
            border-radius: 8px;
            background-color: white;
            margin-bottom: 15px;
            border-left: 4px solid var(--accent);
            transition: transform 0.3s, box-shadow 0.3s;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }

        .interview-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .interview-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .candidate-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .candidate-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--light-gray);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--gray);
        }

        .candidate-meta h4 {
            margin: 0;
            color: var(--dark);
        }

        .candidate-meta p {
            margin: 5px 0 0;
            color: var(--gray);
            font-size: 14px;
        }

        .interview-time {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 5px;
        }

        .interview-time span {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 14px;
            color: var(--gray);
        }

        .join-btn {
            background-color: var(--primary);
            color: white;
            padding: 8px 15px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
            text-decoration: none;
            font-size: 14px;
        }

        .join-btn:hover {
            background-color: var(--secondary);
        }

        /* Quick Actions */
        .quick-actions .card-body {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
        }

        .action-btn {
            background-color: var(--light-gray);
            color: var(--dark);
            padding: 15px;
            border-radius: 8px;
            text-decoration: none;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: all 0.3s;
        }

        .action-btn:hover {
            background-color: var(--primary);
            color: white;
        }

        .action-btn i {
            font-size: 24px;
        }

        /* Message Items */
        .message-item {
            display: flex;
            gap: 15px;
            padding: 15px 0;
            border-bottom: 1px solid var(--light-gray);
        }

        .message-item:last-child {
            border-bottom: none;
        }

        .message-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--light-gray);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--gray);
        }

        .message-content {
            flex: 1;
        }

        .message-sender {
            font-weight: 500;
            color: var(--dark);
            margin-bottom: 5px;
        }

        .message-preview {
            color: var(--gray);
            font-size: 14px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .no-data-message {
            color: var(--gray);
            text-align: center;
            padding: 20px;
        }

      

        .company-logo {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    object-fit: cover;
    border: 1px solid var(--light-gray);
}
.company-logo:hover {
    opacity: 0.8;
    transform: scale(1.05);
    transition: all 0.3s ease;
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
    
  <link rel="stylesheet" href="global-styles.css">    
    
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

        <div class="dashboard-container">
            <!-- Sidebar -->
            <aside class="sidebar" id="sidebar">
                <a href="HomePageF.aspx" class="logo">WorkHub</a>
                <nav>
                    <a href="HomePage.aspx" class="nav-item active">
                        <i class="fas fa-home"></i> Dashboard
                    </a>
                    <a href="JopsPosted.aspx" class="nav-item">
                        <i class="fas fa-briefcase"></i> Job Posts
                    </a>
                    <a href="WebForm1.aspx" class="nav-item">
                        <i class="fas fa-users"></i> Applications
                    </a>
                    <a href="CompanyProfile.aspx" class="nav-item">
                        <i class="fas fa-building"></i> Company Profile
                    </a>
                </nav>

                <div class="user-profile" onclick="window.location.href='CompanyProfile.aspx'">
    <% if (!string.IsNullOrEmpty(logoUrl)) { %>
        <img src="<%= logoUrl %>" alt="Company Logo" class="company-logo" />
    <% } else { %>
        <div class="avatar">
            <i class="fas fa-building"></i>
        </div>
    <% } %>
    <div class="username"><%= companyName %></div>
</div>
                 <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="nav-item" Style="margin: 20px; background-color: #f72585; color: white; border: none; border-radius: 8px; padding: 10px; font-weight: bold; cursor: pointer;" OnClick="btnLogout_Click" />
            </aside>

            <!-- Main Content -->
            <main class="main-content">
                <header>
                    <h1><i class="fas fa-tachometer-alt"></i> Company Dashboard</h1>
                    <p>Manage your job posts, applications, and interviews in one place</p>
                </header>

                <!-- Stats Cards -->
                <div class="stats-row">
                    <div class="stat-card">
                        <a href="JopsPosted.aspx" class="stat-link">
                            <div class="stat-icon">
                                <i class="fas fa-briefcase"></i>
                            </div>
                            <h3>Active Job Posts</h3>
                            <div class="stat-value"><asp:Label ID="lblJobCount" runat="server" /></div>
                        </a>
                    </div>
                    
                    <div class="stat-card">
                        <a href="WebForm1.aspx" class="stat-link">
                            <div class="stat-icon">
                                <i class="fas fa-file-alt"></i>
                            </div>
                            <h3>Applications Received</h3>
                            <div class="stat-value"><asp:Label ID="lblAppCount" runat="server" /></div>
                        </a>
                    </div>
                </div>

                <!-- Two Column Layout -->
                <div class="two-column-layout">
                    <!-- Left Column -->
                    <div class="column-left">
                        <!-- Interviews Section -->
                        <div class="dashboard-card">
                            <div class="card-header">
                                <h3><i class="fas fa-video"></i> Upcoming Interviews</h3>
                                <a href="WebForm1.aspx" class="see-all">See All</a>
                            </div>
                            <div class="card-body">
                                <asp:Repeater ID="rptInterviews" runat="server">
                                    <ItemTemplate>
                                        <div class="interview-item">
                                            <div class="interview-details">
                                                <div class="candidate-info">
                                                    <div class="candidate-avatar">
                                                        <i class="fas fa-user"></i>
                                                    </div>
                                                    <div class="candidate-meta">
                                                        <h4><%# Eval("SeekerName") %></h4>
                                                        <p>For: <%# Eval("JobTitle") %></p>
                                                    </div>
                                                </div>
                                                <div class="interview-time">
                                                    <span><i class="far fa-calendar"></i> <%# Eval("InterviewDate", "{0:MMM dd, yyyy}") %></span>
                                                    <span><i class="far fa-clock"></i> <%# Eval("InterviewTime") %></span>
                                                </div>
                                            </div>
                                            <div style="margin-top:10px; text-align:right;">
                                                <a href='<%# Eval("InterviewLink") %>' target="_blank" class="join-btn">
                                                    <i class="fas fa-video"></i> Join Meeting
                                                </a>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <asp:Label ID="lblNoInterviews" runat="server" Text="No upcoming interviews scheduled." Visible="false" CssClass="no-data-message"></asp:Label>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column -->
                    <div class="column-right">
                        <!-- Quick Actions -->
                        <div class="dashboard-card quick-actions">
                            <div class="card-header">
                                <h3><i class="fas fa-bolt"></i> Quick Actions</h3>
                            </div>
                            <div class="card-body">
                                <a href="companyPostJob.aspx" class="action-btn">
                                    <i class="fas fa-plus-circle"></i>
                                    <span>Post New Job</span>
                                </a>
                                <a href="WebForm1.aspx" class="action-btn">
                                    <i class="fas fa-search"></i>
                                    <span>View Applications</span>
                                </a>
                                <a href="CompanyProfile.aspx" class="action-btn">
                                    <i class="fas fa-edit"></i>
                                    <span>Edit Profile</span>
                                </a>
                            </div>
                        </div>

                        <!-- Messages Section -->
                        <div class="dashboard-card messages">
                            <div class="card-header">
                                <h3><i class="fas fa-envelope"></i> Recent Messages</h3>
                            </div>
                            <div class="card-body">
                                <asp:Repeater ID="rptMessages" runat="server">
                                    <ItemTemplate>
                                        <div class="message-item">
                                            <div class="message-avatar">
                                                <i class="fas fa-envelope"></i>
                                            </div>
                                            <div class="message-content">
                                                <div class="message-sender"><%# Eval("Email") %></div>
                                                <div class="message-preview"><%# Eval("Message") %></div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <asp:Label ID="lblNoMessages" runat="server" Text="No recent messages." Visible="false" CssClass="no-data-message"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
        <script>
            // Mobile responsive sidebar functionality
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
    </form>
</body>
    
</html>