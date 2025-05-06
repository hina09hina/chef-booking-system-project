using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;

namespace YourChef
{
    public partial class loginn : Page
    {
        private const string AdminUsername = "admin";
        private const string AdminPassword = "admin123";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Text = "";
                fullName.Text = username.Text = emailAddress.Text = password.Text = phoneNumber.Text = "";
            }
        }

        private void ShowAlert(string message, string color)
        {
            lblMessage.Text = message;
            lblMessage.ForeColor = Color.FromName(color);
        }

        protected void loginButton_Click(object sender, EventArgs e)
        {
            string userInput = loginUsername.Text.Trim();
            string password = loginPassword.Text.Trim();

            if (string.IsNullOrEmpty(userInput) || string.IsNullOrEmpty(password))
            {
                ShowAlert("Please enter your Username/Email and Password!", "red");
                return;
            }

            // Check for admin login
            if (userInput == AdminUsername && password == AdminPassword)
            {
                Session["AdminLoggedIn"] = true;
                Session["UserRole"] = "Admin"; // Set role for admin
                Response.Redirect("Dashboard.aspx");
                return;
            }

            // Regular user login
            string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"
                    SELECT u.UserID, u.Username, u.FullName, u.Email, u.PhoneNumber, u.Role, cd.ChefDetailID 
                    FROM Users u 
                    LEFT JOIN ChefDetails cd ON u.UserID = cd.UserID 
                    WHERE (u.Username = @UserInput OR u.Email = @UserInput) AND u.Password = @Password";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserInput", userInput);
                    cmd.Parameters.AddWithValue("@Password", password);

                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            Session["UserID"] = reader["UserID"].ToString();
                            Session["Username"] = reader["Username"].ToString();
                            Session["FullName"] = reader["FullName"].ToString();
                            Session["Email"] = reader["Email"].ToString();
                            Session["PhoneNumber"] = reader["PhoneNumber"].ToString();
                            Session["UserRole"] = reader["Role"].ToString();

                            string userRole = reader["Role"].ToString();
                            if (userRole == "Chef" && reader["ChefDetailID"] != DBNull.Value)
                            {
                                Session["ChefDetailID"] = reader["ChefDetailID"].ToString();
                                Response.Redirect("chef_dashboard.aspx");
                            }
                            else
                            {
                                Response.Redirect("index.aspx"); // Default page for non-chef users
                            }
                        }
                        else
                        {
                            ShowAlert("Invalid Username/Email or Password!", "red");
                        }
                    }
                    conn.Close();
                }
            }
        }

        protected void signUpButton_Click(object sender, EventArgs e)
        {
            string userFullName = fullName.Text.Trim();
            string userUsername = username.Text.Trim();
            string userEmail = emailAddress.Text.Trim();
            string userPassword = password.Text.Trim();
            string userPhoneNumber = phoneNumber.Text.Trim();

            if (string.IsNullOrEmpty(userFullName) || string.IsNullOrEmpty(userUsername) || string.IsNullOrEmpty(userEmail) || string.IsNullOrEmpty(userPassword) || string.IsNullOrEmpty(userPhoneNumber))
            {
                Response.Write("<script>alert('Please fill all fields!');</script>");
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();

                    string checkQuery = "SELECT COUNT(*) FROM Users WHERE Username = @Username OR Email = @Email OR PhoneNumber = @PhoneNumber";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@Username", userUsername);
                        checkCmd.Parameters.AddWithValue("@Email", userEmail);
                        checkCmd.Parameters.AddWithValue("@PhoneNumber", userPhoneNumber);
                        int count = (int)checkCmd.ExecuteScalar();
                        if (count > 0)
                        {
                            Response.Write("<script>alert('Username, Email, or Phone Number already exists!');</script>");
                            return;
                        }
                    }

                    string query = "INSERT INTO Users (FullName, Username, Email, Password, PhoneNumber, Role) VALUES (@FullName, @Username, @Email, @Password, @PhoneNumber, @Role)";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@FullName", userFullName);
                        cmd.Parameters.AddWithValue("@Username", userUsername);
                        cmd.Parameters.AddWithValue("@Email", userEmail);
                        cmd.Parameters.AddWithValue("@Password", userPassword); // Consider hashing in production
                        cmd.Parameters.AddWithValue("@PhoneNumber", userPhoneNumber);
                        cmd.Parameters.AddWithValue("@Role", "Customer"); // Default role, adjust as needed

                        cmd.ExecuteNonQuery();
                    }

                    Response.Write("<script>alert('Sign Up Successful!'); window.location='loginn.aspx';</script>");
                    fullName.Text = username.Text = emailAddress.Text = password.Text = phoneNumber.Text = "";
                }
            }
            catch (SqlException ex)
            {
                Response.Write($"<script>alert('SQL Error: {ex.Message}');</script>");
            }
        }

        protected void forgotPasswordButton_Click(object sender, EventArgs e)
        {
            string email = forgotEmail.Text.Trim();

            if (string.IsNullOrEmpty(email))
            {
                ShowAlert("Please enter your email address!", "red");
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();

                    string checkQuery = "SELECT UserID FROM Users WHERE Email = @Email";
                    int userID;
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@Email", email);
                        object result = checkCmd.ExecuteScalar();
                        if (result == null)
                        {
                            ShowAlert("Email not found in Users table!", "red");
                            return;
                        }
                        userID = Convert.ToInt32(result);
                    }

                    string token = Guid.NewGuid().ToString();
                    string insertQuery = "INSERT INTO PasswordResetTokens (UserID, Token, Expiration) VALUES (@UserID, @Token, @Expiration)";
                    using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                    {
                        insertCmd.Parameters.AddWithValue("@UserID", userID);
                        insertCmd.Parameters.AddWithValue("@Token", token);
                        insertCmd.Parameters.AddWithValue("@Expiration", DateTime.Now.AddHours(24));
                        insertCmd.ExecuteNonQuery();
                    }

                    string resetLink = $"forgate_pass.aspx?token={token}";
                    ShowAlert($"Password reset link: <a href='{resetLink}'>Click here</a>", "green");
                }
                catch (SqlException sqlEx)
                {
                    ShowAlert($"SQL Error: {sqlEx.Message} (Error Code: {sqlEx.Number})", "red");
                }
                catch (Exception ex)
                {
                    ShowAlert($"General Error: {ex.Message}", "red");
                }
            }
        }
    }
}