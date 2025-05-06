<!-- Dashboard.aspx -->
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="YourChef.Dashboard" %>

<!DOCTYPE html>
<html runat="server">
<head>
    <title>Admin Dashboard - Chef Booking System</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            background: #f4f7fa;
            color: #2d3748;
            line-height: 1.6;
        }

        .container {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 260px;
            background: linear-gradient(180deg, #2b6cb0, #2c5282);
            color: white;
            position: fixed;
            height: 100vh;
            padding: 20px;
            transition: all 0.3s;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        }

        .sidebar .profile {
            text-align: center;
            padding: 20px 0;
            border-bottom: 1px solid rgba(255,255,255,0.2);
        }

        .sidebar .profile img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            border: 3px solid white;
            margin-bottom: 10px;
        }

        .sidebar ul {
            list-style: none;
            margin-top: 20px;
        }

        .sidebar ul li a {
            color: white;
            text-decoration: none;
            padding: 12px 15px;
            display: flex;
            align-items: center;
            border-radius: 8px;
            margin: 5px 0;
            transition: all 0.3s;
        }

        .sidebar ul li a:hover {
            background: rgba(255,255,255,0.1);
            transform: translateX(5px);
        }

        .sidebar ul li a i {
            margin-right: 10px;
            width: 20px;
        }

        .main-content {
            margin-left: 260px;
            padding: 30px;
            width: calc(100% - 260px);
            background: #f4f7fa;
        }

        .header {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            margin-bottom: 25px;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
        }

        .card {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            transition: transform 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card i {
            font-size: 24px;
            margin-bottom: 10px;
            color: #2b6cb0;
        }

        .search-container {
            margin: 25px 0;
            display: flex;
            gap: 10px;
        }

        .search-container input, .search-container select {
            padding: 12px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            width: 200px;
        }

        .search-container button {
            padding: 12px 20px;
            background: #2b6cb0;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }

        .grid-view {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        .grid-view th, .grid-view td {
            padding: 15px;
            text-align: left;
        }

        .grid-view th {
            background: #2b6cb0;
            color: white;
        }

        .grid-view tr:nth-child(even) {
            background: #f8fafc;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 200px;
            }
            .main-content {
                margin-left: 200px;
                width: calc(100% - 200px);
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Hidden field to store the active section -->
        <asp:HiddenField ID="hdnActiveSection" runat="server" Value="dashboard" />

        <div class="container">
            <div class="sidebar">
                <div class="profile">
                    <img src="img/c1.jpg" alt="Admin Profile" />
                    <h3>Admin Panel</h3>
                </div>
                <ul>
                    <li><a href="#" onclick="setActiveSection('dashboard'); return false;"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="#" onclick="setActiveSection('customers'); return false;"><i class="fas fa-users"></i> Customers</a></li>
                    <li><a href="#" onclick="setActiveSection('chefs'); return false;"><i class="fas fa-user-tie"></i> Chefs</a></li>
                    <li><a href="#" onclick="setActiveSection('bookings'); return false;"><i class="fas fa-calendar-check"></i> Bookings</a></li>
                    <li><a href="#" onclick="setActiveSection('ratings'); return false;"><i class="fas fa-star"></i> Ratings</a></li>
                    <li><asp:LinkButton ID="LinkButton1" runat="server" OnClick="btnLogout_Click"><i class="fas fa-sign-out-alt"></i> Logout</asp:LinkButton></li>
                </ul>
            </div>

            <div class="main-content">
                <div class="header">
                    <h1><i class="fas fa-tachometer-alt"></i> Admin Dashboard</h1>
                </div>

                <div id="dashboard" class="section">
                    <div class="dashboard-grid">
                        <div class="card">
                            <i class="fas fa-users"></i>
                            <h3>Total Customers</h3>
                            <asp:Label ID="lblTotalCustomers" runat="server" />
                        </div>
                        <div class="card">
                            <i class="fas fa-user-tie"></i>
                            <h3>Total Chefs</h3>
                            <asp:Label ID="lblTotalChefs" runat="server" />
                        </div>
                        <div class="card">
                            <i class="fas fa-calendar-check"></i>
                            <h3>Total Bookings</h3>
                            <asp:Label ID="lblTotalBookings" runat="server" />
                        </div>
                        <div class="card">
                            <i class="fas fa-star"></i>
                            <h3>High Rated Chefs</h3>
                            <asp:Label ID="lblHighRatedChefs" runat="server" />
                        </div>
                        <div class="card">
                            <i class="fas fa-user-slash"></i>
                            <h3>Unverified Chefs</h3>
                            <asp:Label ID="lblUnverifiedChefs" runat="server" />
                        </div>
                        <div class="card">
                            <i class="fas fa-eye"></i>
                            <h3>Total Visitors</h3>
                            <asp:Label ID="lblTotalVisitors" runat="server" />
                        </div>
                    </div>
                </div>

                <!-- Customers Section -->
                <div id="customers" class="section" style="display:none">
                    <div class="search-container">
                        <asp:TextBox ID="txtSearchCustomer" runat="server" placeholder="Search by Name..." />
                        <asp:TextBox ID="txtSearchCity" runat="server" placeholder="Search by City..." />
                        <asp:Button ID="btnSearchCustomer" runat="server" Text="Search" OnClick="btnSearchCustomer_Click" OnClientClick="setActiveSection('customers'); return true;" />
                    </div>
                    <asp:GridView ID="gvCustomers" runat="server" CssClass="grid-view" AutoGenerateColumns="false">
                        <Columns>
                            <asp:BoundField DataField="UserID" HeaderText="ID" />
                            <asp:BoundField DataField="FullName" HeaderText="Name" />
                            <asp:BoundField DataField="Email" HeaderText="Email" />
                            <asp:BoundField DataField="PhoneNumber" HeaderText="Phone" />
                            <asp:BoundField DataField="City" HeaderText="City" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button ID="btnDeleteCustomer" runat="server" Text="Delete" CommandArgument='<%# Eval("UserID") %>' OnClick="btnDeleteCustomer_Click" OnClientClick="setActiveSection('customers'); return true;" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

                <!-- Chefs Section -->
                <div id="chefs" class="section" style="display:none">
                    <div class="search-container">
                        <asp:TextBox ID="txtSearchChef" runat="server" placeholder="Search by Name..." />
                        <asp:TextBox ID="txtSearchChefCity" runat="server" placeholder="Search by City..." />
                        <asp:Button ID="btnSearchChef" runat="server" Text="Search" OnClick="btnSearchChef_Click" OnClientClick="setActiveSection('chefs'); return true;" />
                    </div>
                    <asp:GridView ID="gvChefs" runat="server" CssClass="grid-view" AutoGenerateColumns="false">
                        <Columns>
                            <asp:BoundField DataField="ChefDetailID" HeaderText="ID" />
                            <asp:BoundField DataField="FullName" HeaderText="Name" />
                            <asp:BoundField DataField="CuisineSpecialty" HeaderText="Specialty" />
                            <asp:BoundField DataField="Experience" HeaderText="Experience" />
                            <asp:BoundField DataField="City" HeaderText="City" />
                            <asp:BoundField DataField="AvailabilityStatus" HeaderText="Status" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button ID="btnDeleteChef" runat="server" Text="Delete" CommandArgument='<%# Eval("ChefDetailID") %>' OnClick="btnDeleteChef_Click" OnClientClick="setActiveSection('chefs'); return true;" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

                <!-- Bookings Section -->
                <div id="bookings" class="section" style="display:none">
                    <div class="search-container">
                        <asp:TextBox ID="txtSearchBooking" runat="server" placeholder="Search by Customer Name..." />
                        <asp:Button ID="btnSearchBooking" runat="server" Text="Search" OnClick="btnSearchBooking_Click" OnClientClick="setActiveSection('bookings'); return true;" />
                    </div>
                    <asp:GridView ID="gvBookings" runat="server" CssClass="grid-view" AutoGenerateColumns="false">
                        <Columns>
                            <asp:BoundField DataField="BookingID" HeaderText="ID" />
                            <asp:BoundField DataField="UserName" HeaderText="Customer" />
                            <asp:BoundField DataField="ChefName" HeaderText="Chef" />
                            <asp:BoundField DataField="EventDate" HeaderText="Date" />
                            <asp:BoundField DataField="CuisineType" HeaderText="Cuisine" />
                            <asp:BoundField DataField="NumberOfPeople" HeaderText="People" />
                            <asp:BoundField DataField="Location" HeaderText="Location" />
                        </Columns>
                    </asp:GridView>
                </div>

                <!-- Ratings Section -->
                <div id="ratings" class="section" style="display:none">
                    <asp:GridView ID="gvRatings" runat="server" CssClass="grid-view" AutoGenerateColumns="false">
                        <Columns>
                            <asp:BoundField DataField="RatingID" HeaderText="ID" />
                            <asp:BoundField DataField="ChefName" HeaderText="Chef" />
                            <asp:BoundField DataField="CustomerName" HeaderText="Customer" />
                            <asp:BoundField DataField="Rating" HeaderText="Rating" />
                            <asp:BoundField DataField="Timestamp" HeaderText="Date" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </form>

    <script type="text/javascript">
        function showSection(sectionId) {
            const sections = document.getElementsByClassName('section');
            for (let section of sections) {
                section.style.display = 'none';
            }
            document.getElementById(sectionId).style.display = 'block';
        }

        function setActiveSection(sectionId) {
            // Update the hidden field with the active section
            var hiddenField = document.getElementById('<%= hdnActiveSection.ClientID %>');
            if (hiddenField) {
                hiddenField.value = sectionId;
            }
            // Also store in local storage for persistence
            localStorage.setItem('activeSection', sectionId);
            showSection(sectionId);
        }

        function restoreSection() {
            // Try to get the active section from the hidden field
            var hiddenField = document.getElementById('<%= hdnActiveSection.ClientID %>');
            var activeSection = hiddenField ? hiddenField.value : null;

            // Fallback to local storage if the hidden field doesn't have a valid value
            if (!activeSection || activeSection === "" || activeSection === "dashboard") {
                activeSection = localStorage.getItem('activeSection') || 'dashboard';
            }

            // Ensure the section is shown
            if (activeSection) {
                showSection(activeSection);
                // Update the hidden field to ensure consistency
                if (hiddenField) {
                    hiddenField.value = activeSection;
                }
            }
        }

        // Restore the section on page load
        document.addEventListener('DOMContentLoaded', function () {
            restoreSection();
        });
    </script>
</body>
</html>