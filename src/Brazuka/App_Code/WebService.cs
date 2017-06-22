using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Brazuka;
 
/// <summary>
/// Summary description for WebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService {

    private Aluno aluno;

    public WebService () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    //[WebMethod]
    //public string HelloWorld() {
    //    return "Hello World2";
    //}

    [WebMethod]
    public string[] GetDadosArquivos(string email, string senha)
    {
        string[] listArquivo = null;

        aluno = new Aluno();
        String msg = aluno.acessarPerfil( email, senha, false, false);
        int nroAluno = 0;
        if (int.TryParse(msg, out nroAluno))
        {
            listArquivo = aluno.fileList(nroAluno);
        }
        else
        {
            listArquivo = new String[] { "Erro." };
        }

        
        return listArquivo;
 
    }

    [WebMethod]
    public bool UploadArquivo(string email, string senha, string arquivo)
    {
        int nroArquivo;
        String nmeArquivo;
        String txtArquivoConteudo;

        aluno = new Aluno();
        String msg = aluno.acessarPerfil(email, senha, false, false);
        int nroAluno = 0;
        if (int.TryParse(msg, out nroAluno))
        {
            nroArquivo = Convert.ToInt32(arquivo.Substring(0, arquivo.IndexOf("#")));
            nmeArquivo = arquivo.Substring(nroArquivo.ToString().Length + 1, arquivo.Substring(nroArquivo.ToString().Length + 1).IndexOf("#")).Replace(".bra","");
            txtArquivoConteudo = arquivo.Substring(nroArquivo.ToString().Length + nmeArquivo.Length + 1).Replace(".bra#", ""); //.Replace("&pula;", "\n");
            msg = aluno.salvarAlgoritmo(txtArquivoConteudo, nroAluno, nmeArquivo, nroArquivo);
            if (msg.IndexOf("sucesso") < 0)
            {
                return false;
            }
        }
        else
        {
            return false;
        }

        return true;
    }

    [WebMethod]
    public string DownloadArquivo(string email, string senha, int idArquivo)
    {

        aluno = new Aluno();
        String msg = aluno.acessarPerfil(email, senha, false, false);
        int nroAluno = 0;
        if (int.TryParse(msg, out nroAluno))
        {
            msg = aluno.recuperarAlgoritmo(idArquivo, nroAluno, nroAluno, false); //.Replace("\n","&pula;");
        }
        else
        {
            msg = "Erro.";
        }

        return msg;
    }
}
