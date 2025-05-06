using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using Twilio.Http;

namespace YourChef
{
    public partial class user_profile1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                LoadUserProfile();
            }

        }
        private void LoadUserProfile()
        {
            // Check if the user is logged in
            if (Session["UserID"] == null)
            {
                Response.Redirect("loginn.aspx"); // Redirect to login page if session is not found
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);
            string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                // Fetch user details from Users table
                string userQuery = "SELECT FullName, Email, PhoneNumber FROM Users WHERE UserID = @UserID";
                using (SqlCommand cmd = new SqlCommand(userQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        txtName.Text = reader["FullName"].ToString();
                        txtEmail.Text = reader["Email"].ToString();
                        txtMobile.Text = reader["PhoneNumber"].ToString();
                    }
                    reader.Close();
                }

                // Fetch profile details from UserProfile table (if exists)
                string profileQuery = "SELECT DOB, Gender FROM UserProfile WHERE UserID = @UserID";
                using (SqlCommand cmd = new SqlCommand(profileQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        txtDOB.Text = Convert.ToDateTime(reader["DOB"]).ToString("yyyy-MM-dd"); // Format for date input
                        string gender = reader["Gender"].ToString();
                        if (gender == "Male")
                        {
                            RadioButton1.Checked = true;
                        }
                        else if (gender == "Female")
                        {
                            RadioButton2.Checked = true;
                        }
                    }
                    reader.Close();
                }
            }
        }


        protected void btnSave_Click1(object sender, EventArgs e)
        {
            // Check if user is logged in
            if (Session["UserID"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);
            string fullName = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string phoneNumber = txtMobile.Text.Trim();
            string dob = txtDOB.Text.Trim();
            string gender = RadioButton1.Checked ? "Male" : (RadioButton2.Checked ? "Female" : "");

            // Validation
            if (string.IsNullOrEmpty(fullName) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(phoneNumber))
            {
                ShowAlert("Full Name, Email, and Phone Number are required!", "red");
                return;
            }

            if (string.IsNullOrEmpty(dob))
            {
                ShowAlert("Date of Birth is required!", "red");
                return;
            }

            if (string.IsNullOrEmpty(gender))
            {
                ShowAlert("Please select a Gender!", "red");
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                // **1. Update Users table**
                string updateUserQuery = "UPDATE Users SET FullName = @FullName, Email = @Email, PhoneNumber = @PhoneNumber WHERE UserID = @UserID";
                using (SqlCommand cmd = new SqlCommand(updateUserQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@FullName", fullName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@PhoneNumber", phoneNumber);
                    cmd.ExecuteNonQuery();
                }

                // **2. Check if profile exists in UserProfile table**
                string checkQuery = "SELECT COUNT(1) FROM UserProfile WHERE UserID = @UserID";
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@UserID", userId);
                    int count = Convert.ToInt32(checkCmd.ExecuteScalar());

                    string profileQuery;
                    if (count > 0)
                    {
                        // **Update UserProfile table**
                        profileQuery = "UPDATE UserProfile SET DOB = @DOB, Gender = @Gender WHERE UserID = @UserID";
                    }
                    else
                    {
                        // **Insert new record in UserProfile table**
                        profileQuery = "INSERT INTO UserProfile (UserID, DOB, Gender) VALUES (@UserID, @DOB, @Gender)";
                    }

                    using (SqlCommand cmd = new SqlCommand(profileQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        cmd.Parameters.AddWithValue("@DOB", Convert.ToDateTime(dob));
                        cmd.Parameters.AddWithValue("@Gender", gender);
                        cmd.ExecuteNonQuery();
                    }
                }

                ShowAlert("Profile updated successfully!", "green");
            }
        }

        private void ShowAlert(string message, string color)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{message}');", true);
        }
    }

}


