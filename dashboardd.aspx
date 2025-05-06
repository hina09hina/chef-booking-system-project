<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="dashboardd.aspx.cs" Inherits="YourChef.dashboardd" %>



<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Chef Booking Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            overflow-x: hidden;
        }

        .container {
            display: flex;
            width: 100%;
        }

        .sidebar {
            width: 250px;
            background: #2c3e50;
            height: 100vh;
            position: fixed;
            color: white;
            transition: all 0.3s;
        }

        .sidebar .logo {
            padding: 20px;
            text-align: center;
            background: #1a252f;
        }

        .sidebar ul {
            list-style: none;
            padding: 20px 0;
        }

        .sidebar ul li {
            padding: 15px 20px;
            cursor: pointer;
            transition: background 0.3s;
        }

        .sidebar ul li:hover {
            background: #34495e;
        }

        .sidebar ul li.active {
            background: #3498db;
        }

        .main-content {
            margin-left: 250px;
            width: calc(100% - 250px);
            padding: 20px;
        }

        .header {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }

        .card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .card h3 {
            margin-bottom: 15px;
            color: #2c3e50;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 80px;
            }

            .sidebar ul li span {
                display: none;
            }

            .main-content {
                margin-left: 80px;
                width: calc(100% - 80px);
            }
        }

        @media (max-width: 480px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }

            .main-content {
                margin-left: 0;
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <!-- Sidebar -->
            <div class="sidebar">
                <div class="logo">
                    <h2>Chef Booking</h2>
                </div>
                <ul id="sidebar-menu">
                    <li class="active"><span>Dashboard</span></li>
                    <li><span>Profile</span></li>
                    <li><span>Bookings</span></li>
                    <asp:PlaceHolder ID="ChefMenu" runat="server" Visible="false">
                        <li><span>Chefs</span></li>
                    </asp:PlaceHolder>
                    <li><span>Settings</span></li>
                    <li><span>Logout</span></li>
                </ul>
            </div>

            <!-- Main Content -->
            <div class="main-content">
                <div class="header">
                    <h1>Welcome, <asp:Label ID="lblFullName" runat="server" Text="[Full Name]"></asp:Label></h1>
                    <p>Role: <asp:Label ID="lblRole" runat="server" Text="[Role]"></asp:Label></p>
                </div>

                <div class="dashboard-grid">
                    <asp:PlaceHolder ID="CustomerDashboard" runat="server" Visible="false">
                        <div class="card">
                            <h3>Your Bookings</h3>
                            <p>You have <asp:Label ID="lblCustomerBookings" runat="server" Text="0"></asp:Label> bookings.</p>
                            <asp:Repeater ID="rptCustomerBookings" runat="server">
                                <ItemTemplate>
                                    <li><%# Eval("EventDate", "{0:MM/dd/yyyy}") %> - <%# Eval("CuisineType") %></li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <div class="card">
                            <h3>Find Chefs</h3>
                            <p>Browse available chefs in your area.</p>
                        </div>
                    </asp:PlaceHolder>

                    <asp:PlaceHolder ID="ChefDashboard" runat="server" Visible="false">
                        <div class="card">
                            <h3>Upcoming Gigs</h3>
                            <p>You have <asp:Label ID="lblChefBookings" runat="server" Text="0"></asp:Label> upcoming bookings.</p>
                            <asp:Repeater ID="rptChefBookings" runat="server">
                                <ItemTemplate>
                                    <li><%# Eval("EventDate", "{0:MM/dd/yyyy}") %> - <%# Eval("Location") %></li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <div class="card">
                            <h3>Profile Stats</h3>
                            <p>Average Rating: <asp:Label ID="lblAverageRating" runat="server" Text="0"></asp:Label></p>
                        </div>
                    </asp:PlaceHolder>

                    <asp:PlaceHolder ID="AdminDashboard" runat="server" Visible="false">
                        <div class="card">
                            <h3>User Management</h3>
                            <p>Total Users: <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label></p>
                        </div>
                        <div class="card">
                            <h3>Booking Overview</h3>
                            <p>Total Bookings: <asp:Label ID="lblTotalBookings" runat="server" Text="0"></asp:Label></p>
                        </div>
                        <div class="card">
                            <h3>Chef Verification</h3>
                            <p>Pending verifications: <asp:Label ID="lblPendingChefs" runat="server" Text="0"></asp:Label></p>
                        </div>
                    </asp:PlaceHolder>
                </div>
            </div>
        </div>
    </form>

    <script>
        const menuItems = document.querySelectorAll('.sidebar ul li');
        menuItems.forEach(item => {
            item.addEventListener('click', () => {
                menuItems.forEach(i => i.classList.remove('active'));
                item.classList.add('active');
            });
        });
    </script>
</body>
</html>