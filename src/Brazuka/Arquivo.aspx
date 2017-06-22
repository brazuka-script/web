<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Arquivo.aspx.cs" Inherits="Arquivo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphConteudo" Runat="Server">
    <form id="form1" runat="server">
        <div id="container_texto_full_width" class="container" runat="server">
            <div id="margem" runat="server">
                <asp:Label ID="lblNmeAluno" runat="server"></asp:Label>
                <br /><br />
                <asp:Image ID="imgUserDefault" Height="120" Width="160" runat="server" />
                <%--<asp:FileUpload ID="fulAlgoritmo" runat="server" />
                <asp:Button ID="btnUploadAlgoritmo" runat="server" 
                    onclick="btnUploadAlgoritmo_Click" Text="Salvar" />--%>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <asp:UpdatePanel ID="udpModal" runat="server">
                    <ContentTemplate>
                        <asp:Panel ID="modal" Height="400" Width="700" CssClass="modal left" runat="server" style="display:none;" >
                            <br />
                            <asp:TextBox ID="txtArquivoConteudo" runat="server" TextMode="MultiLine" Font-Size="8" BackColor="#FFFF33" Width="696" Height="340" BorderStyle="None"></asp:TextBox>
                            <br />
                            <asp:Button ID="btnCloseModal" Text="Fechar" runat="server" 
                                onclick="btnCloseModal_Click" />
                            <asp:Button ID="btnDownload" runat="server" Text="Download" 
                                onclick="btnDownload_Click" />
                            <asp:Button ID="btnUpdate" runat="server" Text="Atualizar" 
                                onclick="btnUpdate_Click" />
                            <asp:Button ID="btnChangeStatus" runat="server" 
                                onclick="btnChangeStatus_Click" />
                            <asp:Label ID="mgsModal" ForeColor="#FF0000" runat="server"></asp:Label>
                        </asp:Panel>
                    </ContentTemplate>
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

                
                <hr />
                <br />
                <asp:UpdatePanel ID="udpAlgoritmos" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="grvAlgoritmos" runat="server" DataSourceID="sdsAlgoritmo" 
                            AllowPaging="True" BorderStyle="None" GridLines="None" PageSize="5" PagerStyle-HorizontalAlign="Center"
                            HorizontalAlign="Center" Width="100%" 
                            EmptyDataText="Nenhum arquivo salvo." AutoGenerateColumns="False" 
                            AllowSorting="True">
                            <Columns>
                                <%--<asp:HyperLinkField DataNavigateUrlFields="NroAlgoritmo" 
                                    DataNavigateUrlFormatString="?nroal={0}" DataTextField="NmeAlgoritmo" 
                                    DataTextFormatString="{0}" HeaderText="Título" />--%>
                                <asp:BoundField DataField="DtaCriacao" HeaderText="Criação" />
                                <asp:BoundField DataField="DtaModificacao" HeaderText="Modificação" />
                                <asp:ImageField DataImageUrlField="StaPublico" HeaderText="Status"
                                    DataImageUrlFormatString="Images/{0}.png" >
                                </asp:ImageField>
                            </Columns>
                            <RowStyle HorizontalAlign="Center" />
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
               
                <asp:SqlDataSource ID="sdsAlgoritmo" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:conStr %>" >
                </asp:SqlDataSource>
            </div>
        </div>
    </form>
</asp:Content>

