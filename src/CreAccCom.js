export default {
    primaryColor: '#3f51b5',
    backgroundColor: '#283593',
    textColor: '#FFFFFF',
};

import config from 'config';

document.addEventListener('DOMContentLoaded', () => {
    const registrationForm = document.getElementById('registrationForm');
    registrationForm.addEventListener('submit', (event) => {
        event.preventDefault(); 

        const companyName = document.getElementById('companyName').value;
        const emailAddress = document.getElementById('emailAddress').value;
        const password = document.getElementById('password').value;
        const countryCode = document.getElementById('countryCode').value;
        const phoneNumber = document.getElementById('phoneNumber').value;
        const website = document.getElementById('website').value;
        const industry = document.getElementById('industry').value;
        const location = document.getElementById('location').value;
        const logo = document.getElementById('logo').files[0];

        console.log('Registration Data:', {
            companyName,
            emailAddress,
            password,
            countryCode,
            phoneNumber,
            website,
            industry,
            location,
            logo
        });

        alert('Registration submitted!');
        registrationForm.reset();
    });
});

