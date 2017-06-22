



<%@ Control language="c#" AutoEventWireup="True" Inherits="YAF.Pages.Admin.editforum" Codebehind="editforum.ascx.cs" %>
<YAF:PageLinks runat="server" id="PageLinks" />
<YAF:adminmenu runat="server" id="Adminmenu1">
	<table class="content" cellspacing="1" cellpadding="0" width="100%">
		<tr>
			<td class="header1" colspan="2">Edit Forum:
				<asp:label id="ForumNameTitle" runat="server"></asp:label></td>
		</tr>
		<tr>
			<td class="postheader"><strong>Category:</strong><br />
				What category to put the forum under.</td>
			<td class="post">
				<asp:dropdownlist id="CategoryList" runat="server" OnSelectedIndexChanged="Category_Change" DataValueField="CategoryID" DataTextField="Name"></asp:dropdownlist></td>
		</tr>
		<tr>
			<td class="postheader"><strong>Parent Forum:</strong><br />
				Will make this forum a sub forum of another forum.</td>
			<td class="post">
				<asp:dropdownlist id="ParentList" runat="server"></asp:dropdownlist></td>
		</tr>
		<tr>
			<td class="postheader"><strong>Name:</strong><br />
				The name of the forum.</td>
			<td class="post">
				<asp:textbox id="Name" runat="server" cssclass="edit"></asp:textbox></td>
		</tr>
		<tr>
			<td class="postheader"><strong>Description:</strong><br />
				A description of the forum.</td>
			<td class="post">
				<asp:textbox id="Description" runat="server" cssclass="edit"></asp:textbox></td>
		</tr>			
		<tr>
			<td class="postheader"><strong>Remote URL:</strong><br />
				Enter a url here, and instead of going to the forum you will be taken to this 
				url instead.</td>
			<td class="post">
				<asp:textbox id="remoteurl" runat="server" cssclass="edit"></asp:textbox></td>
		</tr>
		<tr>
			<td class="postheader"><strong>Theme :</strong><br />
				Choose a theme for this forum if its to differ from the standard Board theme.</td>
			<td class="post">
				<asp:Dropdownlist id="ThemeList" runat="server"></asp:Dropdownlist></td>
		</tr>
		<tr>
			<td class="postheader"><strong>SortOrder:</strong><br />
				Sort order under this category.</td>
			<td class="post">
				<asp:textbox id="SortOrder" Style="width: 50px" MaxLength="5" runat="server"></asp:textbox></td>
		</tr>
		<tr>
			<td class="postheader"><strong>Hide if no access:</strong><br />
				Means that the forum will be hidden when the user don't have read access to it.</td>
			<td class="post">
				<asp:checkbox id="HideNoAccess" runat="server"></asp:checkbox></td>
		</tr>
		<tr>
			<td class="postheader"><strong>Locked:</strong><br />
				If the forum is locked, no one can post or reply in this forum.</td>
			<td class="post">
				<asp:checkbox id="Locked" runat="server"></asp:checkbox></td>
		</tr>
		<tr>
			<td class="postheader"><strong>No posts count:</strong><br />
				If this is checked, posts in this forum will not count in the ladder system/forum statistics.</td>
			<td class="post">
				<asp:checkbox id="IsTest" runat="server"></asp:checkbox></td>
		</tr>
		<tr>
			<td class="postheader"><strong>Pre-moderated:</strong><br />
				If the forum is moderated, posts have to be approved by a moderator.</td>
			<td class="post">
				<asp:checkbox id="Moderated" runat="server"></asp:checkbox></td>
		</tr>
		<tr>
			<td class="postheader">
			
			<strong>Forum Image:</strong><br />
			
			This image will be shown next to this forum, 
			if empty default image for the forum is used.</td>
			
			<td class="post">
			
			<asp:DropDownList ID="ForumImages" runat="server" />
			
			<img align="middle" runat="server" id="Preview" />
			</td>
		</tr>		
		<tr visible="false" runat="server">
			<td class="postheader"><strong>Styles:</strong><br />
				Styles string to customize Forum Name. Leave it empty.</td>
			<td class="post">
				<asp:textbox id="Styles" runat="server"></asp:textbox></td>
		</tr>		
		<tr id="NewGroupRow" runat="server">
			<td class="postheader"><strong>Initial Access Mask:</strong><br />
				The initial access mask for all forums.</td>
			<td class="post">
				<asp:dropdownlist id="AccessMaskID" ondatabinding="BindData_AccessMaskID" runat="server"></asp:dropdownlist></td>
		</tr>
		<asp:repeater id="AccessList" runat="server">
			<HeaderTemplate>
				<tr>
					<td class="header1" colspan="2">Access</td>
				</tr>
				<tr class="header2">
					<td>Group</td>
					<td>Access Mask</td>
				</tr>
			</HeaderTemplate>
			<ItemTemplate>
				<tr>
					<td class="postheader">
						<asp:label id="GroupID" visible="false" runat="server" text='<%# Eval( "GroupID") %>'>
						</asp:label>
						<%# Eval( "GroupName") %>
					</td>
					<td class="post">
						<asp:dropdownlist runat="server" id="AccessMaskID" ondatabinding="BindData_AccessMaskID" onprerender="SetDropDownIndex" value='<%# Eval("AccessMaskID") %>'/>
						...
					</td>
				</tr>
			</ItemTemplate>
		</asp:repeater>
		<tr>
			<td class="postfooter" align="center" colspan="2">
				<asp:button id="Save" runat="server" Text="Save"></asp:button>&nbsp;
				<asp:Button id="Cancel" runat="server" Text="Cancel"></asp:Button></td>
		</tr>
	</table>
</YAF:adminmenu>
<YAF:SmartScroller id="SmartScroller1" runat = "server" />
