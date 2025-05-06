<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="contectus.aspx.cs" Inherits="YourChef.contectus" %>


<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>Contact Us - Your Chef</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous" />
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA==" crossorigin="anonymous" />
    <!-- Custom Styles -->
    <style>
        /* Hero Section */
        .hero {
            background-image: url('images/chef-background.jpg'); /* Replace with your image path */
            background-size: cover;
            background-position: center;
            padding: 100px 0;
            position: relative;
        }
        .hero-overlay {
            background: rgba(0, 0, 0, 0.5); /* Dark overlay for readability */
            color: white;
            padding: 20px;
            text-align: center;
        }
        .hero h1 {
            font-size: 3rem;
            margin-bottom: 10px;
        }
        .hero p {
            font-size: 1.5rem;
        }
        /* Contact Form */
        .contact-form {
            background: white;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        /* Contact Info */
        .contact-info i {
            color: #f0ad4e; /* Warm color for chef theme */
        }
        .form-control {
            font-size: 1.1rem; /* Larger inputs for ease of use */
        }
        .btn-primary {
            background-color: #f0ad4e;
            border-color: #f0ad4e;
        }
        .btn-primary:hover {
            background-color: #e0a34e;
            border-color: #e0a34e;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navigation Bar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">Your Chef</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item"><a class="nav-link" href="Default.aspx">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="AboutUs.aspx">About Us</a></li>
                    <li class="nav-item"><a class="nav-link" href="Services.aspx">Services</a></li>
                    <li class="nav-item active"><a class="nav-link" href="ContactUs.aspx">Contact Us</a></li>
                </ul>
            </div>
        </nav>

        <!-- Hero Section -->
        <section class="hero">
            <div class="hero-overlay">
                <h1>Contact Us</h1>
                <p>Get in touch with Your Chef for all your booking needs.</p>
            </div>
        </section>

        <!-- Contact Form Section -->
        <section class="py-5">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="contact-form">
                            <h2 class="text-center mb-4">Send Us a Message</h2>
                            <asp:ScriptManager ID="ScriptManager1" runat="server" />
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblMessage" runat="server" CssClass="d-block text-center mb-3" />
                                    <div class="form-group">
                                        <label for="txtName">Name</label>
                                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Placeholder="Your Name" />
                                        <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Name is required" CssClass="text-danger" Display="Dynamic" />
                                    </div>
                                    <div class="form-group">
                                        <label for="txtEmail">Email</label>
                                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Your Email" />
                                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required" CssClass="text-danger" Display="Dynamic" />
                                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid email format" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="text-danger" Display="Dynamic" />
                                    </div>
                                    <div class="form-group">
                                        <label for="txtSubject">Subject</label>
                                        <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" Placeholder="Subject" />
                                    </div>
                                    <div class="form-group">
                                        <label for="txtMessage">Message</label>
                                        <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control" Placeholder="Your Message" />
                                        <asp:RequiredFieldValidator ID="rfvMessage" runat="server" ControlToValidate="txtMessage" ErrorMessage="Message is required" CssClass="text-danger" Display="Dynamic" />
                                    </div>
                                    <asp:Button ID="btnSubmit" runat="server" Text="Send Message" CssClass="btn btn-primary btn-lg btn-block" OnClick="btnSubmit_Click" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Contact Information Section -->
        <section class="contact-info py-5 bg-light">
            <div class="container">
                <div class="row text-center">
                    <div class="col-md-4">
                        <i class="fas fa-phone fa-3x mb-3"></i>
                        <h4>Phone</h4>
                        <p>+1 (555) 123-4567</p>
                    </div>
                    <div class="col-md-4">
                        <i class="fas fa-envelope fa-3x mb-3"></i>
                        <h4>Email</h4>
                        <p>contact@yourchef.com</p>
                    </div>
                    <div class="col-md-4">
                        <i class="fas fa-map-marker-alt fa-3x mb-3"></i>
                        <h4>Address</h4>
                        <p>123 Chef Street, Food City, FC 12345</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="text-center py-4 bg-dark text-white">
            <p>&copy; 2023 Your Chef. All rights reserved.</p>
        </footer>
    </form>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js" integrity="sha384-WFNKQKn4aYa/2eFmvfN5fL8L5e5u5tL5vF+e5u5tL5vF+e5u5tL5vF+e5u5tL5vF+" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
</body>
</html>