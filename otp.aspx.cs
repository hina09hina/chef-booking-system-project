using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI;
using Twilio;
using Twilio.Rest.Api.V2010.Account;
using Twilio.Types;

namespace YourChef
{
    public partial class otp : System.Web.UI.Page
    {
        private const string AccountSid = "AC75c8fc6c4685fd81ca90ce17a156cfe0";
        private const string AuthToken = "9b46df3caa329fca1a5cfce7f3152491";
        private const string TwilioPhoneNumber = "+16086024745";

        protected void Page_Load(object sender, EventArgs e) { }

        // Function to validate phone number (only digits, no letters, no special characters)
        private bool IsValidPhoneNumber(string phone)
        {
            return Regex.IsMatch(phone, @"^\d{10,15}$");  // Allows 10 to 15 digits only
        }

        protected void btnSendOtp_Click(object sender, EventArgs e)
        {
            string phoneNumber = txtPhone.Text.Trim();

            // Validate input fields
            if (string.IsNullOrEmpty(phoneNumber))
            {
                Response.Write("<script>alert('Phone number is required!');</script>");
                return;
            }
            if (!IsValidPhoneNumber(phoneNumber))
            {
                Response.Write("<script>alert('Please enter a valid phone number with digits only (10-15 digits).');</script>");
                return;
            }

            string formattedNumber = phoneNumber.StartsWith("+") ? phoneNumber : "+91" + phoneNumber;
            string otpCode = new Random().Next(100000, 999999).ToString();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                con.Open();

                string checkQuery = "SELECT COUNT(*) FROM OTP_Verification WHERE PhoneNumber = @PhoneNumber";
                SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                checkCmd.Parameters.AddWithValue("@PhoneNumber", phoneNumber);
                int count = (int)checkCmd.ExecuteScalar();

                if (count > 0)
                {
                    string updateQuery = "UPDATE OTP_Verification SET OTPCode = @OTPCode, GeneratedAt = GETDATE(), IsVerified = 0 WHERE PhoneNumber = @PhoneNumber";
                    SqlCommand updateCmd = new SqlCommand(updateQuery, con);
                    updateCmd.Parameters.AddWithValue("@OTPCode", otpCode);
                    updateCmd.Parameters.AddWithValue("@PhoneNumber", phoneNumber);
                    updateCmd.ExecuteNonQuery();
                }
                else
                {
                    string insertQuery = "INSERT INTO OTP_Verification (PhoneNumber, OTPCode, IsVerified, GeneratedAt) VALUES (@PhoneNumber, @OTPCode, 0, GETDATE())";
                    SqlCommand insertCmd = new SqlCommand(insertQuery, con);
                    insertCmd.Parameters.AddWithValue("@PhoneNumber", phoneNumber);
                    insertCmd.Parameters.AddWithValue("@OTPCode", otpCode);
                    insertCmd.ExecuteNonQuery();
                }

                con.Close();
            }

            try
            {
                TwilioClient.Init(AccountSid, AuthToken);
                var message = MessageResource.Create(
                    to: new PhoneNumber(formattedNumber),
                    from: new PhoneNumber(TwilioPhoneNumber),
                    body: $"Your OTP is: {otpCode}");

                Response.Write("<script>alert('OTP sent successfully!');</script>");
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('Error sending OTP: {ex.Message}');</script>");
            }
        }

        protected void btnVerify_Click(object sender, EventArgs e)
        {
            string phoneNumber = txtPhone.Text.Trim();
            string enteredOtp = txtOtp.Text.Trim();

            // Validate input fields
            if (string.IsNullOrEmpty(phoneNumber))
            {
                Response.Write("<script>alert('Phone number is required!');</script>");
                return;
            }
            if (!IsValidPhoneNumber(phoneNumber))
            {
                Response.Write("<script>alert('Please enter a valid phone number with digits only (10-15 digits).');</script>");
                return;
            }
            if (string.IsNullOrEmpty(enteredOtp))
            {
                Response.Write("<script>alert('OTP is required!');</script>");
                return;
            }

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                con.Open();

                string verifyQuery = "SELECT OTPCode FROM OTP_Verification WHERE PhoneNumber = @PhoneNumber AND IsVerified = 0 AND GeneratedAt > DATEADD(MINUTE, -5, GETDATE())";
                SqlCommand verifyCmd = new SqlCommand(verifyQuery, con);
                verifyCmd.Parameters.AddWithValue("@PhoneNumber", phoneNumber);
                object dbOtp = verifyCmd.ExecuteScalar();

                if (dbOtp != null && dbOtp.ToString() == enteredOtp)
                {
                    string updateQuery = "UPDATE OTP_Verification SET IsVerified = 1 WHERE PhoneNumber = @PhoneNumber";
                    SqlCommand updateCmd = new SqlCommand(updateQuery, con);
                    updateCmd.Parameters.AddWithValue("@PhoneNumber", phoneNumber);
                    updateCmd.ExecuteNonQuery();

                    Response.Write("<script>alert('OTP verified successfully!'); window.location='index.aspx';</script>");
                }
                else
                {
                    Response.Write("<script>alert('Invalid OTP. Please try again.');</script>");
                }

                con.Close();
            }
        }

        protected void lnkResendOtp_Click(object sender, EventArgs e)
        {
            btnSendOtp_Click(sender, e);
        }
    }
}
