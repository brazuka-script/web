using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Brazuka;

public partial class Amigos : System.Web.UI.Page
{
    //private Image imgUserDefault;
    //private TextBox txtSearchFriend;
    //private Button btnSearchFriend;
    private DataList dtlAmigos;
    //private GridView grvAlunos;

    //Modal
    //private Panel modal;
    private Panel modalTitle;
    private Panel shadeModal;
    private HtmlGenericControl hgcModalTitle;
    //private Button btnCloseModal;

    private Aluno aluno;

    protected void Page_Load(object sender, EventArgs e)
    {   
        // Verifica se existe algum aluno para ser excluido (maneira encontrada por conta dos postback ou submits feito na página junto com controles dinamicos)
        if (Request.QueryString["n"] != null)
        {
            aluno = new Aluno();
            aluno.excluirOuCancelarAmigo((int)Session["NroAluno"],int.Parse(Request.QueryString["n"]));
            Response.Redirect("amigos.aspx");
        }

        //lblNmeAluno.Text = Session["NmeAluno"].ToString();
        lblNmeAluno.Style.Add("font-size", "larger");
        lblNmeAluno.Style.Add("text-transform", "uppercase");

        imgUserDefault.ImageUrl = "HandlerImage.ashx?idAluno=" + Session["NroAluno"].ToString();

        txtSearchFriend.Attributes.Add("onblur", "if(this.value=='') this.value='Encontre mais amigos';");
        txtSearchFriend.Attributes.Add("onfocus", "this.value='';");
        txtSearchFriend.Style.Add("margin-top", "120px;");

        btnSearchFriend.Style.Add("margin-top", "120px;");
        
        
        sdsAmigos.SelectCommand = "SELECT Aluno.NroAluno,NmeAluno= CASE WHEN Amigos.DtaInicio > 0  THEN Aluno.NmeAluno ELSE '(aguardando) ' + Aluno.NmeAluno END " +
            "FROM Aluno AS Aluno INNER JOIN Amigos AS Amigos "+
            "ON (Aluno.NroAluno = Amigos.NroSolicitado AND Amigos.NroSolicitante = " + Session["NroAluno"].ToString() +
            ") OR (Aluno.NroAluno = Amigos.NroSolicitante AND Amigos.NroSolicitado = " + Session["NroAluno"].ToString() + 
            ") WHERE Aluno.ConfirmadoEmail = 1 AND Aluno.DtaFimCadastro IS NULL AND Amigos.DtaFim IS NULL  ORDER BY NmeAluno";
    }

    protected void btnSearchFriend_Click(object sender, EventArgs e)
    {
        buildModal("Pesquisar Amigos");

        divAlunos.Style.Add("display", "block");

        divAlunos.Controls.Add(grvAlunos);

        modal.Controls.Add(btnCloseModal);

        udpModal.ContentTemplateContainer.Controls.Add(modal);
    }

    //build Modal
    public void buildModal(string titulo)
    {
        modal.Style.Clear();

        // A div do titulo e titulo
        modalTitle = new Panel();
        modalTitle.ID = "modalTitle";
        hgcModalTitle = new HtmlGenericControl("h1");
        hgcModalTitle.ID = "hgcModalTitle";
        hgcModalTitle.InnerHtml = titulo;
        modalTitle.Controls.Add(hgcModalTitle);
        udpModal.ContentTemplateContainer.Controls.Add(modalTitle);

        // sombra de fundo da modal que bloqueia os outros controles que não estejam na modal.
        shadeModal = new Panel();
        shadeModal.ID = "shade";
        udpModal.ContentTemplateContainer.Controls.Add(shadeModal);

        sdsAluno.SelectCommand = "sp_show_amigos_pesquisa";
        sdsAluno.SelectCommandType = SqlDataSourceCommandType.StoredProcedure;
        sdsAluno.SelectParameters.Clear();
        sdsAluno.SelectParameters.Add(new Parameter("p_NroAluno", System.Data.DbType.Int32, Session["NroAluno"].ToString()));
        sdsAluno.SelectParameters.Add(new Parameter("p_NmeAmigoPesquisa", System.Data.DbType.String,
            (txtSearchFriend.Text != "Encontre mais amigos" ? txtSearchFriend.Text : " ")));
    }

    protected void grvAlunos_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        buildModal("Informação");

        int index = Convert.ToInt32(e.CommandArgument);
        GridViewRow row = grvAlunos.Rows[index];


        Image img = (Image)row.Cells[0].Controls[0];
        String mensagem = "";
        aluno = new Aluno();
        mensagem = aluno.adicionarAmigo(Convert.ToInt32(Session["NroAluno"]),
            Convert.ToInt32(img.ImageUrl.Replace("HandlerImage.ashx?idAluno=", "")));
        divAlunos.Style.Add("display", "none");
        modal.Controls.Add(new LiteralControl("<br/><h4 id='lblInfoModal'>" + mensagem + "</h4>"));

        btnCloseModal.Text = "OK";

        modal.Controls.Add(btnCloseModal);
    }
    protected void btnCloseModal_Click(object sender, EventArgs e)
    {
        grvAmigos.DataBind();
    }
}