document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('job-posting-form');
    const steps = Array.from(document.querySelectorAll('.form-step'));
    const stepButtons = Array.from(document.querySelectorAll('.step'));
    let currentStep = 1;

    function showStep(stepNumber) {
        steps.forEach(step => step.classList.remove('active'));
        stepButtons.forEach(button => button.classList.remove('active'));

        const stepToShow = document.getElementById(`step-${stepNumber}`);
        const stepButtonToShow = document.querySelector(`.step[data-step="${stepNumber}"]`);

        if (stepToShow && stepButtonToShow) {
            stepToShow.classList.add('active');
            stepButtonToShow.classList.add('active');
        }
    }

    // Initial display
    showStep(currentStep);

    // Next button functionality
    document.querySelectorAll('.next-button').forEach(button => {
        button.addEventListener('click', () => {
            const nextStep = parseInt(button.dataset.next);
            if (nextStep <= steps.length) {
                currentStep = nextStep;
                showStep(currentStep);
            }
        });
    });

    // Previous button functionality
    document.querySelectorAll('.prev-button').forEach(button => {
        button.addEventListener('click', () => {
            const prevStep = parseInt(button.dataset.prev);
            if (prevStep >= 1) {
                currentStep = prevStep;
                showStep(currentStep);
            }
        });
    });

    // Step click functionality
    stepButtons.forEach(button => {
        button.addEventListener('click', () => {
            const stepNumber = parseInt(button.dataset.step);
            if (stepNumber >= 1 && stepNumber <= steps.length) {
                currentStep = stepNumber;
                showStep(currentStep);
            }
        });
    });


    // Form submission
    form.addEventListener('submit', (event) => {
        event.preventDefault();
        // Handle form submission logic here
        alert('Form submitted!');
    });
});