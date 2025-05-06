<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="loginn.aspx.cs" Inherits="YourChef.loginn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Sign Up & Login Page - Your Chef</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('https://images.unsplash.com/photo-1556911220-bff31c812dba');
            background-size: cover;
            background-position: center;
            min-height: 100vh;
        }

        /* Navigation Bar (Menu Bar) */
        .navbar {
            background-color: rgba(0, 0, 0, 0.5);
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        /* Add other navbar-related styles as in ResetPassword.aspx */
        .navbar-left {
            display: flex;
            align-items: center;
        }

        .navbar-left .logo {
            font-size: 24px;
            color: #fff;
            margin-right: 10px;
        }

        .navbar-left .title {
            color: #fff;
            font-size: 20px;
        }

        .navbar-center {
            display: flex;
            align-items: center;
        }

        .nav-link {
            color: #fff;
            text-decoration: none;
            font-weight: bold;
            margin: 0 10px;
        }

        .nav-link.active {
            color: #FF5733; /* Highlight active link */
        }

        .search-container {
            position: relative;
        }

        .search-bar1 {
            padding: 8px 10px 8px 30px;
            border: 1px solid #fff;
            border-radius: 4px;
            background-color: transparent;
            color: #fff;
        }

        .search-bar1::placeholder {
            color: #fff;
        }

        .search-icon1 {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #fff;
        }

        .navbar-right {
            display: flex;
            align-items: center;
        }

        .profile-icon {
            font-size: 24px;
            color: #fff;
            margin-left: 10px;
        }

        /* Form Container */
        .container {
            width: 90%;
            max-width: 400px;
            margin: 40px auto;
            background-color: rgba(255, 255, 255, 0.8);
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .form-container {
            display: block; /* Ensure forms are block by default */
        }

        .icon {
            text-align: center;
            margin-bottom: 20px;
        }

        .icon i {
            font-size: 48px;
            color: #FF5733;
        }

        h2 {
            text-align: center;
            color: #555;
            text-shadow: 1px 1px 2px rgba(255, 255, 255, 0.8);
            margin-bottom: 20px;
        }

        .input-group {
            position: relative;
            margin-bottom: 20px;
        }

        .input-group i:not(.toggle-password) {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #FF5733;
        }

        .input-field {
            width: 100%;
            padding: 10px 40px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            background-color: #fff;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            height: 40px;
            box-sizing: border-box;
        }

        .input-field::placeholder {
            color: #999;
        }

        .toggle-password {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #FF5733;
            cursor: pointer;
        }

        .btn {
            width: 100%;
            padding: 10px;
            background-color: #FF5733;
            border: none;
            color: #fff;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            border-radius: 4px;
        }

        .btn:hover {
            background-color: #e64a19;
        }

        p {
            text-align: center;
            margin-top: 15px;
        }

        p a {
            color: #FF5733;
            text-decoration: none;
            font-weight: bold;
        }

        p a:hover {
            text-decoration: underline;
        }

        .hidden {
            display: none;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
            }

            .navbar-left, .navbar-center, .navbar-right {
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar">
            <div class="navbar-left">
                <i class="fas fa-utensils logo"></i>
                <h1 class="title">Your Chef</h1>
            </div>
            <div class="navbar-center">
                <a href="#" class="nav-link">Book Now</a>
                <a href="#" class="nav-link">Register as Partner</a>
                <div class="search-container">
                    <asp:TextBox ID="searchBar" runat="server" CssClass="search-bar1" placeholder="Search..."></asp:TextBox>
                    <i class="fas fa-search search-icon1"></i>
                </div>
            </div>
            <div class="navbar-right">
                <a href="index.aspx" class="nav-link">Home</a>
                <a href="menu.aspx" class="nav-link">Menu</a>
                <a href="user_profile.aspx" class="fas fa-user-circle profile-icon"></a>
            </div>
        </nav>
        <br/><br/><br/><br/>
        <div class="container">
            <!-- Sign Up Page -->
            <div id="signUpPage" class="form-container">
                <div class="icon">
                    <i class="fas fa-user-circle"></i>
                </div>
                <h2>Sign Up</h2>
                <div class="input-group">
                    <i class="fas fa-user"></i>
                    <asp:TextBox ID="fullName" runat="server" CssClass="input-field" placeholder="Full Name" autocomplete="off"></asp:TextBox>
                </div>
                <div class="input-group">
                    <i class="fas fa-envelope"></i>
                    <asp:TextBox ID="emailAddress" runat="server" CssClass="input-field" placeholder="Email Address" autocomplete="off"></asp:TextBox>
                </div>
                <div class="input-group">
                    <i class="fas fa-user"></i>
                    <asp:TextBox ID="username" runat="server" CssClass="input-field" placeholder="Pick a Username" autocomplete="off"></asp:TextBox>
                </div>
                <div class="input-group">
                    <i class="fas fa-lock"></i>
                    <asp:TextBox ID="password" runat="server" CssClass="input-field" TextMode="Password" placeholder="Set a Password" autocomplete="new-password"></asp:TextBox>
                    <i class="fas fa-eye toggle-password"></i>
                </div>
                <div class="input-group">
                    <i class="fas fa-phone"></i>
                    <asp:TextBox ID="phoneNumber" runat="server" CssClass="input-field" placeholder="Phone Number" autocomplete="off"></asp:TextBox>
                </div>
                <asp:Button ID="signUpButton" runat="server" CssClass="btn" Text="Sign Up" OnClick="signUpButton_Click" />
                <p>Already have an account? <a href="#" id="goToLogin">Login</a></p>
            </div>

            <!-- Login Page -->
            <!-- Inside the <div id="loginPage" class="form-container hidden"> section -->
<div id="loginPage" class="form-container hidden">
    <div class="icon">
        <i class="fas fa-user-circle"></i>
    </div>
    <h2>Login</h2>
    <div class="input-group">
        <i class="fas fa-user"></i>
        <asp:TextBox ID="loginUsername" runat="server" CssClass="input-field" AutoComplete="off" placeholder="Username"></asp:TextBox>
    </div>
    <div class="input-group">
        <i class="fas fa-lock"></i>
        <asp:TextBox ID="loginPassword" runat="server" CssClass="input-field" AutoComplete="off" TextMode="Password" placeholder="Password"></asp:TextBox>
        <i class="fas fa-eye toggle-password"></i>
    </div>
    <asp:Button ID="loginButton" runat="server" CssClass="btn" Text="Login" OnClick="loginButton_Click" />
    <p>Don’t have an account? <a href="#" id="goToSignUp">Sign Up</a></p>
    <!-- Forgot Password Section -->
    <div class="input-group">
        <i class="fas fa-envelope"></i>
        <asp:TextBox ID="forgotEmail" runat="server" CssClass="input-field" placeholder="Enter Email for Reset" autocomplete="off"></asp:TextBox>
    </div>
    <asp:Button ID="forgotPasswordButton" runat="server" CssClass="btn" Text="Request Password Reset" OnClick="forgotPasswordButton_Click" />
    <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
</div>
        </div>

        <script>
            // JavaScript for toggling between Sign Up and Login pages
            const signUpPage = document.getElementById("signUpPage");
            const loginPage = document.getElementById("loginPage");
            const goToLogin = document.getElementById("goToLogin");
            const goToSignUp = document.getElementById("goToSignUp");

            // Ensure only the Login page is visible at first
            window.addEventListener("DOMContentLoaded", () => {
                signUpPage.style.display = "none";
                loginPage.style.display = "block";
            });

            // Event listener to switch to Login Page
            goToLogin.addEventListener("click", (e) => {
                e.preventDefault();
                signUpPage.style.display = "none";
                loginPage.style.display = "block";
            });

            // Event listener to switch to Sign Up Page
            goToSignUp.addEventListener("click", (e) => {
                e.preventDefault();
                loginPage.style.display = "none";
                signUpPage.style.display = "block";
            });

            // Toggle Password Visibility
            const togglePasswordIcons = document.querySelectorAll(".toggle-password");
            togglePasswordIcons.forEach((icon) => {
                icon.addEventListener("click", () => {
                    const input = icon.previousElementSibling;
                    if (input.type === "password") {
                        input.type = "text";
                        icon.classList.remove("fa-eye");
                        icon.classList.add("fa-eye-slash");
                    } else {
                        input.type = "password";
                        icon.classList.remove("fa-eye-slash");
                        icon.classList.add("fa-eye");
                    }
                });
            });

            // Navigation link active state
            const navLinks = document.querySelectorAll('.nav-link');
            navLinks.forEach(link => {
                link.addEventListener('click', (event) => {
                    navLinks.forEach(item => item.classList.remove('active'));
                    link.classList.add('active');
                });
            });

            document.addEventListener('click', (event) => {
                if (!event.target.closest('.navbar')) {
                    navLinks.forEach(item => item.classList.remove('active'));
                }
            });
        </script>
    </form>
</body>
</html>