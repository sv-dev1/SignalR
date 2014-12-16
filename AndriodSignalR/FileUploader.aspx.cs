using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Hosting;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AndriodSignalR
{
    public partial class FileUploader : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            foreach (string s in Request.Files)
            {
                HttpPostedFile file = Request.Files[s];

                int fileSizeInBytes = file.ContentLength;
                string fileName = Path.GetFileNameWithoutExtension(Path.Combine(Server.MapPath("/Uploads"), file.FileName));
                string fileExtension = "";

                if (!string.IsNullOrEmpty(file.FileName))
                    fileExtension = Path.GetExtension(file.FileName);

                string savedFileName = Path.Combine(Server.MapPath("/Uploads"), fileName + fileExtension);
                if (!File.Exists(Path.Combine(Server.MapPath("/Uploads"), fileName + fileExtension)))
                {
                    file.SaveAs(savedFileName);
                    //ClientScript.RegisterStartupScript(GetType(), "Load", String.Format("<script type='text/javascript'>DisplayFiles();</script>", ""));
                }

            }
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
                else if (Path.GetExtension(filePath) == ".pdf")
                {
                    src = "images/pdf.png";
                }
                else if (Path.GetExtension(filePath) == ".xls" || Path.GetExtension(filePath) == ".xlsx")
                {
                    src = "images/xls.png";
                }


                html += "<li><img src='" + src + "' /><label>" + Path.GetFileName(filePath) + "</label><img src='images/del-icon.png' class='deletefile' onclick=\"DeleteFile('" + Path.GetFileName(filePath) + "');\"></li>";
            }
            html += "</ul>";

            if (html == "")
            {
                html = "No File(s) Found !!!!";
            }
            return html;
        }

    }
}