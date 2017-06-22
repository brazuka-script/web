<%@ WebHandler Language="C#" Class="HandlerImage" %>

using System;
using System.Web;

public class HandlerImage : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        //context.Response.ContentType = "text/plain";
        //context.Response.Write("Hello World");


        System.Data.SqlClient.SqlDataReader rdr = null;
        System.Data.SqlClient.SqlConnection conn = null;
        System.Data.SqlClient.SqlCommand selcmd = null;
        try
        {
            conn = new System.Data.SqlClient.SqlConnection
                (System.Configuration.ConfigurationManager.ConnectionStrings["conStr"].ConnectionString);
            selcmd = new System.Data.SqlClient.SqlCommand("select ImgAluno from [BrazukaScript].[dbo].[Aluno] where NroAluno= '" + context.Request.QueryString["idAluno"] + "'", conn);
            conn.Open();
            rdr = selcmd.ExecuteReader();
            while (rdr.Read())
            {
                if (rdr["ImgAluno"] != null && rdr["ImgAluno"].ToString() != "")
                {
                    context.Response.ContentType = "image/jpg";
                    context.Response.BinaryWrite((byte[])rdr["ImgAluno"]);
                }
                else
                {
                    context.Response.ContentType = "image/jpg";
                    context.Response.WriteFile("Images/UserImageDefault.jpg");
                }

            }
            if (rdr != null)
                rdr.Close();
        }
        finally
        {
            if (conn != null)
                conn.Close();
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}