Return-Path: <Simon.Graham@stratus.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C72D10.E80FFCD1"
Content-class: urn:content-classes:message
Date: Sun, 31 Dec 2006 14:21:38 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767104464CB2@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD-8: Minor fix to drbd_strings.c
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C72D10.E80FFCD1
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C72D10.E80FFCD1"


------_=_NextPart_002_01C72D10.E80FFCD1
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Just noticed that the code that converts error codes to strings is
slightly wrong - patch attached.

=20

Simon

=20


------_=_NextPart_002_01C72D10.E80FFCD1
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
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

<p class=3DMsoNormal>Just noticed that the code that converts error =
codes to
strings is slightly wrong &#8211; patch attached.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Simon<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------_=_NextPart_002_01C72D10.E80FFCD1--

------_=_NextPart_001_01C72D10.E80FFCD1
Content-Type: application/octet-stream;
	name="drbd-strings.patch"
Content-Transfer-Encoding: base64
Content-Description: drbd-strings.patch
Content-Disposition: attachment;
	filename="drbd-strings.patch"

SW5kZXg6IHRydW5rL2RyYmQvZHJiZF9zdHJpbmdzLmMKPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gdHJ1bmsvZHJi
ZC9kcmJkX3N0cmluZ3MuYwkocmV2aXNpb24gODQ0OSkKKysrIHRydW5rL2RyYmQvZHJiZF9zdHJp
bmdzLmMJKHdvcmtpbmcgY29weSkKQEAgLTc1LDcgKzc1LDcgQEAKIAlbLVNTX0FscmVhZHlTdGFu
ZEFsb25lXSA9ICJDYW4gbm90IGRpc2Nvbm5lY3QgYSBTdGFuZEFsb25lIGRldmljZSIsCiAJWy1T
U19DV19GYWlsZWRCeVBlZXJdID0gIlN0YXRlIGNoYW5nZWQgd2FzIHJlZnVzZWQgYnkgcGVlciBu
b2RlIiwKIAlbLVNTX0Nhbk5vdE91dGRhdGVETF0gPSAiQ2FuIG5vdCBvdXRkYXRlIGEgZGlza2xl
c3MgZGV2aWNlIiwKLQlbLVNTX0RldmljZUluVXNlXSA9ICJEZXZpY2UgaXMgaGVscCBvcGVuIGJ5
IHNvbWVvbmUiCisJWy1TU19EZXZpY2VJblVzZV0gPSAiRGV2aWNlIGlzIGhlbGQgb3BlbiBieSBz
b21lb25lIgogfTsKIAogY29uc3QgY2hhciogY29ubnNfdG9fbmFtZShkcmJkX2Nvbm5zX3Qgcykg
ewpAQCAtOTUsNyArOTUsNyBAQAogfQogCiBjb25zdCBjaGFyKiBzZXRfc3RfZXJyX25hbWUoc2V0
X3N0X2Vycl90IGVycikgewotCXJldHVybiBlcnIgPCBTU19DV19GYWlsZWRCeVBlZXIgPyAiVE9P
X1NNQUxMIiA6CisJcmV0dXJuIGVyciA8IFNTX0RldmljZUluVXNlID8gIlRPT19TTUFMTCIgOgog
CSAgICAgICBlcnIgPiBTU19Ud29QcmltYXJpZXMgPyAiVE9PX0xBUkdFIgogCQkgICAgICAgIDog
ZHJiZF9zdGF0ZV9zd19lcnJvcnNbLWVycl07CiB9Cg==

------_=_NextPart_001_01C72D10.E80FFCD1--
