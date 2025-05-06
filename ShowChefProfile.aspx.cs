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
    public partial class ShowChefProfile : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAllChefs();
            }
        }

        private void LoadAllChefs()
        {
            string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
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
                            row["ProfileImage"] = "~/Images/default-chef.jpg";
                        }
                        if (row["UserRating"] == DBNull.Value)
                        {
                            row["UserRating"] = 0; // Default to 0 if no rating exists
                        }
                    }

                    rptChefs.DataSource = dt;
                    rptChefs.DataBind();
                    lblChefCount.Text = $"{dt.Rows.Count} Chef(s) Available";
                }
                catch (Exception ex)
                {
                    lblChefCount.Text = "Error loading chefs: " + ex.Message;
                }
            }
        }

        protected void btnBook_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int chefId = int.Parse(btn.CommandArgument);
            Response.Redirect($"BookChef.aspx?chefId={chefId}");
        }

        protected void rptChefs_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Image imgProfile = (Image)e.Item.FindControl("imgProfile");
                if (string.IsNullOrEmpty(imgProfile.ImageUrl))
                {
                    imgProfile.ImageUrl = "~/Images/default-chef.jpg";
                }
                HiddenField hfUserRating = (HiddenField)e.Item.FindControl("hfUserRating");
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

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    string checkQuery = "SELECT COUNT(*) FROM ChefRatings WHERE ChefDetailID = @ChefID AND UserID = @UserID";
                    SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
                    checkCmd.Parameters.AddWithValue("@ChefID", chefId);
                    checkCmd.Parameters.AddWithValue("@UserID", userId);
                    int existingRatingCount = (int)checkCmd.ExecuteScalar();

                    if (existingRatingCount > 0)
                    {
                        // Update existing rating
                        string updateQuery = @"
                            UPDATE ChefRatings 
                            SET Rating = @Rating, Timestamp = GETDATE() 
                            WHERE ChefDetailID = @ChefID AND UserID = @UserID";
                        SqlCommand updateCmd = new SqlCommand(updateQuery, conn);
                        updateCmd.Parameters.AddWithValue("@ChefID", chefId);
                        updateCmd.Parameters.AddWithValue("@UserID", userId);
                        updateCmd.Parameters.AddWithValue("@Rating", rating);
                        updateCmd.ExecuteNonQuery();
                    }
                    else
                    {
                        // Insert new rating
                        string insertQuery = @"
                            INSERT INTO ChefRatings (ChefDetailID, UserID, Rating, Timestamp) 
                            VALUES (@ChefID, @UserID, @Rating, GETDATE())";
                        SqlCommand insertCmd = new SqlCommand(insertQuery, conn);
                        insertCmd.Parameters.AddWithValue("@ChefID", chefId);
                        insertCmd.Parameters.AddWithValue("@UserID", userId);
                        insertCmd.Parameters.AddWithValue("@Rating", rating);
                        insertCmd.ExecuteNonQuery();
                    }
                }
                return new { success = true };
            }
            catch (SqlException sqlEx)
            {
                return new { success = false, message = "Database error: " + sqlEx.Message };
            }
            catch (Exception ex)
            {
                return new { success = false, message = "Error: " + ex.Message };
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
            while (stars.Length / 23 < 5)
                stars += "<i class='far fa-star'></i>";
            return stars;
        }
    }
}