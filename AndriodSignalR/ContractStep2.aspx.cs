using SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AndriodSignalR
{
    public partial class ContractStep2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string desktopdeviceId = "";
            string androidevice = "";
            string query = "";
            if (Request.QueryString["deskdevice"] != null && Request.QueryString["deskdevice"] != "")
            {
                query = Convert.ToString(Request.QueryString["deskdevice"]);
                string[] arr = query.Split('|');
                desktopdeviceId = arr[0];
                //lblConnection.Text = "Connected to :" + desktopdeviceId;
               androidevice = arr[1].Split('=')[1];
               // lblmydevicename.Text = androidevice;
            }
            Common.AddPageConnection(desktopdeviceId, androidevice, "3");
            btnNext.NavigateUrl = "http://websignalr.kindlebit.com/Congratualtions.aspx?deskdevice=" + query;
        }
    }
}