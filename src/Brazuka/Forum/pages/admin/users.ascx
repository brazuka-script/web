<%@ Control Language="c#" AutoEventWireup="True" Inherits="YAF.Pages.Admin.users"
    CodeBehind="users.ascx.cs" %>
<%@ Import Namespace="YAF.Classes.Core" %>
<%@ Import Namespace="YAF.Classes.Core.BBCode" %>
<YAF:PageLinks runat="server" ID="PageLinks" />
<YAF:AdminMenu runat="server" ID="Adminmenu1">
    <table cellspacing="0" cellpadding="0" class="content" width="100%">
        <tr>
            <td class="header1" colspan="4">
                <strong>Search Users</strong>
            </td>
        </tr>
        <tr class="header2">
            <td>
                Role:
            </td>
            <td>
                Rank:
            </td>
            <td>
                User Name Contains:
            </td>
            <td>
                Email Contains:
            </td>
        </tr>
        <tr class="post">
            <td>
                <asp:DropDownList ID="group" runat="server" Width="95%">
                </asp:DropDownList>
            </td>
            <td>
                <asp:DropDownList ID="rank" runat="server" Width="95%">
                </asp:DropDownList>
            </td>
            <td>
                <asp:TextBox ID="name" runat="server" Width="95%"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="Email" runat="server" Width="95%"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="post" colspan="3" align="right">
                Filter by join date since:
            </td>
            <td>
                <asp:DropDownList ID="Since" runat="server" Width="95%" AutoPostBack="True" OnSelectedIndexChanged="Since_SelectedIndexChanged" />
            </td>
        </tr>
        <tr>
            <td class="footer1" colspan="4" align="right">
                <asp:Button ID="search" runat="server" OnClick="search_Click" Text="Search"></asp:Button>
            </td>
        </tr>
    </table>
    <br />
    <YAF:Pager ID="PagerTop" runat="server" OnPageChange="PagerTop_PageChange" UsePostBack="True" />
    <table class="content" cellspacing="1" cellpadding="0" width="100%">
        <tr>
            <td class="header1" colspan="8">
                Users
            </td>
        </tr>
        <tr>
            <td class="header2">
                User Name
            </td>
            <td class="header2">
                Display Name
            </td>
            <td class="header2">
                Email
            </td>
            <td class="header2">
                Rank
            </td>
            <td class="header2" align="center">
                Posts
            </td>
            <td class="header2" align="center">
                Approved
            </td>
            <td class="header2">
                Last Visit
            </td>
            <td class="header2">
                &nbsp;
            </td>
        </tr>
        <asp:Repeater ID="UserList" runat="server" OnItemCommand="UserList_ItemCommand">
            <ItemTemplate>
                <tr>
                    <td class="post">
                        <asp:LinkButton ID="NameEdit" runat="server" CommandName="edit" CommandArgument='<%# Eval("UserID") %>'
                            Text='<%# YafBBCode.EncodeHTML( Eval("Name").ToString() ) %>' />
                    </td>
                    <td class="post">
                        <asp:LinkButton ID="DisplayNameEdit" runat="server" CommandName="edit" CommandArgument='<%# Eval("UserID") %>'
                            Text='<%# YafBBCode.EncodeHTML( Eval("DisplayName").ToString() ) %>' />
                    </td>
                    <td class="post">
                        <%# DataBinder.Eval(Container.DataItem,"Email") %>
                    </td>
                    <td class="post">
                        <%# Eval("RankName") %>
                    </td>
                    <td class="post" align="center">
                        <%# Eval( "NumPosts") %>
                    </td>
                    <td class="post" align="center">
                        <%# BitSet(Eval( "Flags"),2) %>
                    </td>
                    <td class="post">
                        <%# this.Get<YafDateTime>().FormatDateTime((System.DateTime)((System.Data.DataRowView)Container.DataItem)["LastVisit"]) %>
                    </td>
                    <td class="post" align="center">
                        <asp:LinkButton runat="server" CommandName="edit" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "UserID") %>'
                            ID="Linkbutton3" name="Linkbutton1">Edit</asp:LinkButton>
                        |
                        <asp:LinkButton OnLoad="Delete_Load" runat="server" CommandName="delete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "UserID") %>'
                            ID="Linkbutton4" name="Linkbutton2">Delete</asp:LinkButton>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
        <tr>
            <td class="footer1" colspan="8">
                <strong>
                    <asp:LinkButton ID="NewUser" OnClick="NewUser_Click" runat="server">New User</asp:LinkButton></strong>
                | <strong>
                    <asp:LinkButton ID="SyncUsers" OnClick="SyncUsers_Click" runat="server" OnClientClick="return confirm('Are you sure?');">Sync All Membership Users</asp:LinkButton></strong>
            </td>
        </tr>
    </table>
    <YAF:Pager ID="PagerBottom" runat="server" LinkedPager="PagerTop" UsePostBack="True" />
</YAF:AdminMenu>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:Timer ID="UpdateStatusTimer" runat="server" Enabled="false" Interval="4000"
            OnTick="UpdateStatusTimer_Tick" />
    </ContentTemplate>
</asp:UpdatePanel>
<div>
    <div id="SyncUsersMessage" style="display: none" class="ui-overlay">
        <div class="ui-widget ui-widget-content ui-corner-all">
            <h2>
                Syncing Users</h2>
            <p>
                Please do not navigate away from this page while the sync is in progress...</p>
            <div align="center">
                <asp:Image ID="LoadingImage" runat="server" alt="Processing..." />
            </div>
            <br />
        </div>
    </div>
</div>
<YAF:SmartScroller ID="SmartScroller1" runat="server" />
