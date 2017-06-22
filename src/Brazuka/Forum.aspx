<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Forum.aspx.cs" Inherits="Forum" %>
<%@ Register TagPrefix="YAF" Assembly="YAF" Namespace="YAF" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphConteudo" Runat="Server">
    <div id="container_texto_full_width_height" class="container" runat="server">
        <form id="form1" runat="server" enctype="multipart/form-data">
            <%--<YAF:Forum runat="server" ID="forum" BoardID="1">
            </YAF:Forum>--%>
            <YAF:Forum runat="server" ID="forum">
            </YAF:Forum>
        </form>
    </div>
</asp:Content>

