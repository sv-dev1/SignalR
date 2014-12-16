<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContractStep1.aspx.cs" Inherits="AndriodSignalR.ContractStep1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <link href="css/style.css" rel="stylesheet" />
    <script type="text/javascript">
      
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
           <div class="andImage">
                <asp:HyperLink CssClass="urlImage" ID="btnNext" NavigateUrl="" style="text-decoration:none;color:#333" runat="server">
                    <img id="img1" src="~/images/step1.png" runat="server" alt="" />
                </asp:HyperLink>
           </div>
        </div>
    </form>
</body>
</html>
