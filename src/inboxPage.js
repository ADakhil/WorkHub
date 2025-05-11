import Confetti from 'confetti-js';

document.addEventListener('DOMContentLoaded', () => {
    const emailList = document.querySelector('.email-list');
    const emailView = document.querySelector('.email-view');

    let emails = [
        {
            id: 1,
            senderName: 'Ahmed Al-Farsi',
            senderEmail: 'ahmed.alfarsi@email.com',
            time: '7:50 AM',
            subject: 'Application for Software Engineer Position',
            body: '<p>Dear Hiring Manager,</p><p>I am applying for the Software Engineer position at your esteemed company. I have experience in both backend and frontend development, and I am eager to contribute my skills to your team. Please find my resume attached.</p><p>I look forward to the opportunity to discuss my qualifications with you.</p><p>Best regards,</p><p>Ahmed Al-Farsi</p>',
            avatar: '/a/2808ceeb-a49d-4f4e-9fc0-14162eacd7d6' // Example avatar URL
        }
    ];

    function populateEmailList() {
        emailList.innerHTML = emails.map(email => `
          <li class="email-item" data-email-id="${email.id}">
            <div class="email-header">
              <div class="sender-info">
                <div class="avatar"><img src="${email.avatar}" alt="Avatar"></div>
                <div class="sender-name">${email.senderName}</div>
              </div>
              <div class="email-time">${email.time}</div>
            </div>
            <div class="email-subject">${email.subject}</div>
            <div class="email-body">${email.body.substring(0, 50)}...</div>
          </li>
        `).join('');
    }

    populateEmailList();

    emailList.addEventListener('click', (event) => {
        const emailItem = event.target.closest('.email-item');
        if (emailItem) {
            // Remove active class from other emails
            document.querySelectorAll('.email-item').forEach(item => item.classList.remove('active'));
            // Set active class
            emailItem.classList.add('active');
            const emailId = parseInt(emailItem.dataset.emailId);
            displayEmail(emailId);
        }
    });

    function displayEmail(emailId) {
        const email = emails.find(email => email.id === emailId);
        if (email) {
            emailView.innerHTML = `
            <div class="email-header">
              <div class="sender-avatar"><img src="${email.avatar}" alt="Avatar"></div>
              <div class="sender-details">
                <div class="sender-name">${email.senderName}</div>
                <div class="sender-email">${email.senderEmail}</div>
              </div>
            </div>
            <div class="email-subject">${email.subject}</div>
            <div class="email-body">${email.body}</div>
            <div class="email-actions">
              <button class="reply-button">Click here to reply</button>
              <button class="send-button">Send</button>
            </div>
            <div class="reply-section" style="display:none;">
              <textarea placeholder="Type your reply here..."></textarea>
              <button class="send-reply-button">Send Reply</button>
            </div>
          `;

            // Attach event listeners to the newly created buttons
            const replyButton = emailView.querySelector('.reply-button');
            const sendButton = emailView.querySelector('.send-button');
            const replySection = emailView.querySelector('.reply-section');
            const sendReplyButton = emailView.querySelector('.send-reply-button');

            replyButton.addEventListener('click', () => {
                replySection.style.display = 'block'; // Show reply textarea
            });

            sendButton.addEventListener('click', () => {
                // Basic confetti effect on send
                alert('Email sent!');
            });

            sendReplyButton.addEventListener('click', () => {
                const replyTextarea = emailView.querySelector('textarea');
                const replyText = replyTextarea.value;
                alert('Reply sent: ' + replyText);
                replySection.style.display = 'none';
                replyTextarea.value = ''; // Clear the textarea
            });

        }
    }
});