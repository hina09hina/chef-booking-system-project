using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Twilio.Types;


namespace YourChef
{
    public partial class signup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                lblMessage.Text = ""; // Clear message on page load
                fullName.Text = "";
                username.Text = "";
                emailAddress.Text = "";
                password.Text = "";
                phoneNumber.Text = "";

                string role = Request.QueryString["role"]; // Get role from the URL

                if (!string.IsNullOrEmpty(role))
                {
                    hfRole.Value = role; // Store role in HiddenField
                   
                }
                else
                {
                    hfRole.Value = "Customer"; // Default role if no parameter is provided
                    
                }
            }
        }



        private void ShowAlert(string message, string color)
        {
            lblMessage.Text = message;
            lblMessage.ForeColor = System.Drawing.Color.FromName(color);
        }
        protected void signUpButton_Click(object sender, EventArgs e)
        {
            string userFullName = fullName.Text.Trim();
            string userUsername = username.Text.Trim();
            string userEmail = emailAddress.Text.Trim();
            string userPassword = password.Text.Trim();
            string userPhoneNumber = phoneNumber.Text.Trim(); // Get phone number from input
            string role = hfRole.Value;

            // 🛑 Validate Inputs
            if (!ValidationHelper.IsValidFullName(userFullName))
            {
                Response.Write("<script>alert('Invalid Full Name. Only letters and spaces allowed (max 50 characters).');</script>");
                return;
            }

            if (!ValidationHelper.IsValidUsername(userUsername))
            {
                Response.Write("<script>alert('Username must be 1-50 characters long and unique.');</script>");
                return;
            }

            if (!ValidationHelper.IsValidEmail(userEmail))
            {
                Response.Write("<script>alert('Invalid email format (max 50 characters).');</script>");
                return;
            }

            if (!ValidationHelper.IsValidPassword(userPassword))
            {
                Response.Write("<script>alert('Password must be 1-20 characters long.');</script>");
                return;
            }

            // ✅ Check Unique Constraints (Username & Email)
            if (ValidationHelper.IsExistingUser(userUsername))
            {
                Response.Write("<script>alert('Username already exists. Please use a different one.');</script>");
                return;
            }
            if (ValidationHelper.IsExistingUser1(userEmail))
            {
                Response.Write("<script>alert(' Email already exists. Please use a different one.');</script>");
                return;
            }



            // 🛑 Validate Phone Number
            if (!ValidationHelper.IsValidPhoneNumber(userPhoneNumber))
            {
                Response.Write("<script>alert('Invalid Phone Number. Only 10-15 digits allowed.');</script>");
                return;
            }

            // ✅ Check Unique Phone Number
            if (ValidationHelper.IsExistingPhoneNumber(userPhoneNumber))
            {
                Response.Write("<script>alert('Phone Number already exists. Please use a different one.');</script>");
                return;
            }

            // Ensure phone number is not empty
            if (string.IsNullOrEmpty(userPhoneNumber))
            {
                Response.Write("<script>alert('Please enter your phone number!');</script>");
                return;
            }

            if (string.IsNullOrEmpty(userFullName) || string.IsNullOrEmpty(userUsername) ||
               string.IsNullOrEmpty(userEmail) || string.IsNullOrEmpty(userPassword))
            {
                Response.Write("<script>alert('Please fill all fields!');</script>");
                return;
            }
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "INSERT INTO Users (FullName, Username, Email, Password, PhoneNumber,Role) VALUES (@FullName, @Username, @Email, @Password, @PhoneNumber,@Role)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@FullName", userFullName);
                        cmd.Parameters.AddWithValue("@Username", userUsername);
                        cmd.Parameters.AddWithValue("@Email", userEmail);
                        cmd.Parameters.AddWithValue("@Password", userPassword); // Hashing recommended!
                        cmd.Parameters.AddWithValue("@PhoneNumber", userPhoneNumber);
                        cmd.Parameters.AddWithValue("@Role", role); // Save role in DB
                        con.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        con.Close();

                        if (rowsAffected > 0)
                        {
                            Response.Write("<script>alert('Sign Up Successful!'); window.location='loginn.aspx';</script>");
                            // Clear all input fields after successful signup
                            fullName.Text = "";
                            username.Text = "";
                            emailAddress.Text = "";
                            password.Text = "";
                            phoneNumber.Text = "";

                        }
                        else
                        {
                            Response.Write("<script>alert('Error! Please try again.');</script>");
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                // Display the error message
                Response.Write("<script>alert('SQL Error: " + ex.Message + "');</script>");
            }
            catch (Exception ex)
            {
                // Display the error message for general exceptions
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }

        protected void loginButton_Click(object sender, EventArgs e)
        {
            string userInput = loginUsername.Text.Trim(); // User can enter username or email
            string password = loginPassword.Text.Trim();

            // Validate input fields
            if (string.IsNullOrEmpty(userInput) || string.IsNullOrEmpty(password))
            {
                ShowAlert("Please enter your Username/Email and Password!", "red");
                return;
            }

            // Database connection string
            string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Query checks both Username and Email for login
                string query = "SELECT COUNT(1) FROM Users WHERE (Username=@UserInput OR Email=@UserInput) AND Password=@Password";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserInput", userInput);
                cmd.Parameters.AddWithValue("@Password", password);  // Not hashed, consider hashing for security

                conn.Open();
                int count = Convert.ToInt32(cmd.ExecuteScalar());
                conn.Close();

                if (count == 1)
                {
                    Session["Username"] = userInput; // Store the session
                    Response.Redirect("index.aspx"); // Redirect to dashboard/home page
                }
                else
                {
                    ShowAlert("Invalid Username/Email or Password!", "red");
                }
            }
        }


    }
    public static class ValidationHelper
    {
        private static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        // ✅ Validate Full Name (Letters and spaces only, max 50 characters)
        public static bool IsValidFullName(string fullName)
        {
            return !string.IsNullOrWhiteSpace(fullName) && fullName.Length <= 50;
        }

        // ✅ Validate Username (Max 50 characters, must be unique)
        public static bool IsValidUsername(string username)
        {
            return !string.IsNullOrWhiteSpace(username) && username.Length <= 50;
        }

        // ✅ Validate Email (Correct format, max 50 characters)
        public static bool IsValidEmail(string email)
        {
            return !string.IsNullOrWhiteSpace(email) && email.Length <= 50 && Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$");
        }

        // ✅ Validate Password (Max 20 characters)
        public static bool IsValidPassword(string password)
        {
            return !string.IsNullOrWhiteSpace(password) && password.Length <= 20;
        }

        // ✅ Check if Username or Email already exists
        public static bool IsExistingUser(string username)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(1) FROM Users WHERE Username=@Username";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", username);

                conn.Open();
                int count = Convert.ToInt32(cmd.ExecuteScalar());
                conn.Close();

                return count > 0; // Returns true if user exists
            }
        }
        public static bool IsExistingUser1(string email)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(1) FROM Users WHERE Email=@Email";
                SqlCommand cmd = new SqlCommand(query, conn);

                cmd.Parameters.AddWithValue("@Email", email);

                conn.Open();
                int count = Convert.ToInt32(cmd.ExecuteScalar());
                conn.Close();

                return count > 0; // Returns true if user exists
            }
        }
        // ✅ Validate Phone Number (Digits only, 10-15 characters)
        public static bool IsValidPhoneNumber(string phoneNumber)
        {
            return !string.IsNullOrWhiteSpace(phoneNumber) &&
                   Regex.IsMatch(phoneNumber, @"^\d{10,15}$"); // Allows only digits, length 10-15
        }

        // ✅ Check if Phone Number already exists
        public static bool IsExistingPhoneNumber(string phoneNumber)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(1) FROM Users WHERE PhoneNumber=@PhoneNumber";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@PhoneNumber", phoneNumber);

                conn.Open();
                int count = Convert.ToInt32(cmd.ExecuteScalar());
                conn.Close();

                return count > 0; // Returns true if phone number exists
            }
        }

    }

}



