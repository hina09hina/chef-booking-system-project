using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;

namespace YourChef
{
    public partial class booking1 : System.Web.UI.Page
    {
        // Retrieve connection string from Web.config
        private string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Page load logic (if needed)
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid) // Ensure all validation controls pass
            {
                // Retrieve form data
                string occasion = ddlOccasion.SelectedValue;
                string selectedDate = txtDate.Text;
                string selectedMeals = GetSelectedMeals(); // Now supports multiple selections
                string lunchTime = GetSelectedLunchTime(); // Supports multiple lunch times
                string burners = GetSelectedBurners();

                // Save to database
                SaveToDatabase(occasion, selectedDate, selectedMeals, lunchTime, burners);

                // Display success message
                Response.Write("<script>alert('Booking successfully saved!');</script>");
            }
        }

        // Helper method to get the selected meals (supports multiple selections)
        private string GetSelectedMeals()
        {
            string selectedMeals = "";
            if (CheckBoxBreakfast.Checked) selectedMeals += "Breakfast, ";
            if (CheckBoxLunch.Checked) selectedMeals += "Lunch, ";
            if (CheckBoxEveningSnacks.Checked) selectedMeals += "Evening Snacks, ";
            if (CheckBoxDinner.Checked) selectedMeals += "Dinner, ";

            // Remove the trailing comma and space
            if (!string.IsNullOrEmpty(selectedMeals))
                selectedMeals = selectedMeals.TrimEnd(',', ' ');

            return selectedMeals;
        }

        // Helper method to get the selected lunch time (supports multiple selections)
        private string GetSelectedLunchTime()
        {
            string selectedTimes = "";
            if (RadioButton1.Checked) selectedTimes += "10 am onwards, ";
            if (RadioButton2.Checked) selectedTimes += "11 am onwards, ";
            if (RadioButton3.Checked) selectedTimes += "12 pm onwards, ";
            if (RadioButton4.Checked) selectedTimes += "1 pm onwards, ";
            if (RadioButton5.Checked) selectedTimes += "2 pm onwards, ";
            if (RadioButton6.Checked) selectedTimes += "3 pm onwards, ";
            if (RadioButton7.Checked) selectedTimes += "4 pm onwards, ";

            // Remove the trailing comma and space
            if (!string.IsNullOrEmpty(selectedTimes))
                selectedTimes = selectedTimes.TrimEnd(',', ' ');

            return selectedTimes;
        }

        // Helper method to get the number of gas burners
        private string GetSelectedBurners()
        {
            if (RadioButton8.Checked) return "1";
            if (RadioButton9.Checked) return "2";
            if (RadioButton10.Checked) return "3";
            if (RadioButton11.Checked) return "4";
            return "None";
        }

        // Method to save data to the database
        private void SaveToDatabase(string occasion, string date, string meals, string lunchTime, string burners)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Bookings (Occasion, BookingDate, Meals, LunchTime, Burners) VALUES (@Occasion, @BookingDate, @Meals, @LunchTime, @Burners)";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Occasion", occasion);
                    command.Parameters.AddWithValue("@BookingDate", date);
                    command.Parameters.AddWithValue("@Meals", meals);
                    command.Parameters.AddWithValue("@LunchTime", lunchTime);
                    command.Parameters.AddWithValue("@Burners", burners);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }
    }
}