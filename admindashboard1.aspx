<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admindashboard1.aspx.cs" Inherits="YourChef.admindashboard1" %>


<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Dashboard - Chef Booking</title>
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

        .login-container {
            width: 300px;
            margin: 100px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .login-container input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .login-container button {
            width: 100%;
            padding: 10px;
            background: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
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
        <asp:Panel ID="pnlLogin" runat="server" Visible="true">
            <div class="login-container">
                <h2>Admin Login</h2>
                <asp:TextBox ID="txtUsername" runat="server" Placeholder="Username"></asp:TextBox>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Password"></asp:TextBox>
                <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />
                <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false"></asp:Label>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlDashboard" runat="server" Visible="false">
            <div class="container">
                <!-- Sidebar -->
                <div class="sidebar">
                    <div class="logo">
                        <h2>Chef Booking</h2>
                    </div>
                    <ul id="sidebar-menu">
                        <li class="active"><span>Dashboard</span></li>
                        <li><span>Users</span></li>
                        <li><span>Bookings</span></li>
                        <li><span>Chefs</span></li>
                        <li><span>Logout</span></li>
                    </ul>
                </div>

                <!-- Main Content -->
                <div class="main-content">
                    <div class="header">
                        <h1>Welcome, Admin</h1>
                        <p>Role: Admin</p>
                    </div>

                    <div class="dashboard-grid">
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
                            <p>Pending Chefs: <asp:Label ID="lblPendingChefs" runat="server" Text="0"></asp:Label></p>
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
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