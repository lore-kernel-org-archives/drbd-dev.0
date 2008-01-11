Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C85464.B686C67A"
Date: Fri, 11 Jan 2008 10:14:50 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767107C5AF55@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [DRBD-8.0 PATCH] Make heartbeat script conform to LSB
	spec
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C85464.B686C67A
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C85464.B686C67A"


------_=_NextPart_002_01C85464.B686C67A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The drbddisk script has a few places where it returns exit codes that
don't conform to the LSB spec when it could - this patch corrects the
ones I've seen.

=20

Simon


------_=_NextPart_002_01C85464.B686C67A
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" =
xmlns:p=3D"urn:schemas-microsoft-com:office:powerpoint" =
xmlns:a=3D"urn:schemas-microsoft-com:office:access" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" =
xmlns:s=3D"uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" =
xmlns:rs=3D"urn:schemas-microsoft-com:rowset" xmlns:z=3D"#RowsetSchema" =
xmlns:b=3D"urn:schemas-microsoft-com:office:publisher" =
xmlns:ss=3D"urn:schemas-microsoft-com:office:spreadsheet" =
xmlns:c=3D"urn:schemas-microsoft-com:office:component:spreadsheet" =
xmlns:oa=3D"urn:schemas-microsoft-com:office:activation" =
xmlns:html=3D"http://www.w3.org/TR/REC-html40" =
xmlns:q=3D"http://schemas.xmlsoap.org/soap/envelope/" xmlns:D=3D"DAV:" =
xmlns:x2=3D"http://schemas.microsoft.com/office/excel/2003/xml" =
xmlns:ois=3D"http://schemas.microsoft.com/sharepoint/soap/ois/" =
xmlns:dir=3D"http://schemas.microsoft.com/sharepoint/soap/directory/" =
xmlns:ds=3D"http://www.w3.org/2000/09/xmldsig#" =
xmlns:dsp=3D"http://schemas.microsoft.com/sharepoint/dsp" =
xmlns:udc=3D"http://schemas.microsoft.com/data/udc" =
xmlns:xsd=3D"http://www.w3.org/2001/XMLSchema" =
xmlns:sps=3D"http://schemas.microsoft.com/sharepoint/soap/" =
xmlns:xsi=3D"http://www.w3.org/2001/XMLSchema-instance" =
xmlns:udcxf=3D"http://schemas.microsoft.com/data/udc/xmlfile" =
xmlns:wf=3D"http://schemas.microsoft.com/sharepoint/soap/workflow/" =
xmlns:mver=3D"http://schemas.openxmlformats.org/markup-compatibility/2006=
" xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns:mrels=3D"http://schemas.openxmlformats.org/package/2006/relationshi=
ps" =
xmlns:ex12t=3D"http://schemas.microsoft.com/exchange/services/2006/types"=
 =
xmlns:ex12m=3D"http://schemas.microsoft.com/exchange/services/2006/messag=
es" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>The drbddisk script has a few places where it =
returns exit
codes that don&#8217;t conform to the LSB spec when it could &#8211; =
this patch
corrects the ones I&#8217;ve seen.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Simon<o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_002_01C85464.B686C67A--

------_=_NextPart_001_01C85464.B686C67A
Content-Type: application/octet-stream;
	name="0002-Make-heartbeat-script-conform-to-LSB-spec.patch"
Content-Transfer-Encoding: base64
Content-Description: 0002-Make-heartbeat-script-conform-to-LSB-spec.patch
Content-Disposition: attachment;
	filename="0002-Make-heartbeat-script-conform-to-LSB-spec.patch"

RnJvbSBiNTYzNzE3ODVhYmM1ZjIyNjk4ZGNmZmU2OTllMDQzNGE4OGJlYWI3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBHcmFoYW0gPHNncmFoYW1AYW5uYS5zbi5zdHJhdHVz
LmNvbT4KRGF0ZTogRnJpLCAyMSBEZWMgMjAwNyAyMToxMjoyNyAtMDUwMApTdWJqZWN0OiBbUEFU
Q0hdIE1ha2UgaGVhcnRiZWF0IHNjcmlwdCBjb25mb3JtIHRvIExTQiBzcGVjCgotLS0KIHNjcmlw
dHMvZHJiZGRpc2sgfCAgIDEyICsrKysrKy0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCA2IGluc2Vy
dGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc2NyaXB0cy9kcmJkZGlzayBi
L3NjcmlwdHMvZHJiZGRpc2sKaW5kZXggN2QwMDFmNS4uNTNlMDJhMCAxMDA3NTUKLS0tIGEvc2Ny
aXB0cy9kcmJkZGlzaworKysgYi9zY3JpcHRzL2RyYmRkaXNrCkBAIC0yOSwxMyArMjksMTUgQEAg
Y2FzZSAiJENNRCIgaW4KIAl0cnk9NgogCXdoaWxlIHRydWU7IGRvCiAJCSREUkJEQURNIHByaW1h
cnkgJFJFUyAmJiBicmVhawotCQlsZXQgIi0tdHJ5IiB8fCBleGl0IDIwCisJCWxldCAiLS10cnki
IHx8IGV4aXQgMQogCQlzbGVlcCAxCiAJZG9uZQogCTs7CiAgICAgc3RvcCkKLQkjIGV4ZWMsIHNv
IHRoZSBleGl0IGNvZGUgb2YgZHJiZGFkbSBwcm9wYWdhdGVzCi0JZXhlYyAkRFJCREFETSBzZWNv
bmRhcnkgJFJFUworCSREUkJEQURNIHNlY29uZGFyeSAkUkVTCisJaWYgWyAkPyAtZXEgMTEgXTsg
dGhlbgorCSAgICBleGl0IDEKKwlmaQogCTs7CiAgICAgc3RhdHVzKQogCWlmIFsgIiRSRVMiID0g
ImFsbCIgXTsgdGhlbgpAQCAtNDYsMTAgKzQ4LDggQEAgY2FzZSAiJENNRCIgaW4KIAlTVEFURT0k
e1NUJS8qfQogCWlmIFsgIiRTVEFURSIgPSAiUHJpbWFyeSIgXTsgdGhlbgogCSAgICBlY2hvICJy
dW5uaW5nIgotCWVsaWYgWyAiJFNUQVRFIiA9ICJTZWNvbmRhcnkiIF07IHRoZW4KLQkgICAgZWNo
byAic3RvcHBlZCIKIAllbHNlCi0JICAgIGVjaG8gIiRTVCIKKwkgICAgZWNobyAic3RvcHBlZCIK
IAlmaQogCTs7CiAgICAgKikKLS0gCjEuNS40LnJjMQoK

------_=_NextPart_001_01C85464.B686C67A--
