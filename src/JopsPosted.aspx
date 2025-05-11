<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="JopsPosted.aspx.cs" Inherits="workHub.JopsPosted" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jobs Posted | WorkHub</title>
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
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        header h1 {
            margin: 0;
            color: var(--dark);
            font-size: 28px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .btn-back {
            background-color: var(--gray);
            color: white;
            padding: 8px 16px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            margin-bottom: 20px;
        }

        .btn-back:hover {
            background-color: var(--dark);
        }

        .btn-new-job {
            background-color: var(--primary);
            color: white;
            padding: 10px 20px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 5px;
            text-decoration: none;
            font-size: 14px;
        }

        .btn-new-job:hover {
            background-color: var(--secondary);
        }

        /* Jobs Table */
        .jobs-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
        }

        .jobs-table thead {
            background-color: var(--primary);
            color: white;
        }

        .jobs-table th {
            padding: 15px;
            text-align: left;
            font-weight: 500;
        }

        .jobs-table td {
            padding: 15px;
            border-bottom: 1px solid var(--light-gray);
        }

        .jobs-table tr:last-child td {
            border-bottom: none;
        }

        .jobs-table tr:hover {
            background-color: rgba(67, 97, 238, 0.05);
        }

        .status-active {
            color: var(--success);
            font-weight: 500;
        }

        .status-inactive {
            color: var(--gray);
            font-weight: 500;
        }

        .status-closed {
            color: var(--warning);
            font-weight: 500;
        }

        .table-btn {
            padding: 6px 12px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s;
            font-size: 13px;
            margin-right: 5px;
        }

        .btn-edit {
            background-color: var(--accent);
            color: white;
        }

        .btn-edit:hover {
            background-color: #3a7bd5;
        }

        .btn-delete {
            background-color: var(--warning);
            color: white;
        }

        .btn-delete:hover {
            background-color: #d31653;
        }

        .btn-view {
            background-color: var(--success);
            color: white;
        }

        .btn-view:hover {
            background-color: #3ab7d8;
        }

        /* Responsive Styles */
        @media (max-width: 768px) {
            .dashboard-container {
                grid-template-columns: 1fr;
            }
            
           
            
            .jobs-table {
                display: block;
                overflow-x: auto;
            }
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
                <a href="HomePage.aspx" class="logo">WorkHub</a>
                <nav>
                    <a href="HomePage.aspx" class="nav-item">
                        <i class="fas fa-home"></i> Dashboard
                    </a>
                    <a href="JopsPosted.aspx" class="nav-item active">
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
                <a href="HomePage.aspx" class="btn-back">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
                
                <header>
                    <h1><i class="fas fa-briefcase"></i> Jobs Posted</h1>
                    <a href="companyPostJob.aspx" class="btn-new-job">
                        <i class="fas fa-plus"></i> New Job
                    </a>
                </header>

                <div class="content">
                    <table class="jobs-table">
                        <thead>
                            <tr>
                                <th>Job Title</th>
                                <th>Status</th>
                                <th>Activation Date</th>
                                <th>Applicants</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="JobsRepeater" runat="server" OnItemCommand="JobsRepeater_ItemCommand">
                                <ItemTemplate>
                                    <tr>
                                        <td><%# Eval("title") %></td>
                                        <td class='status-<%# Eval("status").ToString().ToLower() %>'><%# Eval("status") %></td>
                                        <td><%# Eval("activationDate") %></td>
                                        <td><%# Eval("applicants") %> applicant(s)</td>
                                        <td>
                                            <asp:Button runat="server" Text="Update" CommandName="UpdateJob" CommandArgument='<%# Eval("id") %>' CssClass="table-btn btn-edit" />
                                            <asp:Button runat="server" Text="Delete" CommandName="DeleteJob" CommandArgument='<%# Eval("id") %>' CssClass="table-btn btn-delete" OnClientClick="return confirm('Are you sure you want to delete this job and all its applications?');" />
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
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