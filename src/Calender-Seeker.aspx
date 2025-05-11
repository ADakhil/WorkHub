<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Calender-Seeker.aspx.cs" Inherits="workHub.Calender_Seeker" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WorkHub Platform - Calendar</title>
    <link rel="stylesheet" href="dashboard.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
    <div class="dashboard-container calendar-layout">
        <aside class="sidebar">
            <div class="logo">Work-Hub</div>
            <nav>
                <a href="index.html" class="nav-item"><span class="icon">🏠</span>Dashboard</a>
                <a href="#" class="nav-item"><span class="icon">📄</span>Resumes</a>
                <a href="calendar.html" class="nav-item active"><span class="icon">📅</span>Calendar</a>
                <a href="#" class="nav-item"><span class="icon">💼</span>Jobs</a>
                <a href="#" class="nav-item"><span class="icon">📝</span>Applications</a>
            </nav>
            <div class="user-profile">
                <div class="avatar">👤</div>
                <span class="username">Sara</span>
            </div>
        </aside>

        <main class="main-content calendar-page">
            <header>
                <h1>Your Calendar</h1>
                <p>Keep track of your job applications and interviews with your personal calendar.</p>
            </header>

            <section class="calendar-section">
                <div id="calendar" class="calendar-grid full-calendar"></div>
            </section>
        </main>

        <div class="chatbot-container">
            <div class="chatbot-header">
                <h3>My chat bot</h3>
            </div>
            <div class="chat-messages" id="chatMessages"></div>
        </div>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const chatButton = document.createElement('button');
            chatButton.className = 'chat-button';
            chatButton.innerHTML = '<span class="chat-icon">💬</span>';
            document.body.appendChild(chatButton);

            const chatContainer = document.querySelector('.chatbot-container');
            const chatMessages = document.getElementById('chatMessages');

            const inputContainer = document.createElement('div');
            inputContainer.className = 'chat-input';
            inputContainer.innerHTML = `
    <input type="text" id="userInput" placeholder="Type your message...">
    <button id="sendMessage">Send</button>
  `;
            chatContainer.appendChild(inputContainer);

            const userInput = document.getElementById('userInput');
            const sendButton = document.getElementById('sendMessage');

            async function getAIResponse(userMessage) {
                try {
                    const response = await fetch('/api/ai_completion', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'Accept': 'application/json',
                        },
                        body: JSON.stringify({
                            prompt: `You are a helpful career advisor chatbot. Provide a helpful, friendly response to the user's message. Keep responses concise and professional.

          interface Response {
            reply: string;
          }

          {
            "reply": "I'd be happy to help you with your job search! What kind of position are you looking for?"
          }
          `,
                            data: userMessage
                        }),
                    });
                    const data = await response.json();
                    return data.reply;
                } catch (error) {
                    console.error('Error fetching AI response:', error);
                    return 'I apologize, but I am having trouble connecting right now. Please try again later.';
                }
            }

            function addMessage(content, sender) {
                const messageDiv = document.createElement('div');
                messageDiv.classList.add('message', ${sender}-message);

                const avatar = document.createElement('div');
                avatar.classList.add(${sender}-avatar);
                avatar.textContent = sender === 'bot' ? '🤖' : '👤';

                const messageContent = document.createElement('div');
                messageContent.classList.add('message-content');
                messageContent.textContent = content;

                messageDiv.appendChild(avatar);
                messageDiv.appendChild(messageContent);
                chatMessages.appendChild(messageDiv);
                chatMessages.scrollTop = chatMessages.scrollHeight;
            }

            async function handleUserInput() {
                const message = userInput.value.trim();
                if (!message) return;

                addMessage(message, 'user');
                userInput.value = '';

                const typingDiv = document.createElement('div');
                typingDiv.className = 'message bot-message typing';
                typingDiv.innerHTML = '<div class="bot-avatar">🤖</div><div class="message-content">Typing...</div>';
                chatMessages.appendChild(typingDiv);

                const aiResponse = await getAIResponse(message);

                chatMessages.removeChild(typingDiv);

                addMessage(aiResponse, 'bot');
            }

            chatButton.addEventListener('click', () => {
                chatContainer.classList.toggle('visible');
                if (chatContainer.classList.contains('visible') && chatMessages.children.length === 0) {
                    addMessage('Hello! I\'m your WorkHub assistant. How can I help you today?', 'bot');
                }
            });

            sendButton.addEventListener('click', handleUserInput);
            userInput.addEventListener('keypress', (e) => {
                if (e.key === 'Enter') {
                    handleUserInput();
                }
            });

            const calendar = document.getElementById('calendar');
            let currentDate = new Date();
            let events = [
                { date: '2024-01-04', title: 'Interview' },
                { date: '2024-01-15', title: 'Follow-up' },
                { date: '2024-01-26', title: 'Meeting' }
            ];

            function renderCalendar(date) {
                const year = date.getFullYear();
                const month = date.getMonth();

                calendar.innerHTML = '';

                const header = document.createElement('div');
                header.className = 'calendar-header';

                const monthSelect = document.createElement('select');
                monthSelect.className = 'month-select';
                const months = [
                    'January', 'February', 'March', 'April', 'May', 'June',
                    'July', 'August', 'September', 'October', 'November', 'December'
                ];
                months.forEach((monthName, index) => {
                    const option = document.createElement('option');
                    option.value = index;
                    option.textContent = monthName;
                    option.selected = index === month;
                    monthSelect.appendChild(option);
                });

                const yearSelect = document.createElement('select');
                yearSelect.className = 'year-select';
                const currentYear = new Date().getFullYear();
                for (let y = currentYear - 5; y <= currentYear + 5; y++) {
                    const option = document.createElement('option');
                    option.value = y;
                    option.textContent = y;
                    option.selected = y === year;
                    yearSelect.appendChild(option);
                }

                header.innerHTML = `
      <button class="calendar-nav prev">←</button>
      <div class="calendar-selectors">
        ${monthSelect.outerHTML}
        ${yearSelect.outerHTML}
      </div>
      <button class="calendar-nav next">→</button>
    `;
                calendar.appendChild(header);

                calendar.querySelector('.month-select').addEventListener('change', (e) => {
                    currentDate.setMonth(parseInt(e.target.value));
                    renderCalendar(currentDate);
                });

                calendar.querySelector('.year-select').addEventListener('change', (e) => {
                    currentDate.setFullYear(parseInt(e.target.value));
                    renderCalendar(currentDate);
                });

                const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
                days.forEach(day => {
                    const dayLabel = document.createElement('div');
                    dayLabel.className = 'calendar-day-label';
                    dayLabel.textContent = day;
                    calendar.appendChild(dayLabel);
                });

                const firstDay = new Date(year, month, 1).getDay();
                const daysInMonth = new Date(year, month + 1, 0).getDate();

                for (let i = 0; i < firstDay; i++) {
                    const blank = document.createElement('div');
                    blank.className = 'calendar-day empty';
                    calendar.appendChild(blank);
                }

                for (let day = 1; day <= daysInMonth; day++) {
                    const dayDiv = document.createElement('div');
                    dayDiv.className = 'calendar-day';

                    const currentDateStr = ${year}-${String(month + 1).padStart(2, '0')}-${String(day).padStart(2, '0')};
                    const dayEvents = events.filter(event => event.date === currentDateStr);

                    if (dayEvents.length > 0) {
                        dayDiv.classList.add('has-event');
                        const eventDot = document.createElement('span');
                        eventDot.className = 'event-dot';
                        dayDiv.appendChild(eventDot);

                        const tooltip = document.createElement('div');
                        tooltip.className = 'event-tooltip';
                        tooltip.textContent = dayEvents.map(event => event.title).join(', ');
                        dayDiv.appendChild(tooltip);
                    }

                    dayDiv.innerHTML += day;
                    calendar.appendChild(dayDiv);

                    dayDiv.addEventListener('click', () => {
                        if (dayEvents.length > 0) {
                            showEventDetails(dayEvents, currentDateStr);
                        } else {
                            showAddEventDialog(currentDateStr);
                        }
                    });
                }

                header.querySelector('.prev').addEventListener('click', () => {
                    currentDate.setMonth(currentDate.getMonth() - 1);
                    renderCalendar(currentDate);
                });

                header.querySelector('.next').addEventListener('click', () => {
                    currentDate.setMonth(currentDate.getMonth() + 1);
                    renderCalendar(currentDate);
                });
            }

            function showEventDetails(events, date) {
                const modal = document.createElement('div');
                modal.className = 'calendar-modal';
                modal.innerHTML = `
      <div class="modal-content">
        <h3>Events on ${new Date(date).toLocaleDateString()}</h3>
        <div class="event-list">
          ${events.map(event => `
            <div class="event-item">
              <span>${event.title}</span>
              <button class="delete-event" data-date="${date}">Delete</button>
            </div>
          `).join('')}
        </div>
        <button class="add-event">Add Event</button>
        <button class="close-modal">Close</button>
      </div>
    `;
                document.body.appendChild(modal);

                modal.querySelector('.close-modal').addEventListener('click', () => {
                    document.body.removeChild(modal);
                });

                modal.querySelector('.add-event').addEventListener('click', () => {
                    document.body.removeChild(modal);
                    showAddEventDialog(date);
                });

                modal.querySelectorAll('.delete-event').forEach(button => {
                    button.addEventListener('click', () => {
                        const eventDate = button.dataset.date;
                        events = events.filter(event => event.date !== eventDate);
                        document.body.removeChild(modal);
                        renderCalendar(currentDate);
                    });
                });
            }

            function showAddEventDialog(date) {
                const modal = document.createElement('div');
                modal.className = 'calendar-modal';
                modal.innerHTML = `
      <div class="modal-content">
        <h3>Add Event on ${new Date(date).toLocaleDateString()}</h3>
        <input type="text" class="event-title" placeholder="Event Title">
        <div class="modal-buttons">
          <button class="save-event">Save</button>
          <button class="close-modal">Cancel</button>
        </div>
      </div>
    `;
                document.body.appendChild(modal);

                modal.querySelector('.save-event').addEventListener('click', () => {
                    const title = modal.querySelector('.event-title').value.trim();
                    if (title) {
                        events.push({ date, title });
                        document.body.removeChild(modal);
                        renderCalendar(currentDate);
                    }
                });

                modal.querySelector('.close-modal').addEventListener('click', () => {
                    document.body.removeChild(modal);
                });
            }

            renderCalendar(currentDate);
        });
    </script>
</body>
</html>
