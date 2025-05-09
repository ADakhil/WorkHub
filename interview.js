export const greetingMessage = "Good Morning";

import {
    greetingMessage
} from './config.js';

document.addEventListener('DOMContentLoaded', () => {
    const dateTimeElement = document.getElementById('date-time');
    const greetingMessageElement = document.getElementById('greeting-message');

    function updateDateTime() {
        const now = dayjs();
        const formattedDateTime = now.format('MMM D, YYYY h:mm A');
        dateTimeElement.textContent = formattedDateTime;
    }

    function updateGreeting() {
        greetingMessageElement.textContent = greetingMessage;
    }

    updateDateTime();
    updateGreeting();

    setInterval(updateDateTime, 60000);
});