Return-Path: <Ernest.Montrose@stratus.com>
Received: from EXNAR.corp.stratus.com (exnar.corp.stratus.com
	[134.111.200.165])
	by mailhub4.stratus.com (8.12.11/8.12.11) with ESMTP id k8KK9qqY028539
	for <drbd-dev@lists.linbit.com>; Wed, 20 Sep 2006 16:09:52 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C6DCF1.D1B354AD"
Date: Wed, 20 Sep 2006 16:17:39 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C7D2@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD Fix for test timeouts in
	trunk/testing/testsuite/testsuite.pl
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6DCF1.D1B354AD
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C6DCF1.D1B354AD"


------_=_NextPart_002_01C6DCF1.D1B354AD
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This patch fixes an issue where testsuite.pl hangs and timeouts waiting
for result from a drbd device under test.  When this=20
happens both the agent and the client are waiting for data from each
other.  Testsuits.pl eventually fails with a timeout.  Send_command()
changed to synchronize the I/o and close the descriptors when done.
=20
EM--
=20

------_=_NextPart_002_01C6DCF1.D1B354AD
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 11">
<meta name=3DOriginator content=3D"Microsoft Word 11">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C6DCD0.4AA0AC70">
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:UseWord2002TableStyleRules/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState=3D"false" LatentStyleCount=3D"156">
 </w:LatentStyles>
</xml><![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";
	mso-ansi-language:#0400;
	mso-fareast-language:#0400;
	mso-bidi-language:#0400;}
</style>
<![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:.5in'>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>This patch fixes an issue where testsuite.pl hangs =
and
timeouts waiting for result from a <span class=3DSpellE>drbd</span> =
device under
test. <span style=3D'mso-spacerun:yes'>&nbsp;</span>When this =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>happens</span></font></span>=
<font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> both the
agent and the client are waiting for data from each other.<span
style=3D'mso-spacerun:yes'>&nbsp; </span>Testsuits.pl eventually fails =
with a
timeout.<span style=3D'mso-spacerun:yes'>&nbsp; </span><span =
class=3DSpellE>Send_<span
class=3DGramE>command</span></span><span =
class=3DGramE>()</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>changed</span></font></span>=
<font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> to synchronize
the I/o and close the descriptors when =
done.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>EM--<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_002_01C6DCF1.D1B354AD--

------_=_NextPart_001_01C6DCF1.D1B354AD
Content-Type: application/octet-stream;
	name="testsuite.pl.patch"
Content-Transfer-Encoding: base64
Content-Description: testsuite.pl.patch
Content-Disposition: attachment;
	filename="testsuite.pl.patch"

SW5kZXg6IHRydW5rL3Rlc3RpbmcvdGVzdHN1aXRlL3Rlc3RzdWl0ZS5wbAo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0t
LSB0cnVuay90ZXN0aW5nL3Rlc3RzdWl0ZS90ZXN0c3VpdGUucGwJKHJldmlzaW9uIDQyMDQpCisr
KyB0cnVuay90ZXN0aW5nL3Rlc3RzdWl0ZS90ZXN0c3VpdGUucGwJKHdvcmtpbmcgY29weSkKQEAg
LTM2OCw3ICszNjgsMTMgQEAKIAogICAgICAgZXhpdCAwOwogICAgIH0KLSAKKyAgICAkbG9jYWxf
cmVwbHkgPSAiIjsKKyAgICB3aGlsZSAoPENISUxEMT4pIHsKKyAgICAgICAgJGxvY2FsX3JlcGx5
IC49ICRfOworICAgIH0KKyAgICBwdXNoIEByZXBseSwgJGxvY2FsX3JlcGx5OworICAgIGNsb3Nl
KENISUxEMSk7CisKICAgICBteSAkcGlkMiA9IG9wZW4oQ0hJTEQyLCAiLXwiKTsKICAgICBpZiAo
JHBpZDIgPT0gMCkgewogICAgICAgcHJpbnQgeyRjb25maWd7J25vZGUyJ319ICRjb21tYW5kLiJc
biI7CkBAIC0zNzgsMTYgKzM4NCwxMSBAQAogICAgIH0KIAogICAgICRsb2NhbF9yZXBseSA9ICIi
OwotICAgIHdoaWxlICg8Q0hJTEQxPikgewotICAgICAgJGxvY2FsX3JlcGx5IC49ICRfOwotICAg
IH0KLSAgICBwdXNoIEByZXBseSwgJGxvY2FsX3JlcGx5OwotCi0gICAgJGxvY2FsX3JlcGx5ID0g
IiI7CiAgICAgd2hpbGUgKDxDSElMRDI+KSB7CiAgICAgICAkbG9jYWxfcmVwbHkgLj0gJF87CiAg
ICAgfQogICAgIHB1c2ggQHJlcGx5LCAkbG9jYWxfcmVwbHk7CisgICAgY2xvc2UoQ0hJTEQyKTsK
ICAgfQogCiAgIHJldHVybiBwcm9jZXNzX3JlcGx5KCRjb21tYW5kLCBAcmVwbHkpOwo=

------_=_NextPart_001_01C6DCF1.D1B354AD--
