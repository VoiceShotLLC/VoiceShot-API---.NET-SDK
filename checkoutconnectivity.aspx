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
		  String xmlcontent, PostResponse, submitval = Request.Form["submit"];

		  try
		  {
			 if (submitval.ToLower()=="") submitval=" ";
		  }
		  catch
		  {
			 submitval = "";
		  }

		  xmlcontent = "<campaign action=\"6\" />";

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

	   void ShowXMLString(String XML)
	   {
			Response.ContentType = "text/xml";
			Response.Write(XML);
	   }

   </script>

