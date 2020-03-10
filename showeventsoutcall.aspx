<%@ Register TagPrefix="UserControl" TagName="FileCheck" Src="filecheck.ascx" %>
<html>
<head>
<title>VoiceShot API v5.0 - Demo</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
a:hover { color: #C00000 }
.newbdytxt { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9pt; line-height: 125%  }
.chklsttxt {  font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 8pt }
.titletxt { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10pt}
.bluelink{ color: #0000CC; }
-->
</style>
</head>

<body bgcolor="#FFFFFF">
<p>&nbsp;</p>
<table width="800" border="0" cellspacing="0" cellpadding="1" align="center" bgcolor="#999966">
  <tr> 
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="5" bgcolor="#FFFFFF">
        <tr> 
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" align="center" class="titletxt">
              <tr>
                <td height="35"><b>Call Events</b></td>
                <td height="35" align="right"><b>Outbound voice call example</b></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="1" align="center" bgcolor="#999966">
              <tr> 
                <td> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr bgcolor="#F4F4E1"> 
                      <td> 
                        <table width="90%" border="0" cellspacing="0" cellpadding="2" align="center" class="newbdytxt">
                          <tr align="center"> 
                            <td class="chklsttxt">(Refresh to see latest results)</td>
                          </tr>
						  <tr>
							<td align="center" class="chklsttxt"> &nbsp;<font color="red"><UserControl:FileCheck runat="server" /></font>
							</td>
                          </tr>
                          <tr> 
                            <td> 
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class="newbdytxt" width="50%"><b>Raw XML</b></td>
                                  <td class="chklsttxt" align="right"><a href="http://www.voiceshot.com/docs/ivrapiv5/?callevents" target="_blank" class="bluelink">What 
                                    are Call Events?</a></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr>
                            <td>
                                <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#C0C0C0">
                                <tr> 
                                  <td><iframe src="xmleventsoutcall.txt" name="IP" width="100%" height="300" frameborder="0"> 
                                    You must use a browser that supports the IFRAME 
                                    tag </iframe></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr> 
                            <td>&nbsp;</td>
                          </tr>
                          <tr> 
                            <td><b>Parsed XML</b></td>
                          </tr>
                          <tr> 
                            <td> 
                              <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#C0C0C0">
                                <tr> 
                                  <td><iframe src="eventsoutcall.txt" name="IP" width="100%" height="300" frameborder="0"> 
                                    You must use a browser that supports the IFRAME 
                                    tag </iframe></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr> 
                            <td>&nbsp;</td>
                          </tr>
                          <tr align="center"> 
                            <td class="chklsttxt"><a href="#" onClick="history.back(-1); return false" class="bluelink">Back</a></td>
                          </tr>
                          <tr align="center"> 
                            <td class="chklsttxt">&nbsp;</td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<br><div align="center"><font color="#666666" class="chklsttxt">Copyright © <script type="text/javascript">
  document.write(new Date().getFullYear());
</script> VoiceShot LLC</font></div>
<p>&nbsp;</p>
</body>
</html>
