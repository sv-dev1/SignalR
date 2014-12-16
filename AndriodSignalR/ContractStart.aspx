<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContractStart.aspx.cs" Inherits="AndriodSignalR.ContractStart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="css/styleAnd.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <%--  <div>

       <div class="andImageBack">
             
              </div>
        <div style="clear:both""></div>
            <div class="andriod_footer">
                <asp:Label ID="lblmydevicename" runat="server"></asp:Label>
                <asp:Label ID="lblConnection" runat="server"></asp:Label>
            </div>
    </div>--%>

        <%-- <div class="welcome_page">
            
               <asp:HyperLink ID="btnNext" CssClass="signature-btn andriodbtn" NavigateUrl="" Text="Comenzar" runat="server" />
            <div class="andriod_footer">
                <asp:Label ID="lblmydevicename" runat="server" CssClass="left_align">dgfd</asp:Label>
                <asp:Label ID="lblConnection" ForeColor="Green" runat="server" CssClass="right_align">gdsfgsdfg</asp:Label>
            </div>

      </div>--%>


 <%--       <div class="inr_wrpr">
            <h1>Bienvenido!</h1>
            <div class="logo_tab notp">
                <img src="images/logo.png" alt="" /></div>
       
            <asp:HyperLink ID="btnNext" CssClass="andriodbtn" NavigateUrl="" Text="Comenzar" runat="server" />
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
                <img src="images/connect.png" alt="">
                <asp:Label ID="lblConnection" ForeColor="#79ba00" runat="server" CssClass="right_align"></asp:Label>
            </p>
                </div>
        </div>--%>
         <div class="inr_wrpr contract-page">
        <h1>Bienvenido!</h1>
        <div class="logo_tab notp">
            <img src="images/logo.png" alt="" /></div>
       <asp:HyperLink ID="btnNext" CssClass="andriodbtn" NavigateUrl="" Text="Comenzar" runat="server" />
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
