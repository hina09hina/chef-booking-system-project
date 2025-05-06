<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="chef_profile.aspx.cs" Inherits="YourChef.chef_profile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chef Profile Detail</title>
    <style>
        :root {
            --primary-color: rgb(255, 112, 67); /* Orange for header and button */
            --background-color: #f3e5f5; /* Light background */
            --text-color: #4a4a4a; /* Neutral text */
            --stat-highlight-color: #43a047; /* Green for ratings */
        }

        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--background-color);
            color: var(--text-color);
        }

        header {
        
            color: white;
            padding: 20px;
            text-align: center;
            font-size: 26px;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .profile-container {
            max-width: 1200px;
            margin: 30px auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
            overflow: hidden;
        }

        .profile-header {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            padding: 20px;
            background-color:#fff;
            color: rgb(0, 0, 0);
        }

        .profile-header img {
            border-radius: 50%;
            width: 120px;
            height: 120px;
            object-fit: cover;
            margin-right: 20px;
        }

        .profile-header .details {
            flex: 1;
        }

        .profile-header .details h1 {
            margin: 0;
            font-size: 28px;
            font-weight: bold;
        }

        .profile-header .details .info {
            margin: 10px 0;
            font-size: 16px;
        }

        .profile-header .details .info span {
            display: inline-block;
            margin-right: 15px;
            font-weight: bold;
        }

        .profile-header .details p {
            font-size: 14px;
        }

        .stats {
            display: flex;
            justify-content: space-between;
            background: #ede7f6;
            padding: 20px;
            gap: 15px;
            text-align: center;
        }

        .stat {
            flex: 1;
            border: 1px solid #d1c4e9;
            border-radius: 8px;
            padding: 15px;
            background: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .stat h3 {
            margin: 0;
            font-size: 24px;
            color: var(--stat-highlight-color); /* Green for ratings */
        }

        .stat p {
            margin: 5px 0 0;
            font-size: 14px;
            color: var(--text-color);
        }

        .section {
            padding: 20px;
            border-top: 1px solid #eee;
        }

        .section h2 {
            margin-top: 0;
            font-size: 22px;
            color: var(--text-color);
        }

        .section ul {
            list-style: none;
            padding: 0;
        }

        .section ul li {
            margin: 10px 0;
            font-size: 16px;
        }

        .section ul li::before {
            content: '\2713'; /* Checkmark */
            color: var(--stat-highlight-color);
            margin-right: 10px;
        }

        .cta {
            text-align: center;
            padding: 20px;
        }

        .cta button {
            padding: 10px 20px;
            background-color: var(--primary-color); /* Orange button */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .cta button:hover {
            background-color: #e64a19; /* Darker orange on hover */
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
       
    <div class="profile-container">
        <div class="profile-header">
            <img src="img/c1.jpg" alt="Chef Bharat">
            <div class="details">
                <h1>Bharat</h1>
                <div class="info">
                    <span>Chef</span>
                    <span>&#x2714; Verified</span>
                    <span>Pro</span>
                </div>
                <p>Expert in South Indian, Italian, North Indian, Chinese, Continental, Barbecue, Beverages, Desserts, Salads, Snacks, Thai, Soups, Authentic South Indian, Mexican, and more.</p>
            </div>
        </div>

        <div class="stats">
            <div class="stat">
                <h3>15+</h3>
                <p>Years of Experience</p>
            </div>
            <div class="stat">
                <h3>4.7</h3>
                <p>Average Rating</p>
            </div>
            <div class="stat">
                <h3>1000+</h3>
                <p>Bookings Completed</p>
            </div>
            <div class="stat">
                <h3>13</h3>
                <p>Followers</p>
            </div>
        </div>

        <div class="section">
            <h2>Personal Information</h2>
            <ul>
                <li>Currently living in Delhi, Delhi</li>
                <li>Can cook Vegetarian & Non-Vegetarian dishes</li>
                <li>Speaks English</li>
                <li>Qualification: 10th Pass</li>
                <li>Marital Status: Married</li>
            </ul>
        </div>

        <div class="section">
            <h2>Work Experience</h2>
            <ul>
                <li>Worked at Khana Khazana (Restaurant), Tughlakabad Extension, Delhi for 1 year</li>
                <li>Worked at Sagar Ratna (Restaurant), Sector 37, Faridabad for 3 years</li>
                <li>Worked at Max Saket Hospital (Hospital Kitchen), Saket, Delhi for 2 years</li>
            </ul>
        </div>

        <div class="cta">
            <button>Call to Book</button>
        </div>
    </div>

    </form>
</body>
</html>
