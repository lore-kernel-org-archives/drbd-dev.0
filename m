Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C820F0.159A8C0E"
Date: Tue, 6 Nov 2007 22:41:29 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767107074967@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] More cases where drbd touches mdev after releasing
	reference
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C820F0.159A8C0E
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C820F0.159A8C0E"


------_=_NextPart_002_01C820F0.159A8C0E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Had a crash today caused by another place where the code touches the
mdev structure without first taking a local reference (actually after
releasing the reference in _req_mod) - in this case, when handling a
read error.=20

=20

I think it's just a matter of moving the dec_local() calls to after
anything that might touch the mdev similar to what we did a while back
to other cases in this function - see attached patch. I'm testing now,
but I think this is pretty clearly wrong.

=20

Simon


------_=_NextPart_002_01C820F0.159A8C0E
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
<meta http-equiv=3DContent-Type content=3D"text/html; =
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

<p class=3DMsoNormal>Had a crash today caused by another place where the =
code
touches the mdev structure without first taking a local reference =
(actually
after releasing the reference in _<i>req</i>_mod) &#8211; in this case, =
when
handling a read error. <o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I think it&#8217;s just a matter of moving the =
dec_local()
calls to after anything that might touch the mdev similar to what we did =
a
while back to other cases in this function &#8211; see attached patch. =
I&#8217;m
testing now, but I think this is pretty clearly wrong.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Simon<o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_002_01C820F0.159A8C0E--

------_=_NextPart_001_01C820F0.159A8C0E
Content-Type: application/octet-stream;
	name="ava-3851.patch"
Content-Transfer-Encoding: base64
Content-Description: ava-3851.patch
Content-Disposition: attachment;
	filename="ava-3851.patch"

SW5kZXg6IHNyYy9kcmJkL2RyYmRfcmVxLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gc3JjL2RyYmQvZHJiZF9y
ZXEuYwkocmV2aXNpb24gMjA2NzkpCisrKyBzcmMvZHJiZC9kcmJkX3JlcS5jCSh3b3JraW5nIGNv
cHkpCkBAIC01MTIsMTAgKzUxMiwxMCBAQAogCiAJCWJpb19wdXQocmVxLT5wcml2YXRlX2Jpbyk7
CiAJCXJlcS0+cHJpdmF0ZV9iaW8gPSBOVUxMOwotCQlkZWNfbG9jYWwobWRldik7CiAJCWlmIChi
aW9fcncocmVxLT5tYXN0ZXJfYmlvKSA9PSBSRUFEQSkgewogCQkJLyogaXQgaXMgbGVnYWwgdG8g
ZmFpbCBSRUFEQSAqLwogCQkJX3JlcV9tYXlfYmVfZG9uZShyZXEsZXJyb3IpOworCQkJZGVjX2xv
Y2FsKG1kZXYpOwogCQkJYnJlYWs7CiAJCX0KIAkJLyogZWxzZSAqLwpAQCAtNTM2LDYgKzUzNiw3
IEBACiAJCSAqIHdlIGdldCBiYWNrIGVub3VnaCBkYXRhIHRvIGJlIGFibGUgdG8gY2xlYXIgdGhl
IGJpdHMgYWdhaW4uCiAJCSAqLwogCQlfX2RyYmRfY2hrX2lvX2Vycm9yKG1kZXYsRkFMU0UpOwor
CQlkZWNfbG9jYWwobWRldik7CiAJCS8qIGZhbGwgdGhyb3VnaDogX3JlcV9tb2QocmVxLHF1ZXVl
X2Zvcl9uZXRfcmVhZCk7ICovCiAKIAljYXNlIHF1ZXVlX2Zvcl9uZXRfcmVhZDoK

------_=_NextPart_001_01C820F0.159A8C0E--
