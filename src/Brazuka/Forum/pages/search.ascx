<%@ Control Language="c#" AutoEventWireup="True" Inherits="YAF.Pages.search" CodeBehind="search.ascx.cs" %>
<%@ Import Namespace="YAF.Classes.Core" %>
<%@ Register Namespace="nStuff.UpdateControls" Assembly="nStuff.UpdateControls" TagPrefix="nStuff" %>
<YAF:PageLinks ID="PageLinks" runat="server" />
<script type="text/javascript">
    function EndRequestHandler(sender, args) {
        $('#<%=LoadingModal.ClientID%>').dialog('close');
    }
    function ShowLoadingDialog() {
        $('#<%=LoadingModal.ClientID%>').dialog('open');
    }
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
</script>
<nStuff:UpdateHistory ID="UpdateHistory" runat="server" OnNavigate="OnUpdateHistoryNavigate" />
<table cellpadding="0" cellspacing="1" class="content" width="100%">
    <tr>
        <td class="header1" colspan="2">
            <YAF:LocalizedLabel runat="server" LocalizedTag="title" />
        </td>
    </tr>
    <tr>
        <td align="center" class="postheader" colspan="2">
            <asp:DropDownList ID="listForum" runat="server" />
            <asp:DropDownList ID="listResInPage" runat="server" />
        </td>
    </tr>
    <tr>
        <td align="right" class="postheader" width="35%">
            <YAF:LocalizedLabel runat="server" LocalizedTag="postedby" />
        </td>
        <td align="left" class="postheader">
            <asp:TextBox ID="txtSearchStringFromWho" runat="server" Width="350px" />
            <asp:DropDownList ID="listSearchFromWho" runat="server" />
        </td>
    </tr>
    <tr>
        <td align="right" class="postheader" width="35%">
            <YAF:LocalizedLabel runat="server" LocalizedTag="posts" />
        </td>
        <td align="left" class="postheader">
            <asp:TextBox ID="txtSearchStringWhat" runat="server" Width="350px" />
            <asp:DropDownList ID="listSearchWhat" runat="server" />
        </td>
    </tr>
    <tr>
        <td align="center" class="postheader" colspan="2">
            <asp:Button ID="btnSearch" runat="server" CssClass="pbutton" OnClick="btnSearch_Click"
                OnClientClick="ShowLoadingDialog(); return true;" Visible="false" />
            <asp:Button ID="btnSearchExt1" runat="server" CssClass="pbutton" Visible="false"
                OnClick="BtnExtSearch1_Click" />
            <asp:Button ID="btnSearchExt2" runat="server" CssClass="pbutton" Visible="false"
                OnClick="BtnExtSearch2_Click" />
        </td>
    </tr>
</table>
<br />
<asp:UpdatePanel ID="SearchUpdatePanel" runat="server" UpdateMode="Conditional">
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="btnSearch" />
    </Triggers>
    <ContentTemplate>
        <YAF:Pager runat="server" ID="Pager" OnPageChange="Pager_PageChange" />
        <asp:Repeater ID="SearchRes" runat="server" OnItemDataBound="SearchRes_ItemDataBound">
            <HeaderTemplate>
                <table class="content" cellspacing="1" cellpadding="0" width="100%">
                    <tr>
                        <td class="header1" colspan="2">
                            <YAF:LocalizedLabel runat="server" LocalizedTag="RESULTS" />
                        </td>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr class="header2">
                    <td colspan="2">
                        <strong>
                            <YAF:LocalizedLabel runat="server" LocalizedTag="topic" />
                        </strong><a href="<%# YafBuildLink.GetLink(ForumPages.posts,"t={0}", Container.DataItemToField<int>("TopicID")) %>">
                            <%# HtmlEncode(Container.DataItemToField<string>("Topic")) %>
                        </a>
                    </td>
                </tr>
                <tr class="postheader">
                    <td width="140px" id="NameCell" valign="top">
                        <a name="<%# Container.DataItemToField<int>("MessageID") %>" /><strong>
                            <YAF:UserLink ID="UserLink1" runat="server" UserID='<%# Container.DataItemToField<int>("UserID") %>' />
                        </strong>
                        <YAF:OnlineStatusImage ID="OnlineStatusImage" runat="server" Visible='<%# PageContext.BoardSettings.ShowUserOnlineStatus && !UserMembershipHelper.IsGuestUser( Container.DataItemToField<int>("UserID") )%>'
                            Style="vertical-align: bottom" UserID='<%# Container.DataItemToField<int>("UserID") %>' />
                    </td>
                    <td width="80%" class="postheader">
                        <strong>
                            <YAF:LocalizedLabel runat="server" LocalizedTag="POSTED" />
                        </strong>
                        <%# this.Get<YafDateTime>().FormatDateTime( Container.DataItemToField<DateTime>("Posted") )%>
                    </td>
                </tr>
                <tr class="post">
                    <td colspan="2">
                        <YAF:MessagePostData ID="MessagePostPrimary" runat="server" ShowAttachments="false"
                            ShowSignature="false" HighlightWords="<%# this.HighlightSearchWords %>" DataRow="<%# Container.DataItem %>">
                        </YAF:MessagePostData>
                    </td>
                </tr>
            </ItemTemplate>
            <AlternatingItemTemplate>
                <tr class="header2">
                    <td colspan="2">
                        <strong>
                            <YAF:LocalizedLabel runat="server" LocalizedTag="topic" />
                        </strong><a href="<%# YafBuildLink.GetLink(ForumPages.posts,"t={0}", Container.DataItemToField<int>("TopicID")) %>">
                            <%# Container.DataItemToField<string>("Topic") %>
                        </a>
                    </td>
                </tr>
                <tr class="postheader">
                    <td width="140px" id="NameCell" valign="top">
                        <a name="<%# Container.DataItemToField<int>("MessageID") %>" /><strong>
                            <YAF:UserLink ID="UserLink1" runat="server" UserID='<%# Container.DataItemToField<int>("UserID") %>' />
                        </strong>
                        <YAF:OnlineStatusImage ID="OnlineStatusImage" runat="server" Visible='<%# PageContext.BoardSettings.ShowUserOnlineStatus && !UserMembershipHelper.IsGuestUser( Container.DataItemToField<int>("UserID") )%>'
                            Style="vertical-align: bottom" UserID='<%# Container.DataItemToField<int>("UserID") %>' />
                    </td>
                    <td width="80%" class="postheader">
                        <strong>
                            <YAF:LocalizedLabel runat="server" LocalizedTag="POSTED" />
                        </strong>
                        <%# this.Get<YafDateTime>().FormatDateTime( Container.DataItemToField<DateTime>("Posted") )%>
                    </td>
                </tr>
                <tr class="post_alt">
                    <td colspan="2">
                        <YAF:MessagePostData ID="MessagePostAlt" runat="server" ShowAttachments="false" ShowSignature="false"
                            HighlightWords="<%# this.HighlightSearchWords %>" DataRow="<%# Container.DataItem %>">
                        </YAF:MessagePostData>
                    </td>
                </tr>
            </AlternatingItemTemplate>
            <FooterTemplate>
                <tr>
                    <td class="footer1" colspan="2">
                    </td>
                </tr>
                </table>
            </FooterTemplate>
        </asp:Repeater>
        <asp:PlaceHolder ID="NoResults" runat="Server" Visible="false">
            <table class="content" cellspacing="1" cellpadding="0" width="100%">
                <tr>
                    <td class="header1" colspan="2">
                        <YAF:LocalizedLabel runat="server" LocalizedTag="RESULTS" />
                    </td>
                </tr>
                <tr>
                    <td class="postheader" colspan="2" align="center">
                        <br />
                        <YAF:LocalizedLabel runat="server" LocalizedTag="NO_SEARCH_RESULTS" />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td class="footer1" colspan="2">
                    </td>
                </tr>
            </table>
        </asp:PlaceHolder>
        <YAF:Pager ID="Pager1" runat="server" LinkedPager="Pager" />
    </ContentTemplate>
</asp:UpdatePanel>
<DotNetAge:Dialog ID="LoadingModal" runat="server" DialogButtons="None" ShowModal="true">
    <BodyTemplate runat="server">
        <span class="modalOuter"><span class="modalInner">
            <asp:Literal ID="LoadingModalText" runat="server" OnLoad="LoadingModalText_Load"></asp:Literal>
        </span></span><span style="display: block; margin: 0 auto; text-align: center;">
            <asp:Image ID="LoadingImage" runat="server" alt="Searching..." OnLoad="LoadingImage_Load" />
        </span>
    </BodyTemplate>
</DotNetAge:Dialog>
<div id="DivSmartScroller">
    <YAF:SmartScroller ID="SmartScroller1" runat="server" />
</div>
