<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Congratualtions.aspx.cs" Inherits="AndriodSignalR.Congratualtions" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%-- <link href="css/style.css" rel="stylesheet" />--%>

    <link href="css/styleAnd.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">


        <%--  <div class="welcome_page">

             <span class="congracts-txt">Enhorabuena</span>
             <div class="wish-box">La Firma ha sido envaida con exito</div>
            <div class="andriod_footer">
                <asp:Label ID="lblmydevicename" runat="server" CssClass="left_align"></asp:Label>
                <asp:Label ID="lblConnection" ForeColor="Green" runat="server" CssClass="right_align"></asp:Label>
            </div>

        </div>--%>

        <%-- <div class="congrats_page">
                <div class="andriod_footer">
                    <asp:Label ID="lblmydevicename" runat="server" CssClass="left_align"></asp:Label>
                    <asp:Label ID="lblConnection" ForeColor="Red" runat="server" CssClass="right_align"></asp:Label>
                </div>
            </div>--%>

        <%--<div class="inr_wrpr notp2">

            <div class="logo_tab notp notp1">
                <img src="images/logo.png" alt="" /></div>
            <div class="tab_icon">
                <img src="images/tab_icon.png" alt="" />
            </div>
            <div class="tab_textarea">
                Enhorabuena!<br />
                La firma ha sido<br />
                enviada con exito.
            </div>
            <div class="belowarea_tab top242">
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
                <img src="images/connect.png" alt="">
                <asp:Label ID="lblConnection" ForeColor="Green" runat="server" CssClass="right_align"></asp:Label>
            </p>
                </div>
        </div>--%>

         <div class="inr_wrpr notp2">

        <div class="logo_tab notp notp1">
            <img src="images/logo.png" alt="" /></div>
        <div class="tab_icon">
            <img src="images/tab_icon.png" alt="" />
        </div>
        <div class="tab_textarea">
            Enhorabuena!<br />
            La firma ha sido<br />
            enviada con exito.
        </div>
        <div class="belowarea_tab top242">
            <p>financiado por</p>
            <img src="images/ft_logo.png" alt="" />
        </div>
        <div class="clear"></div>
    </div>
    <div class="tab_footer">
        <p class="ft_lft">Android Device Friendly Name</p>
        <p class="ft_ryt">
            <img src="images/disconnect.png" alt="">Not connected</p>
    </div>

    <div class="tab_footer">
        <div class="ftr_wrpr">
            <p class="ft_lft">
              <asp:Label ID="lblmydevicename" runat="server" CssClass="left_align"></asp:Label>
            </p>
            <p class="ft_ryt">
                <img alt="" src="images/connect.png">
            <asp:Label ID="lblConnection" ForeColor="Green" runat="server" CssClass="right_align"></asp:Label>
            </p>
        </div>
    </div>

    </form>
</body>
</html>
