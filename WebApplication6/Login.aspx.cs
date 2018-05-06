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
using NScrape;
using HtmlAgilityPack;
using NScrape.Forms;
using OpenQA.Selenium;
using OpenQA.Selenium.PhantomJS;



namespace WebApplication6
{



    public partial class Login : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            
            //var webClient = new WebClient();
            //var form = new BasicHtmlForm(webClient);
            //form.Load(new Uri("http://www.weather.gov/"), new KeyValuePair<string, string>("name", "getForecast"));
            //form.InputControls.Single(c => c.Name == "inputstring").Value = "fairbanks, ak";

            //using (var response = form.Submit())
            //{
            //    if (response.ResponseType == WebResponseType.Html)
            //    {
            //        var scraper = new TestScraper(((HtmlWebResponse)response).Html);
                    
            //        var conditions = scraper.GetConditions();

            //        var temperature = scraper.GetTemperature();
            //        System.Diagnostics.Debug.WriteLine(conditions);
            //        Weather.InnerText = temperature;

            //        var scraper2 = new TestScraper2(((HtmlWebResponse)response).Html);
            //        var craigslist = scraper2.GetList();
            //    }
            //}

            var webClient1 = new WebClient();
            var form1 = new BasicHtmlForm(webClient1);
            form1.Load(new Uri("https://www.trulia.com/rent/"), new KeyValuePair<string, string>("data-reactid", "29"));
            form1.InputControls.Single(c => c.Name == "location-autocomplete").Value = "Frisco, TX";
            using (var response = form1.Submit())
            {
                if (response.ResponseType == WebResponseType.Html)
                {
                  
                    var scraper2 = new TestScraper2(((HtmlWebResponse)response).Html);

                   // var craigslist = scraper2.GetList();
                   // Weather.InnerText = craigslist;
                }
            }

            
            IWebDriver driver = new PhantomJSDriver();
            driver.Navigate().GoToUrl("https://twitter.com/Twitter");
            var backpack = driver.Title;
            var back = driver.FindElement(By.XPath("//*[@class='u-linkComplex-target']"));
            var backpack2 = driver.FindElement(By.XPath("//*[contains(@class,'twitter-timeline-link')]/span[2]"));

            
        }

        private class TestScraper : Scraper
        {
            public TestScraper(string html) : base(html)
            {
            }

            public string GetConditions()
            {
                var node = HtmlDocument.DocumentNode.Descendants().SingleOrDefault(n => n.Attributes.Contains("class") && n.Attributes["class"].Value == "myforecast-current");

                if (node != null)
                {
                    return node.InnerText;
                }

                throw new ScrapeException("Could not scrape conditions.", Html);
            }

            public string GetTemperature()
            {
                var node = HtmlDocument.DocumentNode.Descendants().SingleOrDefault(n => n.Attributes.Contains("class") && n.Attributes["class"].Value == "myforecast-current-lrg");

                if (node != null)
                {
                    return node.InnerText.Replace("&deg;", "°");
                }

                throw new ScrapeException("Could not scrape temperature.", Html);
            }
        }

        private class TestScraper2 : Scraper
        {
            public TestScraper2(string html) : base(html)
            {
            }

            public string GetList()
            {

                var node = HtmlDocument.DocumentNode.Descendants().SingleOrDefault(n => n.Attributes.Contains("data-reactid") && n.Attributes["data-reactid"].Value == "58");
                var node2 = HtmlDocument.DocumentNode.SelectSingleNode(".//html/body/section/div[3]/div[1]/div[1]/div[2]/div/div[1]/div[1]/div[1]/ul/li[1]/div/div/div[2]/a[2]/div/div");
                var aTags = HtmlDocument.DocumentNode.SelectSingleNode("/html/body[@class='fontsLoaded']/section[@class='layout']/div[@class='columns']/div[@id='leftColumn']/div[@id='scrollContent']/div[@id='resultsColumn']/div[@class='resultsColumn']/div[@class='backgroundControls']/div[1]/div[@class='containerFluid']/ul[@class='mvn row']/li[@class='xsCol12Landscape smlCol12 lrgCol8'][1]/div[@class='ptm cardContainer positionRelative clickable']/div[@class='card backgroundBasic']/div[2]/a[@class='tileLink']/div[@class='backgroundBasic']/div[@class='cardDetails man pts pbn phm h6 typeWeightNormal']/div[2]/ul[@class='listInline typeTruncate mvn']/li[1]");
                // foreach (var aTag in aTags)
                //  return aTag.OuterHtml;

                if (aTags != null)
                {
                    //  return node.GetAttributeValue("href", "none");
                    return aTags.InnerHtml;
                }

                throw new ScrapeException("Could not scrape.", Html);




            }
        }

        protected void Button_Click(object sender, EventArgs e)
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
    }


}