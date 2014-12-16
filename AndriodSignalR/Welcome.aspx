<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Welcome.aspx.cs" Inherits="AndriodSignalR.Idle" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/styleAnd.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="Scripts/jquery-1.10.2.min.js"></script>



</head>
<body>
    <form id="form1" runat="server">

        <%-- <div class="welcome_page">
                <div class="andriod_footer">
                    <asp:Label ID="lblmydevicename" runat="server" CssClass="left_align"></asp:Label>
                    <asp:Label ID="lblConnection" ForeColor="Green" runat="server" CssClass="right_align"></asp:Label>
                </div>
            </div>--%>



      <%--  <div class="inr_wrpr">
            <h1>Bienvenido!</h1>
            <div class="logo_tab">
                <img src="images/logo.png" alt="" />
            </div>
            <div class="belowarea_tab">
                <p>financiado por</p>
                <img src="images/ft_logo.png" alt="" />
            </div>
            <div class="clear"></div>
        </div>

        <div class="tab_footer">
            <div class="ftr_wrpr">
            <p class="ft_lft">
               
            </p>
            <p class="ft_ryt">
                <img src="images/connect.png" alt="">
            
            </p>
                </div>
        </div>--%>


         <div class="inr_wrpr">
        <h1>Bienvenido!</h1>
        <div class="logo_tab">
            <img src="images/logo.png" alt="" /></div>
        <div class="belowarea_tab">
            <p>financiado por</p>
            <img src="images/ft_logo.png" alt="" />
        </div>
        <div class="clear"></div>
    </div>
    <div class="tab_footer">
        <div class="ftr_wrpr">
            <p class="ft_lft">
         
                 <asp:Label ID="lblmydevicename" runat="server" CssClass="left_align"></asp:Label>
            </p>
            <p class="ft_ryt">
                <img alt="" src="images/connect.png">
               
                     <asp:Label ID="lblConnection" ForeColor="#79ba00" runat="server" CssClass="right_align"></asp:Label>
            </p>
        </div>
    </div>

    </form>
</body>
</html>
