﻿<%@ Control Language="C#" AutoEventWireup="true" Inherits="YAF.Controls.EditUsersKill" Codebehind="EditUsersKill.ascx.cs" %>
<table class="content" width="100%" cellspacing="1" cellpadding="0">
	<tr runat="server" id="trHeader">
		<td class="header1" colspan="2">
			Kill User's Activity
		</td>
	</tr>
	<tr>
		<td class="postheader">
			<strong>IP Addresses:</strong>
		</td>
		<td class="post">
			<asp:Literal ID="IpAddresses" runat="server"></asp:Literal>
		</td>
	</tr>	
	<tr>
		<td class="postheader">
			<strong>Ban IP Addresses of User?</strong>
		</td>
		<td class="post">
			<asp:CheckBox ID="BanIps" runat="server" />
		</td>
	</tr>	
	<tr>
		<td class="postheader">
			<strong>Delete all Posts for User?</strong>
		</td>
		<td class="post">
			<strong><asp:Literal ID="PostCount" runat="server"></asp:Literal></strong> (<asp:HyperLink ID="ViewPostsLink" runat="server" Target="_blank">View All</asp:HyperLink>)
		</td>
	</tr>	
	<tr>
		<td colspan="2" class="footer1" align="center">
			<asp:Button runat="server" ID="Kill" Text="Kill User" CssClass="pbutton" OnClientClick="return confirm('Are you sure you want to delete all posts by and optionally ban all IP addreess for this user?');" OnClick="Kill_OnClick" />
		</td>
	</tr>
</table>