using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Brazuka;

public partial class ConfirmaEmail : System.Web.UI.Page
{
    private Aluno aluno;

    protected void Page_Load(object sender, EventArgs e)
    {
        string msg = "";
        aluno = new Aluno();
        msg = aluno.confirmarEmail(Request.QueryString["key"].ToString(), int.Parse(Request.QueryString["u"]), aluno);
        if (msg == "sucesso")
        {
            Session.Add("isLogged", true);
        }

        Response.Redirect("Default.aspx");
    }
}