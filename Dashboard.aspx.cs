// Dashboard.aspx.cs
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.UI;

namespace YourChef
{
    public partial class Dashboard : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        private const string AdminUsername = "admin";
        private const string AdminPassword = "admin123";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["AdminLoggedIn"] == null || !(bool)Session["AdminLoggedIn"])
                {
                    Response.Redirect("loginn.aspx");
                }
                try
                {
                    hdnActiveSection.Value = "dashboard";
                    LoadDashboardData();
                    LoadCustomers();
                    LoadChefs();
                    LoadBookings();
                    LoadRatings();
                    UpdateVisitorCount();
                }
                catch (Exception ex)
                {
                    Response.Write($"Error loading dashboard: {ex.Message}");
                }
            }
            else
            {
                // Ensure the section is restored after postback
                ScriptManager.RegisterStartupScript(this, this.GetType(), "restoreSection", "restoreSection();", true);
            }
        }

        private void LoadDashboardData()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Role = 'Customer'", conn);
                    lblTotalCustomers.Text = cmd.ExecuteScalar()?.ToString() ?? "0";

                    cmd = new SqlCommand("SELECT COUNT(*) FROM ChefDetails", conn);
                    lblTotalChefs.Text = cmd.ExecuteScalar()?.ToString() ?? "0";

                    cmd = new SqlCommand("SELECT COUNT(*) FROM ChefBookings", conn);
                    lblTotalBookings.Text = cmd.ExecuteScalar()?.ToString() ?? "0";

                    cmd = new SqlCommand("SELECT COUNT(*) FROM ChefRatings cr JOIN ChefDetails cd ON cr.ChefDetailID = cd.ChefDetailID WHERE Rating >= 4", conn);
                    lblHighRatedChefs.Text = cmd.ExecuteScalar()?.ToString() ?? "0";

                    cmd = new SqlCommand("SELECT COUNT(*) FROM ChefDetails WHERE AvailabilityStatus = 'Pending'", conn);
                    lblUnverifiedChefs.Text = cmd.ExecuteScalar()?.ToString() ?? "0";

                    cmd = new SqlCommand("SELECT VisitorCount FROM WebsiteStats WHERE ID = 1", conn);
                    object visitorCount = cmd.ExecuteScalar();
                    lblTotalVisitors.Text = visitorCount != null ? visitorCount.ToString() : "0";
                }
                catch (Exception ex)
                {
                    Response.Write($"Error loading dashboard data: {ex.Message}");
                }
            }
        }

        private void UpdateVisitorCount()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(
                        "IF EXISTS (SELECT 1 FROM WebsiteStats WHERE ID = 1) " +
                        "UPDATE WebsiteStats SET VisitorCount = VisitorCount + 1 WHERE ID = 1 " +
                        "ELSE " +
                        "INSERT INTO WebsiteStats (VisitorCount) VALUES (1)", conn);
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    Response.Write($"Error updating visitor count: {ex.Message}");
                }
            }
        }

        private void LoadCustomers()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT u.*, c.CityName AS City " +
                                  "FROM Users u " +
                                  "LEFT JOIN UserAddresses ua ON u.UserID = ua.UserID " +
                                  "LEFT JOIN City c ON ua.CityID = c.CityID " +
                                  "WHERE u.Role = 'Customer'";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvCustomers.DataSource = dt;
                    gvCustomers.DataBind();
                }
                catch (Exception ex)
                {
                    Response.Write($"Error loading customers: {ex.Message}");
                }
            }
        }

        private void LoadChefs()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT cd.*, u.FullName FROM ChefDetails cd JOIN Users u ON cd.UserID = u.UserID";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvChefs.DataSource = dt;
                    gvChefs.DataBind();
                }
                catch (Exception ex)
                {
                    Response.Write($"Error loading chefs: {ex.Message}");
                }
            }
        }

        private void LoadBookings()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT cb.*, u.FullName AS ChefName " +
                                  "FROM ChefBookings cb " +
                                  "JOIN ChefDetails cd ON cb.ChefDetailID = cd.ChefDetailID " +
                                  "JOIN Users u ON cd.UserID = u.UserID";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvBookings.DataSource = dt;
                    gvBookings.DataBind();
                }
                catch (Exception ex)
                {
                    Response.Write($"Error loading bookings: {ex.Message}");
                }
            }
        }

        private void LoadRatings()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT cr.RatingID, cr.Rating, cr.Timestamp, " +
                                  "uc.FullName AS CustomerName, uch.FullName AS ChefName " +
                                  "FROM ChefRatings cr " +
                                  "JOIN Users uc ON cr.UserID = uc.UserID " +
                                  "JOIN ChefDetails cd ON cr.ChefDetailID = cd.ChefDetailID " +
                                  "JOIN Users uch ON cd.UserID = uch.UserID";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvRatings.DataSource = dt;
                    gvRatings.DataBind();
                }
                catch (Exception ex)
                {
                    Response.Write($"Error loading ratings: {ex.Message}");
                }
            }
        }

        protected void btnSearchCustomer_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT u.*, c.CityName AS City " +
                                  "FROM Users u " +
                                  "LEFT JOIN UserAddresses ua ON u.UserID = ua.UserID " +
                                  "LEFT JOIN City c ON ua.CityID = c.CityID " +
                                  "WHERE u.Role = 'Customer' " +
                                  "AND (@Name IS NULL OR u.FullName LIKE @Name) " +
                                  "AND (@City IS NULL OR c.CityName LIKE @City)";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Name", string.IsNullOrEmpty(txtSearchCustomer.Text) ? (object)DBNull.Value : "%" + txtSearchCustomer.Text + "%");
                    cmd.Parameters.AddWithValue("@City", string.IsNullOrEmpty(txtSearchCity.Text) ? (object)DBNull.Value : "%" + txtSearchCity.Text + "%");
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvCustomers.DataSource = dt;
                    gvCustomers.DataBind();

                    hdnActiveSection.Value = "customers";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveSection", "setActiveSection('customers');", true);
                }
                catch (Exception ex)
                {
                    Response.Write($"Error searching customers: {ex.Message}");
                }
            }
        }

        protected void btnSearchChef_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT cd.*, u.FullName FROM ChefDetails cd JOIN Users u ON cd.UserID = u.UserID " +
                                  "WHERE (@Name IS NULL OR u.FullName LIKE @Name) " +
                                  "AND (@City IS NULL OR cd.City LIKE @City)";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Name", string.IsNullOrEmpty(txtSearchChef.Text) ? (object)DBNull.Value : "%" + txtSearchChef.Text + "%");
                    cmd.Parameters.AddWithValue("@City", string.IsNullOrEmpty(txtSearchChefCity.Text) ? (object)DBNull.Value : "%" + txtSearchChefCity.Text + "%");
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvChefs.DataSource = dt;
                    gvChefs.DataBind();

                    hdnActiveSection.Value = "chefs";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveSection", "setActiveSection('chefs');", true);
                }
                catch (Exception ex)
                {
                    Response.Write($"Error searching chefs: {ex.Message}");
                }
            }
        }

        protected void btnSearchBooking_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT cb.*, u.FullName AS ChefName " +
                                  "FROM ChefBookings cb " +
                                  "JOIN ChefDetails cd ON cb.ChefDetailID = cd.ChefDetailID " +
                                  "JOIN Users u ON cd.UserID = u.UserID " +
                                  "WHERE @Name IS NULL OR cb.UserName LIKE @Name";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Name", string.IsNullOrEmpty(txtSearchBooking.Text) ? (object)DBNull.Value : "%" + txtSearchBooking.Text + "%");
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvBookings.DataSource = dt;
                    gvBookings.DataBind();

                    hdnActiveSection.Value = "bookings";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveSection", "setActiveSection('bookings');", true);
                }
                catch (Exception ex)
                {
                    Response.Write($"Error searching bookings: {ex.Message}");
                }
            }
        }

        protected void btnDeleteCustomer_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int userId = Convert.ToInt32(btn.CommandArgument);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("DELETE FROM Users WHERE UserID = @UserID", conn);
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    Response.Write($"Error deleting customer: {ex.Message}");
                }
            }
            LoadCustomers();
            LoadDashboardData();
            hdnActiveSection.Value = "customers";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveSection", "setActiveSection('customers');", true);
        }

        protected void btnDeleteChef_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int chefDetailId = Convert.ToInt32(btn.CommandArgument);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("DELETE FROM ChefDetails WHERE ChefDetailID = @ChefDetailID", conn);
                    cmd.Parameters.AddWithValue("@ChefDetailID", chefDetailId);
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    Response.Write($"Error deleting chef: {ex.Message}");
                }
            }
            LoadChefs();
            LoadDashboardData();
            hdnActiveSection.Value = "chefs";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveSection", "setActiveSection('chefs');", true);
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session["AdminLoggedIn"] = null;
            Response.Redirect("loginn.aspx");
        }
    }
}