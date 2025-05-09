<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="interview2.aspx.cs" Inherits="workHub.interview2" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Interviews | WorkHub</title>
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

        .container {
            display: grid;
            grid-template-columns: 250px 1fr;
            min-height: 100vh;
        }

        .sidebar {
            background-color: white;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
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

        .main-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .search-bar {
            display: flex;
            align-items: center;
            background-color: white;
            border-radius: 30px;
            padding: 8px 15px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            width: 300px;
            display:none;
        }

        .search-bar input {
            border: none;
            outline: none;
            flex: 1;
            padding: 5px 10px;
        }

        .search-bar button {
            background: none;
            border: none;
            color: var(--gray);
            cursor: pointer;
        }

        .profile-header {
            display: flex;
            align-items: center;
            gap: 10px;
            color: var(--gray);
        }

        .profile-header img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }

        .interview-list {
            background-color: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .interview-list h2 {
            margin-top: 0;
            color: var(--dark);
            border-bottom: 1px solid var(--light-gray);
            padding-bottom: 15px;
        }

        .filter-section {
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .filter-section label {
            font-weight: 500;
            color: var(--gray);
        }

        .filter-section select {
            padding: 8px 15px;
            border-radius: 6px;
            border: 1px solid var(--light-gray);
            background-color: white;
        }

        .interview-card {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            border-radius: 8px;
            background-color: white;
            margin-bottom: 15px;
            border-left: 4px solid var(--primary);
            transition: transform 0.3s, box-shadow 0.3s;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }

        .interview-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .interview-info {
            flex: 1;
        }

        .interview-info h3 {
            margin: 0 0 5px;
            color: var(--dark);
        }

        .interview-info p {
            margin: 5px 0;
            color: var(--gray);
            font-size: 14px;
        }

        .interview-meta {
            display: flex;
            gap: 15px;
            margin-top: 10px;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 13px;
            color: var(--gray);
        }

        .interview-actions {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 8px 15px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--secondary);
        }

        .btn-outline {
            background-color: transparent;
            border: 1px solid var(--primary);
            color: var(--primary);
        }

        .btn-outline:hover {
            background-color: var(--light-gray);
        }

        .status-badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-interview {
            background-color: #e3f2fd;
            color: #1976d2;
        }

        .status-completed {
            background-color: #e8f5e9;
            color: #388e3c;
        }

        .status-cancelled {
            background-color: #ffebee;
            color: #d32f2f;
        }

        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: var(--gray);
        }

        .empty-state i {
            font-size: 50px;
            color: var(--light-gray);
            margin-bottom: 15px;
        }

        .empty-state p {
            margin-bottom: 20px;
        }

        .company-logo {
            width: 50px;
            height: 50px;
            border-radius: 8px;
            background-color: var(--light-gray);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            margin-right: 15px;
        }

        .company-logo img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .interview-datetime {
            text-align: right;
            margin-right: 20px;
        }

        .interview-datetime .date {
            font-weight: 500;
            color: var(--dark);
        }

        .interview-datetime .time {
            font-size: 14px;
            color: var(--gray);
        }

        @media (max-width: 768px) {
            .container {
                grid-template-columns: 1fr;
            }
            .interview-card {
                flex-direction: column;
                align-items: flex-start;
            }
            .interview-actions {
                margin-top: 15px;
                width: 100%;
                justify-content: flex-end;
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
                    <a href="Notification-Seeker.aspx" class="nav-item"><i class="fas fa-bell"></i> Notifications</a>
                    <a href="interview2.aspx" class="nav-item active"><i class="fas fa-video"></i> Interviews</a>
                     <a href="seeker-resumes.aspx" class="nav-item">
    <i class="fas fa-file-pdf"></i> My Resumes
</a>
                </nav>
                <a class="user-profile" href="SeekerProfile.aspx">
    <div class="avatar">
        <i class="fas fa-user"></i>
    </div>
     <span class="username"><asp:Literal ID="lblUserName" runat="server" /></span>
</a>
                  <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="nav-item" Style=" background-color: #f72585; color: white; border: none; border-radius: 8px; padding: 10px; font-weight: bold; cursor: pointer; width:80%; margin:0 auto;" OnClick="btnLogout_Click" />
            </aside>
            <main class="main-content">
                <header class="main-header">
                    <div class="search-bar">
                        <asp:TextBox ID="txtSearch" runat="server" placeholder="Search interviews..." BorderStyle="None"></asp:TextBox>
                        <asp:Button ID="btnSearch" runat="server" Text="&#xf002;" CssClass="fas" OnClick="btnSearch_Click" BorderStyle="None" BackColor="Transparent" />
                    </div>
                    
                </header>

                <div class="interview-list">
                    <h2><i class="fas fa-calendar-day"></i> My Scheduled Interviews</h2>
                    <div class="filter-section">
                        <label for="ddlStatusFilter">Filter by:</label>
                        <asp:DropDownList ID="ddlStatusFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlStatusFilter_SelectedIndexChanged">
                            <asp:ListItem Value="All">All Interviews</asp:ListItem>
                            <asp:ListItem Value="Upcoming">Upcoming</asp:ListItem>
                            <asp:ListItem Value="Completed">Completed</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <asp:Repeater ID="rptInterviews" runat="server">
                        <ItemTemplate>
                            <div class="interview-card">
                                <div style="display: flex; align-items: center;">
                                    
                                    <div class="interview-info">
                                        <h3><%# Eval("JobTitle") %></h3>
                                        <p><%# Eval("CompanyName") %></p>
                                        <div class="interview-meta">
                                            <div class="meta-item"><i class="fas fa-map-marker-alt"></i> <%# Eval("Location") %></div>
                                            <div class="meta-item"><i class="fas fa-briefcase"></i> <%# Eval("JobType") %></div>
                                            <span class='status-badge status-<%# Eval("Status").ToString().ToLower() %>'><%# Eval("Status") %></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="interview-datetime">
                                    <div class="date"><%# ((DateTime)Eval("InterviewDate")).ToString("MMM dd, yyyy") %></div>
                                    <div class="time"><i class="far fa-clock"></i> <%# Eval("InterviewTime") %></div>
                                </div>
                                <div class="interview-actions">
                                    <asp:Button ID="btnJoinInterview" runat="server" Text='Join Interview' CssClass="btn btn-primary" CommandArgument='<%# Eval("InterviewLink") %>' OnClick="btnJoinInterview_Click" />
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:Label ID="lblNoInterviews" runat="server" CssClass="empty-state" Visible="false">
                        <i class="far fa-calendar-times"></i>
                        <p>No interviews scheduled yet</p>
                        <a href="jobsearch-seeker.aspx" class="btn btn-primary">Browse Jobs</a>
                    </asp:Label>
                </div>
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
