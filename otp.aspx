<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="otp.aspx.cs" Inherits="YourChef.otp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>OTP Verification</title>
  <!-- Font Awesome for Icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    /* General Styles */
    body {
      font-family: Arial, sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
      
      background-image: linear-gradient(rgba(255, 255, 255, 0.3), rgba(255, 255, 255, 0.3)),
    url(https://wallpapercave.com/wp/wp1882369.jpg);
  background-size: cover;
  opacity: 0.8;
  background-repeat: no-repeat;
  background-position: center;

        }

    .form-container {
      background: #ffffff;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      text-align: center;
      width: 300px;
    }

    .icon {
      margin-bottom: 20px;
    }

    .icon i {
      color: #ffa500;
    }

    h2 {
      margin-bottom: 20px;
    }

    /* Inner Form Controls with Equal Margins */
    .form-group {
      margin: 15px 0;
      text-align: left;
    }

    .form-group label {
      display: flex;
      align-items: center;
      font-size: 14px;
      color: #555;
    }

    .form-group label i {
      margin-right: 10px;
      color: #ffa500;
    }

    .form-group input {
      width: calc(100% - 20px); /* Adds padding inside for uniform spacing */
      padding: 10px;
      margin: 5px 10px; /* Equal margin on both sides */
      border: 1px solid #ccc;
      border-radius: 5px;
      font-size: 14px;
      box-sizing: border-box; /* Ensures padding is included in width */
    }

    button {
      background: #ffa500;
      color: white;
      border: none;
      padding: 10px;
      border-radius: 5px;
      cursor: pointer;
      font-size: 16px;
      width: calc(100% - 20px);
      margin: 10px;
    }

    button:hover {
      background: #ff8c00;
    }

    .resend {
      margin-top: 10px;
      font-size: 14px;
    }

    .resend a {
      color: #ffa500;
      text-decoration: none;
      font-weight: bold;
    }

    .resend a:hover {
      text-decoration: underline;
    }
    .navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: white;
    padding: 15px 30px;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    position: fixed; /* Makes the navbar fixed at the top */
    top: 0; /* Aligns it to the top of the page */
    left: 0; /* Aligns it to the left edge */
    width: 100%; /* Ensures the navbar spans the entire width of the page */
    z-index: 1000; /* Keeps it above other content */
}

  
  .navbar-left {
    display: flex;
    align-items: center;
  }
  
  .logo {
    font-size: 28px;
    color: #ff7043;
    margin-right: 10px;
  }
  
  .title {
    font-size: 24px;
    font-weight: bold;
    color: #343a40;
    margin: 0;
  }
  
  .navbar-center {
    display: flex;
    align-items: center;
    flex: 1;
    justify-content: center;
    gap: 20px;
  }
  
  .navbar-right {
    display: flex;
    align-items: center;
    gap: 20px;
  }
  
  .nav-link {
    text-decoration: none;
    color: #495057;
    font-size: 16px;
    padding: 8px 12px;
    border-radius: 5px;
    background-color: #f1f3f5;
    transition: color 0.3s, background-color 0.3s;
  
  }
  
  .nav-link:hover {
    color: white;
    background-color:rgba(255, 112, 67,0.7);
  }
  
  .search-container {
    flex-grow: 1;
    position: relative; /* For positioning the icon inside the input */
    display: flex;
    align-items: center;
    max-width: 400px;
    margin-left: 120px;
    margin-right:20px;;
  }
  
  .search-bar1 {
    width: 100%;
    padding: 8px 12px;
    padding-right: 40px;
    font-size: 16px;
    border: 2px solid #ced4da;
    border-radius: 5px;
    transition: border-color 0.3s;
  }
  .nav-link.active {
    background-color: orange; /* Clicked background color */
    color: white; /* Clicked text color */
  }
  .search-bar1:focus {
    border-color: #ff7043;
    outline: none;
  }
  
  .profile-icon {
    font-size: 24px;
    color: #6c757d;
    cursor: pointer;
    transition: color 0.3s;
   margin-top: 0px;
   margin-right: 50px;
  }
  
  .profile-icon:hover {
    color: #ff7043;
  }
  
  /* Responsive Design */
  @media screen and (max-width: 768px) {
    .navbar {
      flex-wrap: wrap;
      text-align: center;
    }
  
    .navbar-center {
      flex-direction: column;
      gap: 10px;
    }
  
    .search-container {
      width: 100%;
      max-width: none;
      margin: 10px 0;
    }
  
    .nav-link {
      margin: 5px 0;
    }
  }
  /* Search Bar Wrapper Styling */
.search-icon1 {
  position: absolute;
  right: 10px; /* Position the icon inside the input field */
  color: #6c757d;
  font-size: 18px;
  pointer-events: none; /* Make the icon unclickable */
  transition: color 0.3s;
}

.search-bar1:focus + .search-icon1 {
  color: #ff7043; /* Change icon color on focus */
}
/* General Styles */
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
        <input type="text" class="search-bar1" placeholder="Search...">
        <i class="fas fa-search search-icon1"></i>
      </div>
    </div>
    <div class="navbar-right">
      <a href="index.aspx" class="nav-link">Home</a>
      <a href="menu.aspx" class="nav-link">Menu</a>
      <i class="fas fa-user-circle profile-icon"></i>
    </div>
  </nav>
  <div class="form-container">
        <!-- Profile Icon -->
        <div class="icon">
            <i class="fas fa-user-circle fa-5x"></i>
        </div>
        <h2>Phone Verification</h2>
        <!-- OTP Form -->
        <div id="otpForm">
            <!-- Phone Number -->
            <div class="form-group">
                <label for="txtPhone">
                    <i class="fas fa-phone"></i> Phone Number
                </label>
                <asp:TextBox ID="txtPhone" runat="server" placeholder="Enter Phone Number" required="true"></asp:TextBox>
                <asp:Button ID="btnSendOtp" runat="server" Text="Send OTP" OnClick="btnSendOtp_Click" BackColor="#FF9E3E" />
            </div>

            <!-- OTP Input -->
            <div class="form-group">
                <label for="txtOtp">
                    <i class="fas fa-key"></i> Enter OTP
                </label>
                <asp:TextBox ID="txtOtp" runat="server" placeholder="Enter the OTP" required="true"></asp:TextBox>
            </div>

            <!-- Verify Button -->
            <div class="form-group">
                <asp:Button ID="btnVerify" runat="server" Text="Verify" OnClick="btnVerify_Click" BackColor="#FF9E3E" BorderColor="Black" />
            </div>

            <!-- Resend OTP Link -->
            <p class="resend">Didn't get the OTP? <asp:LinkButton ID="lnkResendOtp" runat="server" OnClick="lnkResendOtp_Click">Resend OTP</asp:LinkButton></p>
        </div>
    </div>
    </form>
</body>
</html>
