using System;
using System.Web;
using Microsoft.AspNet.SignalR;
namespace SignalRChat
{
    public class ChatHub : Hub
    {
        AndroidGCM GCM = new AndroidGCM();
       // User _user = HttpContext.Current.Session["CurrentUser"] as User;
        public string Send(string name, string message, string device, string desktopid)
        {
            string res = string.Empty;
            try
            {
                // Call the broadcastMessage method to update clients.
                Clients.All.broadcastMessage(name, message, device);
                string[] RegId = name.Split('}');
                string[] Devicename = device.Split('}');
                //  System.Web.HttpContext.Current.Session["DevicenameList"] = device;
                for (int i = 0; i < RegId.Length; i++)
                {
                    string id = RegId[i];
                   res= GCM.SendNotification(id, message, "type", desktopid);
                }
                return res;
            }
            catch (Exception ee)
            {
                return res;
            }
            
        }


        public void SendURL(string name, string message, string device)
        {
            Clients.All.broadcastMessage(name, message, device);
        }
    }
}