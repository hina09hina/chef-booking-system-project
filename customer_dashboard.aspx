<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="customer_dashboard.aspx.cs" Inherits="YourChef.customer_dashboard" %>


<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Customer Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        .header {
            background-color: #4a4de6;
            color: white;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .header h1 {
            margin: 0;
            font-size: 24px;
        }
        .header p {
            margin: 5px 0 0;
            font-size: 14px;
        }
        .section {
            margin-bottom: 30px;
        }
        .section h2 {
            font-size: 20px;
            color: #333;
            margin-bottom: 10px;
        }
        .grid {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .card {
            background-color: white;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 300px;
            transition: transform 0.2s;
        }
        .card:hover {
            transform: scale(1.03);
        }
        .card h3 {
            margin: 0 0 10px;
            font-size: 16px;
            color: #333;
        }
        .card p {
            margin: 5px 0;
            font-size: 14px;
            color: #666;
        }
        .status {
            display: inline-block;
            padding: 5px 10px;
            color: white;
            font-size: 12px;
            border-radius: 10px;
        }
        .status-pending { background-color: #e67e22; }
        .status-confirmed { background-color: #27ae60; }
        .status-canceled { background-color: #c0392b; }
        .status-completed { background-color: #7f8c8d; }
        .no-data {
            color: #777;
            font-size: 14px;
        }

        /* Responsive Design */
        @media (min-width: 600px) {
            .card { width: calc(50% - 20px); }
        }
        @media (min-width: 900px) {
            .card { width: calc(33.33% - 20px); }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <!-- Header -->
            <header class="header">
                <h1>Welcome, <asp:Label ID="lblFullName" runat="server" Text="User"></asp:Label></h1>
                <p><asp:Label ID="lblContact" runat="server" Text="Email | Phone"></asp:Label></p>
            </header>

            <!-- Current Bookings -->
            <section class="section">
                <h2>Current Bookings</h2>
                <div class="grid">
                    <asp:Repeater ID="rptCurrentBookings" runat="server">
                        <ItemTemplate>
                            <div class="card">
                                <h3>Chef: <%# Eval("ChefName") %></h3>
                                <p><strong>Date:</strong> <%# Eval("EventDateTime", "{0:MM/dd/yyyy HH:mm}") %></p>
                                <p><strong>Location:</strong> <%# Eval("Location") %></p>
                                <p><strong>People:</strong> <%# Eval("NumberOfPeople") %></p>
                                <span class="status status-<%# Eval("Status").ToString().ToLower() %>"><%# Eval("Status") %></span>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                            <%# (rptCurrentBookings.Items.Count == 0) ? "<p class='no-data'>No current bookings found.</p>" : "" %>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </section>

            <!-- Past Bookings -->
            <section class="section">
                <h2>Past Bookings</h2>
                <div class="grid">
                    <asp:Repeater ID="rptPastBookings" runat="server">
                        <ItemTemplate>
                            <div class="card">
                                <h3>Chef: <%# Eval("ChefName") %></h3>
                                <p><strong>Date:</strong> <%# Eval("EventDateTime", "{0:MM/dd/yyyy HH:mm}") %></p>
                                <p><strong>Location:</strong> <%# Eval("Location") %></p>
                                <p><strong>People:</strong> <%# Eval("NumberOfPeople") %></p>
                                <span class="status status-<%# Eval("Status").ToString().ToLower() %>"><%# Eval("Status") %></span>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                            <%# (rptPastBookings.Items.Count == 0) ? "<p class='no-data'>No past bookings found.</p>" : "" %>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </section>
        </div>
    </form>
</body>
</html>