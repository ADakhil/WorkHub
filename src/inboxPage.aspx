<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="inboxPage.aspx.cs" Inherits="workHub.inboxPage" %>

<!DOCTYPE html>

<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Email Inbox</title>
  <link rel="stylesheet" href="inboxPage.css">
  <script src="inboxPage.js" type="module"></script>
  <script type="importmap">
      {
        "imports": {
          "confetti-js": "https://cdn.jsdelivr.net/npm/confetti-js@0.0.18/dist/confetti.min.js"
        }
      }
    </script>
</head>

<body>
  <div class="container">
    <aside class="sidebar">
      <div class="logo">Aramco</div>
      <nav>
        <ul>
          <li><a href="#">🏠</a></li>
          <li><a href="#">🔎</a></li>
          <li class="active"><a href="#">✉️</a></li>
        </ul>
      </nav>
    </aside>
    <main class="content">
      <header>
        <div class="search-bar">
          <input type="text" placeholder="Search">
        </div>
        <div class="date">Dec 2, 2024 8:00 AM</div>
      </header>
      <section class="inbox">
        <h2>Inbox</h2>
        <ul class="email-list">
          <!-- Email items will be dynamically added here -->
        </ul>
      </section>
    </main>
    <aside class="email-view" id="email-view">
      <!-- Email content will be dynamically loaded here -->
    </aside>
  </div>
</body>

</html>
