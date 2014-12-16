<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AndWelcome.aspx.cs" Inherits="AndriodSignalR.Idle" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-1.10.2.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            var desktop = getUrlVars()["deskdevice"];
            $('#imgwelcome').click(function () {
                window.location.href = "http://websignalr.kindlebit.com/ContractStart.aspx?deskdevice=" + desktop;
            });

        });

        function getUrlVars() {
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }
            return vars;
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h1>IDLE page</h1>
  
       <img src="" id="imgwelcome" alt="" />

        <asp:Label ID="lblmydevicename" runat="server"></asp:Label>
        <asp:Label ID="lblConnection" runat="server"></asp:Label>
    </div>
    </form>
</body>
</html>
