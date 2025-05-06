using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net.NetworkInformation;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace YourChef
{
    public partial class chefProfilepage : Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null || Session["UserRole"]?.ToString() != "Chef")
                {
                    Response.Write("<script>alert('Session expired or unauthorized access! Please log in again.');</script>");
                    Response.Redirect("loginn.aspx");
                    return;
                }

                // Debugging: Log session values
                Response.Write($"<script>console.log('Session UserID: {Session["UserID"]}, Role: {Session["UserRole"]}');</script>");

                // Test database connection
                try
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();
                        Response.Write("<script>alert('Database connection successful!');</script>");
                    }
                }
                catch (SqlException ex)
                {
                    Response.Write($"<script>alert('Connection failed: {ex.Message}');</script>");
                }

                // Set user fields from session (assumes set during login)
                txtFirstName.Text = Session["FullName"]?.ToString();
                
                txtEmail.Text = Session["Email"]?.ToString();
                txtPhoneNumber.Text = Session["PhoneNumber"]?.ToString();

                LoadChefDetails();
            }
        }

        private void LoadChefDetails()
        {
            try
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT * FROM [dbo].[ChefDetails] WHERE UserID = @UserID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                txtAddress.Text = reader["Address"].ToString();
                                txtCity.Text = reader["City"].ToString();
                                txtState.Text = reader["State"].ToString();
                                txtPINCode.Text = reader["PINCode"].ToString();
                                string cuisineSpecialty = reader["CuisineSpecialty"].ToString();
                                if (!string.IsNullOrEmpty(cuisineSpecialty))
                                {
                                    foreach (ListItem item in ddlCuisineSpecialty.Items)
                                        item.Selected = cuisineSpecialty.Contains(item.Value);
                                }
                                txtExperience.Text = reader["Experience"].ToString();
                                ddlAvailability.SelectedValue = reader["AvailabilityStatus"].ToString();
                                imgProfile.ImageUrl =  reader["ProfilePicture"].ToString();
                               // string.IsNullOrEmpty(reader["ProfilePicture"].ToString())   ? "~/img/c4.jpg"
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('Error loading details: {ex.Message}');</script>");
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Response.Write("<script>console.log('btnSubmit_Click event fired');</script>");

            Response.Write($"<script>console.log('Form Values: FirstName={txtFirstName.Text},  Email={txtEmail.Text}, PhoneNumber={txtPhoneNumber.Text}, Address={txtAddress.Text}, City={txtCity.Text}, State={txtState.Text}, PINCode={txtPINCode.Text}, Experience={txtExperience.Text}, Availability={ddlAvailability.SelectedValue}');</script>");

            // Explicitly trigger validation
            Response.Write("<script>console.log('Triggering server-side validation...');</script>");
            Page.Validate();

            if (!Page.IsValid)
            {
                Response.Write("<script>console.log('Page validation failed');</script>");
                Response.Write("<script>alert('Validation failed. Please correct the errors in the form.');</script>");
                foreach (IValidator validator in Page.Validators)
                {
                    if (!validator.IsValid)
                    {
                        Response.Write($"<script>console.log('Validation error: {validator.ErrorMessage}');</script>");
                    }
                }
                return;
            }

            Response.Write("<script>console.log('Server-side validation passed');</script>");

            SqlConnection conn = null;
            SqlTransaction transaction = null;
            bool isTransactionCommitted = false;

            try
            {
                Response.Write("<script>console.log('Collecting form data...');</script>");

                string firstName = txtFirstName.Text.Trim();
                
                string email = txtEmail.Text.Trim();
                string phoneNumber = txtPhoneNumber.Text.Trim();
                string address = txtAddress.Text.Trim();
                string city = txtCity.Text.Trim();
                string state = txtState.Text.Trim();
                string pinCode = txtPINCode.Text.Trim();
                string cuisineSpecialty = string.Join(",", ddlCuisineSpecialty.Items.Cast<ListItem>()
                    .Where(i => i.Selected).Select(i => i.Value));
                int experience = 0;
                if (!string.IsNullOrEmpty(txtExperience.Text.Trim()))
                {
                    Response.Write("<script>console.log('Parsing experience...');</script>");
                    experience = int.Parse(txtExperience.Text.Trim());
                }
                string availability = ddlAvailability.SelectedValue;

                if (Session["UserID"] == null)
                {
                    Response.Write("<script>console.log('Session[UserID] is null');</script>");
                    throw new Exception("Session['UserID'] is null. Please log in again.");
                }
                Response.Write($"<script>console.log('UserID: {Session["UserID"]}');</script>");
                int userId = Convert.ToInt32(Session["UserID"]);

                Response.Write("<script>console.log('Performing server-side validation...');</script>");

                if (!System.Text.RegularExpressions.Regex.IsMatch(firstName, @"^[a-zA-Z\s]+$"))
                    throw new Exception("First Name must contain only letters.");
                
                if (!System.Text.RegularExpressions.Regex.IsMatch(email, @"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"))
                    throw new Exception("Invalid email format.");
                if (!System.Text.RegularExpressions.Regex.IsMatch(phoneNumber, @"^\d{10}$"))
                    throw new Exception("Phone Number must be 10 digits.");
                if (!System.Text.RegularExpressions.Regex.IsMatch(city, @"^[a-zA-Z\s]+$"))
                    throw new Exception("City must contain only letters.");
                if (!System.Text.RegularExpressions.Regex.IsMatch(state, @"^[a-zA-Z\s]+$"))
                    throw new Exception("State must contain only letters.");
                if (!System.Text.RegularExpressions.Regex.IsMatch(pinCode, @"^\d{6}$"))
                    throw new Exception("PIN Code must be 6 digits.");
                if (string.IsNullOrEmpty(cuisineSpecialty))
                    throw new Exception("Please select at least one cuisine specialty.");
                if (experience < 0 || experience > 100)
                    throw new Exception("Experience must be between 0 and 100 years.");

                Response.Write("<script>console.log('Server-side regex validation passed');</script>");

                string imagePath = "~/img/default-chef.png";
                if (fuProfilePicture.HasFile)
                {
                    Response.Write("<script>console.log('Uploading profile picture...');</script>");
                    string imgFolder = Server.MapPath("~/img/");
                    if (!Directory.Exists(imgFolder))
                    {
                        Response.Write("<script>console.log('Creating img directory...');</script>");
                        Directory.CreateDirectory(imgFolder);
                        Response.Write("<script>console.log('Created img directory');</script>");
                    }
                    string fileName = Path.GetFileName(fuProfilePicture.PostedFile.FileName);
                    imagePath = "~/img/" + Guid.NewGuid().ToString() + "_" + fileName;
                    fuProfilePicture.SaveAs(Server.MapPath(imagePath));
                    Response.Write("<script>console.log('Profile picture uploaded: " + imagePath + "');</script>");
                }

                Response.Write("<script>console.log('Opening database connection...');</script>");

                conn = new SqlConnection(connectionString);
                conn.Open();
                transaction = conn.BeginTransaction();

                Response.Write("<script>console.log('Updating Users table...');</script>");
                string updateUserQuery = @"
            UPDATE [dbo].[Users] 
            SET [FullName] = @FirstName, 
                [Email] = @Email, 
                [PhoneNumber] = @PhoneNumber 
            WHERE [UserID] = @UserID";

                using (SqlCommand userCmd = new SqlCommand(updateUserQuery, conn, transaction))
                {
                    userCmd.Parameters.AddWithValue("@UserID", userId);
                    userCmd.Parameters.AddWithValue("@FirstName", firstName);
                   
                    userCmd.Parameters.AddWithValue("@Email", email);
                    userCmd.Parameters.AddWithValue("@PhoneNumber", phoneNumber);
                    Response.Write("<script>console.log('Executing Users update query...');</script>");
                    int rowsAffected = userCmd.ExecuteNonQuery();
                    Response.Write($"<script>console.log('Users table updated. Rows affected: {rowsAffected}');</script>");
                }

                Response.Write("<script>console.log('Checking if ChefDetails record exists...');</script>");
                string checkQuery = "SELECT COUNT(*) FROM [dbo].[ChefDetails] WHERE UserID = @UserID";
                bool recordExists;
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn, transaction))
                {
                    checkCmd.Parameters.AddWithValue("@UserID", userId);
                    Response.Write("<script>console.log('Executing ChefDetails check query...');</script>");
                    recordExists = ((int)checkCmd.ExecuteScalar()) > 0;
                    Response.Write($"<script>console.log('Record exists: {recordExists}');</script>");
                }

                Response.Write("<script>console.log('Preparing ChefDetails query...');</script>");
                string chefQuery = recordExists
                    ? @"UPDATE [dbo].[ChefDetails] 
                SET [Address] = @Address, 
                    [City] = @City, 
                    [State] = @State, 
                    [PINCode] = @PINCode, 
                    [CuisineSpecialty] = @CuisineSpecialty, 
                    [Experience] = @Experience, 
                    [AvailabilityStatus] = @AvailabilityStatus, 
                    [ProfilePicture] = @ProfilePicture 
                WHERE UserID = @UserID"
                    : @"INSERT INTO [dbo].[ChefDetails] 
                ([UserID], [Address], [City], [State], [PINCode], [CuisineSpecialty], 
                 [Experience], [AvailabilityStatus], [ProfilePicture]) 
                VALUES (@UserID, @Address, @City, @State, @PINCode, @CuisineSpecialty, 
                       @Experience, @AvailabilityStatus, @ProfilePicture)";

                using (SqlCommand chefCmd = new SqlCommand(chefQuery, conn, transaction))
                {
                    chefCmd.Parameters.AddWithValue("@UserID", userId);
                    chefCmd.Parameters.AddWithValue("@Address", string.IsNullOrEmpty(address) ? (object)DBNull.Value : address);
                    chefCmd.Parameters.AddWithValue("@City", city);
                    chefCmd.Parameters.AddWithValue("@State", state);
                    chefCmd.Parameters.AddWithValue("@PINCode", pinCode);
                    chefCmd.Parameters.AddWithValue("@CuisineSpecialty", cuisineSpecialty);
                    chefCmd.Parameters.AddWithValue("@Experience", experience);
                    chefCmd.Parameters.AddWithValue("@AvailabilityStatus", availability);
                    chefCmd.Parameters.AddWithValue("@ProfilePicture", imagePath);

                    Response.Write($"<script>console.log('Executing ChefDetails {(recordExists ? "UPDATE" : "INSERT")}...');</script>");
                    int rowsAffected = chefCmd.ExecuteNonQuery();
                    Response.Write($"<script>console.log('ChefDetails operation completed. Rows affected: {rowsAffected}');</script>");
                    if (rowsAffected == 0)
                    {
                        Response.Write("<script>console.log('No rows affected by ChefDetails operation');</script>");
                        throw new Exception("No rows were affected by the ChefDetails operation");
                    }
                }

                Response.Write("<script>console.log('Committing transaction...');</script>");
                transaction.Commit();
                isTransactionCommitted = true;

                Session["FirstName"] = firstName;
                
                Session["Email"] = email;
                Session["PhoneNumber"] = phoneNumber;

                Response.Write("<script>console.log('Profile saved successfully');</script>");
                Response.Write("<script>alert('Chef profile saved successfully!');</script>");
                LoadChefDetails();
                //ClearForm();
            }
            catch (SqlException ex)
            {
                if (!isTransactionCommitted && transaction != null)
                {
                    transaction.Rollback();
                    Response.Write("<script>console.log('Transaction rolled back due to SQL error');</script>");
                }
                Response.Write($"<script>console.log('SQL Error: {ex.Message}, Error Number: {ex.Number}');</script>");
                Response.Write($"<script>alert('Database error: {ex.Message}\\nError Number: {ex.Number}');</script>");
            }
            catch (Exception ex)
            {
                if (!isTransactionCommitted && transaction != null)
                {
                    transaction.Rollback();
                    Response.Write("<script>console.log('Transaction rolled back due to general error');</script>");
                }
                Response.Write($"<script>console.log('Error: {ex.Message}');</script>");
                Response.Write($"<script>alert('Error: {ex.Message}');</script>");
            }
            finally
            {
                if (!isTransactionCommitted && transaction != null)
                {
                    transaction.Dispose();
                    Response.Write("<script>console.log('Transaction disposed');</script>");
                }
                if (conn != null && conn.State == System.Data.ConnectionState.Open)
                {
                    conn.Close();
                    conn.Dispose();
                    Response.Write("<script>console.log('Connection closed and disposed');</script>");
                }
            }
        }
        /*private void ClearForm()
        {
            txtFirstName.Text = txtEmail.Text = txtPhoneNumber.Text = txtAddress.Text = txtCity.Text = txtState.Text = txtPINCode.Text = txtExperience.Text = "";
            ddlCuisineSpecialty.ClearSelection();
            ddlAvailability.SelectedIndex = 0;
            imgProfile.ImageUrl = "~/img/default-chef.png";
        }*/
    }
}