using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace WMSWcf
{
    public class Names
    {
    }

     [DataContract]
    public class DeviceDetails
    {
         [DataMember]
       public string device_id {get;set;}
          [DataMember]
         public string registration_id { get; set; }
          [DataMember]
       public string Model_no { get; set; } 
    }
}