Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7C8DF.337C121D"
Date: Tue, 17 Jul 2007 21:58:55 -0400
Message-ID: <342BAC0A5467384983B586A6B0B376710619DF93@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [DRBD8] Minor patch to drbdmeta restore-md file parsing
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7C8DF.337C121D
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C7C8DF.337C121D"


------_=_NextPart_002_01C7C8DF.337C121D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Found a small bugette in the latest commits to parse the meta data dump
files - need to grab the yyval value before moving on to the next token
when parsing the "9999 times 0x0000000000000000;" format in the bitmap
section - patch attached (without this, the file parses OK but if you
try to actually restore from a file, it ends up writing over the end of
the bitmap array in memory and seg faulting).

=20

Simon

=20


------_=_NextPart_002_01C7C8DF.337C121D
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
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

<p class=3DMsoNormal>Found a small bugette in the latest commits to =
parse the
meta data dump files &#8211; need to grab the yyval value before moving =
on to
the next token when parsing the &#8220;9999 times =
0x0000000000000000;&#8221;
format in the bitmap section &#8211; patch attached (without this, the =
file
parses OK but if you try to actually restore from a file, it ends up =
writing
over the end of the bitmap array in memory and seg =
faulting).<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Simon<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------_=_NextPart_002_01C7C8DF.337C121D--

------_=_NextPart_001_01C7C8DF.337C121D
Content-Type: application/octet-stream;
	name="drbdmeta-parse.patch"
Content-Transfer-Encoding: base64
Content-Description: drbdmeta-parse.patch
Content-Disposition: attachment;
	filename="drbdmeta-parse.patch"

SW5kZXg6IHNyYy91c2VyL2RyYmRtZXRhLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gc3JjL3VzZXIvZHJiZG1l
dGEuYwkocmV2aXNpb24gMTY1MzQpCisrKyBzcmMvdXNlci9kcmJkbWV0YS5jCSh3b3JraW5nIGNv
cHkpCkBAIC0xOTMxLDggKzE5MzEsOCBAQAogCQkJaSsrOwogCQkJYnJlYWs7CiAJCWNhc2UgVEtf
TlVNOgorCQkJdGltZXMgPSB5eWx2YWwudTY0OwogCQkJRVhQKFRLX1RJTUVTKTsKLQkJCXRpbWVz
ID0geXlsdmFsLnU2NDsKIAkJCUVYUChUS19VNjQpOwogCQkJRVhQKCc7Jyk7CiAJCQlpZiAocGFy
c2Vfb25seSkgYnJlYWs7Cg==

------_=_NextPart_001_01C7C8DF.337C121D--
