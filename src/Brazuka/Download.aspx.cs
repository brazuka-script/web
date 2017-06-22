using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class Download : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnDownload_Click(object sender, EventArgs e)
    {
        String nomeArquivo = Server.MapPath("Files/brazuka_plugin.zip");
        FileInfo arquivo = new FileInfo(nomeArquivo);
        Response.Clear();
        Response.AddHeader("Content-disposition", "attachment; filename=brazuka_plugin.zip");
        Response.AddHeader("Content-Length", arquivo.Length.ToString());
        Response.ContentType = "application/octet-stream";
        Response.WriteFile(nomeArquivo);
        Response.End();
    }
    protected void btnDownloadEclipse_Click(object sender, EventArgs e)
    {
        string urlRedirect = "";
        switch (ddlEscolherSistema.SelectedValue)
        {
            case "1":
                urlRedirect = "http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/indigo/SR2/eclipse-java-indigo-SR2-win32.zip";
                break;
            case "2":
                urlRedirect = "http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/indigo/SR2/eclipse-java-indigo-SR2-win32-x86_64.zip";
                break;
            case "3":
                urlRedirect = "http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/indigo/SR2/eclipse-java-indigo-SR2-macosx-cocoa.tar.gz";
                break;
            case "4":
                urlRedirect = "http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/indigo/SR2/eclipse-java-indigo-SR2-macosx-cocoa-x86_64.tar.gz";
                break;
            case "5":
                urlRedirect = "http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/indigo/SR2/eclipse-cpp-indigo-SR2-incubation-linux-gtk.tar.gz";
                break;
            case "6":
                urlRedirect = "http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/indigo/SR2/eclipse-java-indigo-SR2-linux-gtk-x86_64.tar.gz";
                break;
        }

        if (! String.IsNullOrEmpty(urlRedirect))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "redirect", "window.open('" + urlRedirect + "','_blank','width=200,height=100');", true);
        }
        
    }
    protected void btnDownloadManual_Click(object sender, EventArgs e)
    {
        String nomeArquivo = Server.MapPath("Files/TCC_BrazukaScript_ManualUsuário.pdf");
        FileInfo arquivo = new FileInfo(nomeArquivo);
        Response.Clear();
        Response.AddHeader("Content-disposition", "attachment; filename=brazuka_plugin.pdf");
        Response.AddHeader("Content-Length", arquivo.Length.ToString());
        Response.ContentType = "application/pdf";
        Response.WriteFile(nomeArquivo);
        Response.End();
    }
}