<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Jobapplicationsinboxcompny.aspx.cs" Inherits="workHub.Jobapplicationsinboxcompny" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Job Posts Dashboard</title>
  <link rel="stylesheet" href="styles.css">
  <style>
      * {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: "Segoe UI", Roboto, sans-serif;
  display: flex;
  background: linear-gradient(to right, #eef2f7, #dfe6f5);
  min-height: 100vh;
  transition: background 0.3s ease-in-out;
}

/* Sidebar */
.sidebar {
  width: 80px;
  background: linear-gradient(180deg, #1e3a8a, #3b5998);
  padding: 20px 0;
  display: flex;
  flex-direction: column;
  align-items: center;
  box-shadow: 4px 0 10px rgba(0, 0, 0, 0.1);
  transition: 0.3s;
}

.sidebar:hover {
  width: 100px;
}

.logo {
  color: white;
  font-weight: bold;
  margin-bottom: 40px;
  font-size: 18px;
  transition: transform 0.3s;
}

.sidebar:hover .logo {
  transform: scale(1.1);
}

.sidebar nav {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.sidebar a {
  color: rgba(255, 255, 255, 0.7);
  text-decoration: none;
  padding: 12px;
  border-radius: 12px;
  display: flex;
  justify-content: center;
  align-items: center;
  transition: 0.3s;
}

.sidebar a:hover {
  background-color: rgba(255, 255, 255, 0.3);
  transform: scale(1.1);
}

.sidebar a.active {
  color: white;
  background-color: rgba(255, 255, 255, 0.2);
  transform: scale(1.1);
}

/* Main Content */
main {
  flex: 1;
  padding: 20px;
}

/* Header */
header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30px;
}

.search-bar {
  background: rgba(255, 255, 255, 0.8);
  padding: 12px 20px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  gap: 12px;
  width: 300px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(5px);
  transition: all 0.3s ease-in-out;
}

.search-bar input {
  border: none;
  outline: none;
  font-size: 16px;
  width: 100%;
  background: transparent;
}

.search-bar:hover {
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.header-right {
  display: flex;
  align-items: center;
  gap: 20px;
}

.settings-icon {
  color: #666;
  cursor: pointer;
  transition: transform 0.3s, color 0.3s;
}

.settings-icon:hover {
  color: #283593;
  transform: rotate(90deg);
}

/* Button */
.new-job-btn {
  background: linear-gradient(to right, #3b5998, #1e3a8a);
  color: white;
  border: none;
  padding: 12px 24px;
  border-radius: 8px;
  cursor: pointer;
  font-weight: 500;
  transition: 0.3s;
  box-shadow: 0 4px 10px rgba(40, 57, 147, 0.3);
}

.new-job-btn:hover {
  background: linear-gradient(to right, #1e3a8a, #0b2545);
  transform: scale(1.05);
  box-shadow: 0 6px 14px rgba(40, 57, 147, 0.5);
}

/* Content */
.content h2 {
  margin-bottom: 20px;
  font-size: 22px;
  color: #333;
  transition: color 0.3s;
}

.content h2:hover {
  color: #1e3a8a;
}

/* Job List */
.job-list {
  background: white;
  border-radius: 16px;
  overflow: hidden;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.08);
  transition: 0.3s ease-in-out;
}

.job-header {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr 2fr 60px;
  padding: 20px;
  background: #f5f7fa;
  font-weight: 500;
  color: #666;
}

.job-item {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr 2fr 60px;
  padding: 20px;
  align-items: center;
  border-bottom: 1px solid #eee;
  transition: all 0.3s ease-in-out;
}

.job-item:hover {
  background: #e3eaf5;
  transform: scale(1.02);
}

/* Status Labels */
.status {
  display: inline-block;
  padding: 8px 16px;
  border-radius: 20px;
  font-size: 14px;
  text-align: center;
  width: fit-content;
  font-weight: bold;
  transition: transform 0.3s ease-in-out;
}

.status:hover {
  transform: scale(1.1);
}

.status.activated {
  background: linear-gradient(to right, #4caf50, #2e7d32);
  color: white;
}

.status.pending {
  background: linear-gradient(to right, #ffa726, #ff6f00);
  color: white;
}

/* Job Titles */
.job-title {
  font-weight: 500;
  color: #222;
  transition: color 0.3s ease-in-out;
}

.job-title:hover {
  color: #3b5998;
}

/* Delete Button */
.delete-btn {
  border: none;
  background: none;
  color: #999;
  cursor: pointer;
  padding: 8px;
  border-radius: 4px;
  transition: transform 0.3s ease-in-out, background 0.3s;
}

.delete-btn:hover {
  background: #ffebee;
  color: #d32f2f;
  transform: scale(1.2);
}

/* Icons */
.material-icons {
  vertical-align: middle;
  transition: transform 0.3s ease-in-out, color 0.3s;
}

.material-icons:hover {
  transform: scale(1.2);
  color: #3b5998;
}

  </style>
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>
<body>
  <div class="sidebar">
    <div class="logo">Aramco</div>
    <nav>
      <a href="#"><span class="material-icons">home</span></a>
      <a href="#"><span class="material-icons">search</span></a>
      <a href="#" class="active"><span class="material-icons">work</span></a>
      <a href="#"><span class="material-icons">mail</span></a>
      <a href="#"><span class="material-icons">chat</span></a>
    </nav>
  </div>
  
  <main>
    <header>
      <div class="search-bar">
        <span class="material-icons">search</span>
        <input type="text" placeholder="Search...">
      </div>
      <div class="header-right">
        <span class="material-icons settings-icon">tune</span>
        <button class="new-job-btn">+ New job</button>
      </div>
    </header>

    <div class="content">
      <h2>Job posted</h2>
      
      <div class="job-list">
        <div class="job-header">
          <span>Job title</span>
          <span>Status</span>
          <span>Activation date</span>
          <span>Seeker applied</span>
          <span></span>
        </div>
        <div class="job-item">
          <span class="job-title">Software engineering</span>
          <span class="status activated">Activated</span>
          <span class="date">2/9/2025</span>
          <span class="applicant">Layla Al-Qahtani</span>
          <span class="actions">
            <button class="delete-btn"><span class="material-icons">delete</span></button>
          </span>
        </div>

        <div class="job-item">
          <span class="job-title">Graphic Designer</span>
          <span class="status activated">Activated</span>
          <span class="date">2/8/2025</span>
          <span class="applicant">Ahmed Al-Farsi</span>
          <span class="actions">
            <button class="delete-btn"><span class="material-icons">delete</span></button>
          </span>
        </div>

        <div class="job-item">
          <span class="job-title">Graphic Designer</span>
          <span class="status activated">Activated</span>
          <span class="date">2/8/2025</span>
          <span class="applicant">Layla Al-Qahtani</span>
          <span class="actions">
            <button class="delete-btn"><span class="material-icons">delete</span></button>
          </span>
        </div>
      </div>
    </div>
  </main>
  <script>
      document.addEventListener('DOMContentLoaded', () => {
          // Add click handlers for delete buttons
          const deleteButtons = document.querySelectorAll('.delete-btn');
          deleteButtons.forEach(button => {
              button.addEventListener('click', (e) => {
                  const jobItem = e.target.closest('.job-item');
                  if (jobItem) {
                      jobItem.remove();
                  }
              });
          });

          // Add click handler for new job button
          const newJobBtn = document.querySelector('.new-job-btn');
          newJobBtn.addEventListener('click', () => {
              alert('New job functionality would go here');
          });
      });
  </script>
</body>
</html>
