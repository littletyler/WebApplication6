using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace WebApplication6
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            
            //////////con.Open();
            //////////var i = TextBox1.Text;
            //////////var d = TextBox2.Text;
            //////////SqlCommand cmd = new SqlCommand("select count(*) from tst_tbl where id =@username and name=@password", con);
            //////////cmd.Parameters.AddWithValue("@username", TextBox1.Text);
            //////////cmd.Parameters.AddWithValue("@password", TextBox2.Text);
            //////////var str = cmd.ToString();

            try
            {
                string uid = TextBox1.Text;
                string pass = TextBox2.Text;
                con.Open();
                string qry = "select * from tst_tbl where id='" + uid + "' and name='" + pass + "'";
                SqlCommand cmd = new SqlCommand(qry, con);
                SqlDataReader sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    Session["Username"] = TextBox1.Text;
                    Response.Redirect("User_Home.aspx");
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
                con.Close();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }

    }
    }
