using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Brazuka;
using System.Drawing;
using System.Configuration;

public partial class _Default : System.Web.UI.Page
{
    //Campos utilizados no login do usuário
    private Label lblEmailLogin;
    private TextBox txtEmailLogin;
    private Label lblSenha;
    private TextBox txtSenhaLogin;
    private CheckBox ckbKeepConection;
    private Button btnSubmit;
    private LinkButton lnkRememberPsw;
    private LinkButton lnkSignin;

    //Campos utilizado no frame de usuário logado
    private LinkButton lnkSair;
    private System.Web.UI.WebControls.Image imgUserDefault;
    private LinkButton lnkUserName;
    private LinkButton lnkAlteraSenha;
    private LinkButton lnkAmigos;
    private LinkButton lnkArquivos;
    private LinkButton lnkInativar;
    private LinkButton lnkAceitarAmigo;
    
    //Campos utilizados nas modais
    private TextBox txtNomeModal;
    private TextBox txtEmailModal;
    private TextBox txtSenhaModal;
    private TextBox txtNovaSenha;
    private TextBox txtSenhaConfirmModal;
    private TextBox txtCPFModal;
    private DropDownList ddlSexo;

    private HtmlGenericControl hgcModalTitle;

    private Panel shadeModal;
    private Panel modalTitle;
    private Panel hiddenModalControls;


    public Aluno aluno;

    private string msg;

    protected void Page_Load(object sender, EventArgs e)
    {
        //// teste de postback
        //if (IsPostBack)
        //{
        //    ClientScript.RegisterStartupScript(this.GetType(), "POSTSBACK", "alert('É postback');", true);
        //}
        //else
        //{
        //    ClientScript.RegisterStartupScript(this.GetType(), "POSTSBACK", "alert('Não é postback');", true);
        //}

        if (Request.Cookies["bra.email"] != null && Request.Cookies["bra.senha"] != null
                && Request.Cookies["bra.email"].ToString() != "" && Request.Cookies["bra.senha"].ToString() != "")
        {
            logar(Request.Cookies["bra.email"].Value, Request.Cookies["bra.senha"].Value, true);
        }
        else
        {
            if (Session["isLogged"] != null && (bool)Session["isLogged"])
            {
                builUserFrameLogged();
            }
            else
            {
                buildUserFrameNoLogged();
            }
        }
    }
    // Instancia os Controles para serem usados em qualquer modal Modal
    private void buildControlsToModal(string idModal)
    {
        // limpa o display:'none'
        modal.Style.Clear();
                
        // A div do titulo e titulo
        modalTitle = new Panel();
        modalTitle.ID = "modalTitle";
        hgcModalTitle = new HtmlGenericControl("h1");
        hgcModalTitle.ID = "hgcModalTitle";
        hgcModalTitle.InnerHtml = "lblModalTitle";
        modalTitle.Controls.Add(hgcModalTitle);
        udpModal.ContentTemplateContainer.Controls.Add(modalTitle);

        // sombra de fundo da modal que bloqueia os outros controles que não estejam na modal.
        shadeModal = new Panel();
        shadeModal.ID = "shade";
        udpModal.ContentTemplateContainer.Controls.Add(shadeModal);

        // Nome exibido na modal de Cadastro
        txtNomeModal = new TextBox();
        txtNomeModal.ID = "txtNomeModal";
        txtNomeModal.Text = "Nome Completo";
        txtNomeModal.Width = 300;
        txtNomeModal.Attributes.Add("onblur", "if(this.value==''){ this.value='Nome Completo';}"); //Passar esses atributos para jquery
        txtNomeModal.Attributes.Add("onfocus", "this.value='';this.style.color = 'black';");
        txtNomeModal.ToolTip = "Nome Completo";

        
        // Email exibido na modal de Cadastro
        txtEmailModal = new TextBox();
        txtEmailModal.ID = "txtEmailModal";
        txtEmailModal.Text = "Email";
        txtEmailModal.Width = 300;
        txtEmailModal.Attributes.Add("onblur", "if(this.value==''){ this.value='Email';}");
        txtEmailModal.Attributes.Add("onfocus", "this.value='';this.style.color = 'black';");
        txtEmailModal.ToolTip = "Email";

        // Senha exibada na modal de Cadastro
        txtSenhaModal = new TextBox();
        txtSenhaModal.ID = "txtSenhaModal";
        txtSenhaModal.Width = 300;
        txtSenhaModal.Text = "Senha";
        txtSenhaModal.Attributes.Add("onblur", "if(this.value==''){this.type='text'; this.value='Senha';}");
        txtSenhaModal.Attributes.Add("onfocus", "this.value='';this.type='password';this.style.color = 'black';");
        txtSenhaModal.ToolTip = "Senha";

        // Nova senha a ser exibida na modal de Cadastro
        txtNovaSenha = new TextBox();
        txtNovaSenha.ID = "txtNovaSenha";
        txtNovaSenha.Width = 300;
        txtNovaSenha.Text = "Nova Senha";
        txtNovaSenha.Attributes.Add("onblur", "if(this.value==''){this.type='text'; this.value='Nova Senha';}");
        txtNovaSenha.Attributes.Add("onfocus", "this.value='';this.type='password';this.style.color = 'black';");
        txtSenhaModal.ToolTip = "Nova Senha";

        // Confirmação de senha na modal
        txtSenhaConfirmModal = new TextBox();
        txtSenhaConfirmModal.ID = "txtSenhaConfirmModal";
        txtSenhaConfirmModal.Width = 300;
        txtSenhaConfirmModal.Text = "Confirme Senha";
        txtSenhaConfirmModal.Attributes.Add("onblur", "if(this.value==''){this.type='text'; this.value='Confirme Senha';}");
        txtSenhaConfirmModal.Attributes.Add("onfocus", "this.value='';this.type='password';this.style.color = 'black';");
        txtSenhaConfirmModal.ToolTip = "Confirmar Senha";

        txtCPFModal = new TextBox();
        txtCPFModal.ID = "txtCPFModal";
        txtCPFModal.Width = 300;
        txtCPFModal.MaxLength = 11;
        txtCPFModal.Text = "CPF (só números)";
        txtCPFModal.Attributes.Add("onblur", "if(this.value==''){this.type='text'; this.value='CPF (só números)';}");
        txtCPFModal.Attributes.Add("onfocus", "this.value='';");
        txtCPFModal.Attributes.Add("onkeypress", "return isNumberKey(event);");

        ddlSexo = new DropDownList();
        ddlSexo.ID = "ddlSexo";
        ddlSexo.Items.Add(new ListItem("Selecione..", " "));
        ddlSexo.Items.Add(new ListItem("Masculino","M"));
        ddlSexo.Items.Add(new ListItem("Feminino", "F"));
        ddlSexo.Width = 300;

        sdsAmigosAceitar.SelectCommand = "SELECT Aluno.NroAluno, Aluno.NmeAluno " +
            "FROM Aluno AS Aluno INNER JOIN Amigos AS Amigos " +
            "ON Aluno.NroAluno = Amigos.NroSolicitante  " +
            "WHERE Aluno.ConfirmadoEmail = 1 AND Amigos.DtaInicio IS NULL AND Amigos.Dtafim IS NULL AND Aluno.DtaFimCadastro IS NULL AND Amigos.NroSolicitado = " +
            (Session["NroAluno"] != null ? Session["NroAluno"].ToString() : "null") + " ORDER BY NmeAluno";

        gridviewPanel.Style.Add("display", "none");
    }
    // Build do frame de usuário antes de estar logado.
    private void buildUserFrameNoLogged()
    {
        //buildHiddenControls();

        // Título da janela de usuário
        udpContainer_user.ContentTemplateContainer.Controls.Add(new LiteralControl("<h4>ACESSE SUA CONTA</h4><br/>"));
        
        lblEmailLogin = new Label();
        lblEmailLogin.ID = "lblEmailLogin";
        lblEmailLogin.Text = "Login:";
        udpContainer_user.ContentTemplateContainer.Controls.Add(lblEmailLogin);

        txtEmailLogin = new TextBox();
        txtEmailLogin.ID = "txtEmailLogin";
        txtEmailLogin.Width = 175;
        udpContainer_user.ContentTemplateContainer.Controls.Add(txtEmailLogin);
        udpContainer_user.ContentTemplateContainer.Controls.Add(new LiteralControl("<br/><br/>"));

        lblSenha = new Label();
        lblSenha.ID = "lblSenha";
        lblSenha.Text = "Senha:";
        udpContainer_user.ContentTemplateContainer.Controls.Add(lblSenha);

        txtSenhaLogin = new TextBox();
        txtSenhaLogin.ID = "txtSenhaLogin";
        txtSenhaLogin.Width = 174;
        txtSenhaLogin.TextMode = TextBoxMode.Password;
        udpContainer_user.ContentTemplateContainer.Controls.Add(txtSenhaLogin);
        udpContainer_user.ContentTemplateContainer.Controls.Add(new LiteralControl("<br/>"));

        ckbKeepConection = new CheckBox();
        ckbKeepConection.ID = "ckbKeepConection";
        ckbKeepConection.Text = "Mantenha-me conectado";
        udpContainer_user.ContentTemplateContainer.Controls.Add(ckbKeepConection);
        udpContainer_user.ContentTemplateContainer.Controls.Add(new LiteralControl("<br/><br/>"));

        btnSubmit = new Button();
        btnSubmit.ID = "btnSubmit";
        btnSubmit.Text = "Entrar";
        btnSubmit.Click += btnSubmit_Click;
        udpContainer_user.ContentTemplateContainer.Controls.Add(btnSubmit);
        udpContainer_user.ContentTemplateContainer.Controls.Add(new LiteralControl("<br/>"));

        lnkRememberPsw = new LinkButton();
        lnkRememberPsw.ID = "lnkRemberPsw";
        lnkRememberPsw.Text = "Esqueci minha senha";
        lnkRememberPsw.CssClass = "lnkBlue";
        lnkRememberPsw.Click += buildModalLembraSenha;
        udpContainer_user.ContentTemplateContainer.Controls.Add(lnkRememberPsw);
        
        udpContainer_user.ContentTemplateContainer.Controls.Add(new LiteralControl("<br/>"));

        lnkSignin = new LinkButton();
        lnkSignin.ID = "lnkSignin";
        lnkSignin.Text = "Cadastre-se";
        lnkSignin.CssClass = "lnkBlue";
        lnkSignin.Click += buildModalCadastro;
        udpContainer_user.ContentTemplateContainer.Controls.Add(lnkSignin);
    }
    // Build do frame do usuário logado
    private void builUserFrameLogged()
    {
        udpContainer_user.ContentTemplateContainer.Controls.Clear();

        //link de sair
        lnkSair = new LinkButton();
        lnkSair.ID = "lnkSair";
        lnkSair.Text = "[X]";
        lnkSair.CssClass = "lnkRed";
        lnkSair.Click += sair;
        udpContainer_user.ContentTemplateContainer.Controls.Add(lnkSair);
        
        // Título da janela de usuário
        udpContainer_user.ContentTemplateContainer.Controls.Add(new LiteralControl("<h4>ÁREA RESTRITA</h4>"));

        imgUserDefault = new System.Web.UI.WebControls.Image();
        imgUserDefault.ID = "imgUserDefault";
        // Se a sessão está vazia ou for verdadeira (vazia ou nula dentro da classe Aluno)
        if (String.IsNullOrEmpty(Session["IsImgAlunoEmpty"].ToString()) || (bool)Session["IsImgAlunoEmpty"]) 
        {
            imgUserDefault.ImageUrl = "~/Images/UserImageDefault.jpg";
        }
        else
        {
            imgUserDefault.ImageUrl = "HandlerImage.ashx?idAluno=" + Session["NroAluno"].ToString();
        }
        
        imgUserDefault.Width = 160;
        imgUserDefault.Height = 120;
        imgUserDefault.BorderStyle = BorderStyle.Dotted;
        imgUserDefault.BorderColor = System.Drawing.Color.Black;
        udpContainer_user.ContentTemplateContainer.Controls.Add(imgUserDefault);

        udpContainer_user.ContentTemplateContainer.Controls.Add(new LiteralControl("<br/>Bem vindo(a) "));

        lnkUserName = new LinkButton();
        lnkUserName.ID = "lnkUserName";
        lnkUserName.Text = Session["NmeAluno"].ToString();
        lnkUserName.CssClass = "lnkBlue";
        lnkUserName.Click += buildModalAtualizaPerfil;
        lnkUserName.Attributes.Add("onmouseover", "this.innerText +=' [edit]';");
        lnkUserName.Attributes.Add("onmouseout", "this.innerText = '" + Session["NmeAluno"].ToString() + "';");
        udpContainer_user.ContentTemplateContainer.Controls.Add(lnkUserName);
        udpContainer_user.ContentTemplateContainer.Controls.Add(new LiteralControl("!<br/><br/>"));

        lnkAmigos = new LinkButton();
        lnkAmigos.ID = "lnkAmigos";
        lnkAmigos.Text = "Amigos";
        lnkAmigos.CssClass = "lnkBlue";
        lnkAmigos.PostBackUrl = "~/Amigos.aspx";
        udpContainer_user.ContentTemplateContainer.Controls.Add(lnkAmigos);

        lnkAceitarAmigo = new LinkButton();
        lnkAceitarAmigo.ID = "lnkAceitarAmigo";
        aluno = new Aluno();
        int qtdConvites = aluno.qtdConvitesAbertos(Convert.ToInt32(Session["NroAluno"]));
        if (qtdConvites > 0)
        {
            lnkAceitarAmigo.Text = " (" + qtdConvites.ToString() + ")";
            lnkAceitarAmigo.Attributes.Add("onmouseout", "this.innerText = ' (" + qtdConvites.ToString() + ")';");
        }
        lnkAceitarAmigo.CssClass = "lnkBlue";
        lnkAceitarAmigo.Click += buildModalAceitarAmigo;
        lnkAceitarAmigo.Attributes.Add("onmouseover", "this.innerText = this.innerText.substring(0,this.innerText.length-1) + ' pedido(s))';");
        udpContainer_user.ContentTemplateContainer.Controls.Add(lnkAceitarAmigo);
        udpContainer_user.ContentTemplateContainer.Controls.Add(new LiteralControl("<br/><br/>"));

        lnkArquivos = new LinkButton();
        lnkArquivos.ID = "lnkArquivos";
        lnkArquivos.Text = "Arquivos";
        lnkArquivos.CssClass = "lnkBlue";
        lnkArquivos.PostBackUrl = "~/Arquivo.aspx";
        udpContainer_user.ContentTemplateContainer.Controls.Add(lnkArquivos);
        udpContainer_user.ContentTemplateContainer.Controls.Add(new LiteralControl("<br/><br/>"));

        lnkAlteraSenha = new LinkButton();
        lnkAlteraSenha.ID = "lnkAlteraSenha";
        lnkAlteraSenha.Text = "Alterar Senha";
        lnkAlteraSenha.CssClass = "lnkBlue";
        lnkAlteraSenha.Click += buildModalAlteraSenha;
        udpContainer_user.ContentTemplateContainer.Controls.Add(lnkAlteraSenha);
        udpContainer_user.ContentTemplateContainer.Controls.Add(new LiteralControl("<br/><br/>"));

        lnkInativar = new LinkButton();
        lnkInativar.ID = "lnkInativar";
        lnkInativar.Text = "Inativar";
        lnkInativar.CssClass = "lnkBlue";
        lnkInativar.Click += buildModalConfirmaInativadade;
        udpContainer_user.ContentTemplateContainer.Controls.Add(lnkInativar);

    }
    // Build da Modal inativar aluno
    public void buildModalConfirmaInativadade(object sender, EventArgs e)
    {
        Session.Add("tipoModal", "inativarConta");
        buildControlsToModal("ConfirmaInativadade");
        hgcModalTitle.InnerHtml = "Inativar";
        modal.Controls.Add(new LiteralControl("<br/><br/>"));
        modal.Controls.Add(new LiteralControl("<h4 id='lblInfoModal'>Deseja realmente inativar este aluno?</h4>"));
        modal.Controls.Add(new LiteralControl("<br/><br/><br/>"));
        modal.Controls.Add(btnSubmitModal);

        modal.Controls.Add(btnCloseModal);
    }
    // Build da Modal de atualização de imageDefault e nome de exibição
    public void buildModalAtualizaPerfil(object sender, EventArgs e)
    {
        Session.Add("tipoModal", "atualizarPerfil");
        buildControlsToModal("AtualizaPerfil");
        // limpa o css que esconde o controle nas outras modais
        fulUserImageModal.Style.Clear();
        hgcModalTitle.InnerHtml = "Atualizar Perfil";
        modal.Controls.Add(new LiteralControl("<h4 id='lblInfoModal'>Alterar Imagem</h4>"));
        modal.Controls.Add(new LiteralControl("<br/><br/>"));
        modal.Controls.Add(fulUserImageModal);
        modal.Controls.Add(new LiteralControl("<br/><br/><br/>"));
        modal.Controls.Add(btnSubmitModal);

        modal.Controls.Add(btnCloseModal);
    }
    public void buildModalAceitarAmigo(object sender, EventArgs e)
    {
        Session.Add("tipoModal", "aceitarAmigos");
        buildControlsToModal("AceitarAmigos");
        hgcModalTitle.InnerHtml = "Aceitar Amigos";
        modal.Controls.Add(new LiteralControl("<br/>"));
        modal.Height = 250;
        btnSubmitModal.Visible = false;
        gridviewPanel.Style.Clear();
        modal.Controls.Add(gridviewPanel);

        modal.Controls.Add(btnCloseModal);
    }
    // Build da Modal de "Alterar Senha"
    public void buildModalAlteraSenha(object sender, EventArgs e)
    {
        Session.Add("tipoModal", "alterarSenha");
        buildControlsToModal("AlteraSenha");
        hgcModalTitle.InnerHtml = "Alterar Senha";
        modal.Controls.Add(new LiteralControl("<br/><br/>"));
        txtSenhaModal.Text = "Senha Atual";
        modal.Controls.Add(txtSenhaModal);
        modal.Controls.Add(new LiteralControl("<br/>"));
        modal.Controls.Add(txtNovaSenha);
        modal.Controls.Add(new LiteralControl("<br/>"));
        modal.Controls.Add(txtSenhaConfirmModal);
        modal.Controls.Add(new LiteralControl("<br/><br/>"));
        modal.Controls.Add(btnSubmitModal);

        modal.Controls.Add(btnCloseModal);
    }
    // Build da Modal do Link de "Esqueci minha senha"
    public void buildModalLembraSenha(object sender, EventArgs e)
    {
        Session.Add("tipoModal", "esqueciSenha");
        buildControlsToModal("EsqueciSenha");
        hgcModalTitle.InnerHtml = "Esqueci minha senha";
        modal.Controls.Add(new LiteralControl("<h4 id='lblInfoModal'>ATENÇÃO<br/>Informe o email cadastrado</h4>"));
        modal.Controls.Add(txtEmailModal);
        
        modal.Controls.Add(btnSubmitModal);

        modal.Controls.Add(btnCloseModal);
    }
    // Build da Modal do Link de "Cadastre-se"
    public void buildModalCadastro(object sender, EventArgs e)
    {
        Session.Add("tipoModal","cadastro");
        buildControlsToModal("Cadastro");
        //lblModalTitle.InnerText = "Cadastro";
        hgcModalTitle.InnerHtml = "Cadastro";
        modal.Controls.Add(new LiteralControl("<br/><span id='mgsModal' style='color:#FF0000;'></span><br/>"));        
        modal.Controls.Add(txtNomeModal);
        modal.Controls.Add(new LiteralControl("<br/>"));
        modal.Controls.Add(txtEmailModal);
        modal.Controls.Add(new LiteralControl("<br/>"));
        modal.Controls.Add(txtSenhaModal);
        modal.Controls.Add(new LiteralControl("<br/>"));
        modal.Controls.Add(txtSenhaConfirmModal);
        modal.Controls.Add(new LiteralControl("<br/>"));
        modal.Controls.Add(txtCPFModal);
        modal.Controls.Add(new LiteralControl("<br/>"));
        modal.Controls.Add(ddlSexo);
        modal.Controls.Add(new LiteralControl("<br/>"));
        // limpa o css que esconde o controle nas outras modais
        fulUserImageModal.Style.Clear();
        modal.Controls.Add(fulUserImageModal);
        modal.Controls.Add(new LiteralControl("<br/><br/>"));
        btnSubmitModal.OnClientClick = "return validaCadastro();";
        modal.Controls.Add(btnSubmitModal);
        
        modal.Controls.Add(btnCloseModal);

        modal.Height = 300;
    }
    // Constroi a Modal de mensagem
    public void buildModalMensagem(String mensagem)
    {
        btnSubmitModal.Visible = false;
        buildControlsToModal("Mensagem");
        hgcModalTitle.InnerHtml = "Informação";
        modal.Controls.Add(new LiteralControl("<br/><h4 id='lblInfoModal'>" + mensagem + "</h4>"));

        btnCloseModal.Text = "OK";
        
        modal.Controls.Add(btnCloseModal);
    }
    // Procedimento de Atualizar Perfil
    protected void atualizar()
    {
        aluno = new Aluno();
        msg = aluno.atualizarPerfil(fulUserImageModal);
        buildModalMensagem(msg);
    }
    // Procedimento de Cadastro
    protected void cadastrar()
    {
        aluno = new Aluno();
        string nome = HttpContext.Current.Request["ctl00$cphConteudo$txtNomeModal"];
        string email = HttpContext.Current.Request["ctl00$cphConteudo$txtEmailModal"];
        string senha = HttpContext.Current.Request["ctl00$cphConteudo$txtSenhaModal"];
        string senhaConfirma = HttpContext.Current.Request["ctl00$cphConteudo$txtSenhaConfirmModal"];
        string cpf = HttpContext.Current.Request["ctl00$cphConteudo$txtCPFModal"].ToString() == "CPF (só números)" ? "" : HttpContext.Current.Request["ctl00$cphConteudo$txtCPFModal"].ToString();
        char sexo = char.Parse(HttpContext.Current.Request["ctl00$cphConteudo$ddlSexo"]);
        if (senha != senhaConfirma)
        {
            msg = "A senha informada não confirma";
        }
        else
        {
            msg = aluno.cadastrarAluno(nome, email, senha, cpf, sexo, fulUserImageModal);
        }
        buildModalMensagem(msg);
    }
    // Procedimento de Cadastro
    protected void alterarSenha()
    {
        //aluno = new Aluno();
        string senhaAtual = HttpContext.Current.Request["ctl00$cphConteudo$txtSenhaModal"];
        string senhaNovaSenha = HttpContext.Current.Request["ctl00$cphConteudo$txtNovaSenha"];
        string senhaNovaConfirma = HttpContext.Current.Request["ctl00$cphConteudo$txtSenhaConfirmModal"];
        if (senhaNovaSenha != senhaNovaConfirma)
        {
            msg = "Senha nova diferente da senha de confirmação.";
        }
        else
        {
            msg = aluno.trocaSenha(senhaAtual, senhaNovaSenha, senhaNovaConfirma, Session["TxtEmail"].ToString());
        }
        
        buildModalMensagem(msg);
    }
    // Procedimento de recuperarSenha
    protected void recuperarSenha()
    {
        aluno = new Aluno();
        msg = aluno.recuperarSenha(HttpContext.Current.Request["ctl00$cphConteudo$txtEmailModal"]);
        buildModalMensagem(msg);
    }
    // Procedimento de login
    protected void logar(string email, string senha, bool keep)
    {
        aluno = new Aluno();
        msg = aluno.acessarPerfil(email,senha,keep);
        if (msg == "sucesso")
        {
            Session.Add("isLogged", true);
            builUserFrameLogged();
        }
        else
        {
            buildModalMensagem(msg);
        }
    }
    protected void inativar()
    {
        Session.Add("tipoModal", "sairInativarConta");
        aluno = new Aluno();
        msg = aluno.inativarAluno(Session["TxtEmail"].ToString());
        buildModalMensagem(msg);        
    }
    // Evento de login
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        logar(txtEmailLogin.Text, txtSenhaLogin.Text, ckbKeepConection.Checked);
    }
    // Metodo de Sair
    protected void sair(object sender, EventArgs e)
    {
        aluno = null ;
        Session.Remove("isLogged");
        Session.RemoveAll();
        HttpContext.Current.Response.Cookies["bra.email"].Value = null;
        HttpContext.Current.Response.Cookies["bra.senha"].Value = null;
        HttpContext.Current.Response.Cookies["bra.email"].Expires = DateTime.Now;
        HttpContext.Current.Response.Cookies["bra.senha"].Expires = DateTime.Now;
        HttpContext.Current.Response.Redirect("Default.aspx");
    }
    // Limpa a modal e fecha
    protected void btnCloseModal_Click(object sender, EventArgs e)
    {
        udpModal.ContentTemplateContainer.Controls.Clear();
        if (Session["tipoModal"] == "sairInativarConta")
        {
            Session.Remove("tipoModal");
            aluno = null;
            Session.Remove("isLogged");
            HttpContext.Current.Response.Cookies["bra.email"].Value = null;
            HttpContext.Current.Response.Cookies["bra.senha"].Value = null;
            HttpContext.Current.Response.Cookies["bra.email"].Expires = DateTime.Now;
            HttpContext.Current.Response.Cookies["bra.senha"].Expires = DateTime.Now;
            HttpContext.Current.Response.Redirect("Default.aspx");
        }
        Session.Remove("tipoModal");
    }
    // Constroi a Modal pelo tipo
    protected void btnSubmitModal_Click(object sender, EventArgs e)
    {
        string eventClick = (Session["tipoModal"] != null ? Session["tipoModal"].ToString() : "");
        switch (eventClick)
        {
            case "cadastro": cadastrar();
                break;
            case "esqueciSenha": recuperarSenha();
                break;
            case "alterarSenha": alterarSenha();
                break;
            case "atualizarPerfil": atualizar();
                break;
            case "inativarConta": inativar();
                break;
        }
    }
    // Aceitar ou cancelar convites de amizade
    protected void grvAmigos_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        sdsAmigosAceitar.SelectCommand = "SELECT Aluno.NroAluno, Aluno.NmeAluno " +
            "FROM Aluno AS Aluno INNER JOIN Amigos AS Amigos " +
            "ON Aluno.NroAluno = Amigos.NroSolicitante  " +
            "WHERE Aluno.ConfirmadoEmail = 1 AND Amigos.DtaInicio IS NULL AND Amigos.Dtafim IS NULL AND Aluno.DtaFimCadastro IS NULL AND Amigos.NroSolicitado = " +
            (Session["NroAluno"] != null ? Session["NroAluno"].ToString() : "null") + " ORDER BY NmeAluno";

        // index informa qual o registro da tabela
        int index = Convert.ToInt32(e.CommandArgument);
        // recupera a tupla da tabela do index
        GridViewRow row = grvAmigos.Rows[index];
        // recupera a image para pegar o número do amigo que está no src
        System.Web.UI.WebControls.Image img = (System.Web.UI.WebControls.Image)row.Cells[0].Controls[0];

        string comando = e.CommandName;

        aluno = new Aluno();
        if (comando == "Cancelar")
        {
            msg = aluno.excluirOuCancelarAmigo(Convert.ToInt32(Session["NroAluno"]), Convert.ToInt32(img.ImageUrl.Replace("HandlerImage.ashx?idAluno=", "")));
        }
        else
        {
            msg = aluno.adicionarAmigo(Convert.ToInt32(Session["NroAluno"]), Convert.ToInt32(img.ImageUrl.Replace("HandlerImage.ashx?idAluno=", "")));
        }

        sdsAmigosAceitar.SelectCommand = "SELECT Aluno.NroAluno, Aluno.NmeAluno " +
            "FROM Aluno AS Aluno INNER JOIN Amigos AS Amigos " +
            "ON Aluno.NroAluno = Amigos.NroSolicitante  " +
            "WHERE Aluno.ConfirmadoEmail = 1 AND Amigos.DtaInicio IS NULL AND Amigos.Dtafim IS NULL AND Aluno.DtaFimCadastro IS NULL AND Amigos.NroSolicitado = " +
            (Session["NroAluno"] != null ? Session["NroAluno"].ToString() : "null") + " ORDER BY NmeAluno";

        grvAmigos.DataBind();

        buildModalMensagem(msg); 
    }
}