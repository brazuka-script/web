<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Documentacao.aspx.cs" Inherits="Documentacao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphConteudo" Runat="Server">
    <div id="container_texto_full_width" class="container justify">
        <div id="margem">
            <h1><span>Concepção</span></h1>
            <hr />
            <p>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            Ao longo do curso foram analisadas as dificuldades enfrentadas por alunos iniciantes em programação, 
            pode-se observar que os problemas eram os mesmos independente da linguagem utilizada.
            Atualmente o mercado dispõe de diversas ferramentas para introdução a lógica de programação, 
            porém ainda possuem limitações para o desenvolvimento de casos mais complexos, como os algoritmos de estruturas de dados.
            A ideia de desenvolvimento do Projeto Brazuka nasceu a partir da análise das dificuldades dos alunos. 
            Este projeto visa proporcionar ao aluno um sincronismo dos algoritmos desenvolvidos utilizando a pseudolinguagem Brazuka Script, 
            possibilitando ao usuário participar de uma rede social para discussões, compartilhamento e download de arquivos.
            </p>
            <br />
            <form id="form1" runat="server">
                <asp:Table ID="Table1" HorizontalAlign="Center" CellSpacing="30" runat="server">
                    <asp:TableRow VerticalAlign="Top" HorizontalAlign="Center">
                        <asp:TableCell Width="75">
                            <asp:ImageButton ID="imgArquivo1" runat="server" ImageUrl="~/Images/folder.png" 
                                onclick="imgArquivo1_Click" />
                            <br />
                            <asp:Label ID="Label1" runat="server" Text="Concepção"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell Width="75">
                            <asp:ImageButton ID="imgArquivo2" runat="server" ImageUrl="~/Images/folder.png" 
                                onclick="imgArquivo2_Click" />
                            <br />
                            <asp:Label ID="Label2" runat="server" Text="Diagramas"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell Width="75">
                            <asp:ImageButton ID="imgArquivo3" runat="server" ImageUrl="~/Images/folder.png" 
                                onclick="imgArquivo3_Click" />
                            <br />
                            <asp:Label ID="Label3" runat="server" Text="Especificação Caso Uso"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell Width="75">
                            <asp:ImageButton ID="imgArquivo4" runat="server" ImageUrl="~/Images/folder.png" 
                                onclick="imgArquivo4_Click" />
                            <br />
                            <asp:Label ID="Label4" runat="server" Text="Navegável"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell Width="75">
                            <asp:ImageButton ID="imgArquivo5" runat="server" ImageUrl="~/Images/folder.png" 
                                onclick="imgArquivo5_Click" />
                            <br />
                            <asp:Label ID="Label5" runat="server" Text="Protótipos de Interface"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell Width="75">
                            <asp:ImageButton ID="imgArquivo6" runat="server" ImageUrl="~/Images/folder.png" 
                                onclick="imgArquivo6_Click" />
                            <br />
                            <asp:Label ID="Label6" runat="server" Text="Roteiro de Teste"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell Width="75">
                            <asp:ImageButton ID="imgArquivo7" runat="server" ImageUrl="~/Images/folder.png" 
                                onclick="imgArquivo7_Click" />
                            <br />
                            <asp:Label ID="Label7" runat="server" Text="Outros"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </form>
             
            
            
           <%-- <h1><span>Lorem Ipsum</span></h1>
            <hr />
            <p>
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
            orci luctus et ultrices posuere cubilia Curae; Pellentesque viverra iaculis magna non interdum. Cras adipiscing, 
            sem quis luctus pellentesque, magna neque venenatis neque, cursus bibendum libero nibh vitae ante. Vivamus sit 
            amet massa sapien. Vestibulum sollicitudin, ipsum id luctus posuere, metus tortor rhoncus arcu, nec sollicitudin 
            lectus justo in ipsum. Integer a magna et dolor fermentum vehicula. Nullam pulvinar nisi ut sapien volutpat aliquet. 
            Integer luctus lectus vel nisl interdum quis aliquet magna euismod. Phasellus accumsan posuere ultricies.
            </p>
            <p>
            Proin porttitor volutpat adipiscing. Vivamus ultricies urna eu urna euismod condimentum. Praesent eleifend diam 
            et enim molestie eleifend. Nunc mollis turpis risus. Duis vitae augue eu enim aliquet lobortis in eget justo. 
            Aenean suscipit blandit magna, sed porta enim suscipit non. Pellentesque eleifend dapibus pellentesque. Maecenas adipiscing congue consequat. Maecenas vestibulum, diam sit amet aliquet tristique, urna eros hendrerit tortor, sed adipiscing mauris lorem nec massa. Suspendisse a lacus est.
            </p>--%>
        </div>
    </div>
</asp:Content>

