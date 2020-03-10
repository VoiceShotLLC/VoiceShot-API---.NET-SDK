<%@ Page Language="C#" aspcompat=true %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Collections" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.SessionState" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="System.Web.UI.HtmlControls" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Text.RegularExpressions" %>

   <script language="C#" runat=server>


	   Boolean ParseXML(string XMLContent) {
	    try {
	     XmlDocument doc = new XmlDocument();
	     doc.LoadXml(XMLContent);

	     String MenuID, CallerID, CallID, sText;
	     XmlNode TempNode;
	     Byte[] VoiceFile;

	     XmlElement root = doc.DocumentElement;
	     XmlAttributeCollection attrColl = root.Attributes;

	     //parse inbound values
	     MenuID = attrColl["menuid"].Value;
	     CallID = attrColl["callid"].Value;
	     CallerID = attrColl["callerid"].Value;
	     sText = doc.DocumentElement.SelectSingleNode("/campaign/prompts/prompt/@txt").Value;

	     //writed parsed values to file
	     StreamWriter w = File.AppendText(Request.MapPath("summaryinsms.txt"));
	     w.WriteLine("--- " + DateTime.Now + " ------------------------------------------------------");
	     w.WriteLine("MenuId: " + MenuID);
	     if (CallID != "") {
	      w.WriteLine("CallId: " + CallID);
	     }
	     w.WriteLine("CallerId: " + CallerID);
	     w.WriteLine("Text: " + sText);
	     w.WriteLine("");
	     w.WriteLine("");
	     w.Close();
	     return true;
	    } catch (Exception e) {
	     Response.Write(e.Message);
	     return false;
	    }
	   }

	   void Page_Load(object sender, System.EventArgs e) {
	    try {
	     String xmlcontent, PostResponse, campaign;
	     Byte[] Bindata = Request.BinaryRead(Request.TotalBytes);

	     string XML;
	     XML = System.Text.Encoding.ASCII.GetString(Bindata);
	     StreamWriter w = File.AppendText(Request.MapPath("xmlsummaryinsms.txt"));
	     w.WriteLine("--- " + DateTime.Now + " ------------------------------------------------------");
	     w.WriteLine(XML.Replace("<?xml version=\"1.0\"?>", "")); //needed so ?xml tag will display as text
	     w.WriteLine("");
	     w.WriteLine("");
	     w.Close();
	     if (!ParseXML(XML)) Response.Write("ERROR - Unable to write to file.  Check server-side file write permissions.");

	    } catch (Exception error) {
	     Response.Write(error.Message);
	    }
	   }
	   
   </script>