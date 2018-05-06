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

namespace WebApplication6
{
    public partial class index_Logged_In : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString);
        public enum WarningType
        {
            Success,
            Info,
            Warning,
            Danger
        }

        public void ShowNotification(string message, WarningType type)
        {
            var mainContentHolder = Master.FindControl("main") as ContentPlaceHolder;
            Panel notificationPanel = new Panel();
            {
                LiteralControl closeButton = new LiteralControl();
                closeButton.Text = "<a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>";

                Label notificationMessage = new Label() { Text = message };

                notificationPanel.Controls.Add(closeButton);
                notificationPanel.Controls.Add(notificationMessage);
            }
            notificationPanel.CssClass = string.Format("alert alert-{0} alert-dismissable", type.ToString().ToLower());
            notificationPanel.Attributes.Add("role", "alert");

            mainContentHolder.Controls.AddAt(0, notificationPanel);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString);

            if (Session["Username"] != null)
            {
                username.Text = Session["Username"].ToString();
                //   theDiv.Visible = true;
            }
            else
            {
                // theDiv.Visible = false;
                Response.Redirect("index.aspx");
            }
            userid.InnerHtml = Session["UserID"].ToString();
            //Populating a DataTable from database.
            DataTable dt = this.GetData();

            //Building an HTML string.
            StringBuilder html = new StringBuilder();

            //Table start.
            html.Append("<table class='table' border = '1'><thead>");

            //Building the Header row.
            html.Append("<tr>");
            foreach (DataColumn column in dt.Columns)
            {
                html.Append("<th scope='col'>");
                html.Append(column.ColumnName);
                html.Append("</th>");
            }
            html.Append("<th>Select</th></tr></thead><tbody class='table'>");

            //Building the Data rows.
            foreach (DataRow row in dt.Rows)
            {
                html.Append("<tr>");
                foreach (DataColumn column in dt.Columns)
                {
                    html.Append("<td>");
                    html.Append(row[column.ColumnName]);
                    html.Append("</td>");
                }
                html.Append("<td>");
                html.Append("<a href='http://www.google.com/search?q=" + HttpUtility.UrlEncode(row[0].ToString().Trim()) + "'><button class='btn btn-sm btn-primary'>View</button></a>&nbsp; <button class='btn btn-sm btn-success' value='" + row[0].ToString() + "'  data-toggle='modal' data-target='#appModal'>Apply</button>");
                html.Append("</td>");
                html.Append("</tr>");
            }

            //Table end.
            html.Append("</tbody></table>");

            placeholder2.Controls.Add(new Literal { Text = html.ToString() });

        }
        public void Fav_Click(object sender, EventArgs e)
        {
            //ADD TO FAVORITES TABLE

            LinkButton lnk = sender as LinkButton;
            String place1 = lnk.Text;
            Response.Redirect("index_Logged_In.aspx#favoriteModal");
        }


        private DataTable GetData()
        {
            string constr = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT StreetAddr, City, StateAbbr, ActionDate from EventHistory where UserID='"+ Session["UserID"].ToString() +"' "))
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

        protected void SignOutClick1(object sender, EventArgs e)
        {
            Session.Contents.RemoveAll();
            Response.Redirect(Request.RawUrl);
        }

        protected void Application_Button_Click(object sender, EventArgs e)
        {
            try
            {
                string uid = "1";
                string employer = field2.Text;
                string employerPhoned = employerPhone.Text;
                string family = fam.Text;
                string money = income.Text;
                string dependent = dep.Text;
                string pet = field28.Text;
                string applicationState = "TX";
                string applicationStreet = "TX";
                string applicationCity = "TX";
                Session["appStreet"] = applicationStreet;
                Session["appCity"] = applicationCity;

                con.Open();
                string qry = "Insert UserID, CurrentEmployer, CurrentEmplyerPhone, AnnualIncome, FamilyMembersInHome, Dependents, Pets, PetType, ApplicationStreetAddr, ApplicationCity, ApplicationStateAbbr Into ApplicationBase values ('" + uid + "','"+ employer +"','"+ employerPhone + "','"+ employer +"','" + money + "','" + family + "','" + dependent + "','" + pet + "','" + pet + "','" + applicationStreet + "','" + applicationCity + "','" + applicationState + "');";
                SqlCommand cmd = new SqlCommand(qry, con);
                con.Close();
                ShowNotification("Error: You can't do that!", WarningType.Danger);
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
    }
}
