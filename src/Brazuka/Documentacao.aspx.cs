using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class Documentacao : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void imgArquivo1_Click(object sender, ImageClickEventArgs e)
    {
        download("Concepcao.zip");
    }
    private void download(string fileName)
    {
        String nomeArquivo = Server.MapPath("Files/" + fileName);
        FileInfo arquivo = new FileInfo(nomeArquivo);
        Response.Clear();
        Response.AddHeader("Content-disposition", "attachment; filename=" + fileName);
        Response.AddHeader("Content-Length", arquivo.Length.ToString());
        Response.ContentType = "application/octet-stream";
        Response.WriteFile(nomeArquivo);
        Response.End();
    }
    protected void imgArquivo2_Click(object sender, ImageClickEventArgs e)
    {
        download("Diagramas.zip");
    }
    protected void imgArquivo3_Click(object sender, ImageClickEventArgs e)
    {
        download("EspecificacaoCasoUso.zip");
    }
    protected void imgArquivo4_Click(object sender, ImageClickEventArgs e)
    {
        download("Navegavel.zip");
    }
    protected void imgArquivo5_Click(object sender, ImageClickEventArgs e)
    {
        download("PrototiposInterface.zip");
    }
    protected void imgArquivo6_Click(object sender, ImageClickEventArgs e)
    {
        download("RoteiroTeste.zip");
    }
    protected void imgArquivo7_Click(object sender, ImageClickEventArgs e)
    {
        download("Outros.zip");
    }
}