<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="address.aspx.cs" Inherits="YourChef.address" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <style>
    body {
    margin: 0;
    font-family: Arial, sans-serif;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    overflow: hidden;
    position: relative;
    background-image: linear-gradient(rgba(255, 255, 255, 0.3), rgba(255, 255, 255, 0.3)),
    url("img/back1.png");
  background-size: cover;
  opacity: 0.8;
  background-repeat: no-repeat;
  background-position: center;
}

/* Background Image */
.background-image {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: url('https://via.placeholder.com/1920x1080') no-repeat center center/cover;
    opacity: 0.5;
    z-index: -1;
}

     .container {
         width: 90%;
         max-width: 600px;
         margin: 20px auto;
         background-color: #fff;
         padding: 20px;
         border-radius: 8px;
         box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
     }

     h1 {
         text-align: center;
         font-size: 24px;
         color: #555;
         margin-bottom: 20px;
     }

     label {
         display: block;
         margin-bottom: 5px;
         font-weight: bold;
         color: #333;
     }

     input[type="text"],
     textarea,
     select,
     button {
         width: 100%;
         padding: 10px;
         margin-bottom: 15px;
         border: 1px solid #ccc;
         border-radius: 4px;
         font-size: 14px;
     }

     textarea {
         resize: none;
     }

     .btn {
         background-color: #ffcc00;
         border: none;
         color: #fff;
         font-weight: bold;
         cursor: pointer;
         padding: 12px;
         font-size: 16px;
         border-radius: 4px;
         transition: background-color 0.3s ease;
     }

     .btn:hover {
         background-color: #e6b800;
     }

     .address-type {
         display: flex;
         gap: 10px;
         margin-bottom: 15px;
     }

     .address-type button {
         flex: 1;
         background-color: #f2f2f2;
         border: 1px solid #ccc;
         padding: 10px;
         font-size: 14px;
         cursor: pointer;
         border-radius: 4px;
         align-content:center;
         justify-content:center;
     }

     .address-type button.active {
         background-color: #ffcc00;
         color: #fff;
         border-color: #e6b800;
     }

     .address-type button:hover {
         background-color: #e6b800;
         color: #fff;
     }
 </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
     <h1>Add Address</h1>

     <label for="txtFullName">Full Name <small>(whom should partner meet at this address?)</small></label>
     <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"></asp:TextBox>
      
     <label for="txtHouseNo">House No. / Flat No. / Floor / Apartment / Building Name</label>
     <asp:TextBox ID="txtHouseNo" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
           

     <label for="txtStreet">Street / Area / Sector</label>
     <asp:TextBox ID="txtStreet" runat="server" CssClass="form-control"></asp:TextBox>

            <label for="ddlCity">Country</label>
<asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-control" AutoPostBack="true">
</asp:DropDownList>

<label for="ddlCity">State</label>
<asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control" AutoPostBack="True">
</asp:DropDownList>
                 <label for="ddlCity">City</label>
    <asp:DropDownList ID="ddlCity" runat="server" CssClass="form-control">
</asp:DropDownList>



             <label for="pincode">Pin Code:</label>
            <asp:TextBox ID="txtPinCode" runat="server" CssClass="form-control" placeholder="Enter Pin Code"></asp:TextBox>

     <label for="txtLocation">Location/Full Address <small>(partner will arrive here)</small></label>
     <asp:TextBox ID="txtLocation" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>

     <asp:Button ID="btnAddAddress" runat="server" Text="Add Address" CssClass="btn" OnClick="AddAddress_Click" />
 </div>
    </form>
</body>
</html>
