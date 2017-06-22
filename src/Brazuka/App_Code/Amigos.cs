using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Configuration;


namespace Brazuka
{
    /// <summary>
    /// Summary description for Amigos
    /// </summary>
    public class Amigos
    {
        //private int id;
        //private String nome;
        //private String email;
        //private String senha;
        //private Image image;
        //private DataList grupoAmigos;
        //private Arquivos[] arquivos;

        DataSet ds = new DataSet();
        SqlConnection conn;
        SqlCommand cmd;

        public void loadSessionAmigo(int idAmigo)
        {

            //string retorno = "";

            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString);

            cmd = new SqlCommand("SELECT [NroAluno], [NmeAluno], [TxtEmail], [ImgAluno] " +
                "FROM [BrazukaScript].[dbo].[Aluno]" +
                "WHERE [NroAluno] =  @p_nroAluno", conn);
            //cmd = new SqlCommand("select * from [BrazukaScript].[dbo].[Aluno]", conn);
            cmd.CommandType = CommandType.Text;

            cmd.Parameters.Add(new SqlParameter("@p_nroAluno", SqlDbType.Int)).Value = idAmigo;

            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {

                HttpContext.Current.Session["NmeAmigo"] = dr["NmeAluno"].ToString();
                HttpContext.Current.Session["NroAmigo"] = (int)dr["NroAluno"];
                HttpContext.Current.Session["TxtEmailAmigo"] = dr["TxtEmail"].ToString();
                HttpContext.Current.Session["IsImgAmigoEmpty"] = String.IsNullOrEmpty(dr["ImgAluno"].ToString());

            }
            conn.Close();

        }
        // Adicionar amigos
        public string adicionarAmigos(int nroAluno, int nroAmigo)
        {
            string retorno = "";
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString);

            cmd = new SqlCommand("BrazukaScript.dbo.sp_convidar_amigo", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@p_NroSolicitante", SqlDbType.VarChar)).Value = nroAluno;
            cmd.Parameters.Add(new SqlParameter("@p_NroSolicitado", SqlDbType.VarChar)).Value = nroAmigo;

            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                retorno = dr[1].ToString();
            }
            conn.Close();

            return retorno;
        }
        // Adicionar amigos
        public string excluirOuCancelarAmigo(int nroAluno, int nroAmigo)
        {
            string retorno = "";
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString);

            cmd = new SqlCommand("BrazukaScript.dbo.sp_cancelar_exclui_amigo", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@p_NroSolicitante", SqlDbType.VarChar)).Value = nroAluno;
            cmd.Parameters.Add(new SqlParameter("@p_NroSolicitado", SqlDbType.VarChar)).Value = nroAmigo;

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