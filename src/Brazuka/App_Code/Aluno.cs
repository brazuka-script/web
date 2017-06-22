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
    /// Summary description for Aluno
    /// </summary>
    public class Aluno
    {
        private int id;
        private String nome;
        private String email;
        private String senha;
        private Image image;

        DataSet ds = new DataSet();
        SqlConnection conn;
        SqlCommand cmd;

        private Arquivo arquivo;
        private Amigos amigos;

        public Aluno()
        {
            arquivo = new Arquivo();
            amigos = new Amigos();
        }

        // Cadastrar
        public string cadastrarAluno(String nome, String email, String senha, string cpf, char sexo, FileUpload fulImage)
        {
            String retorno = "";
            String conteudoEmail = "Prezado aluno(a) " + nome +
                                    ",\n\nAgradecemos seu interesse em fazer parte da comunidade BrazukaScript," +
                                    " para controle de segurança pedimos sua compreensão e colaboração confirmando seu email " +
                                    "através do link abaixo no prazo de 24 horas a contar do horário de cadastro, no caso de não ter feito " +
                                    "nenhum cadastro em nosso site, pedimos que desconsidere o envio do mesmo e seu email será retirado " +
                                    "do nosso banco em 24 horas.\n\n http://localhost/brazuka/ConfirmaEmail.aspx?key={0}&u={1} \n\n" +
                                    "Atencionsamente," +
                                    "\nEquipe Brazuka Script";
            //conn = new SqlConnection("Data Source=ALBERTOSAM-PC\\SQLEXPRESS;Initial Catalog=BrazukaScript;Integrated Security=True;User ID=ALBERTOSAM-PC\\AlbertoSam;Password=''");
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString);
            cmd = new SqlCommand("BrazukaScript.dbo.sp_cadastrar_usuario", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@p_nmeAluno", SqlDbType.VarChar)).Value = nome;
            cmd.Parameters.Add(new SqlParameter("@p_txtSenha", SqlDbType.VarChar)).Value = senha;
            cmd.Parameters.Add(new SqlParameter("@p_txtEmail", SqlDbType.VarChar)).Value = email;
            cmd.Parameters.Add(new SqlParameter("@p_NroCpf", SqlDbType.VarChar)).Value = cpf;
            cmd.Parameters.Add(new SqlParameter("@p_Sexo", SqlDbType.Char)).Value = sexo; 
            cmd.Parameters.Add(new SqlParameter("@p_imgAluno", SqlDbType.Image)).Value = fulImage != null && fulImage.HasFile ? imageConvert(fulImage) : null;
            cmd.Parameters.Add(new SqlParameter("@p_imgTipo", SqlDbType.VarChar)).Value = fulImage != null && fulImage.HasFile ? fulImage.FileName.Substring(fulImage.FileName.IndexOf('.')+1) : "";

            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                retorno = dr[1].ToString();
                if (dr[0].ToString() == "1")
                {
                    string retorno2 = enviarEmail(email, String.Format(conteudoEmail, dr[2].ToString(), dr[3].ToString()), "Confirmação de Email");
                    if (!String.IsNullOrEmpty(retorno2))
                    {
                        retorno = retorno2;
                    }
                }
            }
            conn.Close();

            return retorno;
        }

        /// <summary>
        /// Método para o envio de email
        /// </summary>
        /// <param name="destinarioEmail">Endereço de destino</param>
        /// <param name="destinarioNome">Nome do Aluno</param>
        private string enviarEmail(String destinarioEmail, String conteudo, String assunto)
        {
            var objMail = new MailMessage();
            objMail.From = new MailAddress("brazukascript@gmail.com");
            //objMail.To.Add(new MailAddress(destinarioEmail));
            objMail.To.Add(new MailAddress("littlesheep84@gmail.com"));
            objMail.Subject = assunto;
            objMail.Body = conteudo;
            objMail.IsBodyHtml = false;
            objMail.Priority = MailPriority.Normal;
            objMail.SubjectEncoding = System.Text.Encoding.GetEncoding("ISO-8859-1");
            objMail.BodyEncoding = System.Text.Encoding.GetEncoding("ISO-8859-1");
            var clienteSMTP = new SmtpClient();
            try
            {
                clienteSMTP.Send(objMail);
            }
            catch (Exception ex)
            {
                return ex.Message + "\ncontate o Administrador do site.";
                throw ex;
            }
            finally
            {
                //Exclui o objeto de email da memória
                objMail.Dispose();
            }
            return "";
        }
        
        // converte a imagem em um tipo que possa se armazenado no banco
        private byte[] imageConvert(FileUpload fulImage)
        {
            byte[] imageSize = new byte[fulImage.PostedFile.ContentLength];
            HttpPostedFile uploadedImage = fulImage.PostedFile;
            uploadedImage.InputStream.Read(imageSize, 0, (int)fulImage.PostedFile.ContentLength);
            return imageSize;
        }

        // Alterar imagem
        public string atualizarPerfil(FileUpload fulImage)
        {
            string retorno = "";

            if (fulImage.PostedFile != null)
            {   //Converte a imagem no controle FileUpload para um tipo byte[] 

                conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString);

                cmd = new SqlCommand("BrazukaScript.dbo.sp_atualizar_perfil", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@p_txtEmail", SqlDbType.VarChar)).Value = HttpContext.Current.Session["TxtEmail"];
                cmd.Parameters.Add(new SqlParameter("@p_imgAluno", SqlDbType.Image)).Value = fulImage != null && fulImage.HasFile ? imageConvert(fulImage) : null;
                cmd.Parameters.Add(new SqlParameter("@p_imgTipo", SqlDbType.VarChar)).Value = fulImage != null && fulImage.HasFile ? fulImage.FileName.Substring(fulImage.FileName.IndexOf('.') + 1) : "";

                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    if (dr[0].ToString() != "0")
                    {
                        HttpContext.Current.Session["IsImgAlunoEmpty"] = false;
                    }

                    retorno = dr[1].ToString();
                }
                conn.Close();
            }

            return retorno;
        }
         // Login
        public string acessarPerfil(String email, String senha, Boolean keep)
        {
            return acessarPerfil( email,  senha,  keep, true);
        }
        // Login
        public string acessarPerfil(String email, String senha, Boolean keep, bool session)
        {
            string retorno = "";
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString);

            cmd = new SqlCommand("BrazukaScript.dbo.sp_login_usuario", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@p_txtSenha", SqlDbType.VarChar)).Value = senha;
            cmd.Parameters.Add(new SqlParameter("@p_txtEmail", SqlDbType.VarChar)).Value = email;

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
                    retorno = "sucesso";
                    if (keep)
                    {
                        HttpContext.Current.Response.Cookies["bra.email"].Value = email;
                        HttpContext.Current.Response.Cookies["bra.email"].Expires = DateTime.Now.AddMonths(1);
                        HttpContext.Current.Response.Cookies["bra.senha"].Value = senha;
                        HttpContext.Current.Response.Cookies["bra.senha"].Expires = DateTime.Now.AddMonths(1);
                    }
                    if (session)
                    {
                        HttpContext.Current.Session.Add("NmeAluno", dr["NmeAluno"].ToString());
                        HttpContext.Current.Session["NroAluno"] = (int)dr["NroAluno"];
                        HttpContext.Current.Session["TxtEmail"] = dr["TxtEmail"].ToString();
                        HttpContext.Current.Session["IsImgAlunoEmpty"] = String.IsNullOrEmpty(dr["ImgAluno"].ToString());
                        HttpContext.Current.Session["QtdAmigos"] = (int)dr["QtdAmigos"];
                    }
                    else
                    {
                        retorno = dr["NroAluno"].ToString();
                    }
                    
                    this.nome = dr["NmeAluno"].ToString();
                    this.id = (int)dr["NroAluno"];
                    this.email = dr["TxtEmail"].ToString();

                }
            }
            conn.Close();

            return retorno;
        }

        // Esqueci a senha
        public string recuperarSenha(String email)
        {
            String retorno = "";
            String conteudoEmail = "Caro Aluno(a), \nA sua senha para login em nossos servidores segue abaixo:\nsenha: {0}." +
                                    "\n\nAtencionsamente," +
                                    "\nEquipe Brazuka Script";
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString);

            cmd = new SqlCommand("BrazukaScript.dbo.sp_recuperar_senha", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@p_txtEmail", SqlDbType.VarChar)).Value = email;

            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                retorno = dr[1].ToString();
                if (dr[0].ToString() == "1")
                {
                    string retorno2 = enviarEmail(email, String.Format(conteudoEmail, dr[2].ToString()), "Recuperação de Senha BrazukaScript");
                }
            }
            conn.Close();

            return retorno;
        }

        // Trocar senha
        public string trocaSenha(String senhaAtual, String senhaNova, String senhaNovaConfirma, String email)
        {
            string retorno = "";
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString);

            cmd = new SqlCommand("BrazukaScript.dbo.sp_atualizar_senha", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@p_txtSenhaAtual", SqlDbType.VarChar)).Value = senhaAtual;
            cmd.Parameters.Add(new SqlParameter("@p_txtSenhaNova", SqlDbType.VarChar)).Value = senhaNova;
            cmd.Parameters.Add(new SqlParameter("@p_txtSenhaNovaConfirma", SqlDbType.VarChar)).Value = senhaNovaConfirma;
            cmd.Parameters.Add(new SqlParameter("@p_txtEmail", SqlDbType.VarChar)).Value = email;

            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                retorno = dr[1].ToString();
            }
            conn.Close();

            return retorno;
        }

        // Inativa aluno
        public string inativarAluno(String email)
        {
            string retorno = "";
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString);

            cmd = new SqlCommand("BrazukaScript.dbo.sp_inativa_aluno", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@p_txtEmail", SqlDbType.VarChar)).Value = email;

            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                retorno = dr[1].ToString();
            }
            conn.Close();

            return retorno;
        }
        // Quantidade de convite aberto 
        public int qtdConvitesAbertos(int nroAluno)
        {
            int retorno = 0;
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString);

            cmd = new SqlCommand("SELECT	Count(NroSolicitante) " +
                                 "FROM	    BrazukaScript.dbo.Amigos Amigos " +
                                                "INNER JOIN BrazukaScript.dbo.Aluno Aluno " +
                                "ON Amigos.NroSolicitante = Aluno.NroAluno " +
                                "AND Aluno.DtaFimCadastro IS NULL " +
                                "AND Aluno.ConfirmadoEmail = 1 " +
                                "WHERE	Amigos.NroSolicitado = @p_nroAluno AND Amigos.DtaInicio IS NULL AND Amigos.DtaFim IS NULL", conn);
            cmd.CommandType = CommandType.Text;

            cmd.Parameters.Add(new SqlParameter("@p_nroAluno", SqlDbType.VarChar)).Value = nroAluno;

            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                retorno = (int)dr[0];
            }
            conn.Close();

            return retorno;
        }

        // Confirmar email
        public string confirmarEmail(String key, int nroAluno, Aluno aluno)
        {
            string retorno = "";
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString);

            cmd = new SqlCommand("BrazukaScript.dbo.sp_confirmar_email", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@p_txtKey", SqlDbType.VarChar)).Value = key;
            cmd.Parameters.Add(new SqlParameter("@p_nroAluno", SqlDbType.VarChar)).Value = nroAluno;

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
                    retorno = "sucesso";

                    HttpContext.Current.Session["NmeAluno"] = aluno.nome = dr["NmeAluno"].ToString();
                    HttpContext.Current.Session["NroAluno"] = aluno.id = (int)dr["NroAluno"];
                    HttpContext.Current.Session["TxtEmail"] = aluno.email = dr["TxtEmail"].ToString();
                    //aluno.image = new Image();
                    //aluno.image.ImageUrl = "HandlerImage.ashx";
                    HttpContext.Current.Session["IsImgAlunoEmpty"] = String.IsNullOrEmpty(dr["ImgAluno"].ToString());
                    //aluno.image = (image)dr["ImgAluno"];
                }
            }
            conn.Close();

            return retorno;
        }

        public void recuperarAmigo(int id)
        {
            amigos.loadSessionAmigo(id);
        }

        public string adicionarAmigo(int aluno, int amigo)
        {
            return amigos.adicionarAmigos(aluno, amigo);
        }

        public string salvarAlgoritmo(FileUpload fulAlgoritmo, int idAluno)
        {
            return arquivo.upLoad(fulAlgoritmo, idAluno);
        }

        public string salvarAlgoritmo(String conteudo, int idAluno, String nome, int nroAlgoritmo)
        {
            return arquivo.upLoad(conteudo, idAluno, nome, nroAlgoritmo);
        }

        public string recuperarAlgoritmo(int idAlgoritmo, int idAluno, int idAlunoPesquisante)
        {
            return arquivo.download(idAlgoritmo, idAluno, idAlunoPesquisante);
        }
        public string recuperarAlgoritmo(int idAlgoritmo, int idAluno, int idAlunoPesquisante, bool session)
        {
            return arquivo.download(idAlgoritmo, idAluno, idAlunoPesquisante, session);
        }

        public string excluirOuCancelarAmigo(int aluno, int amigo)
        {
            return amigos.excluirOuCancelarAmigo(aluno, amigo);
        }
        public bool changeStatus(int nroAlgoritmo, int nroAluno, bool staPublico)
        {
            return arquivo.changeStatus(nroAlgoritmo, nroAluno, staPublico);
        }
        public string[] fileList(int nroAluno)
        {
            return arquivo.fileList(nroAluno);
        }

        public string getMD5Hash(string input)
        {
            //System.Security.Cryptography.MD5 md5 = System.Security.Cryptography.MD5.Create();
            byte[] inputBytes = System.Text.Encoding.ASCII.GetBytes(input);
            //byte[] hash = md5.ComputeHash(inputBytes);
            byte[] hash = inputBytes;
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            for (int i = 0; i < hash.Length; i++)
            {
                sb.Append(hash[i].ToString("X2"));
            }
            return sb.ToString();
        }


    }
}

