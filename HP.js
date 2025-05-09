const seekersData = [
    {
        name: 'John Smith',
        title: 'Software Engineer',
        skills: 'Java, Python, ReactJS',
        experience: '5 Years'
    },
    {
        name: 'Ahmed Al-Qahtani',
        title: 'Full Stack Developer',
        skills: 'JavaScript, Node.js, React, MongoDB',
        experience: '5 Years'
    },
    {
        name: 'Mohammed Al-Dosari',
        title: 'Game Developer',
        skills: 'Unity, Unreal Engine, C++, 3D Modeling',
        experience: '3 Years'
    }
];

function createSeekerCard(seeker) {
    return `
    <div class="seeker-card">
      <div class="avatar">
        <svg viewBox="0 0 24 24">
          <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" fill="currentColor"/>
        </svg>
      </div>
      <div class="seeker-info">
        <div class="seeker-name">${seeker.name}</div>
        <div class="seeker-title">${seeker.title}</div>
        <div class="seeker-details">
          Skills: ${seeker.skills}<br>
          Experience: ${seeker.experience}
        </div>
      </div>
      <div class="cv-icon">
        <svg viewBox="0 0 24 24">
          <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8l-6-6zm-1 1v5h5v10H6V4h7zm-2 8H8v1h3v-1zm0 2H8v1h3v-1zm0 2H8v1h3v-1zm5-2h-3v1h3v-1zm0 2h-3v1h3v-1z" fill="currentColor"/>
        </svg>
      </div>
    </div>
  `;
}

document.addEventListener('DOMContentLoaded', () => {
    const seekersList = document.getElementById('seekersList');
    if (seekersList) {
        seekersList.innerHTML = seekersData.map(createSeekerCard).join('');
    }

    // Update datetime
    const updateDateTime = () => {
        const now = new Date();
        const options = {
            year: 'numeric',
            month: 'short',
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        };
        const dateTimeStr = now.toLocaleDateString('en-US', options);
        document.querySelector('.datetime').textContent = dateTimeStr;
    };

    // Update time immediately and then every minute
    updateDateTime();
    setInterval(updateDateTime, 60000);

    // Handle stat card clicks
    document.querySelectorAll('.stat-card').forEach(card => {
        card.addEventListener('click', (e) => {
            const title = e.currentTarget.querySelector('h3').textContent;
            console.log(`Navigating to ${title} page`);
            // Add actual navigation logic here
        });
    });

    // Handle profile section click
    const profileSection = document.querySelector('.profile-section');
    if (profileSection) {
        profileSection.addEventListener('click', (e) => {
            console.log('Navigating to profile page');
            // Add actual navigation logic here
        });
    }

    const addJobBtn = document.querySelector('.add-job-btn');
    if (addJobBtn) {
        addJobBtn.addEventListener('click', () => {
            console.log('Add job clicked');
        });
    }
});