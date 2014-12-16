using SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AndriodSignalR
{
    public partial class Idle : System.Web.UI.Page
    {
        string desktopdeviceId = "";
        string androidevice = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string desktopdeviceId = "";
            string androidevice = "";
            if (Request.QueryString["deskdevice"] != null && Request.QueryString["deskdevice"] != "")
            {
                string query = Convert.ToString(Request.QueryString["deskdevice"]);  
                string[] arr = query.Split('|');
                desktopdeviceId = arr[0];
                lblConnection.Text = "Not Connected";
                androidevice = arr[1].Split('=')[1];
                lblmydevicename.Text = androidevice;
            }
            Common.AddPageConnection(desktopdeviceId, androidevice, "0");
        }
    }
}