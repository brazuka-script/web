<%@ Page Title="BrazukaScript" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="QuemSomos.aspx.cs" Inherits="QuemSomos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphConteudo" Runat="Server">
    <div id="container_texto" class="container justify">
        <div id="margem">
            <h1><span>&nbsp;&nbsp;&nbsp;Quem Somos</span></h1>
            <hr />
            <p>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Este projeto foi desenvolvido como trabalho de conclusão do curso de Bacharel em Sistemas de Informação 
                pela Faculdade Anhanguera - FACNET, onde tivemos o professor Guilherme Parente Costa como orientador.
            <br/>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                A idéia de desenvolvimento do site e da pseudolinguagem surgiu a partir de uma análise a respeito das principais 
                dificuldades enfrentadas pelos alunos do curso de BSI, e partir daí pudemos concluir que a ausência de uma base 
                de conhecimento sólida em lógica e a falta de uma ferramenta que possibilitasse o desenvolvimento e armazenamento 
                de códigos fontes que estivessem disponíveis fora do ambiente academico.
            <br/>
                &nbsp;&nbsp;&nbsp;&nbsp;
                Brazuka é um site desenvolvido visando proporcionar o compartilhamento e armazenamento de scripts desenvolvidos 
                utilizando o pseudocódigo Brazuka Scrip, tendo como um diferencial facilidade de uso e as diferentes alternativas 
                de armazenamento e desenvolvimento.
        </div>
    </div>
    <div id="container_user_home" class="container">
        <img class="imgQuemSomos" alt="Cynthia" src="Images/cyntia.jpg" />
        <img class="imgQuemSomos" alt="Luiz" src="Images/luiz.jpg" /><br />
        <img class="imgQuemSomos" alt="Kleber" src="Images/kleber.jpg" />
        <img class="imgQuemSomos" alt="Jaqueline" src="Images/jaque.jpg" /><br />
        <img class="imgQuemSomos" alt="Alberto" src="Images/eu mais novo.png" />

    </div>
</asp:Content>

