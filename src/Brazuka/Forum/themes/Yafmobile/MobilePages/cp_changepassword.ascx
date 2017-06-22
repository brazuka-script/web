<%@ Control Language="c#" CodeFile="cp_changepassword.ascx.cs" Inherits="YAF.Pages.cp_changepassword" %>
<YAF:PageLinks ID="PageLinks" runat="server" />
<div class="DivTopSeparator">
</div>
<div align="center">
	<asp:ChangePassword ID="ChangePassword1" runat="server" Width="100%">
        <ChangePasswordTemplate>
            <table class="content" border="0" cellpadding="1" cellspacing="0" style="border-collapse: collapse"
                width="100%">
                <tr>
                    <td class="header1">
                        <YAF:LocalizedLabel ID="LocalizedLabel1" runat="server" LocalizedTag="TITLE" />
                    </td>
                </tr>
                <tr>
                    <td align="center" class="postheader">
                        <asp:Label ID="CurrentPasswordLabel" runat="server" 
                            AssociatedControlID="CurrentPassword">
                            <YAF:LocalizedLabel ID="LocalizedLabel2" runat="server" 
                            LocalizedTag="OLD_PASSWORD" />
                        </asp:Label>
                        <br />
                        <asp:TextBox ID="CurrentPassword" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" 
                            ControlToValidate="CurrentPassword" ErrorMessage="Password is required." 
                            ToolTip="Password is required." ValidationGroup="ctl00$ChangePassword1">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="postheader">
                        <asp:Label ID="NewPasswordLabel" runat="server" 
                            AssociatedControlID="NewPassword">
                            <YAF:LocalizedLabel ID="LocalizedLabel3" runat="server" 
                            LocalizedTag="NEW_PASSWORD" />
                        </asp:Label>
                        <br />
                        <asp:TextBox ID="NewPassword" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" 
                            ControlToValidate="NewPassword" ErrorMessage="New Password is required." 
                            ToolTip="New Password is required." ValidationGroup="ctl00$ChangePassword1">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="postheader">
                        <asp:Label ID="ConfirmNewPasswordLabel" runat="server" 
                            AssociatedControlID="ConfirmNewPassword">
                            <YAF:LocalizedLabel ID="LocalizedLabel4" runat="server" 
                            LocalizedTag="CONFIRM_PASSWORD" />
                        </asp:Label>
                        <br />
                        <asp:TextBox ID="ConfirmNewPassword" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" 
                            ControlToValidate="ConfirmNewPassword" 
                            ErrorMessage="Confirm New Password is required." 
                            ToolTip="Confirm New Password is required." 
                            ValidationGroup="ctl00$ChangePassword1">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td align="center" style="color: red" class="post">
                        <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword"
                            ControlToValidate="ConfirmNewPassword" Display="Dynamic" ErrorMessage="The Confirm New Password must match the New Password entry."
                            ValidationGroup="ctl00$ChangePassword1"></asp:CompareValidator>
                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="footer1">
                        <asp:Button ID="ChangePasswordPushButton" runat="server" CommandName="ChangePassword"
                            Text="Change Password" ValidationGroup="ctl00$ChangePassword1" />
                        <asp:Button ID="CancelPushButton" runat="server" CausesValidation="False" CommandName="Cancel"
                            Text="Cancel" OnClick="CancelPushButton_Click" />
                    </td>
                </tr>
            </table>
        </ChangePasswordTemplate>
        <SuccessTemplate>
            <table class="content" border="0" cellpadding="1" cellspacing="0" style="border-collapse: collapse"
                width="700">
                <tr>
                    <td colspan="2" class="header1">
                        <YAF:LocalizedLabel ID="LocalizedLabel5" runat="server" LocalizedTag="TITLE" />
                        <%# GetText("TITLE") %>
                    </td>
                </tr>
                <tr>
                    <td class="post">
                        <YAF:LocalizedLabel ID="LocalizedLabel6" runat="server" LocalizedTag="CHANGE_SUCCESS" />
                </td></tr>
                <tr>
                    <td colspan="2" class="footer1" align="center">
                        <asp:Button ID="ContinuePushButton" runat="server" CausesValidation="False" CommandName="Continue"
                            Text="Continue" OnClick="ContinuePushButton_Click" />
                    </td>
                </tr>
            </table>
        </SuccessTemplate>
    </asp:ChangePassword>
<asp:ValidationSummary id="ValidationSummary1" runat="server" showmessagebox="True" showsummary="False" validationgroup="ctl00$ChangePassword1" />
</div>
<div id="DivSmartScroller">
	<YAF:SmartScroller ID="SmartScroller1" runat="server" />
</div>
