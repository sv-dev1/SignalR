using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using SignalR;
using System.Configuration;
using System.Text;
using System.IO;
using System.Web.Hosting;
namespace AndriodSignalR
{
    public partial class Default : System.Web.UI.Page
    {
        protected string desktopdeviceId = "";
        protected string siteurl = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            siteurl = ConfigurationManager.AppSettings["weburl"].ToString();
            checkCookie();
            desktopdeviceId = getCookie();
            hdndevicecookie.Value = desktopdeviceId;

            Common.ClearPageConnectionforDesktop(desktopdeviceId);
        }

        public static string CreateJson(DataTable dt)
        {
            string res = "";// "[{" + @"""" + "text" + @"""" + ": " + @"""" + "Select Andriod Device" + @"""" + "," + @"""" + "value" + @"""" + ": " + @"""" + "-1" + @"""" + "," + @"""" + "selected" + @"""" + ":" + @"""" + "false" + @"""" + "," + @"""" + "description" + @"""" + ": " + @"""" + "Andriod Devices" + @"""" + "," + @"""" + "imageSrc" + @"""" + ": " + @"""http://websignalr.kindlebit.com/Images/mobileicon.png" + @"""" + "},";


            foreach (DataRow dr in dt.Rows)
            {
                string description = "";
                string imagepath = "";

                if (Convert.ToString(dr["IsConnected"]) == "1")
                {
                    description = "Available";
                    imagepath = "http://websignalr.kindlebit.com/Images/firma1.png";
                }
                else
                {

                    description = "Disconnected";
                    imagepath = "http://websignalr.kindlebit.com/Images/firma2.png";
                }





                if (Convert.ToString(dr["Registration_id"]) != "")
                {
                    if (res == "")
                    {
                        res = "[{" + @"""" + "text" + @"""" + ": " + @"""" + Convert.ToString(dr["Device_id"]) + @"""" + "," + @"""" + "value" + @"""" + ": " + @"""" + Convert.ToString(dr["Registration_id"]) + @"""" + "," + @"""" + "selected" + @"""" + ":" + @"""" + "false" + @"""" + "," + @"""" + "description" + @"""" + ": " + @"""" + description + @"""" + "," + @"""" + "imageSrc" + @"""" + ": " + @"""" + imagepath + @"""" + "},";
                    }
                    else
                    {
                        res = res + "{" + @"""" + "text" + @"""" + ": " + @"""" + Convert.ToString(dr["Device_id"]) + @"""" + "," + @"""" + "value" + @"""" + ": " + @"""" + Convert.ToString(dr["Registration_id"]) + @"""" + "," + @"""" + "selected" + @"""" + ":" + @"""" + "false" + @"""" + "," + @"""" + "description" + @"""" + ": " + @"""" + description + @"""" + "," + @"""" + "imageSrc" + @"""" + ": " + @"""" + imagepath + @"""" + "},";
                    }
                }
            }
            if (res != "")
            {
                //   res = res + "{" + @"""" + "text" + @"""" + ": " + @"""" + "Select Andriod Device" + @"""" + "," + @"""" + "value" + @"""" + ": " + @"""" + "-1" + @"""" + "," + @"""" + "selected" + @"""" + ":" + @"""" + "false" + @"""" + "," + @"""" + "description" + @"""" + ": " + @"""" + "Andriod Devices" + @"""" + "," + @"""" + "imageSrc" + @"""" + ": " + @"""http://websignalr.kindlebit.com/Images/mobileicon.png" + @"""" + "},";
                if (res.Substring(res.Length - 1).ToString().Contains(","))
                {
                    res = res.Remove(res.Length - 1);
                }
                res = res + "]";

            }
            return res;
        }

        #region Webmethods


        //    [WebMethod]
        //    public static List<string> GetAndriodDevices()
        //    {
        //        List<string> devices = new List<string>();
        //        string connectedJson = "";
        //        string disconnectedJson = "";

        ////        DataTable dt = Common.GetAndroidDevices();

        //        DataTable connected = Common.GetAndriodDevicesbystatus("1");
        //        if (connected != null && connected.Rows.Count > 0)
        //        {
        //            connectedJson = CreateJson(connected);
        //        }
        //        devices.Add(connectedJson);

        //        DataTable disconnected = Common.GetAndriodDevicesbystatus("0");
        //        if (disconnected != null && disconnected.Rows.Count > 0)
        //        {
        //            disconnectedJson = CreateJson(disconnected);
        //        }

        //        devices.Add(disconnectedJson);

        //        return devices;

        //    }

        [WebMethod]
        public static string GetAndriodDevices()
        {
            List<string> devices = new List<string>();

            string res = "";
            DataTable dt = Common.GetAndroidDevices();
            if (dt != null && dt.Rows.Count > 0)
            {
                res = CreateJson(dt);
            }
            return res;

        }

        [WebMethod]
        public static bool clearConnectionxmlWithAndriod(string Andriodid)
        {
            bool res =Common.ClearPageConnection(Andriodid);
            return res;
        }


        [WebMethod]
        public static string GetPagestatus(string desktopdeviceid, string andriodid)
        {
            string res = "";
            res = Common.GetPairedPagestatus(andriodid, desktopdeviceid);
            return res;
        }


        [WebMethod]
        public static bool UpdateClosetime(string deviceID)
        {
            string currenttime = DateTime.Now.ToShortTimeString();
            bool res = false;
            res = Common.UpdateDesktopDevice(deviceID, "0", currenttime, "");
            return res;
        }


        [WebMethod]
        public static bool UpdateOpentime(string deviceID)
        {
            bool res = false;
            res = Common.AddUpdateDevice(deviceID, "1", DateTime.Now.ToShortTimeString(), "", "");
            return res;
        }



        [WebMethod]
        public static string DisplayFiles()
        {
            string html = "<ul class='pdf_list_new'>";
            string[] filePaths = Directory.GetFiles(HostingEnvironment.MapPath("~/Uploads/"));
            
            foreach (string filePath in filePaths)
            {

                string src = "";
                if (Path.GetExtension(filePath) == ".png" || Path.GetExtension(filePath) == ".jpg")
                {
                    src = "images/pngicon.png";
                }
                else if (Path.GetExtension(filePath) == ".pdf") {
                    src = "images/pdf.png";
                }
                else if (Path.GetExtension(filePath) == ".xls" || Path.GetExtension(filePath) == ".xlsx")
                {
                    src = "images/xls.png";
                }


                html += "<li><span class='icon-1'><img src='"+src+"' /></span><label>" + Path.GetFileName(filePath) + "</label><img src='images/del-icon.png' class='deletefile' onclick=\"DeleteFile('" + Path.GetFileName(filePath) + "');\"></li>";
            }
            html += "</ul>";

            if (html == "") {
                html = "No File(s) Found !!!!";
            }
            return html;
        }


        [WebMethod]
        public static bool deleteFile(string file)
        {
            bool res = false;
            try
            {
                string path = HostingEnvironment.MapPath("~/Uploads/" + file);
                File.Delete(path);

                return true;
            }
            catch (Exception ee) {
                return res;
            }
        }


        #endregion

        #region Cookies
        public void checkCookie()
        {
            string deviceid = getCookie();
            if (deviceid == "" || deviceid == null)
            {
                setcookie();
            }
        }

        public string getCookie()
        {

            string deviceId = "";
            HttpCookie myCookie = Request.Cookies["uniqueId"];
            if (myCookie != null)
            {
                if (!string.IsNullOrEmpty(myCookie.Values["uniqueId"]))
                {
                    deviceId = myCookie.Values["uniqueId"].ToString();
                }
            }
            return deviceId;
        }

        public void setcookie()
        {
            string id = "";
            //create a cookie
            HttpCookie myCookie = new HttpCookie("uniqueId");
            int myRandomNo = 0;
            string deviceid = "";
            DataTable dt = Common.GetDesktopDevices();
            if (dt != null && dt.Rows.Count > 0)
            {
                //sort dt
                DataView dv = dt.DefaultView;
                dv.Sort = "Device_id Desc";
                DataTable dt2 = new DataTable();
                dt2 = dv.ToTable();
                deviceid = Convert.ToString(dt.Rows[0]["Device_id"]);
                myRandomNo = Convert.ToInt32(deviceid) + 1;
                id = myRandomNo.ToString();
                id = id.PadLeft(4, '0');
            }
            else
            {
                id = "0001";
            }

            myCookie.Values.Add("uniqueId", id);
            myCookie.Expires = DateTime.Now.AddYears(1);
            Response.Cookies.Add(myCookie);

        }

        #endregion


    }
    public class clsJson
    {
        public string text { get; set; }
        public int value { get; set; }
        public bool selected { get; set; }
        public string description { get; set; }
        public string imageSrc { get; set; }

    }
}
