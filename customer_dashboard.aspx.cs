using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace YourChef
{
    public partial class customer_dashboard : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        private int userId; // Define at class level

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("loginn.aspx"); // Redirect to login page if session is not found
                return;
            }

            userId = Convert.ToInt32(Session["UserID"]); // Assign userId here

            if (!IsPostBack)
            {
                LoadUserDetails();
                LoadCurrentBookings();
                LoadPastBookings();
            }
        }

        private void LoadUserDetails()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT FullName, Email, PhoneNumber FROM Users WHERE UserID = @UserID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    lblFullName.Text = reader["FullName"].ToString();
                    lblContact.Text = $"{reader["Email"]} | {reader["PhoneNumber"]}";
                }
                conn.Close();
            }
        }

        private void LoadCurrentBookings()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                SELECT b.BookingID, u.FullName AS ChefName, b.EventDateTime, b.Location, b.NumberOfPeople, b.Status
                FROM ChefBookings b
                JOIN ChefDetails cd ON b.ChefDetailID = cd.ChefDetailID
                JOIN Users u ON cd.UserID = u.UserID
                WHERE b.UserID = @UserID 
                    AND b.EventDateTime >= GETDATE()
                    AND b.Status IN ('Pending', 'Confirmed', 'Canceled')";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                rptCurrentBookings.DataSource = dt;
                rptCurrentBookings.DataBind();
            }
        }

        private void LoadPastBookings()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                SELECT b.BookingID, u.FullName AS ChefName, b.EventDateTime, b.Location, b.NumberOfPeople, b.Status
                FROM ChefBookings b
                JOIN ChefDetails cd ON b.ChefDetailID = cd.ChefDetailID
                JOIN Users u ON cd.UserID = u.UserID
                WHERE b.UserID = @UserID 
                    AND (b.Status = 'Completed' OR b.EventDateTime < GETDATE())";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                rptPastBookings.DataSource = dt;
                rptPastBookings.DataBind();
            }
        }
    }
}
