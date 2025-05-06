using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace YourChef
{
    public partial class forgate_pass : System.Web.UI.Page
    {
            protected void Page_Load(object sender, EventArgs e)
            {
                if (!IsPostBack)
                {
                    string token = Request.QueryString["token"];
                    if (string.IsNullOrEmpty(token))
                    {
                        lblMessage.Text = "Invalid or missing token.";
                        lblMessage.ForeColor = Color.Red;
                        updatePasswordButton.Enabled = false;
                    }
                }
            }

        protected void updatePasswordButton_Click(object sender, EventArgs e)
        {
            string token = Request.QueryString["token"];
            string newPass = newPassword.Text.Trim();
            string confirmPass = confirmPassword.Text.Trim();

            if (string.IsNullOrEmpty(newPass) || newPass != confirmPass)
            {
                lblMessage.Text = "Passwords do not match or are empty.";
                lblMessage.ForeColor = Color.Red;
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    // Verify token and get UserID
                    string query = "SELECT UserID FROM PasswordResetTokens WHERE Token = @Token AND Expiration > GETDATE()";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Token", token);
                        object result = cmd.ExecuteScalar();
                        if (result == null)
                        {
                            lblMessage.Text = "Invalid or expired token.";
                            lblMessage.ForeColor = Color.Red;
                            return;
                        }
                        int userId = Convert.ToInt32(result);

                        // Update password (plain text)
                        string updateQuery = "UPDATE Users SET Password = @Password WHERE UserID = @UserID";
                        using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn))
                        {
                            updateCmd.Parameters.AddWithValue("@Password", newPass); // Store plain text
                            updateCmd.Parameters.AddWithValue("@UserID", userId);
                            updateCmd.ExecuteNonQuery();
                        }

                        // Delete the used token
                        string deleteQuery = "DELETE FROM PasswordResetTokens WHERE Token = @Token";
                        using (SqlCommand deleteCmd = new SqlCommand(deleteQuery, conn))
                        {
                            deleteCmd.Parameters.AddWithValue("@Token", token);
                            deleteCmd.ExecuteNonQuery();
                        }

                        lblMessage.Text = "Password updated successfully. <a href='loginn.aspx'>Click here to login</a>.";
                        lblMessage.ForeColor = Color.Green;
                        updatePasswordButton.Enabled = false;
                    }
                }
                catch (SqlException sqlEx)
                {
                    lblMessage.Text = $"Database error: {sqlEx.Message}";
                    lblMessage.ForeColor = Color.Red;
                }
                catch (Exception ex)
                {
                    lblMessage.Text = $"An error occurred: {ex.Message}";
                    lblMessage.ForeColor = Color.Red;
                }
            }
        }

        }
    }