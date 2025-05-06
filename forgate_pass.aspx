<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="forgate_pass.aspx.cs" Inherits="YourChef.forgate_pass" %>



<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reset Password</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
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

        /* Navigation Bar Styles */
        .navbar {
            background-color: rgba(0, 0, 0, 0.5);
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar-left {
            display: flex;
            align-items: center;
        }

        .logo {
            font-size: 24px;
            color: #fff;
            margin-right: 10px;
        }

        .title {
            color: #fff;
            font-size: 20px;
            margin: 0;
        }

        .navbar-center {
            display: flex;
            align-items: center;
        }

        .nav-link {
            color: #fff;
            text-decoration: none;
            margin: 0 15px;
            font-size: 16px;
        }

        .nav-link:hover {
            color: #FF5733;
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
            font-size: 14px;
        }

        .search-icon1 {
            position: absolute;
            left: 10px;
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
            margin-left: 15px;
        }

        /* Container Styles */
        .container {
            width: 90%;
            max-width: 400px;
            margin: 40px auto;
            background-color: rgba(255, 255, 255, 0.8);
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #555;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }

        /* Input Group Styles */
        .input-group {
            position: relative;
            margin-bottom: 20px;
        }

        .input-group i {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #FF5733;
        }

        .input-field {
            width: 100%;
            padding: 10px 10px 10px 40px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            background-color: #fff;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            height: 40px;
            box-sizing: border-box;
        }

        .toggle-password {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #FF5733;
        }

        /* Button Styles */
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

        /* Message Label */
        #lblMessage {
            display: block;
            margin-bottom: 15px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navigation Bar -->
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

        <!-- Reset Password Form -->
        <div class="container">
            <h2>Reset Password</h2>
            <asp:Label ID="lblMessage" runat="server" />
            <label for="newPassword">New Password</label>
            <div class="input-group">
                <i class="fas fa-lock"></i>
                <asp:TextBox ID="newPassword" runat="server" CssClass="input-field" TextMode="Password" placeholder="New Password"></asp:TextBox>
                <i class="fas fa-eye toggle-password"></i>
            </div>
            <label for="confirmPassword">Confirm Password</label>
            <div class="input-group">
                <i class="fas fa-lock"></i>
                <asp:TextBox ID="confirmPassword" runat="server" CssClass="input-field" TextMode="Password" placeholder="Confirm Password"></asp:TextBox>
                <i class="fas fa-eye toggle-password"></i>
            </div>
            <asp:Button ID="updatePasswordButton" runat="server" CssClass="btn" Text="Update Password" OnClick="updatePasswordButton_Click" />
        </div>

        <!-- JavaScript for Password Toggle -->
        <script>
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
        </script>
    </form>
</body>
</html>