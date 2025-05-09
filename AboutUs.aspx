<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="workHub.AboutUs" %>

<!--<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us | WorkHub</title>
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
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--light);
            color: var(--dark);
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Header */
        header {
            background-color: var(--primary);
            color: white;
            padding: 20px 0;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
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

        nav a {
            color: white;
            font-weight: 500;
            padding: 8px 15px;
            border-radius: 6px;
            transition: background-color 0.3s;
        }

        nav a:hover {
            background-color: var(--secondary);
        }

        /* Main Content */
        .page-header {
            text-align: center;
            padding: 50px 0 30px;
        }

        .page-header h1 {
            font-size: 36px;
            margin-bottom: 15px;
            color: var(--primary);
        }

        .page-header p {
            color: var(--gray);
            max-width: 800px;
            margin: 0 auto;
        }

        .about-section {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            overflow: hidden;
            padding: 30px;
        }

        .about-section h2 {
            color: var(--primary);
            margin-top: 0;
            font-size: 24px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }

        .team-member {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            overflow: hidden;
            transition: transform 0.3s;
        }

        .team-member:hover {
            transform: translateY(-5px);
        }

        .member-image {
            height: 250px;
            overflow: hidden;
        }

        .member-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s;
        }

        .team-member:hover .member-image img {
            transform: scale(1.05);
        }

        .member-info {
            padding: 20px;
            text-align: center;
        }

        .member-info h3 {
            margin: 0 0 5px;
            color: var(--dark);
        }

        .member-info p {
            color: var(--gray);
            margin: 0;
        }

        .social-links {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 15px;
        }

        .social-links a {
            color: var(--primary);
            font-size: 18px;
            transition: color 0.3s;
        }

        .social-links a:hover {
            color: var(--secondary);
        }

        /* Stats */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin: 50px 0;
        }

        .stat-item {
            text-align: center;
            padding: 30px 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .stat-number {
            font-size: 42px;
            font-weight: bold;
            color: var(--primary);
            margin-bottom: 10px;
        }

        .stat-label {
            color: var(--gray);
            font-size: 16px;
        }

        /* Footer */
        footer {
            background-color: var(--dark);
            color: white;
            padding: 30px 0;
            margin-top: 50px;
        }

        .footer-content {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 30px;
        }

        .footer-logo {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .footer-links h3 {
            font-size: 18px;
            margin-bottom: 15px;
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
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid var(--gray);
            text-align: center;
            color: var(--light-gray);
            font-size: 14px;
        }

        /* Responsive Styles */
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 15px;
            }
            
            nav ul {
                flex-direction: column;
                gap: 10px;
                text-align: center;
            }
            
            .team-grid {
                grid-template-columns: 1fr;
            }
            
            .stats-container {
                grid-template-columns: 1fr;
            }
            
            .footer-content {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="container header-content">
            <a href="HomePageF.aspx" class="logo">
                <i class="fas fa-briefcase"></i> WorkHub
            </a>
            <nav>
                <ul>
                    <li><a href="HomePageF.aspx">Home</a></li>
                    <li><a href="#mission">Our Mission</a></li>
                    <li><a href="#team">Our Team</a></li>
                    <li><a href="#values">Our Values</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <main class="container">
        <div class="page-header">
            <h1>About WorkHub</h1>
            <p>Transforming the way job seekers and employers connect through innovative technology and exceptional service.</p>
        </div>

        <section id="mission" class="about-section">
            <h2><i class="fas fa-bullseye"></i> Our Mission</h2>
            <p>At WorkHub, we're on a mission to revolutionize the job search and hiring process. We believe that finding the right job or the perfect candidate should be simple, efficient, and stress-free. Our platform bridges the gap between talented professionals and forward-thinking companies, creating meaningful connections that drive success for both parties.</p>
            <p>Founded in 2023, WorkHub has quickly grown to become a trusted name in the recruitment industry, serving thousands of job seekers and employers across multiple industries.</p>
        </section>

        <section class="stats-container">
            <div class="stat-item">
                <div class="stat-number">10,000+</div>
                <div class="stat-label">Successful Hires</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">5,000+</div>
                <div class="stat-label">Companies Trust Us</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">50+</div>
                <div class="stat-label">Industries Served</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">98%</div>
                <div class="stat-label">User Satisfaction</div>
            </div>
        </section>

        <section id="values" class="about-section">
            <h2><i class="fas fa-heart"></i> Our Core Values</h2>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px;">
                <div>
                    <h3 style="color: var(--primary);"><i class="fas fa-lightbulb"></i> Innovation</h3>
                    <p>We constantly push boundaries to develop cutting-edge solutions that simplify the recruitment process for everyone involved.</p>
                </div>
                <div>
                    <h3 style="color: var(--primary);"><i class="fas fa-handshake"></i> Integrity</h3>
                    <p>We operate with honesty and transparency, building trust with our users through ethical business practices.</p>
                </div>
                <div>
                    <h3 style="color: var(--primary);"><i class="fas fa-users"></i> User-Centric</h3>
                    <p>Every decision we make prioritizes the needs and experiences of our job seekers and employers.</p>
                </div>
                <div>
                    <h3 style="color: var(--primary);"><i class="fas fa-chart-line"></i> Excellence</h3>
                    <p>We strive for the highest standards in everything we do, from platform features to customer support.</p>
                </div>
            </div>
        </section>

        <section id="team" class="about-section">
            <h2><i class="fas fa-users"></i> Meet Our Team</h2>
            <p>The passionate professionals behind WorkHub are dedicated to creating the best possible experience for our users.</p>
            
            <div class="team-grid">
                <div class="team-member">
                    <div class="member-image">
                        <img src="https://images.unsplash.com/photo-1560250097-0b93528c311a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80" alt="Sarah Johnson">
                    </div>
                    <div class="member-info">
                        <h3>Sarah Johnson</h3>
                        <p>CEO & Founder</p>
                        <div class="social-links">
                            <a href="#"><i class="fab fa-linkedin"></i></a>
                            <a href="#"><i class="fab fa-twitter"></i></a>
                        </div>
                    </div>
                </div>
                
                <div class="team-member">
                    <div class="member-image">
                        <img src="https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80" alt="Michael Chen">
                    </div>
                    <div class="member-info">
                        <h3>Michael Chen</h3>
                        <p>CTO</p>
                        <div class="social-links">
                            <a href="#"><i class="fab fa-linkedin"></i></a>
                            <a href="#"><i class="fab fa-github"></i></a>
                        </div>
                    </div>
                </div>
                
                <div class="team-member">
                    <div class="member-image">
                        <img src="https://images.unsplash.com/photo-1580489944761-15a19d654956?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1061&q=80" alt="Priya Patel">
                    </div>
                    <div class="member-info">
                        <h3>Priya Patel</h3>
                        <p>Head of Product</p>
                        <div class="social-links">
                            <a href="#"><i class="fab fa-linkedin"></i></a>
                            <a href="#"><i class="fab fa-twitter"></i></a>
                        </div>
                    </div>
                </div>
                
                <div class="team-member">
                    <div class="member-image">
                        <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80" alt="David Kim">
                    </div>
                    <div class="member-info">
                        <h3>David Kim</h3>
                        <p>Marketing Director</p>
                        <div class="social-links">
                            <a href="#"><i class="fab fa-linkedin"></i></a>
                            <a href="#"><i class="fab fa-instagram"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <footer>
        <div class="container">
            <div class="footer-content">
                <div class="footer-about">
                    <div class="footer-logo">
                        <i class="fas fa-briefcase"></i> WorkHub
                    </div>
                    <p>Connecting talent with opportunity through innovative technology.</p>
                </div>
                
                <div class="footer-links">
                    <h3>Quick Links</h3>
                    <ul>
                        <li><a href="HomePageF.aspx">Home</a></li>
                        <li><a href="AboutUs.aspx">About Us</a></li>
                        <li><a href="TermsOfUse.aspx">Terms of Use</a></li>
                    </ul>
                </div>
                
                <div class="footer-links">
                    <h3>Contact</h3>
                    <ul>
                        <li><i class="fas fa-envelope"></i> support@workhub.com</li>
                        <li><i class="fas fa-phone"></i> +1 (555) 123-4567</li>
                        <li><i class="fas fa-map-marker-alt"></i> 123 Business Ave, City</li>
                    </ul>
                </div>
            </div>
            
            <div class="copyright">
                &copy; 2025 WorkHub. All rights reserved.
            </div>
        </div>
    </footer>
</body>
</html> -->





<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us | WorkHub</title>
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
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--light);
            color: var(--dark);
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        header {
            background-color: var(--primary);
            color: white;
            padding: 20px 0;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
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

        nav a {
            color: white;
            font-weight: 500;
            padding: 8px 15px;
            border-radius: 6px;
            transition: background-color 0.3s;
        }

        nav a:hover {
            background-color: var(--secondary);
        }

        .page-header {
            text-align: center;
            padding: 50px 0 30px;
        }

        .page-header h1 {
            font-size: 36px;
            margin-bottom: 15px;
            color: var(--primary);
        }

        .page-header p {
            color: var(--gray);
            max-width: 800px;
            margin: 0 auto;
        }

        .about-section {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            overflow: hidden;
            padding: 30px;
        }

        .about-section h2 {
            color: var(--primary);
            margin-top: 0;
            font-size: 24px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }

        .team-member {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            padding: 40px 20px;
            text-align: center;
            transition: transform 0.3s;
        }

        .team-member:hover {
            transform: translateY(-5px);
        }

        .member-name {
            font-size: 22px;
            color: var(--dark);
            margin: 0 0 15px 0;
            font-weight: 600;
        }

        .linkedin-icon {
            color: #0077B5;
            font-size: 24px;
            transition: all 0.3s;
        }

        .linkedin-icon:hover {
            transform: scale(1.1);
            opacity: 0.9;
        }

        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin: 50px 0;
        }

        .stat-item {
            text-align: center;
            padding: 30px 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .stat-number {
            font-size: 42px;
            font-weight: bold;
            color: var(--primary);
            margin-bottom: 10px;
        }

        .stat-label {
            color: var(--gray);
            font-size: 16px;
        }

        footer {
            background-color: var(--dark);
            color: white;
            padding: 30px 0;
            margin-top: 50px;
        }

        .footer-content {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 30px;
        }

        .footer-logo {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .footer-links h3 {
            font-size: 18px;
            margin-bottom: 15px;
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
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid var(--gray);
            text-align: center;
            color: var(--light-gray);
            font-size: 14px;
        }

        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 15px;
            }
            
            nav ul {
                flex-direction: column;
                gap: 10px;
                text-align: center;
            }
            
            .team-grid {
                grid-template-columns: 1fr;
            }
            
            .stats-container {
                grid-template-columns: 1fr;
            }
            
            .footer-content {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="container header-content">
            <a href="HomePageF.aspx" class="logo">
                <i class="fas fa-briefcase"></i> WorkHub
            </a>
            <nav>
                <ul>
                    <li><a href="HomePageF.aspx">Home</a></li>
                    <li><a href="#mission">Our Mission</a></li>
                    <li><a href="#team">Our Team</a></li>
                    <li><a href="#values">Our Values</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <main class="container">
        <div class="page-header">
            <h1>About WorkHub</h1>
            <p>Transforming the way job seekers and employers connect through innovative technology and exceptional service.</p>
        </div>

        <section id="mission" class="about-section">
            <h2><i class="fas fa-bullseye"></i> Our Mission</h2>
            <p>At WorkHub, we're on a mission to revolutionize the job search and hiring process. We believe that finding the right job or the perfect candidate should be simple, efficient, and stress-free. Our platform bridges the gap between talented professionals and forward-thinking companies, creating meaningful connections that drive success for both parties.</p>
           
        </section>

        

        <section id="values" class="about-section">
            <h2><i class="fas fa-heart"></i> Our Core Values</h2>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px;">
                <div>
                    <h3 style="color: var(--primary);"><i class="fas fa-lightbulb"></i> Innovation</h3>
                    <p>We constantly push boundaries to develop cutting-edge solutions that simplify the recruitment process for everyone involved.</p>
                </div>
                <div>
                    <h3 style="color: var(--primary);"><i class="fas fa-handshake"></i> Integrity</h3>
                    <p>We operate with honesty and transparency, building trust with our users through ethical business practices.</p>
                </div>
                <div>
                    <h3 style="color: var(--primary);"><i class="fas fa-users"></i> User-Centric</h3>
                    <p>Every decision we make prioritizes the needs and experiences of our job seekers and employers.</p>
                </div>
                <div>
                    <h3 style="color: var(--primary);"><i class="fas fa-chart-line"></i> Excellence</h3>
                    <p>We strive for the highest standards in everything we do, from platform features to customer support.</p>
                </div>
            </div>
        </section>

        <section id="team" class="about-section">
            <h2><i class="fas fa-users"></i> Our Team</h2>
            
            <div class="team-grid">
                <div class="team-member">
                    <p class="member-name">Lama Alaskar</p>
                    <a href="https://www.linkedin.com/in/lama-alaskar-402886230/" target="_blank" class="linkedin-icon">
                        <i class="fab fa-linkedin"></i>
                    </a>
                </div>
                
                <div class="team-member">
                    <p class="member-name">Asma Aldakhil</p>
                    <a href="https://www.linkedin.com/in/asma-aldakhil-002652298/" target="_blank" class="linkedin-icon">
                        <i class="fab fa-linkedin"></i>
                    </a>
                </div>
                
                <div class="team-member">
                    <p class="member-name">Maryam Alhaidar</p>
                    <a href="https://www.linkedin.com/in/maryamalhaidar/" target="_blank" class="linkedin-icon">
                        <i class="fab fa-linkedin"></i>
                    </a>
                </div>
                
                <div class="team-member">
                    <p class="member-name">Manar Alsaiari</p>
                    <a href="https://www.linkedin.com/in/asma-aldakhil-002652298/" target="_blank" class="linkedin-icon">
    <i class="fab fa-linkedin"></i>
</a>
                </div>
            </div>
        </section>
    </main>

    <footer>
        <div class="container">
            <div class="footer-content">
                <div class="footer-about">
                    <div class="footer-logo">
                        <i class="fas fa-briefcase"></i> WorkHub
                    </div>
                    <p>Connecting talent with opportunity through innovative technology.</p>
                </div>
                
                <div class="footer-links">
                    <h3>Quick Links</h3>
                    <ul>
                        <li><a href="HomePageF.aspx">Home</a></li>
                        <li><a href="AboutUs.aspx">About Us</a></li>
                        <li><a href="TermsOfUse.aspx">Terms of Use</a></li>
                    </ul>
                </div>
                
                <div class="footer-links">
                    <h3>Contact</h3>
                    <ul>
                        <li><i class="fas fa-envelope"></i> support@workhub.com</li>
                        <li><i class="fas fa-map-marker-alt"></i> Saudi Arabia, Dhahran</li>
                    </ul>
                </div>
            </div>
            
            <div class="copyright">
                &copy; 2025 WorkHub. All rights reserved.
            </div>
        </div>
    </footer>
</body>
</html>