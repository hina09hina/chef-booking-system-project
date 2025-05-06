using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace YourChef
{
    public partial class dashboardd : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;



        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Simulate logged-in user (replace with actual authentication)
                int userId = 1; // Example user ID from session or authentication
                LoadDashboard(userId);
            }
        }
    
    
        private void LoadDashboard(int userId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Load user info
                string userQuery = "SELECT FullName, Role FROM Users WHERE UserID = @UserID";
                using (SqlCommand cmd = new SqlCommand(userQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblFullName.Text = reader["FullName"].ToString();
                            lblRole.Text = reader["Role"].ToString();
                            string role = reader["Role"].ToString();
                            reader.Close();

                            switch (role)
                            {
                                case "Customer":
                                    LoadCustomerDashboard(userId, conn);
                                    CustomerDashboard.Visible = true;
                                    ChefMenu.Visible = true;
                                    break;

                                case "Chef":
                                    LoadChefDashboard(userId, conn);
                                    ChefDashboard.Visible = true;
                                    break;

                                case "Admin":
                                    LoadAdminDashboard(conn);
                                    AdminDashboard.Visible = true;
                                    ChefMenu.Visible = true;
                                    break;

                                default:
                                    Response.Write("Invalid role");
                                    break;
                            }
                        }
                    }
                }
            }
        }

        private void LoadCustomerDashboard(int userId, SqlConnection conn)
        {
            string query = "SELECT EventDate, CuisineType FROM ChefBookings WHERE UserID = @UserID";
            using (SqlDataAdapter da = new SqlDataAdapter(query, conn))
            {
                da.SelectCommand.Parameters.AddWithValue("@UserID", userId);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptCustomerBookings.DataSource = dt;
                rptCustomerBookings.DataBind();
                lblCustomerBookings.Text = dt.Rows.Count.ToString();
            }
        }

        private void LoadChefDashboard(int userId, SqlConnection conn)
        {
            // Get ChefDetailID
            string chefQuery = "SELECT ChefDetailID FROM ChefDetails WHERE UserID = @UserID";
            int chefDetailId = 0;
            using (SqlCommand cmd = new SqlCommand(chefQuery, conn))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);
                object result = cmd.ExecuteScalar();
                if (result != null) chefDetailId = Convert.ToInt32(result);
            }

            // Load bookings
            string bookingQuery = "SELECT EventDate, Location FROM ChefBookings WHERE ChefDetailID = @ChefDetailID";
            using (SqlDataAdapter da = new SqlDataAdapter(bookingQuery, conn))
            {
                da.SelectCommand.Parameters.AddWithValue("@ChefDetailID", chefDetailId);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptChefBookings.DataSource = dt;
                rptChefBookings.DataBind();
                lblChefBookings.Text = dt.Rows.Count.ToString();
            }

            // Load average rating
            string ratingQuery = "SELECT AVG(Rating) FROM ChefRatings WHERE ChefDetailID = @ChefDetailID";
            using (SqlCommand cmd = new SqlCommand(ratingQuery, conn))
            {
                cmd.Parameters.AddWithValue("@ChefDetailID", chefDetailId);
                object avgRating = cmd.ExecuteScalar();
                lblAverageRating.Text = avgRating != DBNull.Value ? Convert.ToDouble(avgRating).ToString("F1") : "0";
            }
        }

        private void LoadAdminDashboard(SqlConnection conn)
        {
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

            // Pending Chefs (assuming chefs need verification)
            string chefQuery = "SELECT COUNT(*) FROM Users WHERE Role = 'Chef'";
            using (SqlCommand cmd = new SqlCommand(chefQuery, conn))
            {
                lblPendingChefs.Text = cmd.ExecuteScalar().ToString();
            }
        }
    }
}

    