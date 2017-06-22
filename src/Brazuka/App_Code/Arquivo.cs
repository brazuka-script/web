using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.IO;

namespace Brazuka
{
    /// <summary>
    /// Summary description for Arquivo
    /// </summary>
    public class Arquivo
    {
        //private int id;
        //private string nome;
        //private DateTime dtCriacao;
        //private String conteudo;
        //private bool isPublic;

        DataSet ds = new DataSet();
        SqlConnection conn;
        SqlCommand cmd;

        public Arquivo()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        // Troca o status do Algoritmo: Bloqueado ou Desbloqueado
        public bool changeStatus(int idAlgoritmo, int idAluno, bool isPublico)
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString);

            cmd = new SqlCommand("UPDATE BrazukaScript.dbo.Algoritmo SET StaPublico = @p_staPublico WHERE NroAluno= @p_nroAluno	AND NroAlgoritmo = @p_nroAlgoritmo", conn);
            cmd.CommandType = CommandType.Text;

            cmd.Parameters.Add(new SqlParameter("@p_nroAlgoritmo", SqlDbType.Int)).Value = idAlgoritmo;
            cmd.Parameters.Add(new SqlParameter("@p_nroAluno", SqlDbType.Int)).Value = idAluno;
            cmd.Parameters.Add(new SqlParameter("@p_staPublico", SqlDbType.Bit)).Value = isPublico ? 0 : 1;

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            HttpContext.Current.Session["StaPublico"] = isPublico ? false : true;

            return isPublico ? false : true;
        }
        // Recupera lista de arquivos
        public string[] fileList(int idAluno)
        {
            System.Collections.ArrayList retorno = new System.Collections.ArrayList();
            //string[] retorno = null;
            //int count = 0;

            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString);

            cmd = new SqlCommand("BrazukaScript.dbo.sp_recuperar_lista_arquivos ", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@p_nroAluno", SqlDbType.Int)).Value = idAluno;

            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                if (dr[0].ToString() == "0")
                {
                    //return retorno.ToArray(typeof(String)) as String[];
                    break;
                }
                else
                {
                    retorno.Add(dr["NroAlgoritmo"].ToString() + "#" + dr["NmeAlgoritmo"].ToString().Replace(".bra","") + ".bra#" +
                        (dr["DtaModificacao"].ToString() == "" ? dr["DtaCriacao"].ToString() : dr["DtaModificacao"].ToString()) );//.Replace("/","").Substring(0, 8));
                }

            }
            conn.Close();

            return retorno.ToArray(typeof(String)) as String[]; ;
        }
        // sobrecarga
        public string download(int idAlgoritmo, int idAluno, int idAlunoPesquisante)
        {
            return download(idAlgoritmo, idAluno, idAlunoPesquisante, true);
        }
        public string download(int idAlgoritmo, int idAluno, int idAlunoPesquisante, bool armenaSession)
        {
            string retorno = "";

            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString);

            cmd = new SqlCommand("BrazukaScript.dbo.sp_recuperar_arquivo", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@p_nroAlgoritmo", SqlDbType.Int)).Value = idAlgoritmo;
            cmd.Parameters.Add(new SqlParameter("@p_nroAluno", SqlDbType.Int)).Value = idAluno;
            cmd.Parameters.Add(new SqlParameter("@p_nroAlunoPesquisante", SqlDbType.Int)).Value = idAlunoPesquisante;

            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                if (dr[0].ToString() == "0")
                {
                    retorno = dr[1].ToString();
                }
                else
                {
                    if (armenaSession)
                    {
                        HttpContext.Current.Session["StaPublico"] = (bool)dr["StaPublico"];
                        HttpContext.Current.Session["ArquivoNome"] = String.IsNullOrEmpty(dr["NmeAlgoritmo"].ToString()) ?
                            "Algoritmo" + dr["NroAlgoritmo"].ToString() : dr["NmeAlgoritmo"].ToString();
                    }
                    retorno = dr["TxtArquivoConteudo"].ToString();
                }
                
            }
            conn.Close();

            return retorno;
        }

        public string upLoad(FileUpload fulAlgoritmo, int idAluno)
        {
            string retorno = "";

            if (fulAlgoritmo.HasFile)
	        {
                if (fulAlgoritmo.FileName.IndexOf(".bra") < 1)
                {
                    retorno = "Tipo de Arquivo incompativel.";
                }
                else
                {
                    StreamReader reader = new StreamReader(fulAlgoritmo.FileContent);
                    string conteudo = reader.ReadToEnd();

                    conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString);

                    cmd = new SqlCommand("sp_save_arquivo", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add(new SqlParameter("@p_nroAluno", SqlDbType.Int)).Value = idAluno;
                    cmd.Parameters.Add(new SqlParameter("@p_txtConteudo", SqlDbType.NText)).Value = conteudo;
                    cmd.Parameters.Add(new SqlParameter("@p_nmeAlgoritmo", SqlDbType.VarChar)).Value = fulAlgoritmo.FileName.Replace(".bra", "");

                    conn.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        retorno = dr[1].ToString();
                    }
                    conn.Close();
                }
		        
	        }

            return retorno;
        }

        public string upLoad(String txtAlgoritmoConteudo, int idAluno, String nmeAlgoritmo, int nroAlgoritmo )
        {
            string retorno = "";

            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString);

            cmd = new SqlCommand("sp_save_arquivo", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@p_nroAluno", SqlDbType.Int)).Value = idAluno;
            cmd.Parameters.Add(new SqlParameter("@p_txtConteudo", SqlDbType.NText)).Value = txtAlgoritmoConteudo;
            cmd.Parameters.Add(new SqlParameter("@p_nmeAlgoritmo", SqlDbType.VarChar)).Value = nmeAlgoritmo;
            cmd.Parameters.Add(new SqlParameter("@p_nroAlgoritmo", SqlDbType.VarChar)).Value = nroAlgoritmo;

            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                retorno = dr[1].ToString();
            }
            conn.Close();


            return retorno;
        }
    }
}