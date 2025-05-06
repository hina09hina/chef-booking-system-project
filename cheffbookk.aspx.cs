using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web;

namespace YourChef
{
    public partial class cheffbookk : Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAllChefs();
            }
        }

        private void LoadAllChefs()
        {
            if (string.IsNullOrEmpty(connectionString))
            {
                Response.Write("Error: Connection string is not configured.");
                return;
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = @"
                        SELECT 
                            cd.ChefDetailID, 
                            u.FullName, 
                            u.PhoneNumber, 
                            cd.City, 
                            cd.State, 
                            cd.Experience, 
                            cd.CuisineSpecialty, 
                            cd.AvailabilityStatus AS Availability, 
                            cd.ProfilePicture AS ProfileImage,
                            ISNULL(AVG(CAST(cr.Rating AS FLOAT)), 0) AS AverageRating,
                            COUNT(cr.Rating) AS RatingCount,
                            MAX(CASE WHEN cr.UserID = @UserID THEN cr.Rating ELSE NULL END) AS UserRating
                        FROM ChefDetails cd
                        INNER JOIN Users u ON cd.UserID = u.UserID
                        LEFT JOIN ChefRatings cr ON cd.ChefDetailID = cr.ChefDetailID
                        WHERE cd.AvailabilityStatus = 'Available'
                        GROUP BY 
                            cd.ChefDetailID, 
                            u.FullName, 
                            u.PhoneNumber, 
                            cd.City, 
                            cd.State, 
                            cd.Experience, 
                            cd.CuisineSpecialty, 
                            cd.AvailabilityStatus, 
                            cd.ProfilePicture";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@UserID", Session["UserID"] != null ? Session["UserID"] : (object)DBNull.Value);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    foreach (DataRow row in dt.Rows)
                    {
                        if (row["ProfileImage"] == DBNull.Value || string.IsNullOrEmpty(row["ProfileImage"].ToString()))
                        {
                            row["ProfileImage"] = "~/img/c1.jpg";
                        }
                        if (row["UserRating"] == DBNull.Value)
                        {
                            row["UserRating"] = 0;
                        }
                    }

                    rptChefs.DataSource = dt;
                    rptChefs.DataBind();
                }
                catch (SqlException sqlEx)
                {
                    Response.Write($"SQL Error loading chefs: {sqlEx.Message} (Error Code: {sqlEx.Number})");
                }
                catch (Exception ex)
                {
                    Response.Write($"Error loading chefs: {ex.Message}");
                }
            }
        }

        protected void rptChefs_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Image imgProfile = e.Item.FindControl("imgProfile") as Image;
                if (imgProfile != null && string.IsNullOrEmpty(imgProfile.ImageUrl))
                {
                    imgProfile.ImageUrl = "~/img/c1.jpg";
                }

                HiddenField hfUserRating = e.Item.FindControl("hfUserRating") as HiddenField;
                if (hfUserRating != null)
                {
                    hfUserRating.ClientIDMode = ClientIDMode.Static;
                    hfUserRating.ID = "hfUserRating_" + ((DataRowView)e.Item.DataItem)["ChefDetailID"].ToString();
                }
            }
        }

        [WebMethod]
        public static object SubmitRating(int chefId, int rating)
        {
            try
            {
                if (HttpContext.Current.Session["UserID"] == null)
                {
                    return new { success = false, redirect = "Loginn.aspx" };
                }

                int userId = Convert.ToInt32(HttpContext.Current.Session["UserID"]);
                string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                if (string.IsNullOrEmpty(connStr))
                {
                    return new { success = false, message = "Connection string is missing" };
                }

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    string checkQuery = "SELECT COUNT(*) FROM ChefRatings WHERE ChefDetailID = @ChefID AND UserID = @UserID";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@ChefID", chefId);
                        checkCmd.Parameters.AddWithValue("@UserID", userId);
                        int existingRatingCount = (int)checkCmd.ExecuteScalar();

                        if (existingRatingCount > 0)
                        {
                            string updateQuery = @"
                                UPDATE ChefRatings 
                                SET Rating = @Rating, Timestamp = GETDATE() 
                                WHERE ChefDetailID = @ChefID AND UserID = @UserID";
                            using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn))
                            {
                                updateCmd.Parameters.AddWithValue("@ChefID", chefId);
                                updateCmd.Parameters.AddWithValue("@UserID", userId);
                                updateCmd.Parameters.AddWithValue("@Rating", rating);
                                updateCmd.ExecuteNonQuery();
                            }
                        }
                        else
                        {
                            string insertQuery = @"
                                INSERT INTO ChefRatings (ChefDetailID, UserID, Rating, Timestamp) 
                                VALUES (@ChefID, @UserID, @Rating, GETDATE())";
                            using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                            {
                                insertCmd.Parameters.AddWithValue("@ChefID", chefId);
                                insertCmd.Parameters.AddWithValue("@UserID", userId);
                                insertCmd.Parameters.AddWithValue("@Rating", rating);
                                insertCmd.ExecuteNonQuery();
                            }
                        }
                    }
                }
                return new { success = true };
            }
            catch (SqlException sqlEx)
            {
                return new { success = false, message = $"Database error: {sqlEx.Message} (Code: {sqlEx.Number})" };
            }
            catch (Exception ex)
            {
                return new { success = false, message = $"Error: {ex.Message}" };
            }
        }

        [WebMethod]



        
        public static object SubmitBooking(int chefId, string eventDate, string eventTime, int duration, string location, int numberOfPeople, string cuisineType, string specialRequests)
        {
            try
            {
                if (HttpContext.Current.Session["UserID"] == null)
                {
                    return new { success = false, redirect = "Loginn.aspx" };
                }

                int userId = Convert.ToInt32(HttpContext.Current.Session["UserID"]);
                string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                if (string.IsNullOrEmpty(connStr))
                {
                    return new { success = false, message = "Connection string is missing" };
                }

                // Define multiple date formats to accept
                string[] dateFormats = { "yyyy-MM-dd", "MM/dd/yyyy", "dd/MM/yyyy", "yyyy/MM/dd" };
                DateTime parsedDate;
                if (!DateTime.TryParseExact(eventDate, dateFormats, System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None, out parsedDate))
                {
                    return new { success = false, message = "Invalid date format. Please use YYYY-MM-DD, MM/DD/YYYY, or DD/MM/YYYY." };
                }

                // Define multiple time formats to accept
                string[] timeFormats = { "HH:mm", "H:mm", "hh:mm tt", "h:mm tt" };
                DateTime parsedTimeDt;
                if (!DateTime.TryParseExact(eventTime, timeFormats, System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None, out parsedTimeDt))
                {
                    return new { success = false, message = "Invalid time format. Please use HH:MM (24-hour) or hh:MM AM/PM." };
                }

                // Combine date and time
                DateTime eventDateTime = parsedDate.Add(parsedTimeDt.TimeOfDay);

                // Prevent past dates from being booked
                if (eventDateTime < DateTime.Now)
                {
                    return new { success = false, message = "You cannot select a past date or time." };
                }

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    string userQuery = @"
                SELECT FullName, Email, PhoneNumber 
                FROM Users 
                WHERE UserID = @UserID";

                    string bookingQuery = @"
                INSERT INTO ChefBookings (
                    ChefDetailID, UserID, EventDateTime, DurationHours, Location, 
                    NumberOfPeople, CuisineType, SpecialRequests, BookingDate
                ) VALUES (
                    @ChefID, @UserID, @EventDateTime, @Duration, @Location, 
                    @NumberOfPeople, @CuisineType, @SpecialRequests, GETDATE()
                )";

                    // Get user details
                    string fullName = "", email = "", phoneNumber = "";
                    using (SqlCommand userCmd = new SqlCommand(userQuery, conn))
                    {
                        userCmd.Parameters.AddWithValue("@UserID", userId);
                        using (SqlDataReader reader = userCmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                fullName = reader["FullName"].ToString();
                                email = reader["Email"].ToString();
                                phoneNumber = reader["PhoneNumber"].ToString();
                            }
                            else
                            {
                                return new { success = false, message = "User not found." };
                            }
                        }
                    }

                    // Insert booking
                    using (SqlCommand cmd = new SqlCommand(bookingQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@ChefID", chefId);
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        cmd.Parameters.AddWithValue("@EventDateTime", eventDateTime);
                        cmd.Parameters.AddWithValue("@Duration", duration);
                        cmd.Parameters.AddWithValue("@Location", location);
                        cmd.Parameters.AddWithValue("@NumberOfPeople", numberOfPeople);
                        cmd.Parameters.AddWithValue("@CuisineType", cuisineType);
                        cmd.Parameters.AddWithValue("@SpecialRequests", string.IsNullOrEmpty(specialRequests) ? (object)DBNull.Value : specialRequests);
                        cmd.ExecuteNonQuery();
                    }

                    return new
                    {
                        success = true,
                        userName = fullName,
                        userEmail = email,
                        userPhone = phoneNumber
                    };
                }
            }
            catch (SqlException sqlEx)
            {
                return new { success = false, message = $"Database error: {sqlEx.Message} (Code: {sqlEx.Number})" };
            }
            catch (Exception ex)
            {
                return new { success = false, message = $"Error: {ex.Message}" };
            }
        }
        protected string GetAverageStars(double rating)
        {
            int fullStars = (int)rating;
            bool halfStar = (rating - fullStars) >= 0.5;
            string stars = "";
            for (int i = 0; i < fullStars; i++)
                stars += "<i class='fas fa-star'></i>";
            if (halfStar)
                stars += "<i class='fas fa-star-half-alt'></i>";
            int totalStars = fullStars + (halfStar ? 1 : 0);
            while (totalStars < 5)
            {
                stars += "<i class='far fa-star'></i>";
                totalStars++;
            }
            return stars;
        }
    }
}