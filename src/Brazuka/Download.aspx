<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Download.aspx.cs" Inherits="Download" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphConteudo" Runat="Server">
    <div id="container_texto_full_width" class="container center">
        <br /><br /><br /><br />
        <form id="form1" runat="server">
            <asp:Image ID="logoDownload" runat="server" ImageUrl="~/Images/logo260x50.png" />
            <br />
            <asp:Label ID="lblDownload" runat="server" Text="Plugin Eclispe version 1.0, baixe primeiro o Eclipse"></asp:Label>
            <br />
            <asp:Button ID="btnDownload" runat="server" Text="Download" 
                onclick="btnDownload_Click" />
            <br /><br /><br /><br /><br />
            <asp:Panel ID="pnlDeBaixo" CssClass="marginCenter" Width="620" runat="server">
                <asp:Panel ID="pnlEclipseDownload" CssClass="floatLeft" Width="310" runat="server">
                    <asp:Image ID="imgEclipseIde" style="vertical-align:middle" runat="server" ImageUrl="~/Images/eclipse_indigo.jpg" />&nbsp;&nbsp;<span style="color:#7036BE; font-size:25px;">Eclipse Indigo IDE</span>
                    <br />
                    <asp:DropDownList ID="ddlEscolherSistema" runat="server">
                        <asp:ListItem Selected="True">Escolha o sistema</asp:ListItem>
                        <asp:ListItem Value="1">Windows 32-bits</asp:ListItem>
                        <asp:ListItem Value="2">Windows 64-bits</asp:ListItem>
                        <asp:ListItem Value="3">Mac Cocoa 32-bits</asp:ListItem>
                        <asp:ListItem Value="4">Mac Cocoa 64-bits</asp:ListItem>
                        <asp:ListItem Value="5">Linux 32-bits</asp:ListItem>
                        <asp:ListItem Value="6">Linux 64-bits</asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <asp:Button ID="btnDownloadEclipse" runat="server" Text="Download" 
                        onclick="btnDownloadEclipse_Click" />
                </asp:Panel>
                <asp:Panel ID="pnlManual" CssClass="floatLeft" Width="310" runat="server">
                    <asp:Image ID="imgPDF" style="vertical-align:middle" runat="server" 
                        ImageUrl="~/Images/adobe-pdf-icon-200x200-150x150.png" />&nbsp;&nbsp;<span style="color:Blue; font-size:25px;">Manual Usuário</span>
                    <br />
                    <br />
                    <asp:Button ID="btnDownloadManual" runat="server" Text="Download" 
                        onclick="btnDownloadManual_Click" />
                </asp:Panel>
            </asp:Panel>
        </form>
    </div>
</asp:Content>

