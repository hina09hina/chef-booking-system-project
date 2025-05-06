<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="YourChef.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Responsive Navigation Bar</title>
  <link rel="stylesheet" href="CSS/styles.css"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
  <!-- Link Swiper's CSS -->
  <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
</head>
<body>
    <form id="form1" runat="server">
  <nav class="navbar">
    <div class="navbar-left">
      <i class="fas fa-utensils logo"></i>
      <h1 class="title">Your Chef</h1>
    </div>
    <div class="navbar-center">
      <asp:LinkButton ID="btnBookNow" runat="server" CssClass="nav-link" OnClick="btnBookNow_Click">
    Book Now
</asp:LinkButton>

<asp:LinkButton ID="btnRegisterPartner" runat="server" CssClass="nav-link" OnClick="btnRegisterPartner_Click">
    Register as Partner
</asp:LinkButton>
              <asp:LinkButton ID="LinkButton1" runat="server" CssClass="nav-link" OnClick="btnBookNow_Click">
    Chef Profile
</asp:LinkButton>
              <asp:LinkButton ID="LinkButton2" runat="server" CssClass="nav-link" OnClick="LinkButton2_Click" >
    Chef dashboard
</asp:LinkButton>

      <div class="search-container">
        <input type="text" class="search-bar" placeholder="Search..."/>
        <i class="fas fa-search search-icon"></i>
      </div>
    </div>
    <div class="navbar-right">
      <asp:Button ID="btnSignUp" runat="server" Text="Sign Up" CssClass="nav-link" OnClick="btnSignUp_Click" />
      <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="nav-link" OnClick="btnLogin_Click" />
      <asp:Button ID="Button1" runat="server" Text="Logout" CssClass="nav-link" OnClick="Button1_Click" />
      <a href="user_profile.aspx"  class="fas fa-user-circle profile-icon"></a>
    
    </div>
  </nav>
  <!--home page animation-->
  <!-- slider section start -->
  <div class="home" id="home">
    <div class="swiper home-slider">
      <div class="swiper-wrapper">
        <div class="swiper-slide slide slide1">
          <div class="content">
            <img src="img/crown-symbol.png" alt="Crown"/>
            <h3>delicious royal taste</h3>
            <h1>gift voucher</h1>
            <p>give away your beloved customers</p>
            <a href="#" class="btn">Book Now</a>
          </div>
        </div>
        <div class="swiper-slide slide slide2">
          <div class="content">
            <img src="img/crown-symbol.png" alt="Crown">
            <h3>sale of 10% this dish</h3>
            <h1>the fresh</h1>
            <a href="#" class="btn">Book Now</a>
          </div>
        </div>
        <div class="swiper-slide slide slide3">
          <div class="content">
            <img src="img/crown-symbol.png" alt="Crown">
            <h3>we are open</h3>
            <h1>fresh fruits</h1>
            <p>you will love it</p>
            <a href="#" class="btn">Book Now</a>
          </div>
        </div>
      </div>
      <div class="swiper-pagination"></div>
    </div>
  </div>
  <!--foooter-->
  <div class="sec6">
    <div>
        <i class="fas fa-utensils logo1"></i>
        <p>Delight in every bite with Your Chef.</p>
    </div>
     <div>
         <ul>
             <li>Main Menu</li>
             <li><a href="index.html"></a>Home</li>
             <li><a href="menu.html">Menu</a></li>
             <li><a href="#">Events</a></li>
             <li><a href="#">Offers</a></li>
             <li><a href="cheffbookk.aspx">Book Now</a></li>
             <li><a href="signup.html">Sign Up</a></li>
            
         </ul>
     </div>
     <div>
 <ul>
     <li>Information</li>
     <li><a href="#"></a>Contect Us</li>
     <li><a href="#">About Us</a></li>
     <li><a href="ShowChefProfile.aspx">Top Raited Chef</a></li>
     <li><a href="gallery.aspx">Gallery</a></li>
     <li><a href="#">Register As Partner</a></li>
 </ul>
</div>
     <div>
 <ul>
     <li>Address</li>
     <p>New Delhi,India</p>
     <p>9:00pm - 11:00pm</p>
 </ul>
</div>
 </div>
 <div class="footer">
     <p>copyright @copy;2024 Your Chef |all rights reserved</p>
 </div>
	<!-- slider section ends -->
  <script src="JS/script.js"></script>
  <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

    <!-- Initialize Swiper -->
    <script>
      var swiper = new Swiper(".home-slider", {
  spaceBetween: 30,
  centeredSlides: true,
  autoplay: {
    delay: 7500,
    disableOnInteraction: false,
  },
  pagination: {
    el: ".swiper-pagination",
    clickable: true,
  },
  loop: true,
});

    </script>
    <script type="text/javascript">
		let menu = document.querySelector('#menu');
		let navbar = document.querySelector('.navbar');

		menu.onclick = () =>{
			menu.classList.toggle('fa-times');
			navbar.classList.toggle('active');
		}
    </script>
	
    </form>
</body>
</html>
