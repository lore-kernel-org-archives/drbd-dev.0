Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7B8EF.1E156359"
Date: Wed, 27 Jun 2007 15:12:56 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767105DEC044@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Modifying the usermode helper program executed by DRBD
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7B8EF.1E156359
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C7B8EF.1E156359"


------_=_NextPart_002_01C7B8EF.1E156359
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Currently, the DRBD driver is hardcoded to execute "/sbin/drbdadm" as
the usermode helper program - this means that it is not possible to have
drbdadm installed in a different location or to replace it with another
program (such as a different front end to drbdsetup).

=20

To enable this, I've created a simple patch which adds a sysfs file
/sys/module/drbd/parameters/usermode_helper which can be updated with
the path to the executable to be run as the usermode helper - the
default value of this is "/sbin/drbdadm" so the default behavior is
unchanged.

=20

Simon


------_=_NextPart_002_01C7B8EF.1E156359
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

<p class=3DMsoNormal>Currently, the DRBD driver is hardcoded to execute =
&#8220;/sbin/drbdadm&#8221;
as the usermode helper program &#8211; this means that it is not =
possible to
have drbdadm installed in a different location or to replace it with =
another
program (such as a different front end to drbdsetup).<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>To enable this, I&#8217;ve created a simple patch =
which adds
a sysfs file /sys/module/drbd/parameters/usermode_helper which can be =
updated
with the path to the executable to be run as the usermode helper &#8211; =
the default
value of this is &#8220;/sbin/drbdadm&#8221; so the default behavior is
unchanged.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Simon<o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_002_01C7B8EF.1E156359--

------_=_NextPart_001_01C7B8EF.1E156359
Content-Type: application/octet-stream;
	name="drbd-usermode-helper.patch"
Content-Transfer-Encoding: base64
Content-Description: drbd-usermode-helper.patch
Content-Disposition: attachment;
	filename="drbd-usermode-helper.patch"

SW5kZXg6IHNyYy9kcmJkL2RyYmRfbmwuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBzcmMvZHJiZC9kcmJkX25s
LmMJKHJldmlzaW9uIDE1NjM4KQorKysgc3JjL2RyYmQvZHJiZF9ubC5jCSh3b3JraW5nIGNvcHkp
CkBAIC0xNjQsNyArMTY0LDcgQEAKIGludCBkcmJkX2toZWxwZXIoZHJiZF9kZXYgKm1kZXYsIGNo
YXIqIGNtZCkKIHsKIAljaGFyIG1iWzEyXTsKLQljaGFyICphcmd2W10gPSB7Ii9zYmluL2RyYmRh
ZG0iLCBjbWQsIG1iLCBOVUxMIH07CisJY2hhciAqYXJndltdID0ge3VzZXJtb2RlX2hlbHBlciwg
Y21kLCBtYiwgTlVMTCB9OwogCXN0YXRpYyBjaGFyICplbnZwW10gPSB7ICJIT01FPS8iLAogCQkJ
CSJURVJNPWxpbnV4IiwKIAkJCQkiUEFUSD0vc2JpbjovdXNyL3NiaW46L2JpbjovdXNyL2JpbiIs
CkBAIC0xNzIsOCArMTcyLDEwIEBACiAKIAlzbnByaW50ZihtYiwxMiwibWlub3ItJWQiLG1kZXZf
dG9fbWlub3IobWRldikpOwogCisJSU5GTygiaGVscGVyIGNvbW1hbmQ6ICVzICVzXG4iLHVzZXJt
b2RlX2hlbHBlcixjbWQpOworCiAJZHJiZF9iY2FzdF9ldl9oZWxwZXIobWRldixjbWQpOwotCXJl
dHVybiBjYWxsX3VzZXJtb2RlaGVscGVyKCIvc2Jpbi9kcmJkYWRtIixhcmd2LGVudnAsMSk7CisJ
cmV0dXJuIGNhbGxfdXNlcm1vZGVoZWxwZXIodXNlcm1vZGVfaGVscGVyLGFyZ3YsZW52cCwxKTsK
IH0KIAogZHJiZF9kaXNrc190IGRyYmRfdHJ5X291dGRhdGVfcGVlcihkcmJkX2RldiAqbWRldikK
SW5kZXg6IHNyYy9kcmJkL2RyYmRfbWFpbi5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIHNyYy9kcmJkL2RyYmRf
bWFpbi5jCShyZXZpc2lvbiAxNTYzOCkKKysrIHNyYy9kcmJkL2RyYmRfbWFpbi5jCSh3b3JraW5n
IGNvcHkpCkBAIC0xMTksNiArMTE5LDE0IEBACiBtb2R1bGVfcGFyYW0odHJhY2VfZGV2cyxpbnQs
MDY0NCk7CiAjZW5kaWYKIAorCisvLyBNb2R1bGUgcGFyYW1ldGVyIGZvciBzZXR0aW5nIHRoZSB1
c2VyIG1vZGUgaGVscGVyIHByb2dyYW0KKy8vIHRvIHJ1bi4gRGVmYXVsdCBpcyAvc2Jpbi9kcmJk
YWRtCisKK2NoYXIgdXNlcm1vZGVfaGVscGVyWzgwXSA9ICIvc2Jpbi9kcmJkYWRtIjsKKworbW9k
dWxlX3BhcmFtX3N0cmluZyh1c2VybW9kZV9oZWxwZXIsIHVzZXJtb2RlX2hlbHBlciwgc2l6ZW9m
KHVzZXJtb2RlX2hlbHBlciksIDA2NDQpOworCiAvLyBnbG9iYWwgcGFuaWMgZmxhZwogdm9sYXRp
bGUgaW50IGRyYmRfZGlkX3BhbmljID0gMDsKIApJbmRleDogc3JjL2RyYmQvZHJiZF9pbnQuaAo9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09Ci0tLSBzcmMvZHJiZC9kcmJkX2ludC5oCShyZXZpc2lvbiAxNTYzOCkKKysrIHNy
Yy9kcmJkL2RyYmRfaW50LmgJKHdvcmtpbmcgY29weSkKQEAgLTUxLDYgKzUxLDggQEAKIGV4dGVy
biBpbnQgZmF1bHRfZGV2czsKICNlbmRpZgogCitleHRlcm4gY2hhciB1c2VybW9kZV9oZWxwZXJb
XTsKKwogI2luY2x1ZGUgPGxpbnV4L21ham9yLmg+CiAjaWZkZWYgRFJCRF9NQUpPUgogIyB3YXJu
aW5nICJGSVhNRS4gRFJCRF9NQUpPUiBpcyBub3cgb2ZmaWNpYWxseSBkZWZpbmVkIGluIG1ham9y
LmgiCg==

------_=_NextPart_001_01C7B8EF.1E156359--
