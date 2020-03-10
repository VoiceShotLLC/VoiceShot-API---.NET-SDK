<%@ Page Language="C#" %>
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

	   String  BuildXML(String callid, String menuid, String phone, String mode, String format, String submitval, String tts, String ext, String callerid, String alttts, String transferto)
	   {             
  
		  String promptinfo = "";
		  
		  if (tts != "")        tts        = "      <prompt promptid=\"2\" tts=\""+tts+"\" />";
		  if (callid != "")     callid     = "callid=\""+callid+"\"";
		  if (ext != "")        ext        = "ext=\""+ext+"\"";
		  if (callerid != "")   callerid   = "callerid=\""+callerid+"\"";
		  if (alttts != "")     alttts     = "alttts=\""+alttts+"\"";
		  if (transferto != "") transferto = "transferto=\""+transferto+"\"";
		  if ((alttts != "") || (transferto != "")) promptinfo = "      <prompt promptid=\"1\" "+ alttts +" "+ transferto +" />";
		  
		  StringBuilder XML = new StringBuilder("<campaign action=\"0\" menuid=\"" + menuid + "\" " + callerid + " >");
		  
		  if ((tts != "") || (promptinfo != ""))
		  {
		    XML.Append("      <prompts>");
		    if (promptinfo != "") XML.Append(promptinfo);
		    if (tts != "") XML.Append(tts);		    
		    XML.Append("      </prompts>");
		  }	
		  
		  XML.Append("  <phonenumbers>");
		  XML.Append("    <phonenumber number=\"" + phone + "\" " + ext + " " + callid + "  />");		  	  		  
		  XML.Append("  </phonenumbers>");
		  XML.Append("</campaign>");
		  return XML.ToString();
	   }
	   
	   String PostXML(String url, String XMLContent, bool Retry)
	   {
		  String result = "";
		  StreamWriter StreamWriterObj= null;

		  HttpWebRequest RequestObject = (HttpWebRequest)WebRequest.Create(url);
		  RequestObject.Method = "POST";
		  RequestObject.ContentLength = XMLContent.Length;
		  RequestObject.ContentType = "text/xml";

		  try
		  {
			 StreamWriterObj= new StreamWriter(RequestObject.GetRequestStream());
			 StreamWriterObj.Write(XMLContent);
		  }
		  catch (Exception e)
		  {
			 return e.Message;
		  }
		  finally {
			 StreamWriterObj.Close();
		  }
          try
		  {
		    HttpWebResponse ResponseObject = (HttpWebResponse)RequestObject.GetResponse();
		    using (StreamReader StreamReaderObj = new StreamReader(ResponseObject.GetResponseStream()) )
		    {
			   result = StreamReaderObj.ReadToEnd();

			   // Close and clean up the StreamReader
		  	   StreamReaderObj.Close();
		    }
		  }
		  catch (Exception e)
		  {		     
		     if (Retry)
			 {
               // Do not swap these two URLs. Always post to api.voiceshot.com first.
			   return PostXML("https://apiproxy.voiceshot.com/ivrapi.asp", XMLContent, false);
			 }
			 else
			 {
			   return e.Message;
			 }
		  }		  		  
		  return result;
	   }

	   void Page_Load(object sender, System.EventArgs e)
	   {
		  string callid, menuid, phone, mode, format, submitval, tts,ext,alttts,callerid,transferto;
		  String xmlcontent, PostResponse, campaign;
          alttts      = "";
		  callid      = Request.Form["callid"];
		  phone 	  = Request.Form["phonenumber"];
		  mode 		  = Request.Form["mode"];
		  format 	  = Request.Form["format"];
		  submitval   = Request.Form["submit"];
		  tts         = Request.Form["tts"];
		  ext         = Request.Form["ext"];
		  callerid    = Request.Form["callerid"];
                  // Unrem to use alttts, must unrem the form variable in staroutcall.htm
		  // alttts      = Request.Form["alttts"];
		  transferto  = Request.Form["transferto"];

		  if (Request.Form["UseDefault"]=="1")
			 menuid = "0";
		  else
			 menuid = Request.Form["menuid"];

		  try
		  {
			 if (submitval.ToLower()=="") submitval=" ";
		  }
		  catch
		  {
			 submitval = "";
		  }

		  xmlcontent = BuildXML(callid, menuid, phone, mode, format, submitval, tts, ext, callerid, alttts,transferto);
          if (callerid=="")
		  {
		    Response.Write("Data Validation Error: callerid attribute cannot be blank.");
		  }
		  else
		  {
		    if (submitval.ToLower()=="view")
		    {
               //Show XML that will be posted to VoiceShot
		  	   ShowXMLString(xmlcontent);
		    }
		    else
		    {
			   //post to website
			   PostResponse = PostXML("https://api.voiceshot.com/ivrapi.asp", xmlcontent, true);

			   //Show Response
			   ShowXMLString(PostResponse);
		    }
		  }
	   }

	   void ShowXMLString(String XML)
	   {
			Response.ContentType = "text/xml";
			Response.Write(XML);
	   }

   </script>