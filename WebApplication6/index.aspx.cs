using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Services;
using System.Web.Services;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI.HtmlControls;
namespace MyFunction_Click
{

}
namespace WebApplication6
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString);

        private DataTable GetData()
        {

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM tst_tbl"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            return dt;
                        }
                    }
                }
            }
        }



        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                username.Text = Session["Username"].ToString();
                theDiv.Visible = true;
            }
            else
            {
                theDiv.Visible = false;
            }


        }


        public void Fav_Click(object sender, EventArgs e)
        {
            //ADD TO FAVORITES TABLE

            LinkButton lnk = sender as LinkButton;
            String place1 = lnk.Text;
            Response.Redirect("index_Logged_In.aspx#favoriteModal");
        }


            protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                string uid = TextBox1.Text;
                string pass = TextBox2.Text;
                con.Open();
                string qry = "Select UserBase.UserID from UserInformation inner join UserBase on UserInformation.UserID = UserBase.UserID where UserInformation.email='" + uid + "' and UserBase.UserPassword='" + pass + "';";
                SqlCommand cmd = new SqlCommand(qry, con);
                SqlDataReader sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    Session["Username"] = TextBox1.Text;
                    Session["UserID"] = sdr[0];
                    Response.Redirect("index_Logged_In.aspx");
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
        protected void Button2_Click(object sender, EventArgs e)
        {
            try
            {
                string uid = TextBox3.Text;
                string pass = TextBox4.Text;
                string ssn = TextBox5.Text;
               
                string dob = TextBox6.Text.ToString();
                con.Open();
                string qry = "Insert into UserBase (SSN, DOB, UserPassword) values('" + ssn + "','" + dob + "','" + pass + "');";
                string qry2 = "Select UserID from UserBase where SSN='"+ssn+"'";
                string userID;


                SqlCommand cmd = new SqlCommand(qry, con);
                SqlDataReader sdr = cmd.ExecuteReader();
                    con.Close();
                    SqlCommand cmd2 = new SqlCommand(qry2, con);
                    con.Open();
                    SqlDataReader sdr3 = cmd2.ExecuteReader();
                    if (sdr3.Read())
                    {
                        userID = sdr3[0].ToString();
                       
                        con.Close();
                        string qry3 = "Insert into UserInformation(UserID, Email, FirstName, LastName) values ('" + userID + "','" + uid + "', '"+ ssn +"','"+ ssn+"')";
                    
                        SqlCommand cmd3 = new SqlCommand(qry3, con);
                    con.Open();
                    SqlDataReader sdr4 = cmd3.ExecuteReader();
          
                        Response.Redirect("Login.aspx");
                    }

                con.Close();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }

        protected void SignOutClick(object sender, EventArgs e)
        {
            Session["Username"] = string.Empty;
            Response.Redirect("Index.aspx");
        }
    }
}