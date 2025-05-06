using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.Http;
using System.Web.UI;
using YourChef;

namespace YourChef
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            AreaRegistration.RegisterAllAreas();
            GlobalConfiguration.Configure(WebApiConfig.Register);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            ScriptManager.ScriptResourceMapping.AddDefinition("jquery", new ScriptResourceDefinition
            {
                Path = "~/Scripts/jquery-3.6.0.min.js", // Path to your jQuery file
                DebugPath = "~/Scripts/jquery-3.6.0.js", // Path to the debug version of jQuery
                CdnPath = "https://code.jquery.com/jquery-3.6.0.min.js", // CDN path for jQuery
                CdnDebugPath = "https://code.jquery.com/jquery-3.6.0.js", // CDN debug path for jQuery
                CdnSupportsSecureConnection = true,
                LoadSuccessExpression = "window.jQuery"
            });
        }
    }
}

