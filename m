Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C85464.63AE9C7D"
Date: Fri, 11 Jan 2008 10:12:31 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767107C5AF52@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [DRBD8.0 PATCH] Make minor_count visible through sysfs
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C85464.63AE9C7D
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C85464.63AE9C7D"


------_=_NextPart_002_01C85464.63AE9C7D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This patch makes the minor_count module parameter visible in sysfs which
is useful for other tools

=20

Simon


------_=_NextPart_002_01C85464.63AE9C7D
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

<p class=3DMsoNormal>This patch makes the minor_count module parameter =
visible in
sysfs which is useful for other tools<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Simon<o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_002_01C85464.63AE9C7D--

------_=_NextPart_001_01C85464.63AE9C7D
Content-Type: application/octet-stream;
	name="0001-Make-minor_count-visible-through-sysfs.patch"
Content-Transfer-Encoding: base64
Content-Description: 0001-Make-minor_count-visible-through-sysfs.patch
Content-Disposition: attachment;
	filename="0001-Make-minor_count-visible-through-sysfs.patch"

RnJvbSBmMzc2NTljZmNkZTRkOGYyNzA1OWZlNWJjNGQ5M2M4ZDc4ODIzZTRhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBHcmFoYW0gPHNncmFoYW1AYW5uYS5zbi5zdHJhdHVz
LmNvbT4KRGF0ZTogRnJpLCAyMSBEZWMgMjAwNyAyMToxMDozNSAtMDUwMApTdWJqZWN0OiBbUEFU
Q0hdIE1ha2UgbWlub3JfY291bnQgdmlzaWJsZSB0aHJvdWdoIHN5c2ZzCgotLS0KIGRyYmQvZHJi
ZF9tYWluLmMgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcmJkL2RyYmRfbWFpbi5jIGIvZHJiZC9kcmJkX21h
aW4uYwppbmRleCBkMzY1ZjFiLi45ODRkMDBmIDEwMDY0NAotLS0gYS9kcmJkL2RyYmRfbWFpbi5j
CisrKyBiL2RyYmQvZHJiZF9tYWluLmMKQEAgLTg5LDcgKzg5LDcgQEAgTU9EVUxFX0FMSUFTX0JM
T0NLREVWX01BSk9SKExBTkFOQV9EUkJEX01BSk9SKTsKIE1PRFVMRV9QQVJNX0RFU0MoYWxsb3df
b29zLCAiRE9OVCBVU0UhIik7CiAvKiB0aGFua3MgdG8gdGhlc2UgbWFjcm9zLCBpZiBjb21waWxl
ZCBpbnRvIHRoZSBrZXJuZWwgKG5vdC1tb2R1bGUpLAogICogdGhpcyBiZWNvbWVzIHRoZSBib290
IHBhcmFtZXRlciBkcmJkLm1pbm9yX2NvdW50ICovCi1tb2R1bGVfcGFyYW0obWlub3JfY291bnQs
IGludCwwKTsKK21vZHVsZV9wYXJhbShtaW5vcl9jb3VudCwgaW50LDA0MDApOwogbW9kdWxlX3Bh
cmFtKGFsbG93X29vcywgYm9vbCwwKTsKIAogI2lmZGVmIERSQkRfRU5BQkxFX0ZBVUxUUwotLSAK
MS41LjQucmMxCgo=

------_=_NextPart_001_01C85464.63AE9C7D--
