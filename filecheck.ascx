<%@ Control Language="C#" EnableViewState="False" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.IO" %>

<script language="C#" runat=server>
void Page_Load(object sender, System.EventArgs e)
{
  //check for write permissions necessary for this demonstration

  String OutPutPath = Path.GetDirectoryName(Request.PhysicalPath)+"\\";
  StreamWriter Filewriter;

  if (!File.Exists(OutPutPath + "xmleventsoutcall.txt"))
  {
	 //Create a file to write to.
	 try
	 {
		Filewriter = File.CreateText(OutPutPath + "xmleventsoutcall.txt");
		Filewriter.Close();

		Filewriter = File.CreateText(OutPutPath + "eventsoutcall.txt");
		Filewriter.Close();

		Filewriter = File.CreateText(OutPutPath + "xmleventsincall.txt");
		Filewriter.Close();

		Filewriter = File.CreateText(OutPutPath + "eventsincall.txt");
		Filewriter.Close();

		Filewriter = File.CreateText(OutPutPath + "xmlsummaryincall.txt");
		Filewriter.Close();

		Filewriter = File.CreateText(OutPutPath + "summaryincall.txt");
		Filewriter.Close();

		Filewriter = File.CreateText(OutPutPath + "summaryoutcall.txt");
		Filewriter.Close();

		Filewriter = File.CreateText(OutPutPath + "xmlsummaryoutcall.txt");
		Filewriter.Close();

		Filewriter = File.CreateText(OutPutPath + "xmlsummaryoutsms.txt");
		Filewriter.Close();

		Filewriter = File.CreateText(OutPutPath + "summaryoutsms.txt");
		Filewriter.Close();

		Filewriter = File.CreateText(OutPutPath + "xmlsummaryinsms.txt");
		Filewriter.Close();

		Filewriter = File.CreateText(OutPutPath + "summaryinsms.txt");
		Filewriter.Close();
	 }
	 catch (Exception error)
	 {
		Response.Write("Error: &nbsp;This example requires write permissions. &nbsp;Your Web server cannot write to this directory.");
	 }
  }
}
</script>
