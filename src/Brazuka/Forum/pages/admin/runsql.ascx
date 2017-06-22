<%@ Control Language="C#" AutoEventWireup="true" Inherits="YAF.Pages.Admin.runsql" Codebehind="runsql.ascx.cs" %>
<YAF:PageLinks runat="server" ID="PageLinks" />
<YAF:AdminMenu ID="AdminMenu1" runat="server">
	<table class="content" width="100%" cellspacing="1" cellpadding="0">
		<tr>
			<td class="header1" colspan="2">
				Run SQL Query
			</td>
		</tr>
		<tr>
			<td class="postheader" style="width: 100px" valign="top">
				<strong>SQL Command:</strong>
			</td>
			<td class="post">
				<asp:TextBox ID="txtQuery" runat="server" TextMode="MultiLine" Width="100%" Height="100px"></asp:TextBox>
			</td>
		</tr>
		<tr class="footer1">
			<td colspan="2" align="center">                
                <asp:Checkbox ID="chkRunInTransaction" runat="server" Text="Run In Transaction" Checked="true" />
				<asp:Button ID="btnRunQuery" runat="server" Text="Run Query" OnClick="btnRunQuery_Click" />                
			</td>
		</tr>
		<asp:PlaceHolder ID="ResultHolder" runat="server" Visible="false">
			<tr>
				<td class="postheader" style="width: 100px" valign="top">
					<strong>Result:</strong>
				</td>
				<td class="post">
					<asp:TextBox ID="txtResult" runat="server" TextMode="MultiLine"  Width="100%" Height="300px" Wrap="false" style="font-size: 8pt;"></asp:TextBox>
				</td>
			</tr>
		</asp:PlaceHolder>
	</table>
</YAF:AdminMenu>
