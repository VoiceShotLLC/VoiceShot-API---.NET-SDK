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
<%@ Import Namespace="System.Runtime.InteropServices" %>

   <script language="C#" runat=server>

	   Boolean ParseXML(string XMLContent, ref string KeyPress)
	   {
		 try
		 {
		   XmlDocument doc = new XmlDocument();
		   doc.LoadXml(XMLContent);

		   String MenuID, Duration, CallerID, CallID, DateAndTime, VoiceFileName, PromptID, Action;
		   XmlNode TempNode;

		   StreamWriter w = File.AppendText(Request.MapPath("eventsincall.txt"));
		   w.WriteLine("--- "  + DateTime.Now + " ------------------------------------------------------");

		   XmlElement root = doc.DocumentElement;
		   XmlAttributeCollection attrColl = root.Attributes;
		   //Determine if this a campaign start/stop event or prompt event
		   if (root.Name=="campaign")
		   {
			  //parse campaign attributes
			  MenuID      = attrColl["menuid"].Value;
			  Action      = attrColl["action"].Value;

			  w.WriteLine("Call Start/Stop Event");
			  w.WriteLine("MenuId: " + MenuID);
			  w.WriteLine("Action: " + Action);
			  if (Action=="4")
			  {
				 CallerID = attrColl["callerid"].Value;
				 w.WriteLine("CallerID: " + CallerID);
			  }
			  else
			  {
				 Duration = attrColl["duration"].Value;
				 w.WriteLine("Duration: " + Duration);
			  }
			  CallID = attrColl["callid"].Value;
			  if (CallID != "") {
				w.WriteLine("CallID: " + CallID);
			  }
		   }
		   else
		   {
			  //parse prompt attributes
			  MenuID      = attrColl["menuid"].Value;
			  CallID      = attrColl["callid"].Value;
			  PromptID    = attrColl["promptid"].Value;
			  KeyPress    = attrColl["keypress"].Value;

			  //write parsed values to file
			  w.WriteLine("Prompt Event");
			  w.WriteLine("MenuId: " + MenuID);
			  if (CallID != "") {
				w.WriteLine("CallID: " + CallID);
			  }
			  if (PromptID != "") {
				w.WriteLine("Prompt: " + PromptID);
			  }
			  if (KeyPress != "") {
				w.WriteLine("Key Press: " + KeyPress);
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

		// KeyPress handler example:
	   string CheckKeyPress(string KeyPress)
	   {
		  string ReturnXML = "";

		  switch (KeyPress)
		  {
			case "1234":
			   ReturnXML = "<prompt goto=\"2\" />";
			   break;
		  }
		  return ReturnXML;
	   }

	   void Page_Load(object sender, System.EventArgs e)
	   {
		  try
		  {
			 String XML, xmlcontent, PostResponse, campaign, KeyPress = "";
			 Byte[] Bindata = Request.BinaryRead(Request.TotalBytes);
			 XML = System.Text.Encoding.ASCII.GetString(Bindata);

			 //log raw XML from VoiceShot
			 StreamWriter w = File.AppendText(Request.MapPath("xmleventsincall.txt"));
			 w.WriteLine("--- "  + DateTime.Now + " ------------------------------------------------------");
			 w.WriteLine(XML.Replace("<?xml version=\"1.0\"?>", ""));  //needed so ?xml tag will display as text
			 w.WriteLine("");
			 w.Close();

			 //parse XML from VoiceShot
			 if (ParseXML(XML, ref KeyPress))
			 {
				//return response to VoiceShot
				XML = CheckKeyPress(KeyPress);
				Response.Write(XML);
			 }
			 else
				Response.Write("ERROR - Unable to write to file.  Check server-side file write permissions.");
		   }
		   catch (Exception error)
		   {
			 Response.Write(error.Message);
		   }
	   }

   </script>