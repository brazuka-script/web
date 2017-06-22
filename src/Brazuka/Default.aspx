<%--<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>--%>

<%@ Page Title="BrazukaScript" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" Trace="false"%>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphConteudo" Runat="Server">
    <div id="container_texto" class="container justify">
        <div id="margem">
            <asp:Image ID="Image2" runat="server" ImageUrl="~/Images/lg_logo_anhanguera_nova.png" Width="560px" Height="360px" />
            <h1><span>Lorem Ipsum</span></h1>
            <%--<p>
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi tristique sagittis erat et sollicitudin.
                Suspendisse fermentum pharetra purus, vel ullamcorper ligula consectetur sit amet. Praesent blandit 
                lectus non quam iaculis in porta metus faucibus. Praesent lectus neque, ornare gravida volutpat ut, 
                consectetur in justo. Ut mollis tellus dui, ac adipiscing dui. Vivamus cursus ante sed sapien consequat vestibulum. 
                Sed commodo neque gravida enim adipiscing gravida. Nam id fermentum nisi. Cras sed mollis leo. 
                Donec varius fermentum turpis, ac tristique orci sodales ut. Maecenas at ultrices magna. Etiam nec euismod enim.
            </p>
            <p>
                In ac dapibus eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; 
                Nunc hendrerit felis eget orci consectetur nec semper ligula mattis. Vestibulum ante ipsum primis in faucibus 
                orci luctus et ultrices posuere cubilia Curae; Pellentesque viverra iaculis magna non interdum.
            </p>--%>
        </div>
    </div>
    <div id="container_user_home" class="container" runat="server">
        <form id="form1" runat="server">
      
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="udpModal" runat="server">
                <ContentTemplate>
                    <asp:Panel ID="modal" CssClass="modal" runat="server" style="display:none;" >
                        <asp:Panel ID="gridviewPanel" runat="server" ScrollBars="Auto" Height="200">
                            <asp:GridView ID="grvAmigos" runat="server" DataSourceID="sdsAmigosAceitar" 
                                AllowPaging="True" AutoGenerateColumns="False" ShowHeader="False" 
                                BorderStyle="None" GridLines="None" PageSize="3" HorizontalAlign="Center" 
                                onrowcommand="grvAmigos_RowCommand">
                                <Columns>
                                    <asp:ImageField DataImageUrlField="NroAluno" 
                                        DataImageUrlFormatString="HandlerImage.ashx?idAluno={0}">
                                        <ControlStyle Width="80px" Height="80px" />
                                    </asp:ImageField>
                                    <asp:BoundField DataField="NmeAluno">
                                    <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:ButtonField Text="Aceitar" ButtonType="Button" CommandName="Aceitar" />
                                    <asp:ButtonField Text="Cancelar" ButtonType="Button" CommandName="Cancelar" />
                                </Columns>
                                <RowStyle HorizontalAlign="Center" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsAmigosAceitar" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:conStr %>" >
                            </asp:SqlDataSource>
                        </asp:Panel>
                        <asp:FileUpload ID="fulUserImageModal" runat="server" style="display:none;" ToolTip="Imagem" />
                        <asp:Button ID="btnSubmitModal" runat="server" Text="Confirmar" 
                            onclick="btnSubmitModal_Click" />
                        <asp:Button ID="btnCloseModal" runat="server" Text="Fechar" 
                            onclick="btnCloseModal_Click" />
                    </asp:Panel>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnSubmitModal" />
                </Triggers>
            </asp:UpdatePanel>
            <asp:UpdatePanel ID="udpContainer_user" runat="server">
                <ContentTemplate></ContentTemplate>
            </asp:UpdatePanel>
            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                    <!--Sombra que bloquea toda ação no site na apresentação da modal-->
                    <div id="shadeUpdate"></div>
                    <div id="modalUpdate" >
                        <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/loading.gif" />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <br/>
        </form>
    </div>
    <br />
    <div id="container_links" class="container">
        <h4 id="lblLinksInteressantes" class="lnkBlue">Links Interessantes</h4>
        <input type="image" name="imgMsdn_Lik" id="imgMsdn_Lik"
            src="Images/Msdn_logo.png" align="middle" onclick="window.open(&quot;http://msdn.microsoft.com/pt-br/ms348103.html&quot;);"
            style="height: 40px; border-width: 0px;" />
        &nbsp;&nbsp;&nbsp;
        <input type="image" name="imgW3School_Lik" id="imgW3School_Lik"
            src="Images/w3schools._logo.png" align="middle" onclick="window.open(&quot;http://www.w3schools.com&quot;);"
            style="height: 60px; border-width: 0px;" />
        &nbsp;&nbsp;&nbsp;
        <input type="image" name="imgJava_Lik" id="imgJava_Lik"
            src="Images/Java_Logo.png" align="middle" onclick="window.open(&quot;http://www.oracle.com/br/technologies/java/index.html&quot;);"
            style="height: 60px; border-width: 0px;" />
    </div>
</asp:Content>

