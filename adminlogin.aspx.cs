using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace YourChef
{
    public partial class adminlogin : System.Web.UI.Page
    {

        private const string AdminUsername = "admin";
        private const string AdminPassword = "admin123";

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {


            if (txtUsername.Text == AdminUsername && txtPassword.Text == AdminPassword)
            {
                Session["AdminLoggedIn"] = true;
                Response.Redirect("Dashboard.aspx");
            }
            else
            {
                lblMessage.Text = "Invalid credentials";
            }
        }
    }
}