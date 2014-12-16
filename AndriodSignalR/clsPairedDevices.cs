using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SignalR
{

    public class clsDesktopDevice
    {
        public string Device_id { get; set; }
        public string Ip_Address { get; set; }
        public string System_name { get; set; }
        public string Created_date { get; set; }
        public string Description { get; set; }
        public string IsConnected { get; set; }
        public string StartTime { get; set; }
        public string CloseTime { get; set; }
        public string ResponseTime { get; set; }
    }



    public class clsPairedDevices
    {
        public string DeskDevice_id { get; set; }
        public string AndroidDevice_id { get; set; }
        public string IsPaired { get; set; }
        public string IsConnected { get; set; }
        public string StartTime { get; set; }
        public string CloseTime { get; set; }
        public string ResponseTime { get; set; }
        public string CreatedDate { get; set; }

        public string Desktopconnection { get; set; }
        public string Andriodconnection { get; set; }
    }

    public class clsAndroidDevice
    {
        public string Device_id { get; set; }
        public string Registration_id { get; set; }
        public string Model_no { get; set; }
        public string Created_date { get; set; }
        public string Description { get; set; }
        public string IsConnected { get; set; }
        public string StartTime { get; set; }
        public string CloseTime { get; set; }
        public string ResponseTime { get; set; }

    }

    public class clsDeviceList
    {
        private List<clsDesktopDevice> _desktopCollection;
        private List<clsAndroidDevice> _AndriodCollection;


        public clsDeviceList()
        {
            _desktopCollection = new List<clsDesktopDevice>();
            _AndriodCollection = new List<clsAndroidDevice>();
        }

        public List<clsDesktopDevice> DesktopCollection
        {
            get
            {
                _desktopCollection = Common.Desktopdevicelist();
                return _desktopCollection;
            }

        }
        public List<clsAndroidDevice> AndriodCollection
        {
            get
            {
                _AndriodCollection = Common.Androiddevicelist();
                return _AndriodCollection;
            }
        }
    }

}
