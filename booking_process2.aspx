<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="booking_process2.aspx.cs" Inherits="YourChef.booking_process2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
 <title>Chef Booking Page</title>
  <style>
     
      .container {
          background-color: #fff;
          padding: 20px;
          border-radius: 10px;
          box-shadow: 0 4px 8px rgba(0,0,0,0.1);
         align-content:center;
         align-items:center;
          margin:0;
          width:140%;
         

      }

      label {
          font-weight: bold;
          margin-top: 15px;
          display: block;
      }

      .select-field {
          width: 100%;
          padding: 10px;
          margin-top: 5px;
          border: 1px solid #ccc;
          border-radius: 5px;
      }

      button {
          background-color: #4CAF50;
          color: white;
          padding: 10px 20px;
          border: none;
          border-radius: 5px;
          cursor: pointer;
          margin-top: 20px;
          display: block;
          width: 100%;
      }

      button:hover {
          background-color: #45a049;
      }
      button, .btn-calculate {
            margin-top: 15px;
            padding: 10px;
            background: orange;
            color: black;
            border: none;
            cursor: pointer;
            width: 100%;
            border-radius: 5px;
            font-size: 16px;
        }
        button:hover, .btn-calculate:hover {
            background: #218838;
        }
        .total-price {
            margin-top: 15px;
            font-size: 18px;
            font-weight: bold;
            color: #d9534f;
            text-align: center;
        }
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
  </style></head>
<body>
    <form id="form1" runat="server">
      <div class="container">
        <h1 style="text-align: center">Book Your Menu</h1>
           <label>No. of People for Dinner:</label>
            <asp:DropDownList ID="ddlPeople" runat="server" CssClass="select-field">
                <asp:ListItem Value="1">1</asp:ListItem>
                <asp:ListItem Value="2">2</asp:ListItem>
                <asp:ListItem Value="3">3</asp:ListItem>
                <asp:ListItem Value="4">4</asp:ListItem>
            </asp:DropDownList>
        <label for="cuisines">Select Cuisines:</label>
        <asp:DropDownList ID="ddlCuisines" runat="server" CssClass="select-field">
            <asp:ListItem Text="Select Cuisine" Value="" />
            <asp:ListItem Text="North Indian - ₹500" Value="North Indian" />
            <asp:ListItem Text="Chinese - ₹400" Value="Chinese" />
            <asp:ListItem Text="Italian & American - ₹600" Value="Italian & American" />
            <asp:ListItem Text="South Indian - ₹450" Value="South Indian" />
            <asp:ListItem Text="Thai & Mexican - ₹550" Value="Thai & Mexican" />
        </asp:DropDownList>

        <label for="appetizers">Appetizers (Optional):</label>
        <asp:DropDownList ID="ddlAppetizers" runat="server" CssClass="select-field">
            <asp:ListItem Text="Select Appetizer" Value="" />
            <asp:ListItem Text="Spring Rolls - ₹100" Value="Spring Rolls" />
            <asp:ListItem Text="Garlic Bread - ₹120" Value="Garlic Bread" />
            <asp:ListItem Text="Bruschetta - ₹180" Value="Bruschetta" />
            <asp:ListItem Text="Samosa - ₹100" Value="Samosa" />
            <asp:ListItem Text="Stuffed Mushrooms - ₹200" Value="Stuffed Mushrooms" />
        </asp:DropDownList>

        <label for="mainCourse">Main Course:</label>
        <asp:DropDownList ID="ddlMainCourse" runat="server" CssClass="select-field">
            <asp:ListItem Text="Select Main Course" Value="" />
            <asp:ListItem Text="Butter Chicken - ₹300" Value="Butter Chicken" />
            <asp:ListItem Text="Vegetable Biryani - ₹250" Value="Vegetable Biryani" />
            <asp:ListItem Text="Pasta Alfredo - ₹350" Value="Pasta Alfredo" />
            <asp:ListItem Text="Grilled Salmon - ₹400" Value="Grilled Salmon" />
            <asp:ListItem Text="Paneer Tikka - ₹280" Value="Paneer Tikka" />
        </asp:DropDownList>

        <label for="breadsRice">Breads & Rice (Optional):</label>
        <asp:DropDownList ID="ddlBreadsRice" runat="server" CssClass="select-field">
            <asp:ListItem Text="Select Bread or Rice" Value="" />
            <asp:ListItem Text="Naan - ₹50" Value="Naan" />
            <asp:ListItem Text="Steamed Rice - ₹60" Value="Steamed Rice" />
            <asp:ListItem Text="Garlic Naan - ₹70" Value="Garlic Naan" />
            <asp:ListItem Text="Jeera Rice - ₹80" Value="Jeera Rice" />
            <asp:ListItem Text="Chapati - ₹40" Value="Chapati" />
        </asp:DropDownList>

        <label for="desserts">Desserts (Optional):</label>
        <asp:DropDownList ID="ddlDesserts" runat="server" CssClass="select-field">
            <asp:ListItem Text="Select Dessert" Value="" />
            <asp:ListItem Text="Gulab Jamun - ₹100" Value="Gulab Jamun" />
            <asp:ListItem Text="Ice Cream - ₹120" Value="Ice Cream" />
            <asp:ListItem Text="Tiramisu - ₹150" Value="Tiramisu" />
            <asp:ListItem Text="Cheesecake - ₹180" Value="Cheesecake" />
            <asp:ListItem Text="Brownie - ₹140" Value="Brownie" />
        </asp:DropDownList>

        <label for="soupsBeverages">Soups & Beverages (Optional):</label>
        <asp:DropDownList ID="ddlSoupsBeverages" runat="server" CssClass="select-field">
            <asp:ListItem Text="Select Soup or Beverage" Value="" />
            <asp:ListItem Text="Tomato Soup - ₹90" Value="Tomato Soup" />
            <asp:ListItem Text="Lemonade - ₹80" Value="Lemonade" />
            <asp:ListItem Text="Mint Mojito - ₹110" Value="Mint Mojito" />
            <asp:ListItem Text="Green Tea - ₹70" Value="Green Tea" />
            <asp:ListItem Text="Hot Chocolate - ₹130" Value="Hot Chocolate" />
        </asp:DropDownList>

           <asp:Button ID="btnCalculate" runat="server" CssClass="btn-calculate" Text="Calculate Total" OnClick="btnCalculate_Click" />
            <br />
            <label class="total-price">Total Price:</label>
            <asp:Label ID="lblTotalPrice" runat="server" CssClass="total-price" Text="0"></asp:Label>

        <button type="submit">Submit</button>
    </div>

     </form>
</body>
</html>

