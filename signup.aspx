<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signup.aspx.cs" Inherits="YourChef.signup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Sign Up & Login Page</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="css/signup.css"/>
    
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
           <a href="user_profile.aspx"  class="fas fa-user-circle profile-icon"></a>

        </div>
      </nav>
    <div class="container">
        <!-- Sign Up Page -->
        <div id="signUpPage" class="form-container">
            <div class="icon">
                <i class="fas fa-user-circle"></i>
            </div>
            <h2>Sign Up</h2>
            <div class="input-group">
                <i class="fas fa-user"></i>
                <asp:TextBox ID="fullName" runat="server" CssClass="input-field" AutoComplete="off" placeholder="Full Name" ></asp:TextBox>
            </div>
            <div class="input-group">
                <i class="fas fa-envelope"></i>
                <asp:TextBox ID="emailAddress" runat="server" CssClass="input-field" AutoComplete="off" placeholder="Email Address"></asp:TextBox>
            </div>
            <div class="input-group">
                <i class="fas fa-user"></i>
                <asp:TextBox ID="username" runat="server" CssClass="input-field" AutoComplete="off" placeholder="Pick a Username" ></asp:TextBox>
            </div>
            <div class="input-group">
                <i class="fas fa-lock"></i>
                <asp:TextBox ID="password" runat="server" CssClass="input-field" AutoComplete="off" TextMode="Password" placeholder="Set a Password"></asp:TextBox>
                <i class="fas fa-eye toggle-password"></i>
            </div>
            <div class="input-group">
               <i class="fas fa-user"></i>
               <asp:TextBox ID="phoneNumber" runat="server" CssClass="input-field" AutoComplete="off" placeholder="Pick a PhoneNumber" ></asp:TextBox>
            </div>
            <asp:Button ID="signUpButton" runat="server" CssClass="btn" Text="Sign Up" OnClick="signUpButton_Click" />
            <p>Already have an account? <a href="#" id="goToLogin">Login</a></p><br>
            <asp:Label ID="lblMessage" runat="server" Text="Label"></asp:Label>
            <asp:HiddenField ID="hfRole" runat="server" />


        </div>

        <!-- Login Page -->
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
            <asp:Label ID="label1" runat="server" Text="Label"></asp:Label>
        </div>
    </div>

    <script src="JS/signup.js"></script>
    </form>
    </body>
</html>
