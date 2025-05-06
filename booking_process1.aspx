<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="booking_process1.aspx.cs" Inherits="YourChef.user_profile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <meta name="viewport" content="width=device-width, initial-scale=1" />
 <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" />
 <style>
     .container {
         margin-top: 20px;
     }
     .btn-group-toggle .btn {
         margin-right: 5px;
     }
 </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1><center>Book a Chef</center></h1>
            <div class="container">
        <div class="form-group">
            <label for="ddlOccasion">Select Occasion</label>
            <asp:DropDownList ID="ddlOccasion" runat="server" CssClass="form-control">
                <asp:ListItem>Birthday Party</asp:ListItem>
                <asp:ListItem>Wedding</asp:ListItem>
                <asp:ListItem>Anniversary</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="form-group">
            <label for="txtDate">Select Dates</label>
            <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" placeholder="3 Jan, Fri"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Select Meals</label>
            <div class="btn-group btn-group-toggle" data-toggle="buttons">
                <label class="btn btn-outline-secondary">
                    <input type="radio" name="meals" id="breakfast" autocomplete="off"> Breakfast
                </label>
                <label class="btn btn-outline-secondary active">
                    <input type="radio" name="meals" id="lunch" autocomplete="off" checked> Lunch
                </label>
                <label class="btn btn-outline-secondary">
                    <input type="radio" name="meals" id="eveningSnacks" autocomplete="off"> Evening Snacks
                </label>
                <label class="btn btn-outline-secondary">
                    <input type="radio" name="meals" id="dinner" autocomplete="off"> Dinner
                </label>
            </div>
        </div>
        <div class="form-group">
            <label>Lunch Serving Time</label>
            <div class="btn-group btn-group-toggle" data-toggle="buttons">
                <label class="btn btn-outline-secondary">
                    <input type="radio" name="lunchTime" id="10am" autocomplete="off"> 10 am onwards
                </label>
                <label class="btn btn-outline-secondary">
                    <input type="radio" name="lunchTime" id="11am" autocomplete="off"> 11 am onwards
                </label>
                <label class="btn btn-outline-secondary">
                    <input type="radio" name="lunchTime" id="12pm" autocomplete="off"> 12 pm onwards
                </label>
                <label class="btn btn-outline-secondary">
                    <input type="radio" name="lunchTime" id="1pm" autocomplete="off"> 1 pm onwards
                </label>
                <label class="btn btn-outline-secondary">
                    <input type="radio" name="lunchTime" id="2pm" autocomplete="off"> 2 pm onwards
                </label>
                <label class="btn btn-outline-secondary">
                    <input type="radio" name="lunchTime" id="3pm" autocomplete="off"> 3 pm onwards
                </label>
                <label class="btn btn-outline-secondary">
                    <input type="radio" name="lunchTime" id="4pm" autocomplete="off"> 4 pm onwards
                </label>
            </div>
        </div>
        <div class="form-group">
            <label>No. of Gas Burners in your kitchen</label>
            <div class="btn-group btn-group-toggle" data-toggle="buttons">
                <label class="btn btn-outline-secondary">
                    <input type="radio" name="burners" id="1burner" autocomplete="off"> 1
                </label>
                <label class="btn btn-outline-secondary">
                    <input type="radio" name="burners" id="2burner" autocomplete="off"> 2
                </label>
                <label class="btn btn-outline-secondary">
                    <input type="radio" name="burners" id="3burner" autocomplete="off"> 3
                </label>
                <label class="btn btn-outline-secondary">
                    <input type="radio" name="burners" id="4burner" autocomplete="off"> 4
                </label>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
        