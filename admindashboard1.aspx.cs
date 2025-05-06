using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace YourChef
{
    public partial class admindashboard1 : System.Web.UI.Page
    {
       
            private string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            private const string AdminUsername = "admin";
            private const string AdminPassword = "admin123";

            protected void Page_Load(object sender, EventArgs e)
            {
                if (!IsPostBack)
                {
                    // Check if already logged in (simple flag, replace with session if needed)
                    if (Session["IsAdminLoggedIn"] != null && (bool)Session["IsAdminLoggedIn"])
                    {
                        LoadAdminDashboard();
                    }
                    else
                    {
                        pnlLogin.Visible = true;
                        pnlDashboard.Visible = false;
                    }
                }
            }

            protected void btnLogin_Click(object sender, EventArgs e)
            {
                string username = txtUsername.Text.Trim();
                string password = txtPassword.Text.Trim();

                if (username == AdminUsername && password == AdminPassword)
                {
                    Session["IsAdminLoggedIn"] = true;
                    LoadAdminDashboard();
                }
                else
                {
                    lblError.Text = "Invalid username or password.";
                    lblError.Visible = true;
                    pnlLogin.Visible = true;
                    pnlDashboard.Visible = false;
                }
            }

            private void LoadAdminDashboard()
            {
                pnlLogin.Visible = false;
                pnlDashboard.Visible = true;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    try
                    {
                        conn.Open();

                        // Total Users
                        string userQuery = "SELECT COUNT(*) FROM Users";
                        using (SqlCommand cmd = new SqlCommand(userQuery, conn))
                        {
                            lblTotalUsers.Text = cmd.ExecuteScalar().ToString();
                        }

                        // Total Bookings
                        string bookingQuery = "SELECT COUNT(*) FROM ChefBookings";
                        using (SqlCommand cmd = new SqlCommand(bookingQuery, conn))
                        {
                            lblTotalBookings.Text = cmd.ExecuteScalar().ToString();
                        }

                        // Pending Chefs (assuming all chefs are pending verification for simplicity)
                        string chefQuery = "SELECT COUNT(*) FROM Users WHERE Role = 'Chef'";
                        using (SqlCommand cmd = new SqlCommand(chefQuery, conn))
                        {
                            lblPendingChefs.Text = cmd.ExecuteScalar().ToString();
                        }
                    }
                    catch (Exception ex)
                    {
                        lblError.Text = "Error loading dashboard: " + ex.Message;
                        lblError.Visible = true;
                        pnlLogin.Visible = true;
                        pnlDashboard.Visible = false;
                    }
                }
            }
        }
    }