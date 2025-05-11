<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard-Seeker.aspx.cs" Inherits="workHub.Dashboard_Seeker" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | WorkHub</title>
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
/*            height:100vh;*/
            
            
            
            
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

        
        .logo-small {
            font-size: 20px;
            font-weight: bold;
            text-align: center;
            padding: 10px;
            color: var(--primary);
/*            border-bottom: 1px solid var(--light-gray);*/
            text-decoration: none;
            margin-bottom: 5px;
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

        /* Resume Section */
        .resumes {
            background-color: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }

        .section-header {
            margin-bottom: 20px;
        }

        .section-header h2 {
            margin: 0;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .resume-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }

        .resume-card {
            border: 2px dashed var(--light-gray);
            border-radius: 8px;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            min-height: 150px;
            transition: all 0.3s;
        }

        .resume-card:hover {
            border-color: var(--primary);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .resume-placeholder {
            background-color: transparent;
            border: none;
            color: var(--primary);
            font-weight: 500;
            cursor: pointer;
            padding: 10px;
            text-align: center;
            width: 100%;
        }

        .resume-placeholder:hover {
            text-decoration: underline;
        }

        /* Job Results Section */
        .job-results {
            background-color: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .job-item {
            padding: 20px;
            border-radius: 8px;
            background-color: white;
            margin-bottom: 15px;
            border-left: 4px solid var(--primary);
            transition: transform 0.3s, box-shadow 0.3s;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }

        .job-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .job-item h3 {
            margin: 0 0 5px;
            color: var(--dark);
        }

        .job-item p {
            margin: 5px 0;
            color: var(--gray);
            font-size: 14px;
        }

        /* File Upload Improvements */
        .file-upload-wrapper {
            position: relative;
            margin-bottom: 15px;
            width: 100%;
            
        }

        .file-upload-button {
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
            width: 100%;
            
        }

        .mb{
            margin-bottom:42px;
        }
        
        .mb-2{
            margin-bottom:5px;
        }
        .file-upload-button:hover {
            background-color: var(--secondary);
        }

        /* Responsive Styles */
        @media (max-width: 768px) {
            .dashboard-container {
                grid-template-columns: 1fr;
            }
            
            .resume-grid {
                grid-template-columns: 1fr;
            }
            
            
        }
/* Enhanced Calendar Styles */
.calendar-container {
    background-color: white;
    border-radius: 10px;
    padding: 25px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
    margin-bottom: 30px;
    position: relative;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.calendar-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    width: 60%;
}

.calendar-title {
    font-size: 20px;
    font-weight: 600;
    color: var(--dark);
    display: flex;
    align-items: center;
    gap: 10px;
}

.calendar-nav {
    display: flex;
    gap: 15px;
    align-items: center;
}

.calendar-nav-btn {
    background: var(--light-gray);
    border: none;
    color: var(--primary);
    cursor: pointer;
    font-size: 16px;
    width: 36px;
    height: 36px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s;

}

.calendar-nav-btn:hover {
    background: var(--primary);
    color: white;
}

.calendar-grid {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    gap: 8px;
    margin-bottom: 20px;
    width: 60%;
}

.calendar-day-header {
    text-align: center;
    font-weight: 600;
    padding: 10px 5px;
    color: var(--primary);
    font-size: 14px;
    text-transform: uppercase;
}

.calendar-day {
    text-align: center;
    padding: 12px 5px;
    border-radius: 8px;
    cursor: pointer;
    position: relative;
    transition: all 0.2s;
    aspect-ratio: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    border: 1px solid transparent;
}

.calendar-day:hover {
    background-color: var(--light-gray);
    border-color: var(--primary);
}

.calendar-day.today {
    background-color: var(--primary);
    color: white;
    font-weight: 600;
}

.calendar-day.has-reminder {
    background-color: rgba(248, 37, 133, 0.1);
    border-color: rgba(248, 37, 133, 0.2);
}

.calendar-day.has-reminder .day-number {
    color: var(--warning);
    font-weight: 600;
}

.calendar-day.other-month {
    color: var(--light-gray);
    opacity: 0.6;
}

.day-number {
    font-size: 14px;
    margin-bottom: 2px;
}

.reminder-dot {
    width: 6px;
    height: 6px;
    border-radius: 50%;
    background-color: var(--warning);
    margin-top: 2px;
}

/* Reminder Form Styles */
.reminder-form-container {
    background-color: white;
    border-radius: 10px;
    padding: 20px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
    margin-top: 20px;
    display: none;
}

.reminder-form-container.active {
    display: block;
    animation: fadeIn 0.3s ease;
    width: 60%;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}

.reminder-form-title {
    font-size: 18px;
    font-weight: 600;
    margin-bottom: 15px;
    color: var(--dark);
    display: flex;
    align-items: center;
    gap: 10px;
}

.reminder-form-group {
    margin-bottom: 15px;
}

.reminder-form-label {
    display: block;
    margin-bottom: 5px;
    font-weight: 500;
    color: var(--dark);
}

.reminder-form-input {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid var(--light-gray);
    border-radius: 6px;
    font-size: 14px;
    transition: border-color 0.2s;
}

.reminder-form-input:focus {
    outline: none;
    border-color: var(--primary);
}

.reminder-form-actions {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
    margin-top: 20px;
}

.reminder-form-btn {
    padding: 8px 16px;
    border-radius: 6px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s;
    border: none;
}

.reminder-form-btn.primary {
    background-color: var(--primary);
    color: white;
}

.reminder-form-btn.primary:hover {
    background-color: var(--secondary);
}

.reminder-form-btn.secondary {
    background-color: var(--light-gray);
    color: var(--dark);
}

.reminder-form-btn.secondary:hover {
    background-color: #d1d5db;
}

/* Reminder Tooltip */
.reminder-tooltip {
    position: absolute;
    bottom: 100%;
    left: 50%;
    transform: translateX(-50%);
    background-color: var(--dark);
    color: white;
    padding: 8px 12px;
    border-radius: 6px;
    font-size: 12px;
    white-space: nowrap;
    z-index: 100;
    opacity: 0;
    visibility: hidden;
    transition: all 0.2s;
    pointer-events: none;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.reminder-tooltip:after {
    content: '';
    position: absolute;
    top: 100%;
    left: 50%;
    transform: translateX(-50%);
    border-width: 5px;
    border-style: solid;
    border-color: var(--dark) transparent transparent transparent;
}

.calendar-day:hover .reminder-tooltip {
    opacity: 1;
    visibility: visible;
    bottom: calc(100% + 5px);
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
    <form id="form1" runat="server" enctype="multipart/form-data">
         <asp:ScriptManager ID="ScriptManager2" runat="server" EnablePageMethods="true" />

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
            <aside class="sidebar" id="sidebar">
                <a href="HomePageF.aspx" class="logo">WorkHub</a>
                <nav>
                    <a href="dashboard-seeker.aspx" class="nav-item active">
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
                <header>
                    <h1><i class="fas fa-tachometer-alt"></i> <asp:Literal ID="litWelcome" runat="server" /></h1>
                    <p>Here you can manage your job applications, resumes, and stay updated with new job opportunities!</p>
                </header>

                 <section class="calendar-container" id="calendarContainer">
                    <!-- Calendar will be rendered here by JavaScript -->
                </section>

                <section class="resumes">
                    <div class="section-header">
                        <h2><i class="fas fa-file-alt"></i> Resumes</h2>
                    </div>
                    <div class="resume-grid">
                        <div class="resume-card">
                            <div class="file-upload-wrapper">
                                <asp:Button ID="btnUploadResume" runat="server" Text="Save Resume" 
                                    OnClick="btnUploadResume_Click" CssClass="file-upload-button mb-2" />
                                <asp:FileUpload ID="ResumeUpload" runat="server" CssClass="file-upload-input" />
                            </div>
                        </div>
                        <div class="resume-card">
                            <asp:Button ID="btnCreateTemplate" runat="server" 
                                Text="Create from template" 
                                OnClick="btnCreateTemplate_Click" 
                                CssClass="file-upload-button mb" />
                        </div>
                        <div class="resume-card">
                            <div class="file-upload-wrapper">
                                <asp:Button ID="btnUploadVideo" runat="server" 
                                    Text="Save video resume" 
                                    OnClick="btnUploadVideo_Click" 
                                    CssClass="file-upload-button mb-2" />
                                <asp:FileUpload ID="VideoUpload" runat="server" 
    accept="video/*" 
    CssClass="file-upload-input"
    onchange="validateVideoUpload(this)" />

                            </div>
                        </div>
                    </div>
                </section>

                <section class="job-results">
                    <div class="section-header">
                        <h2><i class="fas fa-search"></i> Recommended Jobs</h2>
                    </div>
                    <asp:Repeater ID="rptJobs" runat="server">
                        <ItemTemplate>
                            <div class="job-item">
                                <h3><%# Eval("title") %></h3>
                                <p><i class="fas fa-map-marker-alt"></i> <%# Eval("city") %>, <%# Eval("country") %></p>
                                <p><i class="fas fa-clock"></i> Posted on: <%# Eval("postedOn") %></p>
                                <p class="status-badge status-<%# Eval("status").ToString().ToLower() %>">
                                    <%# Eval("status") %>
                                </p>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </section>
            </main>
        </div>
    </form>
     <script>
         (function () { if (!window.chatbase || window.chatbase("getState") !== "initialized") { window.chatbase = (...arguments) => { if (!window.chatbase.q) { window.chatbase.q = [] } window.chatbase.q.push(arguments) }; window.chatbase = new Proxy(window.chatbase, { get(target, prop) { if (prop === "q") { return target.q } return (...args) => target(prop, ...args) } }) } const onLoad = function () { const script = document.createElement("script"); script.src = "https://www.chatbase.co/embed.min.js"; script.id = "AU8m9RYS7kFvlTA3dPsfx"; script.domain = "www.chatbase.co"; document.body.appendChild(script) }; if (document.readyState === "complete") { onLoad() } else { window.addEventListener("load", onLoad) } })();
     </script>
    
    <!-- Initialize chatbot with WorkHub branding -->
    <script>
        window.chatbase('updateSettings', {
            chatbotId: 'AU8m9RYS7kFvlTA3dPsfx',
            domain: 'www.chatbase.co',
            title: 'WorkHub Assistant',
            description: 'Ask me anything about WorkHub, job applications, or resume building!',
            primaryColor: '#1a237e'
        });
    </script>
    
    
    
    <script>
        function validateVideoUpload(input) {
            const file = input.files[0];
            if (file && file.size > 5 * 1024 * 1024) {
                alert("⚠️ Video file must be 5 MB or less.");
                input.value = ""; // Clear the file input
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

        document.addEventListener("DOMContentLoaded", async function () {
            const calendarContainer = document.getElementById("calendarContainer");
            const currentDate = new Date();
            let currentMonth = currentDate.getMonth();
            let currentYear = currentDate.getFullYear();
            let reminders = [];

            function loadReminders() {
                PageMethods.GetReminders(function (data) {
                    reminders = data || [];
                    initCalendar();
                }, function (error) {
                    console.error("Failed to load reminders:", error);
                    reminders = [];
                    initCalendar();
                });
            }
            let selectedDate = null;

            // Initialize calendar
            loadReminders();

            function initCalendar() {
                // Clear previous calendar
                calendarContainer.innerHTML = '';

                // Create calendar header
                const calendarHeader = document.createElement('div');
                calendarHeader.className = 'calendar-header';

                // Create navigation buttons
                const prevButton = document.createElement('button');
                prevButton.className = 'calendar-nav-btn';
                prevButton.innerHTML = '<i class="fas fa-chevron-left"></i>';
                prevButton.addEventListener('click', () => {
                    currentMonth--;
                    if (currentMonth < 0) {
                        currentMonth = 11;
                        currentYear--;
                    }
                    initCalendar();
                });

                const nextButton = document.createElement('button');
                nextButton.className = 'calendar-nav-btn';
                nextButton.innerHTML = '<i class="fas fa-chevron-right"></i>';
                nextButton.addEventListener('click', () => {
                    currentMonth++;
                    if (currentMonth > 11) {
                        currentMonth = 0;
                        currentYear++;
                    }
                    initCalendar();
                });

                // Create month/year title
                const monthYearTitle = document.createElement('div');
                monthYearTitle.className = 'calendar-title';
                monthYearTitle.innerHTML = `<i class="far fa-calendar-alt"></i> ${getMonthName(currentMonth)} ${currentYear}`;

                // Create add reminder button
                const addReminderBtn = document.createElement('button');
                addReminderBtn.className = 'calendar-nav-btn';
                addReminderBtn.innerHTML = '<i class="fas fa-plus"></i>';
                addReminderBtn.title = 'Add reminder';
                addReminderBtn.addEventListener('click', () => {
                    selectedDate = new Date(currentYear, currentMonth, 1);
                    showReminderForm();
                });

                // Append header elements
                const navContainer = document.createElement('div');
                navContainer.className = 'calendar-nav';
                navContainer.appendChild(prevButton);
                navContainer.appendChild(nextButton);

                calendarHeader.appendChild(monthYearTitle);
                calendarHeader.appendChild(navContainer);
                calendarHeader.appendChild(addReminderBtn);

                calendarContainer.appendChild(calendarHeader);

                // Create days of week header
                const daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
                const daysHeader = document.createElement('div');
                daysHeader.className = 'calendar-grid';

                daysOfWeek.forEach(day => {
                    const dayElement = document.createElement('div');
                    dayElement.className = 'calendar-day-header';
                    dayElement.textContent = day;
                    daysHeader.appendChild(dayElement);
                });

                calendarContainer.appendChild(daysHeader);

                // Create calendar grid
                const firstDayOfMonth = new Date(currentYear, currentMonth, 1).getDay();
                const daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate();
                const daysInPrevMonth = new Date(currentYear, currentMonth, 0).getDate();

                const calendarGrid = document.createElement('div');
                calendarGrid.className = 'calendar-grid';

                // Add days from previous month
                for (let i = firstDayOfMonth - 1; i >= 0; i--) {
                    const dayElement = createDayElement(daysInPrevMonth - i, true);
                    calendarGrid.appendChild(dayElement);
                }

                // Add days of current month
                for (let i = 1; i <= daysInMonth; i++) {
                    const dayElement = createDayElement(i, false);

                    // Check if this day has reminders
                    const dateKey = formatDateKey(new Date(currentYear, currentMonth, i));
                    const dayReminders = reminders.filter(r => r.date === dateKey);

                    if (dayReminders.length > 0) {
                        dayElement.classList.add('has-reminder');

                        // Create reminder dot
                        const reminderDot = document.createElement('div');
                        reminderDot.className = 'reminder-dot';
                        dayElement.appendChild(reminderDot);

                        // Create tooltip with reminder titles
                        const tooltip = document.createElement('div');
                        tooltip.className = 'reminder-tooltip';
                        tooltip.textContent = dayReminders.map(r => r.title).join(', ');
                        dayElement.appendChild(tooltip);

                        // Click to view reminders
                        dayElement.addEventListener('click', (e) => {
                            e.stopPropagation();
                            selectedDate = new Date(currentYear, currentMonth, i);
                            showRemindersForDate(selectedDate);
                        });
                    }

                    // Highlight today
                    if (i === currentDate.getDate() && currentMonth === currentDate.getMonth() && currentYear === currentDate.getFullYear()) {
                        dayElement.classList.add('today');
                    }

                    calendarGrid.appendChild(dayElement);
                }

                // Add days from next month to fill the grid
                const totalDaysShown = firstDayOfMonth + daysInMonth;
                const remainingDays = 42 - totalDaysShown; // 6 rows x 7 days

                for (let i = 1; i <= remainingDays; i++) {
                    const dayElement = createDayElement(i, true);
                    calendarGrid.appendChild(dayElement);
                }

                calendarContainer.appendChild(calendarGrid);

                // Create reminder form container (hidden by default)
                const reminderFormContainer = document.createElement('div');
                reminderFormContainer.className = 'reminder-form-container';
                reminderFormContainer.id = 'reminderFormContainer';

                const reminderForm = document.createElement('div');
                reminderForm.innerHTML = `
            <div class="reminder-form-title"><i class="far fa-bell"></i> Add Reminder</div>
            <div class="reminder-form-group">
                <label class="reminder-form-label" for="reminderTitle">Title</label>
                <input type="text" id="reminderTitle" class="reminder-form-input" placeholder="Interview with Google">
            </div>
            <div class="reminder-form-group">
                <label class="reminder-form-label" for="reminderDescription">Description</label>
                <textarea id="reminderDescription" class="reminder-form-input" rows="3" placeholder="Prepare for technical interview"></textarea>
            </div>
            <div class="reminder-form-group">
                <label class="reminder-form-label" for="reminderTime">Time</label>
                <input type="time" id="reminderTime" class="reminder-form-input">
            </div>
            <div class="reminder-form-actions">
                <button type="button" class="reminder-form-btn secondary" id="cancelReminderBtn">Cancel</button>
                <button type="button" class="reminder-form-btn primary" id="saveReminderBtn">Save Reminder</button>
            </div>
        `;

                reminderFormContainer.appendChild(reminderForm);
                calendarContainer.appendChild(reminderFormContainer);

                // Add event listeners for reminder form
                document.getElementById('cancelReminderBtn')?.addEventListener('click', hideReminderForm);
                document.getElementById('saveReminderBtn')?.addEventListener('click', saveReminder);
            }

            function createDayElement(day, isOtherMonth) {
                const dayElement = document.createElement('div');
                dayElement.className = 'calendar-day';
                if (isOtherMonth) {
                    dayElement.classList.add('other-month');
                }

                const dayNumber = document.createElement('div');
                dayNumber.className = 'day-number';
                dayNumber.textContent = day;
                dayElement.appendChild(dayNumber);

                // Add click handler to create new reminder
                dayElement.addEventListener('click', function () {
                    if (!isOtherMonth) {
                        selectedDate = new Date(currentYear, currentMonth, day);
                        showReminderForm();
                    }
                });

                return dayElement;
            }

            function showReminderForm() {
                const formContainer = document.getElementById('reminderFormContainer');
                if (!formContainer) return;

                // Update form title with selected date
                const titleElement = formContainer.querySelector('.reminder-form-title');
                if (titleElement && selectedDate) {
                    titleElement.innerHTML = `<i class="far fa-bell"></i> Add Reminder for ${selectedDate.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' })}`;
                }

                // Clear form fields
                document.getElementById('reminderTitle').value = '';
                document.getElementById('reminderDescription').value = '';
                document.getElementById('reminderTime').value = '12:00';

                // Show form
                formContainer.classList.add('active');
            }

            function hideReminderForm() {
                const formContainer = document.getElementById('reminderFormContainer');
                if (formContainer) {
                    formContainer.classList.remove('active');
                }
            }

            function showRemindersForDate(date) {
                const dateKey = formatDateKey(date);
                const dateReminders = reminders.filter(r => r.date === dateKey);

                if (dateReminders.length > 0) {
                    const reminderList = dateReminders.map(r =>
                        `• ${r.title}${r.time ? ' at ' + r.time : ''}${r.description ? '\n  ' + r.description : ''}`
                    ).join('\n');

                    alert(`Reminders for ${date.toLocaleDateString()}:\n\n${reminderList}`);
                } else {
                    alert(`No reminders for ${date.toLocaleDateString()}`);
                }
            }

            function saveReminder() {
                const title = document.getElementById('reminderTitle').value.trim();
                const description = document.getElementById('reminderDescription').value.trim();
                const time = document.getElementById('reminderTime').value;

                if (!title) {
                    alert('Please enter a title for the reminder');
                    return;
                }

                if (!selectedDate) {
                    alert('No date selected');
                    return;
                }

                const dateKey = formatDateKey(selectedDate);

                PageMethods.SaveReminder(dateKey, title, description, time,
                    function (success) {
                        if (success) {
                            // After saving, refresh reminders
                            loadReminders();
                            hideReminderForm();
                            alert("Reminder saved successfully.");
                        } else {
                            alert("Failed to save reminder.");
                        }
                    },
                    function (error) {
                        console.error("Error saving reminder:", error);
                        alert("An error occurred while saving the reminder.");
                    });
            }

            // Replace localStorage functions with these:

            async function getReminders() {
                try {
                    const response = await fetch('/api/reminders');
                    if (!response.ok) throw new Error('Failed to fetch reminders');
                    return await response.json();
                } catch (error) {
                    console.error('Error fetching reminders:', error);
                    return [];
                }
            }



            function formatDateKey(date) {
                return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}`;
            }

            function getMonthName(monthIndex) {
                const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
                return months[monthIndex];
            }
        });

    </script>
</body>
</html>