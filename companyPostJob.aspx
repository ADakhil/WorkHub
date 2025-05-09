<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="companyPostJob.aspx.cs" Inherits="workHub.companyPostJob" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Post Job | WorkHub</title>
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
            flex-grow: 1;
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
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* Form Styles */
        .form-container {
            background-color: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .steps {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
            position: relative;
        }

        .steps::before {
            content: '';
            position: absolute;
            top: 15px;
            left: 0;
            right: 0;
            height: 2px;
            background-color: var(--light-gray);
            z-index: 1;
        }

        .step {
            position: relative;
            text-align: center;
            z-index: 2;
            padding: 10px 15px;
            background-color: var(--light-gray);
            border-radius: 20px;
            color: var(--gray);
            font-weight: 500;
            transition: all 0.3s;
        }

        .step.active {
            background-color: var(--primary);
            color: white;
        }

        .form-step {
            display: none;
        }

        .form-step.active {
            display: block;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 60px;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--dark);
        }

        .form-group label::after {
            content: '*';
            color: var(--warning);
            margin-left: 4px;
            display: none;
        }

        .form-group.required label::after {
            display: inline;
        }

        .form-control {
            width: 100%;
            padding: 10px 15px;
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

        .form-control[aria-invalid="true"] {
            border-color: var(--warning);
        }

        .form-control[aria-invalid="true"]:focus {
            box-shadow: 0 0 0 3px rgba(220, 53, 69, 0.1);
        }

        textarea.form-control {
            min-height: 100px;
            resize: vertical;
        }

        .form-buttons {
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

        .error-message {
            color: var(--warning);
            font-size: 13px;
            margin-top: 5px;
            display: none;
        }

        .message-box {
            padding: 15px;
            margin: 20px 0;
            border-radius: 6px;
            display: none;
        }

        .message-success {
            background-color: rgba(76, 201, 240, 0.1);
            border: 1px solid var(--success);
            color: var(--success);
        }

        .message-error {
            background-color: rgba(247, 37, 133, 0.1);
            border: 1px solid var(--warning);
            color: var(--warning);
        }

        /* Checkbox Styles */
        .checkbox-group {
            display: flex;
            align-items: center;
            margin: 20px 0;
        }

        .checkbox-group input[type="checkbox"] {
            margin-right: 10px;
            width: 18px;
            height: 18px;
        }

        /* Responsive Styles */
        @media (max-width: 768px) {
            .dashboard-container {
                grid-template-columns: 1fr;
            }
            
           
            
            .steps {
                flex-direction: column;
                gap: 10px;
            }
            
            .steps::before {
                display: none;
            }
            
            .step {
                width: 100%;
            }
            
            .form-grid {
                grid-template-columns: 1fr;
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
                    <a href="CompanyProfile.aspx" class="nav-item">
                        <i class="fas fa-building"></i> Company Profile
                    </a>
                </nav>

                <div class="user-profile">
                    <div class="avatar">
                        <i class="fas fa-user"></i>
                    </div>
                    <div class="username">Company</div>
                </div>
            </aside>

            <!-- Main Content -->
            <main class="main-content">
                <header>
                    <h1><i class="fas fa-plus-circle"></i> Post New Job</h1>
                </header>

                <div class="form-container">
                    <div class="steps">
                        <div class="step active" data-step="1">Basic Information</div>
                        <div class="step" data-step="2">Job Description</div>
                        <div class="step" data-step="3">Hiring Process</div>
                        <div class="step" data-step="4">Confirmation</div>
                    </div>

                    <div id="messageBox" runat="server" class="message-box">
                        <asp:Label ID="lblMessage" runat="server" />
                    </div>

                    <!-- Step 1: Basic Information -->
                    <div class="form-step active" id="step-1">
                        <h2>Basic Information</h2>
                        <div class="form-grid">
                            <div class="form-group required">
                                <label for="txtTitle">Job Title</label>
                                <asp:TextBox ID="txtTitle" runat="server" placeholder="Job Title" CssClass="form-control" required aria-required="true" />
                                <div class="error-message">Please enter a job title</div>
                            </div>
                            <div class="form-group required">
                                <label for="ddlJobStatus">Job Status</label>
                                <asp:DropDownList ID="ddlJobStatus" runat="server" CssClass="form-control" required aria-required="true">
                                    <asp:ListItem Text="Select Job Status" Value="" />
                                    <asp:ListItem Text="Active" Value="Active" />
                                    <asp:ListItem Text="Draft" Value="Draft" />
                                </asp:DropDownList>
                                <div class="error-message">Please select a job status</div>
                            </div>
                            <div class="form-group required">
                                <label for="txtDepartment">Department</label>
                                <asp:TextBox ID="txtDepartment" runat="server" placeholder="Department" CssClass="form-control" required aria-required="true" />
                                <div class="error-message">Please enter a department</div>
                            </div>
                            <div class="form-group required">
                                <label for="ddlExperienceLevel">Experience Level</label>
                                <asp:DropDownList ID="ddlExperienceLevel" runat="server" CssClass="form-control" required aria-required="true">
                                    <asp:ListItem Text="Select Experience Level" Value="" />
                                    <asp:ListItem Text="Entry Level" Value="Entry Level" />
                                    <asp:ListItem Text="Mid Level" Value="Mid Level" />
                                    <asp:ListItem Text="Senior Level" Value="Senior Level" />
                                </asp:DropDownList>
                                <div class="error-message">Please select an experience level</div>
                            </div>
                            <div class="form-group required">
                                <label for="txtCountry">Country</label>
                                <asp:TextBox ID="txtCountry" runat="server" placeholder="Country" CssClass="form-control" required aria-required="true" />
                                <div class="error-message">Please enter a country</div>
                            </div>
                            <div class="form-group required">
                                <label for="txtLocation">Location</label>
                                <asp:TextBox ID="txtLocation" runat="server" placeholder="Location" CssClass="form-control" required aria-required="true" />
                                <div class="error-message">Please enter a location</div>
                            </div>
                            <div class="form-group required">
                                <label for="txtCity">City</label>
                                <asp:TextBox ID="txtCity" runat="server" placeholder="City" CssClass="form-control" required aria-required="true" />
                                <div class="error-message">Please enter a city</div>
                            </div>
                            <div class="form-group required">
                                <label for="txtSalary">Salary</label>
                                <asp:TextBox ID="txtSalary" runat="server" placeholder="e.g. 50000 or Negotiable" CssClass="form-control" required aria-required="true" />
                                <div class="error-message">Please enter salary information</div>
                            </div>
                            <div class="form-group required">
                                <label for="ddlJobType">Job Type</label>
                                <asp:DropDownList ID="ddlJobType" runat="server" CssClass="form-control" required aria-required="true">
                                    <asp:ListItem Text="Select Job Type" Value="" />
                                    <asp:ListItem Text="Full-Time" Value="Full-Time" />
                                    <asp:ListItem Text="Part-Time" Value="Part-Time" />
                                    <asp:ListItem Text="Remote" Value="Remote" />
                                    <asp:ListItem Text="Hybrid" Value="Hybrid" />
                                    <asp:ListItem Text="Contract" Value="Contract" />
                                </asp:DropDownList>
                                <div class="error-message">Please select a job type</div>
                            </div>
                        </div>
                        <div class="form-buttons">
                            <button type="button" class="btn btn-outline" data-prev="1" disabled>
                                <i class="fas fa-arrow-left"></i> Previous
                            </button>
                            <button type="button" class="btn btn-primary" data-next="2">
                                Next <i class="fas fa-arrow-right"></i>
                            </button>
                        </div>
                    </div>

                    <!-- Step 2: Job Description -->
                    <div class="form-step" id="step-2">
                        <h2>Job Description</h2>
                        <div class="form-grid">
                            <div class="form-group required">
                                <label for="txtJobSummary">Job Summary</label>
                                <asp:TextBox ID="txtJobSummary" runat="server" TextMode="MultiLine" placeholder="Job Summary" CssClass="form-control" required aria-required="true" />
                                <div class="error-message">Please enter a job summary</div>
                            </div>
                            <div class="form-group required">
                                <label for="txtKeyResponsibilities">Key Responsibilities</label>
                                <asp:TextBox ID="txtKeyResponsibilities" runat="server" TextMode="MultiLine" placeholder="Key Responsibilities" CssClass="form-control" required aria-required="true" />
                                <div class="error-message">Please enter key responsibilities</div>
                            </div>
                            <div class="form-group required">
                                <label for="txtRequiredQualifications">Required Qualifications</label>
                                <asp:TextBox ID="txtRequiredQualifications" runat="server" TextMode="MultiLine" placeholder="Required Qualifications" CssClass="form-control" required aria-required="true" />
                                <div class="error-message">Please enter required qualifications</div>
                            </div>
                            <div class="form-group">
                                <label for="txtPreferredQualifications">Preferred Qualifications</label>
                                <asp:TextBox ID="txtPreferredQualifications" runat="server" TextMode="MultiLine" placeholder="Preferred Qualifications" CssClass="form-control" />
                            </div>
                            <div class="form-group required">
                                <label for="txtSkillsNeeded">Skills Needed</label>
                                <asp:TextBox ID="txtSkillsNeeded" runat="server" TextMode="MultiLine" placeholder="Skills Needed" CssClass="form-control" required aria-required="true" />
                                <div class="error-message">Please enter required skills</div>
                            </div>
                            <div class="form-group">
                                <label for="txtWorkEnvironment">Work Environment</label>
                                <asp:TextBox ID="txtWorkEnvironment" runat="server" TextMode="MultiLine" placeholder="Work Environment" CssClass="form-control" />
                            </div>
                            <div class="form-group">
                                <label for="txtBenefits">Benefits</label>
                                <asp:TextBox ID="txtBenefits" runat="server" TextMode="MultiLine" placeholder="Benefits" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="form-buttons">
                            <button type="button" class="btn btn-outline" data-prev="1">
                                <i class="fas fa-arrow-left"></i> Previous
                            </button>
                            <button type="button" class="btn btn-primary" data-next="3">
                                Next <i class="fas fa-arrow-right"></i>
                            </button>
                        </div>
                    </div>

                    <!-- Step 3: Hiring Process -->
                    <div class="form-step" id="step-3">
                        <h2>Hiring Process</h2>
                        <div class="form-grid">
                            <div class="form-group required">
                                <label for="txtApplicationSubmission">Application Submission</label>
                                <asp:TextBox ID="txtApplicationSubmission" runat="server" TextMode="MultiLine" placeholder="Application Submission" CssClass="form-control" required aria-required="true" />
                                <div class="error-message">Please enter application submission details</div>
                            </div>
                            <div class="form-group required">
                                <label for="txtApplicationDeadline">Application Deadline</label>
                                <asp:TextBox ID="txtApplicationDeadline" runat="server" TextMode="SingleLine" placeholder="Application Deadline" CssClass="form-control" required aria-required="true" />
                                <div class="error-message">Please enter an application deadline</div>
                            </div>
                            <div class="form-group required">
                                <label for="txtOfferProcess">Offer Process</label>
                                <asp:TextBox ID="txtOfferProcess" runat="server" TextMode="MultiLine" placeholder="Offer Process" CssClass="form-control" required aria-required="true" />
                                <div class="error-message">Please enter offer process details</div>
                            </div>
                            <div class="form-group required">
                                <label for="txtInterviewProcess">Interview Process</label>
                                <asp:TextBox ID="txtInterviewProcess" runat="server" TextMode="MultiLine" placeholder="Interview Process" CssClass="form-control" required aria-required="true" />
                                <div class="error-message">Please enter interview process details</div>
                            </div>
                            <div class="form-group">
                                <label for="txtAssessmentTasks">Assessment Tasks</label>
                                <asp:TextBox ID="txtAssessmentTasks" runat="server" TextMode="MultiLine" placeholder="Assessment Tasks" CssClass="form-control" />
                            </div>
                            <div class="form-group">
                                <label for="txtAdditionalNotes">Additional Notes</label>
                                <asp:TextBox ID="txtAdditionalNotes" runat="server" TextMode="MultiLine" placeholder="Additional Notes" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="form-buttons">
                            <button type="button" class="btn btn-outline" data-prev="2">
                                <i class="fas fa-arrow-left"></i> Previous
                            </button>
                            <button type="button" class="btn btn-primary" data-next="4">
                                Next <i class="fas fa-arrow-right"></i>
                            </button>
                        </div>
                    </div>

                    <!-- Step 4: Confirmation -->
                    <div class="form-step" id="step-4">
                        <h2>Confirmation</h2>
                        <p>Please review all the information you've entered and confirm that it's accurate.</p>
                        
                        <div class="checkbox-group">
                            <asp:CheckBox ID="chkTerms" runat="server" required />
                            <label for="chkTerms">I acknowledge that all the information provided is accurate and agree to the terms & conditions</label>
                        </div>
                        <div class="error-message">You must agree to the terms and conditions</div>
                        
                        <div class="form-buttons">
                            <button type="button" class="btn btn-outline" data-prev="3">
                                <i class="fas fa-arrow-left"></i> Previous
                            </button>
                            <asp:Button ID="btnPostJob" runat="server" Text="Post Job" OnClick="btnSubmit_Click" CssClass="btn btn-primary" />
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </form>

    <script>
        // Form navigation and validation
        document.addEventListener('DOMContentLoaded', function () {
            // Navigation between steps
            const steps = document.querySelectorAll('.step');
            const formSteps = document.querySelectorAll('.form-step');

            // Navigation buttons
            document.querySelectorAll('[data-next]').forEach(button => {
                button.addEventListener('click', function () {
                    const currentStep = this.closest('.form-step');
                    const nextStepId = this.getAttribute('data-next');

                    if (validateStep(currentStep)) {
                        // Hide current step
                        currentStep.classList.remove('active');

                        // Show next step
                        document.getElementById(`step-${nextStepId}`).classList.add('active');

                        // Update step indicators
                        steps.forEach(step => step.classList.remove('active'));
                        document.querySelector(`.step[data-step="${nextStepId}"]`).classList.add('active');

                        // Scroll to top
                        window.scrollTo(0, 0);
                    }
                });
            });

            document.querySelectorAll('[data-prev]').forEach(button => {
                button.addEventListener('click', function () {
                    const currentStep = this.closest('.form-step');
                    const prevStepId = this.getAttribute('data-prev');

                    // Hide current step
                    currentStep.classList.remove('active');

                    // Show previous step
                    document.getElementById(`step-${prevStepId}`).classList.add('active');

                    // Update step indicators
                    steps.forEach(step => step.classList.remove('active'));
                    document.querySelector(`.step[data-step="${prevStepId}"]`).classList.add('active');

                    // Scroll to top
                    window.scrollTo(0, 0);
                });
            });

            // Form validation
            function validateStep(step) {
                let isValid = true;
                const requiredFields = step.querySelectorAll('[required]');

                requiredFields.forEach(field => {
                    const errorMessage = field.closest('.form-group').querySelector('.error-message');

                    if (!field.value.trim()) {
                        field.setAttribute('aria-invalid', 'true');
                        errorMessage.style.display = 'block';
                        isValid = false;
                    } else {
                        field.removeAttribute('aria-invalid');
                        errorMessage.style.display = 'none';
                    }
                });

                // Special validation for checkbox
                if (step.id === 'step-4') {
                    const checkbox = document.getElementById('<%= chkTerms.ClientID %>');
                    const errorMessage = step.querySelector('.error-message');

                    if (!checkbox.checked) {
                        errorMessage.style.display = 'block';
                        isValid = false;
                    } else {
                        errorMessage.style.display = 'none';
                    }
                }

                if (!isValid) {
                    // Scroll to first error
                    const firstError = step.querySelector('[aria-invalid="true"]');
                    if (firstError) {
                        firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    }
                }

                return isValid;
            }

            // Show/hide message box
            const messageBox = document.getElementById('<%= messageBox.ClientID %>');
            const messageLabel = document.getElementById('<%= lblMessage.ClientID %>');

            if (messageLabel && messageLabel.innerText.trim() !== '') {
                messageBox.style.display = 'block';
                messageBox.classList.add('message-success');

                setTimeout(() => {
                    messageBox.style.display = 'none';
                    messageLabel.innerText = '';
                }, 5000);
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
    </script>
</body>
</html>