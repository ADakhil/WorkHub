<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePageF.aspx.cs" Inherits="workHub.HomePageF" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>WorkHub - Your Career Starts Here</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --secondary: #3f37c9;
            --accent: #4895ef;
            --light: #f8f9fa;
            --dark: #212529;
            --success: #4cc9f0;
            --warning: #f72585;
            --gray: #6c757d;
            --light-gray: #e9ecef;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light);
            color: var(--dark);
            line-height: 1.6;
        }

        /* Header */
        header {
            background-color: var(--primary);
            padding: 20px 50px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        nav ul {
            list-style: none;
            display: flex;
            gap: 20px;
            margin: 0;
            padding: 0;
        }

        nav a, .button {
            color: white;
            font-weight: 500;
            padding: 10px 20px;
            border-radius: 6px;
            transition: all 0.3s;
            text-decoration:none;
        }

        nav a:hover, .button:hover {
            background-color: var(--secondary);
        }

        /* Hero Section */
        .hero {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 80px 50px;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            color: white;
        }

        .hero-content {
            max-width: 50%;
        }

        .hero h1 {
            font-size: 42px;
            margin-bottom: 20px;
            line-height: 1.2;
        }

        .hero p {
            font-size: 18px;
            margin-bottom: 30px;
            max-width: 80%;
        }

        .hero-image {
            width: 45%;
            border-radius: 10px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
            overflow: hidden;
        }

        .hero-image img {
            width: 100%;
            height: auto;
            display: block;
            transition: transform 0.5s;
        }

        .hero-image:hover img {
            transform: scale(1.03);
        }

        .btn {
            display: inline-block;
            padding: 12px 30px;
            background-color: white;
            color: var(--primary);
            border-radius: 6px;
            font-weight: 600;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            font-size: 16px;
            text-decoration:none;
        }

        .btn:hover {
            background-color: var(--light-gray);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        /* Features Section */
        .features {
            padding: 80px 50px;
            text-align: center;
            background-color: white;
        }

        .section-title {
            font-size: 32px;
            margin-bottom: 50px;
            color: var(--dark);
            position: relative;
            display: inline-block;
        }

        .section-title:after {
            content: '';
            position: absolute;
            width: 50%;
            height: 4px;
            background: var(--primary);
            bottom: -10px;
            left: 25%;
            border-radius: 2px;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-top: 50px;
        }

        .feature-card {
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: all 0.3s;
            text-align: left;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }

        .feature-image {
            height: 200px;
            overflow: hidden;
        }

        .feature-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s;
        }

        .feature-card:hover .feature-image img {
            transform: scale(1.1);
        }

        .feature-content {
            padding: 25px;
        }

        .feature-content h3 {
            font-size: 22px;
            margin-bottom: 15px;
            color: var(--dark);
        }

        .feature-content p {
            color: var(--gray);
            margin-bottom: 20px;
        }

        .feature-link {
            color: var(--primary);
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        /* CTA Section */
        .cta {
            padding: 80px 50px;
            background-color: var(--light);
            text-align: center;
        }

        .cta-container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            border-radius: 10px;
            padding: 50px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .cta h2 {
            font-size: 32px;
            margin-bottom: 20px;
        }

        .cta p {
            color: var(--gray);
            margin-bottom: 30px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Footer */
        footer {
            background-color: var(--dark);
            color: white;
            padding: 50px;
            text-align: center;
        }

        .footer-content {
            display: flex;
            justify-content: space-between;
            max-width: 1200px;
            margin: 0 auto;
            flex-wrap: wrap;
            gap: 30px;
        }

        .footer-logo {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
            color: white;
        }

        .footer-links h3 {
            font-size: 18px;
            margin-bottom: 15px;
            color: white;
        }

        .footer-links ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .footer-links li {
            margin-bottom: 10px;
        }

        .footer-links a {
            color: var(--light-gray);
            transition: color 0.3s;
        }

        .footer-links a:hover {
            color: white;
        }

        .copyright {
            margin-top: 50px;
            padding-top: 20px;
            border-top: 1px solid var(--gray);
            color: var(--light-gray);
            font-size: 14px;
        }

        /* Responsive Styles */
        @media (max-width: 992px) {
            .hero {
                flex-direction: column;
                text-align: center;
                padding: 60px 30px;
            }

            .hero-content {
                max-width: 100%;
                margin-bottom: 40px;
            }

            .hero p {
                max-width: 100%;
            }

            .hero-image {
                width: 80%;
            }
        }

        @media (max-width: 768px) {
            header {
                flex-direction: column;
                padding: 20px;
                gap: 20px;
            }

            nav ul {
                flex-direction: column;
                gap: 10px;
            }

            .features, .cta {
                padding: 50px 20px;
            }

            .cta-container {
                padding: 30px 20px;
            }

            .footer-content {
                flex-direction: column;
                align-items: center;
                text-align: center;
            }
        }

      
/* Fullscreen Showcase */
.company-showcase {
    position: relative;
    width: 100%;
    height: 100vh;
    max-height: 900px;
    overflow: hidden;
    background: #000;
}

.carousel-container {
    position: relative;
    width: 100%;
    height: 100%;

}

.carousel-track {
    display: flex;
    height: 100%;
    transition: transform 1s cubic-bezier(0.33, 0, 0.2, 1);
}

.carousel-slide {
    min-width: 100%;
    height: 100%;
    position: relative;
}

.carousel-slide img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: center;
    opacity: 0.9;
    transition: opacity 0.8s ease;
}

/* Overlay Styling */
.carousel-overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    background: linear-gradient(90deg, rgba(0,0,0,0.7) 0%, rgba(0,0,0,0.3) 100%);
    padding: 0 10%;
}

.overlay-content {
    max-width: 600px;
    color: white;
    animation: fadeInUp 0.8s ease;
}

.section-tagline {
    font-size: 1rem;
    text-transform: uppercase;
    letter-spacing: 3px;
    color: rgba(255,255,255,0.8);
    margin-bottom: 1rem;
}

.company-card {
    background: rgba(255,255,255,0.1);
    backdrop-filter: blur(10px);
    padding: 2.5rem;
    border-radius: 12px;
    border-left: 4px solid var(--primary);
}

.company-name {
    font-size: 2.5rem;
    margin: 0 0 1rem;
    line-height: 1.2;
    text-shadow: 0 2px 4px rgba(0,0,0,0.3);
}

.company-description {
    font-size: 1.2rem;
    line-height: 1.6;
    margin-bottom: 1.5rem;
    opacity: 0.9;
}

.company-meta {
    display: flex;
    gap: 15px;
    margin-bottom: 2rem;
    flex-wrap: wrap;
}

.industry-badge, .location {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 0.9rem;
    background: rgba(255,255,255,0.15);
    padding: 0.5rem 1rem;
    border-radius: 20px;
}

.cta-button {
    display: inline-block;
    padding: 12px 30px;
    background-color: var(--primary);
    color: white;
    border-radius: 6px;
    font-weight: 600;
    text-decoration: none;
    transition: all 0.3s;
    border: 2px solid transparent;
}

.cta-button:hover {
    background-color: transparent;
    border-color: white;
    transform: translateY(-3px);
}

/* Navigation */
.carousel-nav {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    background: rgba(255,255,255,0.2);
    border: none;
    color: white;
    width: 50px;
    height: 50px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: all 0.3s;
    z-index: 10;
    backdrop-filter: blur(5px);
}

.carousel-nav:hover {
    background: var(--primary);
    transform: translateY(-50%) scale(1.1);
}

.prev {
    left: 30px;
}

.next {
    right: 30px;
}

/* Dots */
.carousel-dots {
    position: absolute;
    bottom: 40px;
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    gap: 12px;
}

.carousel-dot {
    width: 14px;
    height: 14px;
    border-radius: 50%;
    background: rgba(255,255,255,0.3);
    cursor: pointer;
    transition: all 0.3s;
}

.carousel-dot.active {
    background: white;
    transform: scale(1.2);
}

/* Animations */
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Responsive */
@media (max-width: 992px) {
    .overlay-content {
        padding: 0 5%;
    }
    .company-card {
        padding: 2rem;
    }
    .company-name {
        font-size: 2rem;
    }
}

@media (max-width: 768px) {
    .company-showcase {
        height: 80vh;
    }
    .company-card {
        padding: 1.5rem;
    }
    .company-name {
        font-size: 1.8rem;
    }
    .company-description {
        font-size: 1rem;
    }
    .carousel-nav {
        width: 40px;
        height: 40px;
    }
}

.btn-seek{
    background-color:var(--light-gray) !important;
    
}

.btn-seek:hover{
    background-color:var(--primary) !important;
    color:white;
}
    </style>
</head>
<body>
    <header>
        <a href="HomePageF.aspx" class="logo">
            <i class="fas fa-briefcase"></i> WorkHub
        </a>
        <nav>
            <ul>
                <li><a href="jobsearch-seeker.aspx">Browse Jobs</a></li>
                <li><a href="CreAccCom.aspx" class="button">For Employers</a></li>
            </ul>
        </nav>
    </header>

    <!-- Company Carousel Section -->
<section class="company-showcase">
    <div class="carousel-container">
        <div class="carousel-track" id="carouselTrack">
            <!-- Dynamic content will be inserted here -->
        </div>
        
        <!-- Overlay Content -->
        <div class="carousel-overlay">
            <div class="overlay-content">
                <h2 class="section-tagline">Featured Employers</h2>
                <div class="company-card" id="companyCard">
                    <h3 class="company-name">Loading featured companies...</h3>
                    <p class="company-description">Discover top employers actively hiring on WorkHub</p>
                    <div class="company-meta">
                        <span class="industry-badge"><i class="fas fa-industry"></i> Technology</span>
                        <span class="location"><i class="fas fa-map-marker-alt"></i> Worldwide</span>
                    </div>
                    <a href="jobsearch-seeker.aspx" class="cta-button">View Jobs</a>
                </div>
            </div>
        </div>
        
        <!-- Navigation -->
        <button class="carousel-nav prev" onclick="moveSlide(-1)">
            <i class="fas fa-chevron-left"></i>
        </button>
        <button class="carousel-nav next" onclick="moveSlide(1)">
            <i class="fas fa-chevron-right"></i>
        </button>
        
        <!-- Progress Dots -->
        <div class="carousel-dots" id="carouselDots"></div>
    </div>
</section>

    <section class="hero">
        <div class="hero-content">
            <h1>Find Your Dream Job or Top Talent</h1>
            <p>WorkHub connects job seekers with employers through an innovative platform designed for the modern workforce.</p>
            <div style="display: flex; gap: 15px; margin-top: 30px;">
                <a href="Create-an-Account-Seeker.aspx" class="btn btn-seek"  >Sign Up as Job Seeker</a>
                <a href="CreAccCom.aspx" class="btn" style="background-color: var(--accent); color: white;">Employers</a>
            </div>
        </div>
        <div class="hero-image">
            <img src="https://images.unsplash.com/photo-1521791136064-7986c2920216?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2069&q=80" alt="Team working together">
        </div>
    </section>

    <section class="features">
        <h2 class="section-title">Why Choose WorkHub?</h2>
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-image">
                    <img src="https://images.unsplash.com/photo-1579389083078-4e7018379f7e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80" alt="Job Seeker">
                </div>
                <div class="feature-content">
                    <h3>For Job Seekers</h3>
                    <p>Find your perfect job match with our advanced search and personalized recommendations.</p>
                    <a href="Create-an-Account-Seeker.aspx" class="feature-link">
                        Get Started <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
            </div>
            
            <div class="feature-card">
                <div class="feature-image">
                    <img src="https://images.unsplash.com/photo-1522071820081-009f0129c71c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80" alt="Employers">
                </div>
                <div class="feature-content">
                    <h3>For Employers</h3>
                    <p>Connect with top talent using our powerful recruitment tools and candidate matching system.</p>
                    <a href="CreAccCom.aspx" class="feature-link">
                        Hire Talent <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
            </div>
            
            <div class="feature-card">
                <div class="feature-image">
                    <img src="https://images.unsplash.com/photo-1552664730-d307ca884978?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80" alt="Interview">
                </div>
                <div class="feature-content">
                    <h3>Video Interviews</h3>
                    <p>Our integrated video interview platform makes remote hiring simple and effective.</p>
                    <a href="interview2.aspx" class="feature-link">
                        Learn More <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
            </div>
        </div>
    </section>

    <section class="cta">
        <div class="cta-container">
            <h2>Ready to Transform Your Career or Hiring Process?</h2>
            <p>Join thousands of professionals and companies who have found success with WorkHub.</p>
            <div style="display: flex; gap: 15px; justify-content: center; margin-top: 30px;">
                <a href="Create-an-Account-Seeker.aspx" class="btn">Sign Up as Job Seeker</a>
                <a href="CreAccCom.aspx" class="btn" style="background-color: var(--primary); color: white;">Sign Up as Employer</a>
            </div>
        </div>
    </section>

    <footer>
        <div class="footer-content">
            <div class="footer-about">
                <div class="footer-logo">
                    <i class="fas fa-briefcase"></i> WorkHub
                </div>
                <p>Connecting talent with opportunity through innovative technology.</p>
            </div>
            
            
            
            <div class="footer-links">
                <h3></h3>
                <ul>
                    
                    <li><a href="TermsOfUse.aspx">Terms of Use</a></li>
                 <!--   <li><a href="TermsOfUse.aspx">Resources</a></li>
                    <li><a href="TermsOfUse.aspx">Support</a></li> -->
                </ul>
            </div>
        </div>
        
        <div class="copyright">
            &copy; 2025 WorkHub. All rights reserved.
        </div>
    </footer>
 <script>
     let currentSlide = 0;
     let slides = [];
     let dots = [];
     let companies = [];
     let autoPlayInterval;

     // Fetch company data
     async function loadCompanies() {
         try {
             const response = await fetch('GetCompanyPosters.aspx');
             companies = await response.json();
             initCarousel();
         } catch (error) {
             console.error("Error loading companies:", error);
             document.getElementById('companyCard').innerHTML = `
                <h3>Featured Companies</h3>
                <p>Discover top employers on WorkHub</p>
                <a href="jobsearch-seeker.aspx" class="cta-button">Browse All Companies</a>
            `;
         }
     }

     // Initialize carousel
     function initCarousel() {
         const track = document.getElementById('carouselTrack');
         const dotsContainer = document.getElementById('carouselDots');

         companies.forEach((company, index) => {
             // Create slide
             const slide = document.createElement('div');
             slide.className = 'carousel-slide';
             slide.innerHTML = `
                <img src="${company.posterPath || 'Assets/default-poster.jpg'}" 
                     alt="${company.companyName} workplace">
            `;
             track.appendChild(slide);
             slides.push(slide);

             // Create dot
             const dot = document.createElement('div');
             dot.className = 'carousel-dot';
             if (index === 0) dot.classList.add('active');
             dot.addEventListener('click', () => goToSlide(index));
             dotsContainer.appendChild(dot);
             dots.push(dot);
         });

         if (companies.length > 0) {
             updateCompanyCard(0);
             startAutoPlay();
         }
     }

     // Update company info display
     function updateCompanyCard(index) {
         const company = companies[index];
         const card = document.getElementById('companyCard');

         card.innerHTML = `
            <h3 class="company-name">${company.companyName}</h3>
            <p class="company-description">${company.description || 'A leading employer in ' + company.industry}</p>
            <div class="company-meta">
                <span class="industry-badge">
                    <i class="fas fa-industry"></i> ${company.industry || 'Various Industries'}
                </span>
                <span class="location">
                    <i class="fas fa-map-marker-alt"></i> ${company.location || 'Multiple Locations'}
                </span>
            </div>
            <a href="jobsearch-seeker.aspx?company=${encodeURIComponent(company.companyName)}" 
               class="cta-button">
               View Open Positions
            </a>
        `;

         // Animate the card
         card.style.animation = 'none';
         void card.offsetWidth; // Trigger reflow
         card.style.animation = 'fadeInUp 0.6s ease';
     }

     // Navigation functions
     function moveSlide(n) {
         currentSlide = (currentSlide + n + slides.length) % slides.length;
         updateCarousel();
     }

     function goToSlide(n) {
         currentSlide = n;
         updateCarousel();
     }

     function updateCarousel() {
         // Update slide position
         slides.forEach((slide, index) => {
             slide.style.transform = `translateX(${-100 * currentSlide}%)`;
         });

         // Update dots
         dots.forEach((dot, index) => {
             dot.classList.toggle('active', index === currentSlide);
         });

         // Update company info
         updateCompanyCard(currentSlide);

         // Reset autoplay timer
         resetAutoPlay();
     }

     // Autoplay controls
     function startAutoPlay() {
         autoPlayInterval = setInterval(() => moveSlide(1), 6000);
     }

     function resetAutoPlay() {
         clearInterval(autoPlayInterval);
         startAutoPlay();
     }

     // Pause on hover
     const container = document.querySelector('.carousel-container');
     container.addEventListener('mouseenter', () => clearInterval(autoPlayInterval));
     container.addEventListener('mouseleave', startAutoPlay);

     // Initialize on load
     document.addEventListener('DOMContentLoaded', loadCompanies);
 </script>
</body>
</html>