document.addEventListener('DOMContentLoaded', function () {
    // Get all form elements
    const inputs = document.querySelectorAll('input');
    const saveBtn = document.querySelector('.save-btn');
    const cancelBtn = document.querySelector('.cancel-btn');

    // Save button click event
    saveBtn.addEventListener('click', function () {
        alert('Changes saved successfully!');
        // Here you would typically send data to a server
    });

    // Cancel button click event
    cancelBtn.addEventListener('click', function () {
        // Reset all editable fields
        inputs.forEach(input => {
            if (!input.readOnly && input.type !== 'password') {
                input.value = '';
            }
        });
    });

    // Add focus styles to inputs
    inputs.forEach(input => {
        input.addEventListener('focus', function () {
            this.style.borderColor = '#4CAF50';
            this.style.boxShadow = '0 0 5px rgba(76, 175, 80, 0.5)';
        });

        input.addEventListener('blur', function () {
            this.style.borderColor = '#ddd';
            this.style.boxShadow = 'none';
        });
    });
});