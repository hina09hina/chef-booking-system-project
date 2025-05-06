using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace YourChef
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            Response.Redirect("signup.aspx");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("loginn.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            Session.Clear(); // Clears session data
            Session.Abandon(); // Ends session
            Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddDays(-1);
            Response.Redirect("Loginn.aspx");
        }

        protected void btnRegisterPartner_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/signup.aspx?role=Chef"); // Redirect to registration page with "Chef" role
        }

        protected void btnBookNow_Click(object sender, EventArgs e)
        {
            Response.Redirect("chefProfilepage.aspx");
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("chef_dashboard.aspx");
        }
    }
    }
