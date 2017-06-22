using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Brazuka;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Text;
using System.Drawing;

public partial class Arquivo : System.Web.UI.Page
{
    private GridView grvArquivoModal;
    private string nroAlunoArquivo;
    private string strArquivoConteudo;

    public Aluno aluno;

    //Modal
    private Panel modalTitle;
    private Panel shadeModal;
    private HtmlGenericControl hgcModalTitle;


    protected void Page_Load(object sender, EventArgs e)
    {
        string nmeAluno = "";
        bool isImgAluno = false;
        strArquivoConteudo = txtArquivoConteudo.Text;

        if (Request.QueryString["n"] == null)
        {
            nmeAluno = Session["NmeAluno"].ToString();
            nroAlunoArquivo = Session["NroAluno"].ToString();
            isImgAluno = (bool)Session["IsImgAlunoEmpty"];
        }
        else
        {
            if (Session["NroAmigo"] == null || Session["NmeAmigo"].ToString() != Request.QueryString["n"].ToString())
            {
                aluno = new Aluno();
                aluno.recuperarAmigo(int.Parse(Request.QueryString["n"]));
            }
            

            nmeAluno = Session["NmeAmigo"].ToString();
            nroAlunoArquivo = Session["NroAmigo"].ToString();
            isImgAluno = (bool)Session["IsImgAmigoEmpty"];
        }

        lblNmeAluno.Text = nmeAluno;
        lblNmeAluno.Style.Add("font-size", "larger");
        lblNmeAluno.Style.Add("text-transform", "uppercase");


        // Se a sessão está vazia ou for verdadeira (vazia ou nula dentro da classe Aluno)
        if (isImgAluno)
        {
            imgUserDefault.ImageUrl = "~/Images/UserImageDefault.jpg";
            imgUserDefault.BorderStyle = BorderStyle.Dotted;
        }
        else
        {
            imgUserDefault.ImageUrl = "HandlerImage.ashx?idAluno=" + nroAlunoArquivo;
        }

        sdsAlgoritmo.SelectCommand = "SELECT UPPER(NmeAlgoritmo) as NmeAlgoritmo, DtaCriacao, DtaModificacao, " +
            "StaPublico, NroAlgoritmo FROM [BrazukaScript].[dbo].[Algoritmo] Where NroAluno=" + nroAlunoArquivo;

        HyperLinkField visualizarAlgoritmo = new HyperLinkField();
        visualizarAlgoritmo.DataNavigateUrlFields = new String[] {"NroAlgoritmo"};
        visualizarAlgoritmo.DataNavigateUrlFormatString = Request.Url.Query.IndexOf("?") >= 0 ? Request.Url.Query + "&nroal={0}" : "?nroal={0}";
        visualizarAlgoritmo.DataTextField = "NmeAlgoritmo";
        visualizarAlgoritmo.DataTextFormatString = "{0}";
        visualizarAlgoritmo.HeaderText = "Título";
        if (grvAlgoritmos.Columns.Count < 4)
        {
            grvAlgoritmos.Columns.Insert(0, visualizarAlgoritmo);
        }

        if (HttpContext.Current.Request.QueryString["nroal"] != null)
        {
            buildModalConteudo();
        }
    }

    protected void buildModalConteudo()
    {
        modal.Style.Clear();

        modal.Attributes.Add("style", "left:25%");


        // A div do titulo e titulo
        modalTitle = new Panel();
        modalTitle.ID = "modalTitle";
        modalTitle.Width = 700;
        modalTitle.Attributes.Add("style", "left:25%");
        hgcModalTitle = new HtmlGenericControl("h1");
        hgcModalTitle.ID = "hgcModalTitle";
        
        modalTitle.Controls.Add(hgcModalTitle);
        udpAlgoritmos.ContentTemplateContainer.Controls.Add(modalTitle);

        // sombra de fundo da modal que bloqueia os outros controles que não estejam na modal.
        shadeModal = new Panel();
        shadeModal.ID = "shade";
        udpAlgoritmos.ContentTemplateContainer.Controls.Add(shadeModal);

        aluno = new Aluno();

        //txtArquivoConteudo.Text = aluno.recuperarAlgoritmo(int.Parse(HttpContext.Current.Request.QueryString["nroal"]), int.Parse(nroAlunoArquivo), Convert.ToInt32(Session["NroAluno"]));
        RecuperarAlgoritmo();
        if (txtArquivoConteudo.Text.IndexOf("Não possui autorização") >= 0)
        {
            txtArquivoConteudo.Font.Bold = true;
            txtArquivoConteudo.Font.Size = 13;
            btnDownload.Visible = false;
            btnUpdate.Visible = false;

            txtArquivoConteudo.Text = "\n\n\t\t" + txtArquivoConteudo.Text;
        }

        hgcModalTitle.InnerHtml = (Session["ArquivoNome"] == null ? "Algoritmo" : "Algoritmo " + Session["ArquivoNome"].ToString().ToUpper());


        btnCloseModal.Attributes.Add("onclick", "document.getElementById('ctl00_cphConteudo_txtArquivoConteudo').value = '';");

        if (Session["StaPublico"] == null || Session["NroAluno"].ToString() != nroAlunoArquivo)
        {
            btnChangeStatus.Visible = false;
        }
        else if ((bool)Session["StaPublico"])
        {
            btnChangeStatus.Text = "Bloquear";
        }
        else
        {
            btnChangeStatus.Text = "Desbloquear";
        }

        ScriptManager sm = ScriptManager.GetCurrent(this.Page);
        sm.RegisterPostBackControl(this.btnDownload);
    }
    private void RecuperarAlgoritmo()
    {
        txtArquivoConteudo.Text = aluno.recuperarAlgoritmo(int.Parse(HttpContext.Current.Request.QueryString["nroal"]), int.Parse(nroAlunoArquivo), Convert.ToInt32(Session["NroAluno"]));
    }

    protected void btnCloseModal_Click(object sender, EventArgs e)
    {
        txtArquivoConteudo.Text = "";
        String queryString = Request.Url.Query;
        Response.Redirect(queryString.IndexOf("?n=") >= 0 ? "Arquivo.aspx" + queryString.Substring(0, queryString.IndexOf("&")) : "Arquivo.aspx");
    }

    protected void btnUploadAlgoritmo_Click(object sender, EventArgs e)
    {
        modal = new Panel();
        modal.ID = "modal";
        modal.CssClass = "modal";
        modal.Height = 200;
        modal.Width = 400;

        // A div do titulo e titulo
        modalTitle = new Panel();
        modalTitle.ID = "modalTitle";
        hgcModalTitle = new HtmlGenericControl("h1");
        hgcModalTitle.ID = "hgcModalTitle";
        hgcModalTitle.InnerHtml = "Algoritmo";
        modalTitle.Controls.Add(hgcModalTitle);
        margem.Controls.Add(modalTitle);

        // sombra de fundo da modal que bloqueia os outros controles que não estejam na modal.
        shadeModal = new Panel();
        shadeModal.ID = "shade";
        margem.Controls.Add(shadeModal);


        aluno = new Aluno();
        string msg = "";
        //msg = aluno.salvarAlgoritmo(fulAlgoritmo, int.Parse(Session["NroAluno"].ToString()));
        //StreamReader reader = new StreamReader(fulAlgoritmo.FileContent,true);

        modal.Controls.Add(new LiteralControl("<br/>"));
        //modal.Controls.Add(new LiteralControl(reader.ReadToEnd().Replace("\n", "<br/>").Replace(" ", "&nbsp;").Replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")));
        modal.Controls.Add(new LiteralControl("<h4 id='lblInfoModal'>" + msg + "</h4>"));

        modal.Controls.Add(new LiteralControl("<br/>"));
        btnCloseModal = new Button();
        btnCloseModal.ID = "btnCloseModal";
        btnCloseModal.Text = "Fechar";
        btnCloseModal.PostBackUrl = "Arquivo.aspx";
        modal.Controls.Add(btnCloseModal);


        margem.Controls.Add(modal);
    }

    protected void btnDownload_Click(object sender, EventArgs e)
    {
        //string sFileName = System.IO.Path.GetRandomFileName();
        //string sGenName = "Friendly.txt";

        string sFileName = (Session["ArquivoNome"] == null ? "unknowned" : Session["ArquivoNome"].ToString().ToUpper());

        ////YOu could omit these lines here as you may
        ////not want to save the textfile to the server
        ////I have just left them here to demonstrate that you could create the text file 
        //using (System.IO.StreamWriter SW = new System.IO.StreamWriter(
        //       Server.MapPath("TextFiles/" + sFileName + ".bra")))
        //{
        //    SW.Write(txtArquivoConteudo.Text);
        //    //SW.WriteLine(txtArquivoConteudo.Text);
        //    SW.Close();
        //}

        //System.IO.FileStream fs = null;
        //fs = System.IO.File.Open(Server.MapPath("TextFiles/" + Request.QueryString["n"].ToString() 
        //         + ".bra"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.AddHeader("Content-disposition", "attachment; filename=" + sFileName + ".bra");
        //Response.ContentType = "application/octet-stream";
        //Response.BinaryWrite(btFile);
        //Response.End();


        //String nomeArquivo = Server.MapPath("TextFiles/" + sFileName + ".bra");
        //FileInfo arquivo = new FileInfo(nomeArquivo);
        Response.Clear();
        Response.AddHeader("Content-disposition", "attachment; filename=" + sFileName + ".bra");
        //Response.AddHeader("Content-Length", arquivo.Length.ToString());
        Response.ContentType = "application/octet-stream";
        Response.Write(txtArquivoConteudo.Text);
        //Response.WriteFile(nomeArquivo);
        Response.End();
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        aluno = new Aluno();
        string msg = "";
        if (Session["NroAluno"].ToString() != nroAlunoArquivo)
        {
            msg = aluno.salvarAlgoritmo(strArquivoConteudo
            , int.Parse(Session["NroAluno"].ToString()), Session["ArquivoNome"].ToString(), 0);
        }
        else
        {
            msg = aluno.salvarAlgoritmo(strArquivoConteudo
            , int.Parse(Session["NroAluno"].ToString()), Session["ArquivoNome"].ToString(), int.Parse(HttpContext.Current.Request.QueryString["nroal"]));
        }
        

        mgsModal.Text = msg + DateTime.Now.TimeOfDay.ToString().Substring(0,8);
        RecuperarAlgoritmo();
    }
    protected void btnChangeStatus_Click(object sender, EventArgs e)
    {
        aluno = new Aluno();
        bool status = aluno.changeStatus(int.Parse(HttpContext.Current.Request.QueryString["nroal"])
            , int.Parse(nroAlunoArquivo), (bool)Session["StaPublico"]);

        if (status)
        {
            btnChangeStatus.Text = "Bloquear";
        }
        else
        {
            btnChangeStatus.Text = "Desbloquear";
        }
        
    }
}