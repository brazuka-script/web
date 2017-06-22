<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Amigos.aspx.cs" Inherits="Amigos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphConteudo" Runat="Server">
    <form id="form1" runat="server">
   
    <div id="container_texto_full_width" class="container" runat="server">
        <div id="margem" runat="server">
            <asp:Label ID="lblNmeAluno" runat="server" Text="Amigos"></asp:Label>
            <br /><br />
            <asp:Image ID="imgUserDefault" Height="120" Width="160" runat="server" />
            <asp:TextBox ID="txtSearchFriend" CssClass="floatRight" 
                Text="Encontre mais amigos" runat="server">
            </asp:TextBox>
            <asp:Button ID="btnSearchFriend" CssClass="floatRight" runat="server" 
                Text="Pesquisar" onclick="btnSearchFriend_Click" />
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="udpModal" runat="server">
                <ContentTemplate>
                    <asp:Panel ID="modal" Height="250" CssClass="modal" runat="server" style="display:none;" >
                        <br />
                        <asp:Panel ID="divAlunos" runat="server" ScrollBars="Auto" Height="200">
                            <%--Gridview de alunos não cadastrados como seu amigo--%>
                            <asp:GridView ID="grvAlunos" AutoGenerateColumns="false" ShowHeader="false" HorizontalAlign="Center"
                                DataSourceID="sdsAluno" BorderStyle="None" GridLines="None" 
                                runat="server" 
                                onrowcommand="grvAlunos_RowCommand" EmptyDataText="Nenhum aluno encontrado.">
                                <Columns>
                                    <asp:ImageField DataImageUrlField="NroAluno" DataImageUrlFormatString="HandlerImage.ashx?idAluno={0}"
                                        ControlStyle-Width="80" ControlStyle-Height="80"></asp:ImageField>
                                    <asp:BoundField DataField="NmeAluno" ItemStyle-Width="200" ItemStyle-Wrap="false" />
                                    <asp:ButtonField Text="Adicionar" ButtonType="Button" />
                                </Columns>
                            </asp:GridView>
                        </asp:Panel>
                        <asp:Button ID="btnCloseModal" Text="Fechar" runat="server" 
                            onclick="btnCloseModal_Click" />
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
            <asp:UpdatePanel ID="udpAmigos" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="grvAmigos" runat="server" DataSourceID="sdsAmigos" 
                        AllowPaging="True" AutoGenerateColumns="False" ShowHeader="False" 
                        BorderStyle="None" GridLines="None" PageSize="2" HorizontalAlign="Center" PagerStyle-HorizontalAlign="Center"
                        EmptyDataText="Nenhum amigo ainda cadastrado">
                        <Columns>
                            <asp:ImageField DataImageUrlField="NroAluno" 
                                DataImageUrlFormatString="HandlerImage.ashx?idAluno={0}">
                                <ControlStyle Width="80px" Height="80px" />
                            </asp:ImageField>
                            <asp:BoundField DataField="NmeAluno">
                            <ItemStyle Wrap="False" Width="240px" />
                            </asp:BoundField>
                            <asp:HyperLinkField DataNavigateUrlFields="NroAluno" 
                                DataNavigateUrlFormatString="~/Arquivo.aspx?n={0}" Text="ver" ItemStyle-Width="50" />
                            <asp:HyperLinkField DataNavigateUrlFields="NroAluno" 
                                DataNavigateUrlFormatString="~/Amigos.aspx?n={0}" Text="excluir" ItemStyle-Width="50" />

                        </Columns>
                        <RowStyle HorizontalAlign="Center" />
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:SqlDataSource ID="sdsAluno" runat="server" 
                ConnectionString="<%$ ConnectionStrings:conStr %>" >
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsAmigos" runat="server" 
                ConnectionString="<%$ ConnectionStrings:conStr %>" >
            </asp:SqlDataSource>
        </div>
    </div>
    </form>
</asp:Content>

