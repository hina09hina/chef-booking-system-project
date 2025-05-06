<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="rated_chefs.aspx.cs" Inherits="YourChef.rated_chefs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Top Rated Chefs</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fff;
        }

        header {
            text-align: center;
            padding: 20px;
            font-size: 24px;
            font-weight: bold;
            color: rgb(48, 46, 45);
        }
        h1{
            text-align: center;
            padding: 20px;
            font-size: 18px;
           
            color: rgb(66, 63, 62);
        }
        .content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .filter {
            text-align: right;
            margin-bottom: 20px;
        }

        select {
            padding: 8px;
            font-size: 16px;
            border: 1px solid rgb(255,112,67);
            border-radius: 4px;
        }

        .chef-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .chef-card {
            border: 1px solid rgba(97, 91, 91, 0.166);
            border-radius: 8px;
            padding: 15px;
            text-align: center;
            background-color: #fff;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        .chef-card img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 10px;
        }

        .chef-card .name {
            font-size: 18px;
            font-weight: bold;
            margin: 5px 0;
            line-height: 1.5;
        }

        .chef-card .name a {
            text-decoration: none;
            color: rgb(255,112,67);
        }

        .chef-card .name a:hover {
            text-decoration: underline;
        }

        .chef-card .details {
            font-size: 14px;
            color: #555;
            margin: 5px 0;
            line-height: 1.5;
        }

        .chef-card .rating {
            font-size: 16px;
            font-weight: bold;
            color: green;
        }

        .view-more {
            text-align: center;
            margin-top: 20px;
        }

        .view-more button {
            padding: 10px 20px;
            font-size: 16px;
            background-color: rgb(255,112,67);
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .view-more button:hover {
            background-color: rgb(230,100,60);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <header>Top Rated Chefs</header>
    <h1>All our cooks and chefs are trained and verified professionals from top restaurants and hotels.</h1>
    <div class="content">
        <div class="filter">
            <label for="city-select">Select City:</label>
            <select id="city-select">
                <option value="all">All Cities</option>
                <option value="delhi">Delhi</option>
                <option value="noida">Noida</option>
                <option value="gurugram">Gurugram</option>
                <option value="faridabad">Faridabad</option>
                <option value="ghaziabad">Ghaziabad</option>
                <option value="greater-noida">Greater Noida</option>
            </select>
        </div>
        <div class="chef-cards">
            <div class="chef-card">
                <img src="img/c1.jpg" alt="Chef Bharat">
                <div class="name"><a href="chef-bharat-profile.html">Bharat</a></div>
                <div class="details">Multi Cuisine Chef<br>15 Years of Experience</div>
                <div class="rating">4.7</div>
            </div>
            <div class="chef-card">
                <img src="img/c4.jpg" alt="Chef Bhupendra">
                <div class="name"><a href="chef-bhupendra-profile.html">Bhupendra</a></div>
                <div class="details">Multi Cuisine Chef<br>11 Years of Experience</div>
                <div class="rating">4.7</div>
            </div>
            <div class="chef-card">
                <img src="img/c5.jpg" alt="Chef Ganesh">
                <div class="name"><a href="chef-ganesh-profile.html">Ganesh</a></div>
                <div class="details">Multi Cuisine Chef<br>18 Years of Experience</div>
                <div class="rating">5.0</div>
            </div>
        </div>
        <div class="chef-cards">
            <div class="chef-card">
                <img src="img/c1.jpg" alt="Chef Bharat">
                <div class="name"><a href="chef-bharat-profile.html">Bharat</a></div>
                <div class="details">Multi Cuisine Chef<br>15 Years of Experience</div>
                <div class="rating">4.7</div>
            </div>
            <div class="chef-card">
                <img src="img/c4.jpg" alt="Chef Bhupendra">
                <div class="name"><a href="chef-bhupendra-profile.html">Bhupendra</a></div>
                <div class="details">North Indian Chef<br>11 Years of Experience</div>
                <div class="rating">4.7</div>
            </div>
            <div class="chef-card">
                <img src="img/c5.jpg" alt="Chef Ganesh">
                <div class="name"><a href="chef-ganesh-profile.html">Ganesh</a></div>
                <div class="details">South Indian Chef<br>18 Years of Experience</div>
                <div class="rating">5.0</div>
            </div>
        </div>
        <div class="chef-cards">
            <div class="chef-card">
                <img src="img/c1.jpg" alt="Chef Bharat">
                <div class="name"><a href="chef-bharat-profile.html">Bharat</a></div>
                <div class="details">Multi Cuisine Chef<br>15 Years of Experience</div>
                <div class="rating">4.7</div>
            </div>
            <div class="chef-card">
                <img src="img/c4.jpg" alt="Chef Bhupendra">
                <div class="name"><a href="chef-bhupendra-profile.html">Bhupendra</a></div>
                <div class="details">Multi Cuisine Chef<br>11 Years of Experience</div>
                <div class="rating">4.7</div>
            </div>
            <div class="chef-card">
                <img src="img/c5.jpg" alt="Chef Ganesh">
                <div class="name"><a href="chef-ganesh-profile.html">Ganesh</a></div>
                <div class="details">Multi Cuisine Chef<br>18 Years of Experience</div>
                <div class="rating">5.0</div>
            </div>
        </div>
        <div class="chef-cards">
            <div class="chef-card">
                <img src="img/c1.jpg" alt="Chef Bharat">
                <div class="name"><a href="chef-bharat-profile.html">Bharat</a></div>
                <div class="details">Multi Cuisine Chef<br>15 Years of Experience</div>
                <div class="rating">4.7</div>
            </div>
            <div class="chef-card">
                <img src="img/c4.jpg" alt="Chef Bhupendra">
                <div class="name"><a href="chef-bhupendra-profile.html">Bhupendra</a></div>
                <div class="details">Multi Cuisine Chef<br>11 Years of Experience</div>
                <div class="rating">4.7</div>
            </div>
            <div class="chef-card">
                <img src="img/c5.jpg" alt="Chef Ganesh">
                <div class="name"><a href="chef-ganesh-profile.html">Ganesh</a></div>
                <div class="details">Multi Cuisine Chef<br>18 Years of Experience</div>
                <div class="rating">5.0</div>
            </div>
        </div>
        <div class="view-more">
            <button>View More Profiles</button>
        </div>
    </div>

    </form>
</body>
</html>
