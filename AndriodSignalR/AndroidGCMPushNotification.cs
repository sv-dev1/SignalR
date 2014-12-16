﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Text;
using System.IO;
using System.Security.Cryptography.X509Certificates;
using System.Net.Security;
using System.Collections.Specialized;
using System.Configuration;

public class AndroidGCM
{
    public AndroidGCM()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public string SendNotification(string registration_id, string message, string type, string desktopdeviceid)
    {
        String sResponseFromServer = string.Empty;
        string result = string.Empty;
        try
        {
            string GoogleAppID = ConfigurationManager.AppSettings["GoogleAppID"];
            var SENDER_ID = ConfigurationManager.AppSettings["SENDER_ID"];
            var value = message;
            WebRequest tRequest;
            tRequest = WebRequest.Create("https://android.googleapis.com/gcm/send");
            tRequest.Method = "post";
            tRequest.ContentType = " application/x-www-form-urlencoded;charset=UTF-8";
            tRequest.Headers.Add(string.Format("Authorization: key={0}", GoogleAppID));

            tRequest.Headers.Add(string.Format("Sender: id={0}", SENDER_ID));
            string postData = "collapse_key=" + Guid.NewGuid() + "&time_to_live=1200&delay_while_idle=true&data.message=" + value + "&data.type=" + type + "&data.time=" + System.DateTime.Now.ToString() + "&registration_id=" + registration_id + "&desktopdevice_id=" + desktopdeviceid + "";
            Console.WriteLine(postData);
            Byte[] byteArray = Encoding.UTF8.GetBytes(postData);
            tRequest.ContentLength = byteArray.Length;

            Stream dataStream = tRequest.GetRequestStream();
            dataStream.Write(byteArray, 0, byteArray.Length);
            dataStream.Close();

            WebResponse tResponse = tRequest.GetResponse();
            dataStream = tResponse.GetResponseStream();

            StreamReader tReader = new StreamReader(dataStream);

          
            sResponseFromServer = tReader.ReadToEnd();

            //if (sResponseFromServer.Contains("id:"))
            //{
                result = sResponseFromServer;
           // }
            //else {
            //    result = "Disconnected";
            //}

            tReader.Close();
            dataStream.Close();
            tResponse.Close();
            return result;
        }
        catch (Exception ex)
        {
            sResponseFromServer = "error: " + ex.Message;
            return result;
        }
       
    }
}