<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="aboutus.aspx.cs" Inherits="YourChef.aboutus1" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>About Us - Your Chef</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" />
    <!-- Custom Styles -->
    <style>
        /* Hero Section */
        .hero {
            background-size: cover;
            background-position: center;
            padding: 100px 0;
            position: relative;
        }
        .hero-overlay {
            background: rgba(0, 0, 0, 0.5); /* Dark overlay for text readability */
            color: white;
            padding: 20px;
            text-align: center;
        }
        .hero h1 {
            font-size: 3em;
            margin-bottom: 10px;
        }
        .hero p {
            font-size: 1.5em;
        }
        /* Why Choose Us */
        .why-choose-us i {
            color: #f0ad4e; /* Warm accent color */
        }
        .why-choose-us h3 {
            font-size: 1.5em;
        }
        /* Team Section */
        .team img {
            max-width: 150px;
            transition: transform 0.3s ease;
        }
        .team .col-md-3:hover img {
            transform: scale(1.1); /* Slight zoom on hover */
        }
        /* Values Section */
        .values li {
            font-size: 1.2em;
            margin-bottom: 10px;
        }
        /* CTA Button */
        .cta .btn {
            transition: transform 0.3s ease, background-color 0.3s ease;
        }
        .cta .btn:hover {
            transform: translateY(-3px);
            background-color: #d9534f; /* Darker red on hover */
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navigation Bar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">Your Chef</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item"><a class="nav-link" href="Default.aspx">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="AboutUs.aspx">About Us</a></li>
                    <li class="nav-item"><a class="nav-link" href="Services.aspx">Services</a></li>
                    <li class="nav-item"><a class="nav-link" href="Contact.aspx">Contact</a></li>
                </ul>
            </div>
        </nav>

        <!-- Hero Section -->
        <section class="hero" style="background-image: url('images/chef-background.jpg');">
            <div class="hero-overlay">
                <h1>About Your Chef</h1>
                <p>Discover the story behind our passion for connecting you with exceptional culinary experiences.</p>
            </div>
        </section>

        <!-- Why Choose Us Section -->
        <section class="why-choose-us py-5">
            <h2 class="text-center">Why Choose Your Chef?</h2>
            <div class="row mt-4">
                <div class="col-md-4 text-center">
                    <i class="fas fa-check-circle fa-2x mb-3"></i>
                    <h3>Vetted Chefs</h3>
                    <p>Our chefs are carefully selected for their expertise and passion.</p>
                </div>
                <div class="col-md-4 text-center">
                    <i class="fas fa-calendar-alt fa-2x mb-3"></i>
                    <h3>Easy Booking</h3>
                    <p>Book your chef in just a few clicks with our user-friendly platform.</p>
                </div>
                <div class="col-md-4 text-center">
                    <i class="fas fa-globe fa-2x mb-3"></i>
                    <h3>Diverse Cuisines</h3>
                    <p>Explore a wide range of culinary styles from around the world.</p>
                </div>
            </div>
        </section>

        <!-- Mission Section -->
        <section class="mission py-5 bg-light">
            <div class="row">
                <div class="col-md-8 mx-auto text-center">
                    <h2>Our Mission</h2>
                    <p>At Your Chef, we aim to revolutionize the way you experience food by bringing professional chefs directly to your home or event. Our mission is to make gourmet dining accessible, convenient, and unforgettable for everyone.</p>
                </div>
            </div>
        </section>

        <!-- Testimonials Section -->
        <section class="testimonials py-5">
            <h2 class="text-center">What Our Customers Say</h2>
            <div id="testimonialCarousel" class="carousel slide mt-4" data-ride="carousel">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <p class="text-center">"Your Chef transformed my dinner party into a gourmet feast. The chef was amazing, and the food was out of this world!" - Jane D.</p>
                    </div>
                    <div class="carousel-item">
                        <p class="text-center">"I booked a chef for my anniversary, and it was the best decision ever. Exceptional service!" - Mark S.</p>
                    </div>
                </div>
                <a class="carousel-control-prev" href="#testimonialCarousel" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#testimonialCarousel" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
        </section>

        <!-- Team Section -->
        <section class="team py-5 bg-light">
            <h2 class="text-center">Meet the Team</h2>
            <div class="row mt-4">
                <div class="col-md-3 text-center">
                    <img src="images/team1.jpg" alt="John Doe" class="img-fluid rounded-circle mb-3" />
                    <h3>John Doe</h3>
                    <p>Founder & CEO</p>
                </div>
                <div class="col-md-3 text-center">
                    <img src="images/team2.jpg" alt="Jane Smith" class="img-fluid rounded-circle mb-3" />
                    <h3>Jane Smith</h3>
                    <p>Head of Culinary Operations</p>
                </div>
            </div>
        </section>

        <!-- Values Section -->
        <section class="values py-5">
            <h2 class="text-center">Our Values</h2>
            <div class="row mt-4">
                <div class="col-md-8 mx-auto">
                    <ul class="list-unstyled">
                        <li><i class="fas fa-star mr-2"></i> <strong>Quality:</strong> Ensuring the highest standards in chef selection and service.</li>
                        <li><i class="fas fa-clock mr-2"></i> <strong>Convenience:</strong> Making booking and managing events as easy as possible.</li>
                        <li><i class="fas fa-heart mr-2"></i> <strong>Customer Satisfaction:</strong> Going above and beyond to meet your expectations.</li>
                    </ul>
                </div>
            </div>
        </section>

        <!-- Call-to-Action Section -->
        <section class="cta py-5 text-center bg-light">
            <h2>Ready to Book Your Chef?</h2>
            <a href="Booking.aspx" class="btn btn-primary btn-lg mt-3">Get Started</a>
        </section>

        <!-- Footer -->
        <footer class="text-center mt-4">
            <p>© 2023 Your Chef. All rights reserved.</p>
        </footer>
    </form>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>