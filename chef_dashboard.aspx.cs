using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace YourChef
{
    public partial class chef_dashboard : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("loginn.aspx");
                return;
            }

            if (!IsPostBack)
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                ViewState["UserID"] = userId; // Store in ViewState for postbacks

                LoadChefProfile(userId);
                LoadBookingRequests(userId);
            }
        }

        private void LoadChefProfile(int userId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT u.FullName, cd.CuisineSpecialty, cd.Experience, cd.AvailabilityStatus
                    FROM ChefDetails cd
                    INNER JOIN Users u ON cd.UserID = u.UserID
                    WHERE cd.UserID = @UserID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    lblChefName.Text = reader["FullName"].ToString();
                    lblSpecialty.Text = reader["CuisineSpecialty"].ToString();
                    lblExperience.Text = reader["Experience"].ToString();
                    lblAvailability.Text = reader["AvailabilityStatus"].ToString();
                }
            }
        }

        private void LoadBookingRequests(int userId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT 
                        cb.BookingID,
                        u.FullName AS CustomerName,
                        cb.EventDateTime,
                        cb.DurationHours,
                        cb.Location,
                        cb.NumberOfPeople,
                        cb.CuisineType,
                        cb.SpecialRequests,
                        cb.Status
                    FROM ChefBookings cb
                    INNER JOIN Users u ON cb.UserID = u.UserID
                    WHERE cb.ChefDetailID = (SELECT ChefDetailID FROM ChefDetails WHERE UserID = @UserID)
                    ORDER BY cb.BookingDate DESC";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptBookings.DataSource = dt;
                rptBookings.DataBind();
            }
        }

        protected void rptBookings_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int bookingId = Convert.ToInt32(e.CommandArgument);
            int userId = Convert.ToInt32(ViewState["UserID"]); // Retrieve userId from ViewState

            string status = "";
            if (e.CommandName == "Confirm") status = "Confirmed";
            else if (e.CommandName == "Cancel") status = "Canceled";
            else if (e.CommandName == "Complete") status = "Completed";

            if (!string.IsNullOrEmpty(status))
            {
                bool success = UpdateBookingStatus(bookingId, status, userId);
                if (success)
                {
                    lblMessage.Text = "Booking status updated successfully!";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    lblMessage.Text = "Update failed. Please try again.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }

                LoadBookingRequests(userId); // Refresh booking list
            }
        }

        private bool UpdateBookingStatus(int bookingId, string status, int userId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                    UPDATE ChefBookings 
                    SET Status = @Status 
                    WHERE BookingID = @BookingID 
                    AND ChefDetailID = (SELECT ChefDetailID FROM ChefDetails WHERE UserID = @UserID)";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@BookingID", bookingId);
                cmd.Parameters.AddWithValue("@UserID", userId);

                conn.Open();
                int rowsAffected = cmd.ExecuteNonQuery();
                return rowsAffected > 0;
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("loginn.aspx");
        }
    }
}
