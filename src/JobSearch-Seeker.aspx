<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="JobSearch-Seeker.aspx.cs" Inherits="workHub.JobSearch_Seeker" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Search | WorkHub</title>
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

        /* Search Filters */
        .search-filters {
            background-color: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }

        .search-bar {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }

        .search-bar input[type="text"] {
            flex: 1;
            padding: 12px 15px;
            border: 1px solid var(--light-gray);
            border-radius: 6px;
            font-size: 16px;
        }

        .search-btn {
            background-color: var(--primary);
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
            transition: background-color 0.3s;
        }

        .search-btn:hover {
            background-color: var(--secondary);
        }

        .filter-options {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .filter-options select {
            padding: 10px 15px;
            border: 1px solid var(--light-gray);
            border-radius: 6px;
            background-color: white;
            color: var(--dark);
            min-width: 180px;
        }

        /* Job Results */
        .job-results {
            background-color: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .result-count {
            color: var(--gray);
            margin-bottom: 20px;
            font-size: 14px;
        }

        .job-listings {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 20px;
        }

        .job-card {
            border: 1px solid var(--light-gray);
            border-radius: 8px;
            padding: 20px;
            transition: all 0.3s;
        }

        .job-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            border-color: var(--primary);
        }

        .job-card h3 {
            margin: 0 0 5px;
            color: var(--dark);
        }

        .job-card .company {
            margin: 0 0 10px;
            color: var(--primary);
            font-weight: 500;
        }

        .job-card .location {
            margin: 0 0 15px;
            color: var(--gray);
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .job-card .description {
            margin: 0 0 15px;
            color: var(--dark);
            font-size: 14px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .job-meta {
            display: flex;
            gap: 15px;
            margin-bottom: 15px;
            flex-wrap: wrap;
        }

        .job-meta span {
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 500;
        }

        .job-type {
            background-color: #e3f2fd;
            color: #1976d2;
        }

        .salary {
            background-color: #e8f5e9;
            color: #388e3c;
        }

        .apply-btn {
            display: inline-block;
            padding: 8px 20px;
            background-color: var(--primary);
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 500;
            transition: background-color 0.3s;
        }

        .apply-btn:hover {
            background-color: var(--secondary);
        }

        /* Responsive Styles */
        @media (max-width: 992px) {
            .job-listings {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .dashboard-container {
                grid-template-columns: 1fr;
            }
            
            .search-bar {
                flex-direction: column;
            }
            
            .filter-options {
                flex-direction: column;
            }
            
           
        }

        /* Add to your existing styles */
.job-card-header {
    display: flex;
    align-items: center;
    gap: 15px;
    margin-bottom: 15px;
}

.company-logo {
    width: 50px;
    height: 50px;
    border-radius: 8px;
    object-fit: cover;
    border: 1px solid var(--light-gray);
}

.company-logo-placeholder {
    width: 50px;
    height: 50px;
    border-radius: 8px;
    background-color: var(--light-gray);
    display: flex;
    align-items: center;
    justify-content: center;
    color: var(--gray);
    font-size: 20px;
}

.job-card-title {
    flex: 1;
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

.company-link {
    text-decoration: none;
    color: inherit;
    display: flex;
    align-items: center;
}

.company-link:hover {
    opacity: 0.8;
}

.company-logo {
    transition: transform 0.2s;
}

.company-link:hover .company-logo {
    transform: scale(1.05);
}

.job-card .company a {
    color: var(--primary);
    text-decoration: none;
}

.job-card .company a:hover {
    text-decoration: underline;
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
      <div></div>
  </div>

         <div class="overlay" id="overlay"></div>


        <div class="dashboard-container">
            <aside class="sidebar" id="sidebar">
                <a href="HomePageF.aspx" class="logo">WorkHub</a>
                <nav>
                    <a href="dashboard-seeker.aspx" class="nav-item">
                        <i class="fas fa-home"></i> Dashboard
                    </a>
                    <a href="jobsearch-seeker.aspx" class="nav-item active">
                        <i class="fas fa-briefcase"></i> Jobs
                    </a>
                    <a href="applications-seeker.aspx" class="nav-item">
                        <i class="fas fa-file-alt"></i> Applications
                    </a>
                    <a href="Notification-Seeker.aspx" class="nav-item">
                        <i class="fas fa-bell"></i> Notifications
                    </a>
                    <a href="interview2.aspx" class="nav-item">
                        <i class="fas fa-video"></i> Interviews
                    </a>
                     <a href="seeker-resumes.aspx" class="nav-item">
    <i class="fas fa-file-pdf"></i> My Resumes
</a>
                </nav>

                <a class="user-profile" href="SeekerProfile.aspx">
                    <div class="avatar">
                        <i class="fas fa-user"></i>
                    </div>
                    <span class="username"><asp:Literal ID="litUsername" runat="server" /></span>
                </a>
                  <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="nav-item" Style="margin: 20px; background-color: #f72585; color: white; border: none; border-radius: 8px; padding: 10px; font-weight: bold; cursor: pointer;" OnClick="btnLogout_Click" />
            </aside>

            <main class="main-content">
                <header>
                    <h1><i class="fas fa-search"></i> Job Search</h1>
                    <p>Find your next career opportunity</p>
                </header>

                <section class="search-filters">
                    <div class="search-bar">
                        <asp:TextBox ID="txtKeyword" runat="server" placeholder="Job title, keywords, or company" />
                        <asp:TextBox ID="txtLocation" runat="server" placeholder="Location" />
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="search-btn" OnClick="btnSearch_Click" />
                    </div>
                    <div class="filter-options">
                        <asp:DropDownList ID="ddlJobType" runat="server">
                            <asp:ListItem Text="Job Type" Value="" />
                            <asp:ListItem Text="Full-Time" Value="Full-Time" />
                            <asp:ListItem Text="Part-time" Value="Part-time" />
                            <asp:ListItem Text="Contract" Value="Contract" />
                            <asp:ListItem Text="Remote" Value="Remote" />
                        </asp:DropDownList>

                        <asp:DropDownList ID="ddlExperience" runat="server">
                            <asp:ListItem Text="Experience Level" Value="" />
                            <asp:ListItem Text="Entry Level" Value="Entry Level" />
                            <asp:ListItem Text="Mid Level" Value="Mid Level" />
                            <asp:ListItem Text="Senior Level" Value="Senior Level" />
                        </asp:DropDownList>

                        <asp:DropDownList ID="ddlSalary" runat="server">
                            <asp:ListItem Text="Salary Range" Value="" />
                            <asp:ListItem Text="Under 5,000 SAR" Value="under" />
                            <asp:ListItem Text="10,000 - 5000 SAR" Value="mid" />
                             <asp:ListItem Text="20,000 - 10,000 SAR" Value="mid" />
                            <asp:ListItem Text="Over 20,000 SAR" Value="over" />
                        </asp:DropDownList>
                    </div>
                </section>

                <section class="job-results">
                    <div class="result-count">Showing <%= jobPosts.Count %> jobs</div>
                    <div class="job-listings">
                        <% foreach (var job in jobPosts)
                           {
                               string title = job.GetValue("Title", "N/A").ToString();
                               string company = job.GetValue("CompanyName", "Unknown Company").ToString();
                               string location = job.GetValue("Location", "Remote").ToString();
                               string description = job.GetValue("JobSummary", "No summary provided").ToString();
                               string jobType = job.GetValue("JobType", "N/A").ToString();
                               string salary = job.GetValue("Salary", "Negotiable").ToString();
                                string logoPath = job.GetValue("LogoPath", "").ToString();
                        %>
                       <div class="job-card">
    <div class="job-card-header">
        <a href='CompanyDetails.aspx?id=<%= job["CompanyId"] %>' class="company-link">
            <% if (!string.IsNullOrEmpty(job.GetValue("LogoPath", "").ToString())) { %>
                <img src='<%= job["LogoPath"] %>' alt="<%= company %> logo" class="company-logo" />
            <% } else { %>
                <div class="company-logo-placeholder"><i class="fas fa-building"></i></div>
            <% } %>
        </a>
        <div class="job-card-title">
            <h3><%= title %></h3>
            <p class="company">
                <a href='CompanyDetails.aspx?id=<%= job["CompanyId"] %>' class="company-link"><%= company %></a>
            </p>
        </div>
    </div>
    <p class="location"><i class="fas fa-map-marker-alt"></i> <%= location %></p>
    <p class="description"><%= description %></p>
    <div class="job-meta">
        <span class="job-type"><%= jobType %></span>
        <span class="salary"><%= salary %></span>
    </div>
    <a href='ApplyJob.aspx?jobId=<%= job["_id"] %>' class="apply-btn">Apply Now</a>
</div>
                        <% } %>
                    </div>
                </section>
            </main>
        </div>
    </form>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            document.querySelectorAll('.apply-btn').forEach(btn => {
                btn.addEventListener('click', function (e) {
                    const jobTitle = this.parentElement.querySelector('h3').textContent;
                    console.log(`Applying for: ${jobTitle}`);
                    // You can add additional logic here if needed
                });
            });
        });

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