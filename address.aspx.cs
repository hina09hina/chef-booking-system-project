using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using Twilio.TwiML.Voice;

namespace YourChef
{
    public partial class address : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int userID;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("loginn.aspx");
            }
            else
            {
                userID = Convert.ToInt32(Session["UserID"]);
            }

            if (!IsPostBack)
            {
                LoadAllData(); // Fetch and bind Country, State, and City in one go
                LoadUserAddress(); // Load user address after dropdowns are populated
            }
        }

        protected void AddAddress_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(DropDownList1.SelectedValue, out int stateID) || stateID <= 0 ||
                !int.TryParse(DropDownList2.SelectedValue, out int countryID) || countryID <= 0 ||
                !int.TryParse(ddlCity.SelectedValue, out int cityID) || cityID <= 0)
            {
                Response.Write("<script>alert('Please select a valid country, state, and city.');</script>");
                return;
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string checkQuery = "SELECT COUNT(*) FROM UserAddresses WHERE UserID = @UserID";
                SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                checkCmd.Parameters.AddWithValue("@UserID", userID);
                int count = (int)checkCmd.ExecuteScalar();

                string query = count > 0 ?
                    "UPDATE UserAddresses SET FullName=@FullName, HouseDetails=@HouseDetails, Street=@Street, CityID=@CityID, StateID=@StateID, CountryID=@CountryID, PinCode=@PinCode, FullAddress=@FullAddress WHERE UserID=@UserID" :
                    "INSERT INTO UserAddresses (UserID, FullName, HouseDetails, Street, CityID, StateID, CountryID, PinCode, FullAddress) VALUES (@UserID, @FullName, @HouseDetails, @Street, @CityID, @StateID, @CountryID, @PinCode, @FullAddress)";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserID", userID);
                cmd.Parameters.AddWithValue("@FullName", txtFullName.Text);
                cmd.Parameters.AddWithValue("@HouseDetails", txtHouseNo.Text);
                cmd.Parameters.AddWithValue("@Street", txtStreet.Text);
                cmd.Parameters.AddWithValue("@CityID", cityID);
                cmd.Parameters.AddWithValue("@StateID", stateID);
                cmd.Parameters.AddWithValue("@CountryID", countryID);
                cmd.Parameters.AddWithValue("@PinCode", txtPinCode.Text);
                cmd.Parameters.AddWithValue("@FullAddress", txtLocation.Text);
                cmd.ExecuteNonQuery();
            }
            Response.Write("<script>alert('Address saved successfully!');</script>");
        }

        private void LoadUserAddress()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT TOP 1 * FROM UserAddresses WHERE UserID = @UserID ORDER BY AddressID DESC";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserID", userID);
                con.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtFullName.Text = reader["FullName"].ToString();
                    txtHouseNo.Text = reader["HouseDetails"].ToString();
                    txtStreet.Text = reader["Street"].ToString();
                    txtPinCode.Text = reader["PinCode"].ToString();
                    txtLocation.Text = reader["FullAddress"].ToString();

                    int countryID = Convert.ToInt32(reader["CountryID"]);
                    int stateID = Convert.ToInt32(reader["StateID"]);
                    int cityID = Convert.ToInt32(reader["CityID"]);

                    // Set Selected Country
                    if (DropDownList2.Items.FindByValue(countryID.ToString()) != null)
                        DropDownList2.SelectedValue = countryID.ToString();

                    // Set Selected State
                    if (DropDownList1.Items.FindByValue(stateID.ToString()) != null)
                        DropDownList1.SelectedValue = stateID.ToString();

                    // Set Selected City
                    if (ddlCity.Items.FindByValue(cityID.ToString()) != null)
                        ddlCity.SelectedValue = cityID.ToString();

                    btnAddAddress.Text = "Update Address";
                }
                reader.Close();
            }
        }

        private void LoadAllData()
        {
            // Load Countries
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                using (SqlCommand countryCmd = new SqlCommand("SELECT CountryID, CountryName FROM Country", con))
                {
                    SqlDataReader countryReader = countryCmd.ExecuteReader();
                    DropDownList2.DataSource = countryReader;
                    DropDownList2.DataTextField = "CountryName";
                    DropDownList2.DataValueField = "CountryID";
                    DropDownList2.DataBind();
                    countryReader.Close();
                }
                DropDownList2.Items.Insert(0, new ListItem("Select Country", "0"));
            }

            // Load States
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                using (SqlCommand stateCmd = new SqlCommand("SELECT StateID, StateName FROM State", con))
                {
                    SqlDataReader stateReader = stateCmd.ExecuteReader();
                    DropDownList1.DataSource = stateReader;
                    DropDownList1.DataTextField = "StateName";
                    DropDownList1.DataValueField = "StateID";
                    DropDownList1.DataBind();
                    stateReader.Close();
                }
                DropDownList1.Items.Insert(0, new ListItem("Select State", "0"));
            }

            // Load Cities
            // Load Cities
            // Load Cities
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                using (SqlCommand cityCmd = new SqlCommand("SELECT CityID, CityName FROM City", con))
                using (SqlDataReader cityReader = cityCmd.ExecuteReader())
                {
                    DataTable dt = new DataTable();
                    dt.Load(cityReader); // Load reader data into DataTable

                    ddlCity.DataSource = dt;
                    ddlCity.DataTextField = "CityName";
                    ddlCity.DataValueField = "CityID";
                    ddlCity.DataBind();
                }
            }
            ddlCity.Items.Insert(0, new ListItem("Select City", "0"));
            ddlCity.Items.Insert(0, new ListItem("Select City", "0"));

        }
    }
}
