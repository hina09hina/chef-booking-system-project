<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="user_profile.aspx.cs" Inherits="YourChef.user_profile1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('https://images.unsplash.com/photo-1556911220-bff31c812dba');
            background-size: cover;
            background-position: center;
        }

        header {
            background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent black overlay */
            padding: 15px 0;
            width: 100%; /* Full width */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Subtle shadow for separation */
        }

        nav ul {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
        }

        nav ul li {
            margin: 0 15px;
        }

        nav ul li a {
            color: #fff;
            text-decoration: none;
            font-weight: bold;
        }

        @media (max-width: 600px) {
            nav ul {
                flex-direction: column;
                align-items: center;
            }

            nav ul li {
                margin: 10px 0;
            }
        }

        .container {
    width: 90%;
    max-width: 800px;
    margin: 20px auto;
    background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent white */
    padding: 20px;
    border-radius: 8px;
}

        h1, h2 {
            text-align: center;
            color: #555;
            text-shadow: 1px 1px 2px rgba(255,255,255,0.8); /* Shadow for readability */
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
            text-shadow: 1px 1px 2px rgba(255,255,255,0.8); /* Shadow for readability */
        }

        .form-control {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc; /* Uniform border */
            border-radius: 4px;
            font-size: 14px;
            background-color: #fff; /* Solid white background */
            box-shadow: 0 1px 3px rgba(0,0,0,0.1); /* Subtle shadow */
            height: 40px; /* Consistent height */
            box-sizing: border-box; /* Ensures padding doesn’t affect size */
        }

        .form-control:focus {
            border-color: #FF5733; /* Highlight on focus */
            outline: none;
        }

        .gender-toggle {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .gender-toggle label {
            margin-left: 10px;
            text-shadow: 1px 1px 2px rgba(255,255,255,0.8); /* Shadow for readability */
        }

        .btn-save {
            width: 100%;
            padding: 10px;
            background-color: #FF5733;
            border: none;
            color: #fff;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2); /* Subtle shadow */
            border-radius: 4px;
        }

        .btn-save:hover {
            background-color: #e64a19; /* Darker shade on hover */
        }

        .my-addresses {
            margin-top: 20px;
        }

        .add-address a {
            display: block;
            text-align: center;
            color: #FF5733;
            text-decoration: none;
            font-weight: bold;
            text-shadow: 1px 1px 2px rgba(255,255,255,0.8); /* Shadow for readability */
        }

        .add-address a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header>
            <nav>
                <ul>
                    <li><a href="home.aspx">Home</a></li>
                    <li><a href="book_chef.aspx">Book a Chef</a></li>
                    <li><a href="customer_dashboard.aspx">My Bookings</a></li>
                    <li><a href="profile.aspx">Profile</a></li>
                    <li><a href="logout.aspx">Logout</a></li>
                </ul>
            </nav>
        </header>
        <div class="container">
            <h1>My Profile</h1>
            <label for="txtName">NAME</label>
            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter your full name"></asp:TextBox>
            <label for="txtEmail">EMAIL</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email"></asp:TextBox>
            <label for="txtMobile">MOBILE</label>
            <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" placeholder="Enter your phone number"></asp:TextBox>
            <label for="txtDOB">DOB</label>
            <asp:TextBox ID="txtDOB" runat="server" CssClass="form-control" placeholder="yyyy/mm/dd" TextMode="Date"></asp:TextBox>
            <label>GENDER</label>
            <div class="gender-toggle">
                <asp:RadioButton ID="RadioButton1" runat="server" Text="MALE" GroupName="Gender" />
                <asp:RadioButton ID="RadioButton2" runat="server" Text="FEMALE" GroupName="Gender" />
            </div>
            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn-save" onclick="btnSave_Click1" />
            <div class="my-addresses">
                <h2>My Addresses</h2>
                <div class="add-address">
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/address.aspx">+ Add Address</asp:HyperLink>
                </div>
            </div>
        </div>
    </form>
</body>
</html>