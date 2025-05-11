<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CompanyProfile.aspx.cs" Inherits="workHub.CompanyProfile" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Company Profile | WorkHub</title>
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

        /* Main Content Styles */
        .main-content {
            padding: 30px;
            background-color: var(--light);
        }

        .profile-container {
            background-color: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            max-width: 800px;
            margin: 0 auto;
        }

        h1 {
            margin: 0 0 30px;
            color: var(--dark);
            font-size: 28px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--dark);
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--light-gray);
            border-radius: 6px;
            font-size: 14px;
            transition: all 0.3s;
        }

        .form-control:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .email-display {
            background-color: var(--light-gray);
            padding: 12px;
            border-radius: 6px;
            font-weight: 500;
            margin-bottom: 20px;
        }

        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
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
            border: 1px solid var(--gray);
            color: var(--dark);
        }

        .btn-outline:hover {
            background-color: var(--light-gray);
        }

        .validation-error {
            color: var(--warning);
            font-size: 13px;
            margin-top: 5px;
        }

        /* Confirmation Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            max-width: 500px;
            width: 90%;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
            text-align: center;
        }

        .modal-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 20px;
        }

        /* Responsive Styles */
        @media (max-width: 768px) {
            .dashboard-container {
                grid-template-columns: 1fr;
            }
            
           
            
            .button-group {
                flex-direction: column;
                gap: 10px;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
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
.username{
    font-weight:500;
}
.text-muted {
    color: var(--gray);
    font-size: 13px;
    display: block;
    margin-top: 5px;
}

/* Style the file upload control */
input[type="file"].form-control {
    padding: 8px;
    border: 1px dashed var(--light-gray);
    background-color: var(--light);
}

input[type="file"].form-control:hover {
    background-color: white;
    border-color: var(--primary);
}

.poster-preview {
    width: 120px;
    height: 80px;
    object-fit: cover;
    border-radius: 8px;
    border: 1px solid var(--light-gray);
}

.poster-upload-container {
    display: flex;
    align-items: center;
    gap: 20px;
    margin-bottom: 15px;
}

.poster-upload-info {
    flex: 1;
}

.poster-toggle {
    margin-top: 10px;
    display: flex;
    align-items: center;
    gap: 8px;
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
 .file-error {
            color: var(--warning);
            font-size: 13px;
            margin-top: 5px;
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
                    <a href="JopsPosted.aspx" class="nav-item">
                        <i class="fas fa-briefcase"></i> Job Posts
                    </a>
                    <a href="WebForm1.aspx" class="nav-item">
                        <i class="fas fa-users"></i> Applications
                    </a>
                    <a href="CompanyProfile.aspx" class="nav-item active">
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
                <div class="profile-container">
                    <h1><i class="fas fa-building"></i> Company Profile</h1>

                 <div class="form-group">
            <label>Company Logo</label>
            <div style="display: flex; align-items: center; gap: 20px; margin-bottom: 15px;">
                <% if (!string.IsNullOrEmpty(logoUrl)) { %>
                    <img src="<%= logoUrl %>" alt="Current Logo" style="width: 80px; height: 80px; object-fit: cover; border-radius: 8px; border: 1px solid var(--light-gray);" />
                <% } else { %>
                    <div style="width: 80px; height: 80px; background-color: var(--light-gray); display: flex; align-items: center; justify-content: center; border-radius: 8px;">
                        <i class="fas fa-building" style="font-size: 24px; color: var(--gray);"></i>
                    </div>
                <% } %>
                <div style="flex: 1;">
                    <asp:FileUpload ID="logoUpload" runat="server" CssClass="form-control" onchange="validateFileUpload(this, 4)" />
                    <small class="text-muted">Recommended size: 200x200 pixels (JPG, PNG). Max 4MB.</small>
                    <div id="logoUploadError" class="file-error">File size exceeds 4MB limit</div>
                </div>
            </div>
        </div>
                    
                    <div class="form-group">
                        <label>Email</label>
                        <div class="email-display">
                            <asp:Label ID="lblEmail" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="txtCompanyName">Company Name</label>
                        <asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    
                    <div class="form-group">
                        <label for="txtPhone">Phone</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    
                    <div class="form-group">
                        <label for="txtWebsite">Website</label>
                        <asp:TextBox ID="txtWebsite" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    
                    <div class="form-group">
                        <label for="txtLocation">Location</label>
                        <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    
                    <div class="form-group">
                        <label for="txtIndustry">Industry</label>
                        <asp:TextBox ID="txtIndustry" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    
                    <div class="form-group">
                        <label for="txtDescription">Description</label>
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox>
                    </div>

                   <div class="form-group">
            <label>Homepage Carousel Poster</label>
            <div style="display: flex; align-items: center; gap: 20px; margin-bottom: 15px;">
                <% if (!string.IsNullOrEmpty(posterUrl)) { %>
                    <img src="<%= posterUrl %>" alt="Current Poster" style="width: 120px; height: 80px; object-fit: cover; border-radius: 8px; border: 1px solid var(--light-gray);" />
                <% } else { %>
                    <div style="width: 120px; height: 80px; background-color: var(--light-gray); display: flex; align-items: center; justify-content: center; border-radius: 8px;">
                        <i class="fas fa-image" style="font-size: 24px; color: var(--gray);"></i>
                    </div>
                <% } %>
                <div style="flex: 1;">
                    <asp:FileUpload ID="posterUpload" runat="server" CssClass="form-control" onchange="validateFileUpload(this, 4)" />
                    <small class="text-muted">Recommended size: 1200x600 pixels (JPG, PNG). Max 4MB.</small>
                    <div id="posterUploadError" class="file-error">File size exceeds 4MB limit</div>
                    <div style="margin-top: 10px;">
                        <asp:CheckBox ID="chkPosterActive" runat="server" Checked="true" />
                        <label for="<%= chkPosterActive.ClientID %>">Show in homepage carousel</label>
                    </div>
                </div>
            </div>
        </div>
                    
                    <div class="button-group">
                        <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn btn-outline" OnClick="btnBack_Click" />
                        <button type="button" id="btnUpdateConfirm" class="btn btn-primary">
                            <i class="fas fa-save"></i> Update Profile
                        </button>
                        <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" CssClass="btn btn-primary" OnClick="btnUpdate_Click" style="display: none;" />
                    </div>
                </div>
            </main>
        </div>

        <!-- Confirmation Modal -->
        <div id="confirmationModal" class="modal">
            <div class="modal-content">
                <h3><i class="fas fa-question-circle"></i> Confirm Update</h3>
                <p>Are you sure you want to update your company profile information?</p>
                <div class="modal-buttons">
                    <button type="button" id="btnCancelUpdate" class="btn btn-outline">Cancel</button>
                    <button type="button" id="btnConfirmUpdate" class="btn btn-primary">Confirm Update</button>
                </div>
            </div>
        </div>
    </form>

    <script>
        // Confirmation dialog for update
        document.getElementById('btnUpdateConfirm').addEventListener('click', function() {
            document.getElementById('confirmationModal').style.display = 'flex';
        });

        document.getElementById('btnCancelUpdate').addEventListener('click', function() {
            document.getElementById('confirmationModal').style.display = 'none';
        });

        document.getElementById('btnConfirmUpdate').addEventListener('click', function() {
            document.getElementById('confirmationModal').style.display = 'none';
            document.getElementById('<%= btnUpdate.ClientID %>').click();
        });

        // Close modal when clicking outside
        window.addEventListener('click', function(event) {
            if (event.target === document.getElementById('confirmationModal')) {
                document.getElementById('confirmationModal').style.display = 'none';
            }
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

        function validateFileUpload(fileUpload, maxSizeMB) {
            const maxSizeBytes = maxSizeMB * 1024 * 1024; // Convert MB to bytes
            const errorElement = document.getElementById(fileUpload.id + 'Error');

            if (fileUpload.files.length > 0) {
                const fileSize = fileUpload.files[0].size;

                if (fileSize > maxSizeBytes) {
                    // Show error message
                    errorElement.style.display = 'block';
                    // Clear the file selection
                    fileUpload.value = '';
                    // Prevent form submission
                    document.getElementById('btnUpdateConfirm').disabled = true;
                } else {
                    // Hide error message if it was shown
                    errorElement.style.display = 'none';
                    // Enable submit button if it was disabled
                    document.getElementById('btnUpdateConfirm').disabled = false;
                }
            }
        }

        // Add event listener to check file sizes before form submission
        document.getElementById('btnUpdateConfirm').addEventListener('click', function (e) {
            const logoUpload = document.getElementById('<%= logoUpload.ClientID %>');
            const posterUpload = document.getElementById('<%= posterUpload.ClientID %>');
            const maxSizeBytes = 4 * 1024 * 1024; // 4MB in bytes

            // Check logo file size
            if (logoUpload.files.length > 0 && logoUpload.files[0].size > maxSizeBytes) {
                e.preventDefault();
                document.getElementById('logoUploadError').style.display = 'block';
                return false;
            }

            // Check poster file size
            if (posterUpload.files.length > 0 && posterUpload.files[0].size > maxSizeBytes) {
                e.preventDefault();
                document.getElementById('posterUploadError').style.display = 'block';
                return false;
            }

            // If validation passes, show confirmation modal
            document.getElementById('confirmationModal').style.display = 'flex';
        });
    </script>
</body>
</html>