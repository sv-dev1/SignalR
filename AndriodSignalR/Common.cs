using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.NetworkInformation;
using System.Reflection;
using System.Web;
using System.Xml;

namespace SignalR
{
    public class Common
    {

        #region Desktopdevice
        public static bool UpdateDesktopDevice(string desktopdevice_id, string connected, string closetime, string description)
        {
            try
            {
                using (DataSet dsResult = new DataSet())
                {
                    dsResult.ReadXml(System.Web.HttpContext.Current.Server.MapPath("~/DesktopDevice.xml"));
                    if (dsResult != null && dsResult.Tables.Count > 0)
                    {
                        DataRow dr = dsResult.Tables[0].Select("Device_id = '" + desktopdevice_id + "'").FirstOrDefault();
                        if (dr != null)
                        {
                            if (connected != "" || connected != string.Empty)
                            {
                                dr["IsConnected"] = connected;

                            }
                            if (closetime != "")
                            {
                                dr["CloseTime"] = closetime;
                            }
                            if (description != "")
                            {
                                dr["Description"] = description;
                            }
                        }
                        dsResult.AcceptChanges();
                        dsResult.WriteXml(System.Web.HttpContext.Current.Server.MapPath("~/DesktopDevice.xml"), XmlWriteMode.IgnoreSchema);
                    }
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static bool AddUpdateDevice(string device_id, string connected, string starttime, string closetime, string description)
        {
            try
            {
                using (DataSet dsResult = new DataSet())
                {
                    dsResult.ReadXml(System.Web.HttpContext.Current.Server.MapPath("~/DesktopDevice.xml"));
                    if (dsResult != null && dsResult.Tables.Count > 0)
                    {
                        DataRow dr = dsResult.Tables[0].Select("Device_id = '" + device_id + "'").FirstOrDefault();
                        if (dr != null)
                        {
                            dsResult.Tables[0].Rows.Remove(dr);
                        }
                        dsResult.AcceptChanges();
                        dsResult.WriteXml(System.Web.HttpContext.Current.Server.MapPath("~/DesktopDevice.xml"), XmlWriteMode.IgnoreSchema);
                    }
                }

                XmlDocument xmldoc = new XmlDocument();
                xmldoc.Load(System.Web.HttpContext.Current.Server.MapPath("~/DesktopDevice.xml"));

                XmlElement parentelement = xmldoc.CreateElement("Comments");
                XmlElement _Deviceid = xmldoc.CreateElement("Device_id");
                _Deviceid.InnerText = device_id;
                XmlElement Createddate = xmldoc.CreateElement("Created_date");
                Createddate.InnerText = DateTime.Now.ToString();
                XmlElement _description = xmldoc.CreateElement("Description");
                _description.InnerText = description;

                XmlElement _isconnected = xmldoc.CreateElement("IsConnected");
                _isconnected.InnerText = connected;
                XmlElement _starttime = xmldoc.CreateElement("StartTime");
                _starttime.InnerText = starttime;
                XmlElement _closetime = xmldoc.CreateElement("CloseTime");
                _closetime.InnerText = closetime;

                parentelement.AppendChild(_Deviceid);
                parentelement.AppendChild(Createddate);
                parentelement.AppendChild(_description);
                parentelement.AppendChild(_isconnected);
                parentelement.AppendChild(_starttime);
                parentelement.AppendChild(_closetime);

                xmldoc.DocumentElement.AppendChild(parentelement);
                xmldoc.Save(System.Web.HttpContext.Current.Server.MapPath("~/DesktopDevice.xml"));
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }



        public static DataTable GetDesktopDevices()
        {
            DataSet ds = new DataSet();
            DataTable dts = new DataTable();
            ds.ReadXml(System.Web.HttpContext.Current.Server.MapPath("~/DesktopDevice.xml"));

            if (ds != null && ds.Tables.Count > 0)
            {
                dts = ds.Tables[0];
            }
            return dts;
        }
        public static List<clsDesktopDevice> Desktopdevicelist()
        {
            List<clsDesktopDevice> list = new List<clsDesktopDevice>();
            DataTable dt = new DataTable();
            dt = GetDesktopDevices();



            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    dr["Created_date"] = Convert.ToDateTime(dr["Created_date"].ToString()); //string.Format("{0:MM/dd/yyyy}", dr["OriginalDate"]);
                }

                DataView dv = dt.DefaultView;
                dv.Sort = "Created_date";
                //   Convert back your sorted DataView to DataTable
                dt = dv.ToTable();
                foreach (DataRow dr in dt.Rows)
                {
                    clsDesktopDevice objPC = new clsDesktopDevice();
                    objPC.Device_id = dr["Device_id"].ToString();
                    objPC.Ip_Address = dr["Ip_Address"].ToString();
                    objPC.System_name = dr["System_name"].ToString();
                    objPC.Created_date = Convert.ToDateTime(dr["Created_date"]).ToShortDateString();
                    objPC.Description = dr["Description"].ToString();
                    objPC.IsConnected = dr["IsConnected"].ToString();
                    objPC.StartTime = dr["StartTime"].ToString();
                    objPC.CloseTime = dr["CloseTime"].ToString();


                    if (dr["StartTime"].ToString() != "" && objPC.IsConnected == "1")
                    {

                        string starttime = dr["StartTime"].ToString().Trim();
                        starttime = starttime.Split(' ')[0];

                        string closetime = DateTime.Now.ToLongTimeString();
                        closetime = (closetime.ToString()).Split(' ')[0];

                        var time = TimeSpan.Parse(starttime);
                        var time2 = TimeSpan.Parse(closetime);

                        TimeSpan x = time2 - time;
                        objPC.ResponseTime = x.TotalMilliseconds.ToString() + " ms";

                    }
                    else if (dr["StartTime"].ToString() != "" && dr["CloseTime"].ToString() != "")
                    {

                        string starttime = dr["StartTime"].ToString().Trim();
                        starttime = starttime.Split(' ')[0];

                        string closetime = dr["CloseTime"].ToString().Trim();
                        closetime = closetime.Split(' ')[0];


                        var time = TimeSpan.Parse(starttime);
                        var time2 = TimeSpan.Parse(closetime);

                        TimeSpan x = time2 - time;
                        objPC.ResponseTime = x.TotalMilliseconds.ToString() + " ms";
                    }


                    list.Add(objPC);
                }
            }
            return list;
        }



        #endregion



        #region AndriodDevices

        public static DataTable GetAndroidDevices()
        {
            DataSet ds = new DataSet();
            DataTable dts = new DataTable();
            //   ds.ReadXml(System.Web.HttpContext.Current.Server.MapPath("~/SignalR.xml")); //for local
            ds.ReadXml(System.Web.HttpContext.Current.Server.MapPath("~/wmswcf/SignalR.xml"));// for server
            if (ds != null && ds.Tables.Count > 0)
            {
                dts = ds.Tables[0];
            }
            return dts;
        }

        public static List<clsAndroidDevice> Androiddevicelist()
        {
            List<clsAndroidDevice> list = new List<clsAndroidDevice>();
            DataTable dt = new DataTable();
            dt = GetAndroidDevices();
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    dr["Created_date"] = Convert.ToDateTime(dr["Created_date"].ToString()); //string.Format("{0:MM/dd/yyyy}", dr["OriginalDate"]);
                }

                DataView dv = dt.DefaultView;
                dv.Sort = "Created_date";
                //   Convert back your sorted DataView to DataTable
                dt = dv.ToTable();
                foreach (DataRow dr in dt.Rows)
                {
                    clsAndroidDevice objPC = new clsAndroidDevice();
                    objPC.Device_id = dr["Device_id"].ToString();
                    objPC.Created_date = Convert.ToDateTime(dr["Created_date"]).ToShortDateString();
                    objPC.Registration_id = dr["Registration_id"].ToString();
                    objPC.Model_no = dr["Model_no"].ToString();
                    objPC.Description = dr["Description"].ToString();
                    objPC.IsConnected = dr["IsConnected"].ToString();
                    objPC.StartTime = dr["StartTime"].ToString();
                    objPC.CloseTime = dr["CloseTime"].ToString();

                    if (dr["StartTime"].ToString() != "" && objPC.IsConnected == "1")
                    {
                        string starttime = dr["StartTime"].ToString().Trim();
                        starttime = starttime.Split(' ')[0];

                        string closetime = DateTime.Now.ToLongTimeString();
                        closetime = (closetime.ToString()).Split(' ')[0];

                        var time = TimeSpan.Parse(starttime);
                        var time2 = TimeSpan.Parse(closetime);

                        TimeSpan x = time2 - time;
                        objPC.ResponseTime = x.TotalMilliseconds.ToString() + " ms";


                    }
                    else if (dr["StartTime"].ToString() != "" && dr["CloseTime"].ToString() != "")
                    {

                        string responsetime = dr["ResponseTime"].ToString().Trim();
                        responsetime = responsetime.Split(' ')[0];
                        var time = TimeSpan.Parse(responsetime);
                        objPC.ResponseTime = time.TotalMilliseconds.ToString() + " ms";
                        // objPC.ResponseTime = dr["ResponseTime"].ToString(); //x.TotalMilliseconds.ToString() + " ms";
                        //TimeSpan x = (Convert.ToDateTime(closetime)) - Convert.ToDateTime(starttime);

                    }

                    list.Add(objPC);
                }
            }
            return list;
        }


        #endregion



        #region PageConection

        public static bool AddPageConnection(string desktopdevice_id, string androidId, string Pagenumber)
        {
            try
            {
                using (DataSet dsResult = new DataSet())
                {
                    dsResult.ReadXml(System.Web.HttpContext.Current.Server.MapPath("~/PageConnection.xml"));
                    if (dsResult != null && dsResult.Tables.Count > 0)
                    {
                        DataRow[] dr = dsResult.Tables[0].Select("DeskDevice_id = '" + desktopdevice_id + "' and AndroidDevice_id ='" + androidId + "'");
                        if (dr != null && dr.Length > 0)
                        {
                            dsResult.Tables[0].Rows.Remove(dr[0]);
                        }
                        dsResult.AcceptChanges();
                        dsResult.WriteXml(System.Web.HttpContext.Current.Server.MapPath("~/PageConnection.xml"), XmlWriteMode.IgnoreSchema);
                    }
                }

                XmlDocument xmldoc = new XmlDocument();
                xmldoc.Load(System.Web.HttpContext.Current.Server.MapPath("~/PageConnection.xml"));

                XmlElement parentelement = xmldoc.CreateElement("Comments");
                XmlElement _deskDeviceid = xmldoc.CreateElement("DeskDevice_id");
                _deskDeviceid.InnerText = desktopdevice_id;
                XmlElement _androidId = xmldoc.CreateElement("AndroidDevice_id");
                _androidId.InnerText = androidId;

                XmlElement _pagenumber = xmldoc.CreateElement("PageNumber");
                _pagenumber.InnerText = Pagenumber;

                parentelement.AppendChild(_deskDeviceid);
                parentelement.AppendChild(_androidId);
                parentelement.AppendChild(_pagenumber);


                xmldoc.DocumentElement.AppendChild(parentelement);
                xmldoc.Save(System.Web.HttpContext.Current.Server.MapPath("~/PageConnection.xml"));
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }


        public static string GetPairedPagestatus(string androidId, string desktopdevice_id)
        {
            DataSet ds = new DataSet();
            DataTable dts = new DataTable();
            DataTable dt2 = new DataTable();
            string pagenumber = "";
            try
            {
                ds.ReadXml(System.Web.HttpContext.Current.Server.MapPath("~/PageConnection.xml")); //for local
                if (ds != null && ds.Tables.Count > 0)
                {
                    string index1 = desktopdevice_id;
                    string index2 = androidId;
                    DataRow dr = ds.Tables[0].Select("DeskDevice_id = '" + desktopdevice_id.Trim() + "' and AndroidDevice_id ='" + androidId.Trim() + "'").FirstOrDefault();
                    if (dr != null)
                    {
                        pagenumber = dr["PageNumber"].ToString();
                        return pagenumber;
                    }

                }
            }
            catch (Exception ee) { }
            return pagenumber;
        }

        public static bool ClearPageConnection(string andriodid)
        {
            try
            {
                using (DataSet dsResult = new DataSet())
                {
                    dsResult.ReadXml(System.Web.HttpContext.Current.Server.MapPath("~/PageConnection.xml"));
                    if (dsResult != null && dsResult.Tables.Count > 0)
                    {
                        DataRow[] dr = dsResult.Tables[0].Select("AndroidDevice_id = '" + andriodid + "'");
                        if (dr != null && dr.Length > 0)
                        {
                            dsResult.Tables[0].Rows.Remove(dr[0]);
                        }
                        dsResult.AcceptChanges();
                        dsResult.WriteXml(System.Web.HttpContext.Current.Server.MapPath("~/PageConnection.xml"), XmlWriteMode.IgnoreSchema);

                    }
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
        public static bool ClearPageConnectionforDesktop(string desktopid)
        {
            try
            {
                using (DataSet dsResult = new DataSet())
                {
                    dsResult.ReadXml(System.Web.HttpContext.Current.Server.MapPath("~/PageConnection.xml"));
                    if (dsResult != null && dsResult.Tables.Count > 0)
                    {
                        DataRow[] dr = dsResult.Tables[0].Select("DeskDevice_id = '" + desktopid + "'");
                        if (dr != null && dr.Length > 0)
                        {
                            dsResult.Tables[0].Rows.Remove(dr[0]);
                        }
                        dsResult.AcceptChanges();
                        dsResult.WriteXml(System.Web.HttpContext.Current.Server.MapPath("~/PageConnection.xml"), XmlWriteMode.IgnoreSchema);

                    }
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }


        #endregion


        #region Json string
        public static string ConvertDataTabletoString(DataTable dt)
        {
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
            Dictionary<string, object> row;
            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
            return serializer.Serialize(rows);
        }


        #endregion

    }

}