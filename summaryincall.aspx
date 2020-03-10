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


	   Boolean ParseXML(string XMLContent)
	   {
		 try
		 {
		   XmlDocument doc = new XmlDocument();
		   doc.LoadXml(XMLContent);

		   String MenuID, Duration, CallerID, CallID, DateAndTime, VoiceFileName;
		   XmlNode TempNode;
		   Byte[] VoiceFile;

		   XmlElement root = doc.DocumentElement;
		   XmlAttributeCollection attrColl = root.Attributes;

		   //parse inbound values
		   MenuID      = attrColl["menuid"].Value;
		   Duration    = attrColl["duration"].Value;
		   CallID      = attrColl["callid"].Value;
		   CallerID    = attrColl["callerid"].Value;

		   //writed parsed values to file
		   StreamWriter w = File.AppendText(Request.MapPath("summaryincall.txt"));
		   w.WriteLine("--- "  + DateTime.Now + " ------------------------------------------------------");
		   w.WriteLine("MenuId: " + MenuID);
		   w.WriteLine("Duration: " + Duration);
		   w.WriteLine("CallId: " + CallID);
		   w.WriteLine("CallerId: " + CallerID);

		   XmlNodeList NodeCount = doc.SelectNodes("/campaign/prompts/prompt" );
		   foreach( XmlNode node in NodeCount)
		   {
				attrColl = node.Attributes;

				w.WriteLine("Prompt ID: " + attrColl["promptid"].Value);
				w.WriteLine("Keypress : " + attrColl["keypress"].Value);

				if (node.HasChildNodes)
				{
				   TempNode = node.FirstChild;
				   attrColl = TempNode.Attributes;

				   //convert file to binary
				   VoiceFile = System.Convert.FromBase64String(TempNode.InnerText);
				   VoiceFileName = attrColl["filename"].Value;

				   //save file in application path
				   FileStream fs = new FileStream(Request.MapPath(VoiceFileName), FileMode.OpenOrCreate);
				   BinaryWriter bw = new BinaryWriter(fs);
				   bw.Write((byte[]) VoiceFile);
				   bw.Close();
				   fs.Close();

				   w.WriteLine("Filename : " + VoiceFileName);
				}
		   }
		   w.WriteLine("");
		   w.WriteLine("");
		   w.Close();
		   return true;
		 }
		 catch (Exception e)
		 {
		   Response.Write(e.Message);
		   return false;
		 }
	   }

	   void Page_Load(object sender, System.EventArgs e)
	   {
		  try
		  {
			 String xmlcontent, PostResponse, campaign;
			 Byte[] Bindata = Request.BinaryRead(Request.TotalBytes);

			 string XML;
			 XML = System.Text.Encoding.ASCII.GetString(Bindata);
			 StreamWriter w = File.AppendText(Request.MapPath("xmlsummaryincall.txt"));
			 w.WriteLine("--- "  + DateTime.Now + " ------------------------------------------------------");
			 w.WriteLine(XML.Replace("<?xml version=\"1.0\"?>", ""));  //needed so ?xml tag will display as text
			 w.WriteLine("");
			 w.WriteLine("");
			 w.Close();

			 if (!ParseXML(XML)) Response.Write("ERROR - Unable to write to file.  Check server-side file write permissions.");
		   }
		   catch (Exception error)
		   {
			 Response.Write(error.Message);
		   }
	   }

   </script>