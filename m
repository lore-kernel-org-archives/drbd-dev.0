Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C860FC.19F04319"
Date: Sun, 27 Jan 2008 10:48:44 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767107E8A3F8@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH] DRBD 8.0;
	Make sure barrier is sent after last data block in epoch
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C860FC.19F04319
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C860FC.19F04319"


------_=_NextPart_002_01C860FC.19F04319
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

With the new barrier implementation, the code that checks if the size of
the current epoch has hit it's max will queue the work item to send the
barrier BEFORE queuing the workitem to send the last data block in the
epoch which is a problem!

=20

Attached patch fixes this by queuing the barrier work item after the
data.

=20

Simon


------_=_NextPart_002_01C860FC.19F04319
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

<p class=3DMsoNormal>With the new barrier implementation, the code that =
checks if
the size of the current epoch has hit it&#8217;s max will queue the work =
item
to send the barrier BEFORE queuing the workitem to send the last data =
block in
the epoch which is a problem!<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Attached patch fixes this by queuing the barrier =
work item
after the data.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Simon<o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_002_01C860FC.19F04319--

------_=_NextPart_001_01C860FC.19F04319
Content-Type: application/octet-stream;
	name="0001-Make-sure-barrier-is-sent-AFTER-last-data-block-in-e.patch"
Content-Transfer-Encoding: base64
Content-Description: 0001-Make-sure-barrier-is-sent-AFTER-last-data-block-in-e.patch
Content-Disposition: attachment;
	filename="0001-Make-sure-barrier-is-sent-AFTER-last-data-block-in-e.patch"

RnJvbSBhNDc0ZWU4MDA4ODgzNWY2NTA0YTQwMTg0MWZjN2ViOWU5ZWQwZDllIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBQLiBHcmFoYW0gPFNpbW9uLkdyYWhhbUBzdHJhdHVz
LmNvbT4KRGF0ZTogU3VuLCAyNyBKYW4gMjAwOCAxMDozMTozNCAtMDUwMApTdWJqZWN0OiBbUEFU
Q0hdIE1ha2Ugc3VyZSBiYXJyaWVyIGlzIHNlbnQgQUZURVIgbGFzdCBkYXRhIGJsb2NrIGluIGVw
b2NoCgotLS0KIGRyYmQvZHJiZF9yZXEuYyB8ICAgMTEgKysrKysrKystLS0KIDEgZmlsZXMgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyYmQv
ZHJiZF9yZXEuYyBiL2RyYmQvZHJiZF9yZXEuYwppbmRleCA4YTZmN2FmLi5lZjM5NDU1IDEwMDY0
NAotLS0gYS9kcmJkL2RyYmRfcmVxLmMKKysrIGIvZHJiZC9kcmJkX3JlcS5jCkBAIC02MTIsMTQg
KzYxMiwxOSBAQCB2b2lkIF9yZXFfbW9kKGRyYmRfcmVxdWVzdF90ICpyZXEsIGRyYmRfcmVxX2V2
ZW50X3Qgd2hhdCwgaW50IGVycm9yKQogCQlyZXEtPmVwb2NoID0gbWRldi0+bmV3ZXN0X2JhcnJp
ZXItPmJyX251bWJlcjsKIAkJbGlzdF9hZGRfdGFpbCgmcmVxLT50bF9yZXF1ZXN0cywmbWRldi0+
bmV3ZXN0X2JhcnJpZXItPnJlcXVlc3RzKTsKIAotCQkvKiBjbG9zZSB0aGUgZXBvY2gsIGluIGNh
c2UgaXQgb3V0Z3JldyB0aGUgbGltaXQgKi8KLQkJaWYoICsrbWRldi0+bmV3ZXN0X2JhcnJpZXIt
Pm5fcmVxID49IG1kZXYtPm5ldF9jb25mLT5tYXhfZXBvY2hfc2l6ZSApCi0JCQlxdWV1ZV9iYXJy
aWVyKG1kZXYpOworCQkvKiBpbmNyZW1lbnQgc2l6ZSBvZiBjdXJyZW50IGVwb2NoICovCisJCW1k
ZXYtPm5ld2VzdF9iYXJyaWVyLT5uX3JlcSsrOwogCisJCS8qIHF1ZXVlIHdvcmsgaXRlbSB0byBz
ZW5kIGRhdGEgKi8KIAkJRF9BU1NFUlQocmVxLT5ycV9zdGF0ZSAmIFJRX05FVF9QRU5ESU5HKTsK
IAkJcmVxLT5ycV9zdGF0ZSB8PSBSUV9ORVRfUVVFVUVEOwogCQlyZXEtPncuY2IgPSAgd19zZW5k
X2RibG9jazsKIAkJZHJiZF9xdWV1ZV93b3JrKCZtZGV2LT5kYXRhLndvcmssICZyZXEtPncpOwor
CisJCS8qIGNsb3NlIHRoZSBlcG9jaCwgaW4gY2FzZSBpdCBvdXRncmV3IHRoZSBsaW1pdCAqLwor
CQlpZiggbWRldi0+bmV3ZXN0X2JhcnJpZXItPm5fcmVxID49IG1kZXYtPm5ldF9jb25mLT5tYXhf
ZXBvY2hfc2l6ZSApCisJCQlxdWV1ZV9iYXJyaWVyKG1kZXYpOworCiAJCWJyZWFrOwogCiAJLyog
RklYTUUKLS0gCjEuNS40LXJjMi5HSVQKCg==

------_=_NextPart_001_01C860FC.19F04319--
