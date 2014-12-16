<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContractStep2.aspx.cs" Inherits="AndriodSignalR.ContractStep2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/style.css" rel="stylesheet" />
     <script src="Scripts/jquery-1.10.2.min.js"></script>
    

   
</head>
<body>
    <form id="form1" runat="server">
    <%--<div>
           <div class="andImage">
                <a href="" class="urlImage"><img id="img1" src="~/images/step2.png" runat="server" alt="" /></a>
            </div>
           
        </div>--%>

          <asp:HyperLink CssClass="urlImage" ID="btnNext" NavigateUrl="" style="text-decoration:none;color:#333" runat="server">


                    <img id="img1" src="~/images/step2.png" runat="server" alt="" />
                </asp:HyperLink>
    </form>
</body>
</html>
