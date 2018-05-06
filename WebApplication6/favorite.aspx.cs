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
using System.Net;
using System.IO;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;
using Newtonsoft.Json.Linq;
using System.Web.Script.Serialization;

namespace WebApplication6
{
    public partial class favorite : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString);
        string place;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["place"] != null)
            {
                Response.Write("place val =" + Request.QueryString["place"]);
                string placeid = Request.QueryString["place"];
                if (Request.QueryString["userid"] != null)
                {
                    Response.Write("userid val =" + Request.QueryString["userid"]);
                    string userid = Request.QueryString["userid"];

                    if (userid == "0")
                    {
                        Response.Redirect("Login.aspx");
                    }
                    else
                    {
                        try
                        {
                            string uid = userid;
                            place = placeid;
                            string num;
                            string addr;
                            string city;
                            string cnty;
                            var url = "https://maps.googleapis.com/maps/api/place/details/json?placeid=" + place + "&key=AIzaSyD3jfeMZK1SWfRFDgMfxn_zrGRSjE7S8Vg";
                            List<AddressComponent> listed = new List<AddressComponent>();
                            using (WebClient wc = new WebClient())
                            {
                               
                                var json = wc.DownloadString(url);


                                JObject o = JObject.Parse(json);

                                num = o["result"]["address_components"][0]["long_name"].ToString();
                                addr = o["result"]["address_components"][1]["long_name"].ToString();
                                city = o["result"]["address_components"][2]["long_name"].ToString();
                                cnty = o["result"]["address_components"][3]["long_name"].ToString();

                               


                                //JavaScriptSerializer jsonSerializer = new JavaScriptSerializer();
                                //dynamic dobj = jsonSerializer.Deserialize<dynamic>(json);
                                //string result = dobj["result"].ToString();
                                //object result1 = dobj["result"];
                               
                                //Response.Write("<p>" + dobj + "</p><br>");
                                //Response.Write("<p>" + result1 + "</p>");


                            }
                            con.Open();
                            string qry = "Insert into EventHistory (UserID, PlacesID, StreetAddr, City, County) values('" + uid + "','" + place + "','"+ num + " " + addr + "','"+ city +"','"+ cnty +"' );";
                            SqlCommand cmd = new SqlCommand(qry, con);
                            SqlDataReader sdr = cmd.ExecuteReader();
                            if (sdr.Read())
                            {
                                
                            }
                            else
                            {
                                Response.Redirect("index_Logged_In.aspx#myModal");
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
        }

        

        private void button1_Click(object sender, EventArgs e)
        {
            
        }

        private void RequestCompleted(IAsyncResult result)
        {
            var request = (HttpWebRequest)result.AsyncState;
            var response = (HttpWebResponse)request.EndGetResponse(result);
            using (var stream = response.GetResponseStream())
            {
                var r = new StreamReader(stream);
                var resp = r.ReadToEnd();
            }

        }


    }

    public class AddressComponent
    {
        public string long_name { get; set; }
        public string short_name { get; set; }
        public List<string> types { get; set; }
    }

    public class Location
    {
        public double lat { get; set; }
        public double lng { get; set; }
    }

    public class Northeast
    {
        public double lat { get; set; }
        public double lng { get; set; }
    }

    public class Southwest
    {
        public double lat { get; set; }
        public double lng { get; set; }
    }

    public class Viewport
    {
        public Northeast northeast { get; set; }
        public Southwest southwest { get; set; }
    }

    public class Geometry
    {
        public Location location { get; set; }
        public Viewport viewport { get; set; }
    }

    public class Close
    {
        public int day { get; set; }
        public string time { get; set; }
    }

    public class Open
    {
        public int day { get; set; }
        public string time { get; set; }
    }

    public class Period
    {
        public Close close { get; set; }
        public Open open { get; set; }
    }

    public class OpeningHours
    {
        public bool open_now { get; set; }
        public List<Period> periods { get; set; }
        public List<string> weekday_text { get; set; }
    }

    public class Photo
    {
        public int height { get; set; }
        public List<string> html_attributions { get; set; }
        public string photo_reference { get; set; }
        public int width { get; set; }
    }

    public class Review
    {
        public string author_name { get; set; }
        public string author_url { get; set; }
        public string language { get; set; }
        public string profile_photo_url { get; set; }
        public int rating { get; set; }
        public string relative_time_description { get; set; }
        public string text { get; set; }
        public int time { get; set; }
    }

    public class Result
    {
        public List<AddressComponent> address_components { get; set; }
        public string adr_address { get; set; }
        public string formatted_address { get; set; }
        public string formatted_phone_number { get; set; }
        public Geometry geometry { get; set; }
        public string icon { get; set; }
        public string id { get; set; }
        public string international_phone_number { get; set; }
        public string name { get; set; }
        public OpeningHours opening_hours { get; set; }
        public List<Photo> photos { get; set; }
        public string place_id { get; set; }
        public double rating { get; set; }
        public string reference { get; set; }
        public List<Review> reviews { get; set; }
        public string scope { get; set; }
        public List<string> types { get; set; }
        public string url { get; set; }
        public int utc_offset { get; set; }
        public string vicinity { get; set; }
        public string website { get; set; }
    }

    public class RootObject
    {
        public List<object> html_attributions { get; set; }
        public Result result { get; set; }
        public string status { get; set; }
    }



}