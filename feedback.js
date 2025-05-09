export default {
    primaryColor: '#3f51b5',
};

import config from 'config';

document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('feedbackForm');

    form.addEventListener('submit', (event) => {
        event.preventDefault();

        const feedbackType = document.querySelector('input[name="feedbackType"]:checked');
        const feedbackText = document.getElementById('feedbackText').value;
        const name = document.getElementById('name').value;
        const email = document.getElementById('email').value;

        if (!feedbackType) {
            alert('Please select a feedback type.');
            return;
        }

        if (!feedbackText) {
            alert('Please describe your feedback.');
            return;
        }

        // Here you would typically send the data to a server
        console.log({
            feedbackType: feedbackType.value,
            feedbackText,
            name,
            email
        });

        alert('Feedback submitted!');
        form.reset();
    });
});
