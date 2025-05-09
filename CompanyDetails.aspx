<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CompanyDetails.aspx.cs" Inherits="workHub.CompanyDetails" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Company Details | WorkHub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="global-styles.css">
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

        /* Main Content Styles */
        .main-content {
            padding: 30px;
            background-color: var(--light);
        }

        .company-header {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 30px;
        }

        .company-logo-large {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--light-gray);
        }

        .company-info h1 {
            margin: 0;
            color: var(--dark);
        }

        .company-meta {
            display: flex;
            gap: 15px;
            margin-top: 10px;
            color: var(--gray);
            font-size: 14px;
        }

        .company-meta i {
            margin-right: 5px;
            color: var(--primary);
        }

        .company-poster {
            width: 100%;
            max-height: 300px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .company-description {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        /* Reviews Section */
        .reviews-section {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .reviews-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .review-card {
            border-bottom: 1px solid var(--light-gray);
            padding: 15px 0;
        }

        .review-card:last-child {
            border-bottom: none;
        }

        .review-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
        }

        .reviewer-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--light-gray);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--gray);
        }

        .reviewer-name {
            font-weight: 500;
        }

        .review-date {
            color: var(--gray);
            font-size: 12px;
        }

        .review-rating {
            color: #ffc107;
            margin-bottom: 5px;
        }

        /* Review Form */
        .review-form {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            margin-top: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid var(--light-gray);
            border-radius: 6px;
            font-size: 14px;
        }

        textarea.form-control {
            min-height: 100px;
        }

        .rating-stars {
            display: flex;
            gap: 5px;
            margin-bottom: 10px;
        }

        .rating-star {
            font-size: 24px;
            color: var(--light-gray);
            cursor: pointer;
        }

        .rating-star.active {
            color: #ffc107;
        }

        .btn {
            padding: 10px 20px;
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s;
        }

        .btn:hover {
            background-color: var(--secondary);
        }

        /* Responsive Styles */
        @media (max-width: 768px) {
            .dashboard-container {
                grid-template-columns: 1fr;
            }

            .company-header {
                flex-direction: column;
                text-align: center;
            }

            .company-meta {
                justify-content: center;
                flex-wrap: wrap;
            }
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
                    <a href="jobsearch-seeker.aspx" class="nav-item">
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
                <div class="company-header">
                    <asp:Image ID="imgCompanyLogo" runat="server" CssClass="company-logo-large" />
                    <div class="company-info">
                        <h1><asp:Literal ID="litCompanyName" runat="server" /></h1>
                        <div class="company-meta">
                            <span><i class="fas fa-map-marker-alt"></i> <asp:Literal ID="litLocation" runat="server" /></span>
                            <span><i class="fas fa-industry"></i> <asp:Literal ID="litIndustry" runat="server" /></span>
                            <span><i class="fas fa-globe"></i> <asp:HyperLink ID="lnkWebsite" runat="server" Target="_blank">Website</asp:HyperLink></span>
                        </div>
                    </div>
                </div>

                <asp:Image ID="imgCompanyPoster" runat="server" CssClass="company-poster" Visible="false" />

                <div class="company-description">
                    <h3>About Us</h3>
                    <asp:Literal ID="litDescription" runat="server" />
                </div>

                <div class="reviews-section">
                    <div class="reviews-header">
                        <h3>Reviews</h3>
                        <div>
                            <span><i class="fas fa-star" style="color: #ffc107;"></i> <asp:Literal ID="litAverageRating" runat="server" /></span>
                            <span style="margin-left: 10px;"><asp:Literal ID="litReviewCount" runat="server" /> reviews</span>
                        </div>
                    </div>

                   <asp:Repeater ID="rptReviews" runat="server">
    <ItemTemplate>
        <div class="review-card">
            <div class="review-header">
                <div class="reviewer-avatar">
                    <i class="fas fa-user"></i>
                </div>
                <div>
                    <div class="reviewer-name"><%# ((Dictionary<string, object>)Container.DataItem)["seekerName"] %></div>
                    <div class="review-date"><%# ((DateTime)((Dictionary<string, object>)Container.DataItem)["createdAt"]).ToString("MMMM dd, yyyy") %></div>
                </div>
            </div>
            <div class="review-rating">
                <%# GetStarRating((int)((Dictionary<string, object>)Container.DataItem)["rating"]) %>
            </div>
            <div class="review-content">
                <%# ((Dictionary<string, object>)Container.DataItem)["comment"] %>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>

                    <div class="review-form">
                        <h3>Add Your Review</h3>
                        <div class="form-group">
                            <label>Rating</label>
                            <div class="rating-stars" id="ratingStars">
                                <i class="fas fa-star rating-star" data-rating="1"></i>
                                <i class="fas fa-star rating-star" data-rating="2"></i>
                                <i class="fas fa-star rating-star" data-rating="3"></i>
                                <i class="fas fa-star rating-star" data-rating="4"></i>
                                <i class="fas fa-star rating-star" data-rating="5"></i>
                            </div>
                            <asp:HiddenField ID="hdnRating" runat="server" Value="0" />
                        </div>
                        <div class="form-group">
                            <label for="txtReview">Your Review</label>
                            <asp:TextBox ID="txtReview" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                        </div>
                        <asp:Button ID="btnSubmitReview" runat="server" Text="Submit Review" CssClass="btn" OnClick="btnSubmitReview_Click" />
                    </div>
                </div>
            </main>
        </div>
    </form>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Rating stars interaction
            const stars = document.querySelectorAll('.rating-star');
            const hiddenRating = document.getElementById('<%= hdnRating.ClientID %>');
            
            stars.forEach(star => {
                star.addEventListener('click', function() {
                    const rating = parseInt(this.getAttribute('data-rating'));
                    hiddenRating.value = rating;
                    
                    stars.forEach((s, index) => {
                        if (index < rating) {
                            s.classList.add('active');
                        } else {
                            s.classList.remove('active');
                        }
                    });
                });
            });

            // Mobile sidebar toggle
            const sidebar = document.getElementById("sidebar");
            const sidebarToggle = document.getElementById("sidebarToggle");
            const overlay = document.getElementById("overlay");

            if (sidebar && sidebarToggle && overlay) {
                sidebarToggle.addEventListener("click", (e) => {
                    e.preventDefault();
                    sidebar.classList.toggle("active");
                    overlay.classList.toggle("active");
                });

                overlay.addEventListener("click", () => {
                    sidebar.classList.remove("active");
                    overlay.classList.remove("active");
                });

                window.addEventListener("resize", () => {
                    if (window.innerWidth > 768) {
                        sidebar.classList.remove("active");
                        overlay.classList.remove("active");
                    }
                });
            }
        });
    </script>
</body>
</html>