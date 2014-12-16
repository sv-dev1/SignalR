using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace WMSWcf
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select Service1.svc or Service1.svc.cs at the Solution Explorer and start debugging.
    [ServiceContract(Namespace = "")]
    public class Service1
    {
        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        public string GetData(int value)
        {
            return string.Format("You entered: {0}", value);
        }

        //connected directly from andriod

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Xml)]
        public bool AddUpdatedeviceConnectionInfo(string androiddevice_id,string registerationid,string modelno,string starttime, string closetime, string responsetime,string IsConnected)
        {

            //write into signalr
                try
                {
                    bool status = false;
                    DataAccess dataAccess = new DataAccess();
                    status = dataAccess.AddUpdateSignalR(androiddevice_id, registerationid, modelno, starttime, closetime, responsetime,IsConnected);
                    return status;
                }
                catch (Exception)
                {
                    throw;
                }
        }



        //connected via push notification
        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Xml)]
        public bool AddUpdateDeviceDetail(string Desktopdevice_id, string andrioddevice_id, string starttime, string closetime, string responsetime, string IsConnected)
        {
            try
            {
                DataAccess dataAccess = new DataAccess();
                bool status = dataAccess.AddUpdatedeviceConnection(Desktopdevice_id, andrioddevice_id, starttime, closetime, responsetime,IsConnected);
                return status;
            }
            catch (Exception)
            {
                throw;
            }
        }

      
    }
}
