<%@ WebHandler Language="C#" Class="Upload" %>

using System;
using System.Web;
using System.IO;
using System.Collections.Generic;
using System.Web.UI.WebControls;
public class Upload : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        if (context.Request.Files.Count > 0)
        {
            HttpFileCollection SelectedFiles = context.Request.Files;
            for (int i = 0; i < SelectedFiles.Count; i++)
            {
                HttpPostedFile PostedFile = SelectedFiles[i];
                string FileName = context.Server.MapPath("~/uploads/" + PostedFile.FileName);
                PostedFile.SaveAs(FileName);
            }

            string html = "<ul class='pdf_list_new'>";
            string[] filePaths = Directory.GetFiles(context.Server.MapPath("~/Uploads/"));

            foreach (string filePath in filePaths)
            {

                string src = "";
                if (Path.GetExtension(filePath) == ".png" || Path.GetExtension(filePath) == ".jpg")
                {
                    src = "images/pngicon.png";
                }
                else if (Path.GetExtension(filePath) == ".pdf")
                {
                    src = "images/pdf.png";
                }
                else if (Path.GetExtension(filePath) == ".xls" || Path.GetExtension(filePath) == ".xlsx")
                {
                    src = "images/xls.png";
                }


                html += "<li><span class='icon-1'><img src='" + src + "' /></span><label>" + Path.GetFileName(filePath) + "</label><img src='images/del-icon.png' class='deletefile' onclick=\"DeleteFile('" + Path.GetFileName(filePath) + "');\"></li>";
            }
            html += "</ul>";
            context.Response.ContentType = "text/plain";
            context.Response.Write(html);
        }
        else
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("Please Select Files");
        }
       
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}