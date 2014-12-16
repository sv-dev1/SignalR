using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Xml;

namespace WMSWcf
{
    public class DataAccess
    {


        public bool AddUpdateDeviceDetail(string device_id, string registration_id, string Model_no)
        {
            try
            {
                string connectionString = ConfigurationSettings.AppSettings["ConnectionString"];
                SqlConnection connection = new SqlConnection(connectionString);
                SqlCommand command = new SqlCommand("InsertUpdateDeviceDetail", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@Device_id", SqlDbType.NVarChar, 500));
                command.Parameters.Add(new SqlParameter("@Registration_id", SqlDbType.NVarChar, 500));
                command.Parameters.Add(new SqlParameter("@Model_no", SqlDbType.NVarChar, 500));
                command.Parameters.Add(new SqlParameter("@Created_date", SqlDbType.DateTime));
                command.Parameters.Add(new SqlParameter("@Modified_date", SqlDbType.DateTime));
                command.Parameters.Add(new SqlParameter("@isActive", SqlDbType.Bit, 1));
                command.Parameters["@Device_id"].Value = device_id;
                command.Parameters["@Registration_id"].Value = registration_id;
                command.Parameters["@Model_no"].Value = Model_no;
                command.Parameters["@Created_date"].Value = DateTime.Now;
                command.Parameters["@Modified_date"].Value = DateTime.Now;
                command.Parameters["@isActive"].Value = 1;
                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
                return true;
            }
            catch (Exception)
            {
                return false;
            }

        }

        public bool AddUpdateSignalR(string device_id, string registration_id, string Model_no, string starttime, string closetime, string responsetime, string Isconnected)
        {
            try
            {

                using (DataSet dsResult = new DataSet())
                {
                    //-- Get the XML file data in to dataset to do further operations
                    dsResult.ReadXml(System.Web.HttpContext.Current.Server.MapPath("~/SignalR.xml"));
                    if (dsResult != null && dsResult.Tables.Count > 0)
                    {
                        //-Get the unique value of the record
                        string index = device_id;

                        //-- Filter the dataset and get datarow
                        DataRow dr = dsResult.Tables[0].Select("Device_id = '" + index + "'").FirstOrDefault();

                        if (dr != null)
                        {
                            //-- Remove the matched row from dataset
                            dsResult.Tables[0].Rows.Remove(dr);
                        }
                        //-- Accept the dataset changes
                        dsResult.AcceptChanges();
                        //-- Write the new changes to xmlfile
                        dsResult.WriteXml(System.Web.HttpContext.Current.Server.MapPath("~/SignalR.xml"), XmlWriteMode.IgnoreSchema);
                    }
                }

                XmlDocument xmldoc = new XmlDocument();
                xmldoc.Load(System.Web.HttpContext.Current.Server.MapPath("~/SignalR.xml"));

                XmlElement parentelement = xmldoc.CreateElement("Comments");
                XmlElement Deviceid = xmldoc.CreateElement("Device_id");
                Deviceid.InnerText = device_id;
                XmlElement registrationid = xmldoc.CreateElement("Registration_id");
                registrationid.InnerText = registration_id;
                XmlElement modelno = xmldoc.CreateElement("Model_no");
                modelno.InnerText = Model_no;

                XmlElement Createddate = xmldoc.CreateElement("Created_date");
                Createddate.InnerText = DateTime.Now.ToString();
                XmlElement Modifieddate = xmldoc.CreateElement("Modified_date");
                Modifieddate.InnerText = "";
                XmlElement isActive = xmldoc.CreateElement("isActive");
                isActive.InnerText = "1";
                XmlElement _description = xmldoc.CreateElement("Description");
                _description.InnerText = "";


                XmlElement _isconnected = xmldoc.CreateElement("IsConnected");
                _isconnected.InnerText = Isconnected;
                XmlElement _starttime = xmldoc.CreateElement("StartTime");
                _starttime.InnerText = DateTime.Now.ToShortTimeString();

                XmlElement _closetime = xmldoc.CreateElement("CloseTime");
                _closetime.InnerText = closetime;
                XmlElement _responsetime = xmldoc.CreateElement("ResponseTime");
                _responsetime.InnerText = responsetime;



                parentelement.AppendChild(Deviceid);
                parentelement.AppendChild(registrationid);
                parentelement.AppendChild(modelno);
                parentelement.AppendChild(Createddate);
                parentelement.AppendChild(Modifieddate);
                parentelement.AppendChild(isActive);
                parentelement.AppendChild(_description);

                parentelement.AppendChild(_isconnected);
                parentelement.AppendChild(_starttime);
                parentelement.AppendChild(_closetime);
                parentelement.AppendChild(_responsetime);

                xmldoc.DocumentElement.AppendChild(parentelement);
                xmldoc.Save(System.Web.HttpContext.Current.Server.MapPath("~/SignalR.xml"));


                if (Isconnected == "0") { 
                    //update page connection xml

                }



                return true;
            }
            catch (Exception)
            {
                return false;
            }

        }

        public bool AddUpdatedeviceConnection(string desktopdevice_id, string android_id, string starttime, string closetime, string responsetime, string isconnected)
        {
            try
            {

                //update signalr

                using (DataSet dsResult = new DataSet())
                {
                    dsResult.ReadXml(System.Web.HttpContext.Current.Server.MapPath("~/SignalR.xml"));
                    if (dsResult != null && dsResult.Tables.Count > 0)
                    {
                        DataRow dr = dsResult.Tables[0].Select("Device_id = '" + android_id + "'").FirstOrDefault();
                        if (dr != null)
                        {
                            dr["StartTime"] = starttime;
                            dr["IsConnected"] = isconnected;
                            dr["CloseTime"] = closetime;
                            dr["ResponseTime"] = responsetime;

                        }
                        dsResult.AcceptChanges();
                        dsResult.WriteXml(System.Web.HttpContext.Current.Server.MapPath("~/SignalR.xml"), XmlWriteMode.IgnoreSchema);
                        
                    }
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }


}