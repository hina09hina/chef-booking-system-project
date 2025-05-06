<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="chef_dashboard.aspx.cs" Inherits="YourChef.chef_dashboard" %>



<!DOCTYPE html>
<html>
<head runat="server">
    <title>Chef Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: url('/Images/chef-bg.jpg') no-repeat center center fixed;
            background-size: cover;
            font-family: Arial, sans-serif;
        }
        .navbar {
            background-color: rgba(0, 0, 0, 0.7);
        }
        .navbar-brand, .nav-link {
            color: white !important;
        }
        .dashboard-container {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            padding: 20px;
            margin: 20px auto;
            max-width: 1200px;
        }
        .booking-card {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 15px;
            background: white;
        }
        .status-pending { color: #ffc107; }
        .status-confirmed { color: #28a745; }
        .status-canceled { color: #dc3545; }
        .status-completed { color: #17a2b8; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navigation Bar -->
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Chef Dashboard</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="#bookings">Bookings</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#profile">Profile</a>
                        </li>
                        <li class="nav-item">
                            <asp:LinkButton class="nav-link" ID="btnLogout" runat="server" OnClick="btnLogout_Click">Logout</asp:LinkButton>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Dashboard Content -->
        <div class="dashboard-container">
            <h2>Welcome, <asp:Label ID="lblChefName" runat="server"></asp:Label></h2>
            
            <!-- Bookings Section -->
            <section id="bookings">
                <h3>Booking Requests</h3>
                <asp:Repeater ID="rptBookings" runat="server" OnItemCommand="rptBookings_ItemCommand">
                    <ItemTemplate>
                        <div class="booking-card">
                            <div class="row">
                                <div class="col-md-8">
                                    <h5>Booking #<%# Eval("BookingID") %></h5>
                                    <p><strong>Customer:</strong> <%# Eval("CustomerName") %></p>
                                    <p><strong>Date:</strong> <%# Eval("EventDateTime", "{0:MMMM dd, yyyy HH:mm}") %></p>
                                    <p><strong>Duration:</strong> <%# Eval("DurationHours") %> hours</p>
                                    <p><strong>Location:</strong> <%# Eval("Location") %></p>
                                    <p><strong>People:</strong> <%# Eval("NumberOfPeople") %></p>
                                    <p><strong>Cuisine:</strong> <%# Eval("CuisineType") %></p>
                                    <p><strong>Requests:</strong> <%# Eval("SpecialRequests") %></p>
                                    <p><strong>Status:</strong> 
                                        <span class='status-<%# Eval("Status").ToString().ToLower() %>'>
                                            <%# Eval("Status") %>
                                        </span>
                                    </p>
                                </div>
                                <div class="col-md-4 text-end">
                                    <asp:Button ID="btnConfirm" runat="server" 
                                        CommandName="Confirm" 
                                        CommandArgument='<%# Eval("BookingID") %>' 
                                        Text="Confirm" 
                                        CssClass="btn btn-success m-1" 
                                        Visible='<%# Eval("Status").ToString() == "Pending" %>' />
                                    <asp:Button ID="btnCancel" runat="server" 
                                        CommandName="Cancel" 
                                        CommandArgument='<%# Eval("BookingID") %>' 
                                        Text="Cancel" 
                                        CssClass="btn btn-danger m-1" 
                                        Visible='<%# Eval("Status").ToString() == "Pending" || Eval("Status").ToString() == "Confirmed" %>' />
                                    <asp:Button ID="btnComplete" runat="server" 
                                        CommandName="Complete" 
                                        CommandArgument='<%# Eval("BookingID") %>' 
                                        Text="Complete" 
                                        CssClass="btn btn-info m-1" 
                                        Visible='<%# Eval("Status").ToString() == "Confirmed" %>' />
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </section>

            <!-- Profile Section (Basic) -->
            <section id="profile">
                <h3>Your Profile</h3>
                <p><strong>Specialty:</strong> <asp:Label ID="lblSpecialty" runat="server"></asp:Label></p>
                <p><strong>Experience:</strong> <asp:Label ID="lblExperience" runat="server"></asp:Label> years</p>
                <p><strong>Availability:</strong> <asp:Label ID="lblAvailability" runat="server"></asp:Label></p>
                <asp:Label ID="lblMessage" runat="server" ForeColor="Red" />

            </section>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>