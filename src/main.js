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

function renderSeekers() {
    const seekersList = document.getElementById('seekersList');
    seekersList.innerHTML = seekersData.map(createSeekerCard).join('');
}
document.addEventListener('click', function (event) {
    if (event.target.closest('.cv-icon')) {
        const cvContent = event.target.closest('.seeker-card').querySelector('.cv-content');
        cvContent.style.display = cvContent.style.display === 'none' ? 'block' : 'none';
    }
});
document.addEventListener('DOMContentLoaded', renderSeekers);