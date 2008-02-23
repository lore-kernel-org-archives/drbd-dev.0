Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C8765C.D847F28A"
Date: Sat, 23 Feb 2008 15:44:10 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767108591DEC@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [DRBD8.0 PATCH] Updated fix to ensure stale state is not
	sent if a cluster wide state change is in progress
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8765C.D847F28A
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C8765C.D847F28A"


------_=_NextPart_002_01C8765C.D847F28A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This is an addendum to a patch I previously submitted (applied to the
8.0 tree as ID 6e9fdc92) that blocks sending state information if a
cluster wide state change is in progress - there was a hole in this
because the code in drbd_request_state() actually released the drbd
state lock BEFORE updating the state locally leaving a small window
where a request to send state can send the old stale state.

=20

Simon


------_=_NextPart_002_01C8765C.D847F28A
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

<p class=3DMsoNormal>This is an addendum to a patch I previously =
submitted (applied
to the 8.0 tree as ID 6e9fdc92) that blocks sending state information if =
a
cluster wide state change is in progress &#8211; there was a hole in =
this
because the code in drbd_request_state() actually released the drbd =
state lock
BEFORE updating the state locally leaving a small window where a request =
to
send state can send the old stale state.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Simon<o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_002_01C8765C.D847F28A--

------_=_NextPart_001_01C8765C.D847F28A
Content-Type: application/octet-stream;
	name="0001-Close-window-where-old-state-can-be-sent-by-drbd_sen.patch"
Content-Transfer-Encoding: base64
Content-Description: 0001-Close-window-where-old-state-can-be-sent-by-drbd_sen.patch
Content-Disposition: attachment;
	filename="0001-Close-window-where-old-state-can-be-sent-by-drbd_sen.patch"

RnJvbSAxYjQxNDliYzVlMDc3NWUzZjRkODY4MGNmZmM1YTkwNjU0NDY3ZjYyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBQLiBHcmFoYW0gPFNpbW9uLkdyYWhhbUBzdHJhdHVz
LmNvbT4KRGF0ZTogU2F0LCAyMyBGZWIgMjAwOCAxNTowNjo0MiAtMDUwMApTdWJqZWN0OiBbUEFU
Q0hdIENsb3NlIHdpbmRvdyB3aGVyZSBvbGQgc3RhdGUgY2FuIGJlIHNlbnQgYnkgZHJiZF9zZW5k
X3N0YXRlKCkKCkEgcHJldmlvdXMgY2hhbmdlIG1hZGUgdGhpcyByb3V0aW5lIGFjcXVpcmUgdGhl
IGRyYmRfc3RhdGVfbG9jaygpIHRvCmVuc3VyZSB0aGF0IGl0IHdvbnQgYmUgc2VudCB3aGVuIHRo
ZXJlIGlzIGEgY2x1c3RlciB3aWRlIHN0YXRlIGNoYW5nZQppbiBwcm9ncmVzcy4gVW5mb3J0dW5h
dGVseSwgdGhlIGNvZGUgaW4gZHJiZF9yZXF1ZXN0X3N0YXRlIHJlbGVhc2VkCnRoZSBsb2NrIGJl
Zm9yZSB1cGRhdGluZyB0aGUgbG9jYWwgc3RhdGUgd2hpY2ggbWVhbnMgdGhhdCBpdCB3YXMgc3Rp
bGwKcG9zc2libGUgZm9yIGRyYmRfc2VuZF9zdGF0ZSgpIHRvIHNlbmQgc3RhbGUgZGF0YS4KClRo
aXMgZml4IHNldHMgdGhlIGxvY2FsIHN0YXRlIHdoaWxzdCBzdGlsbCBob2xkaW5nIHRoZSBzdGF0
ZSBsb2NrLgotLS0KIGRyYmQvZHJiZF9tYWluLmMgfCAgICA4ICsrKysrKy0tCiAxIGZpbGVzIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcmJk
L2RyYmRfbWFpbi5jIGIvZHJiZC9kcmJkX21haW4uYwppbmRleCBkMDNlZDcwLi4xZDcxN2NjIDEw
MDY0NAotLS0gYS9kcmJkL2RyYmRfbWFpbi5jCisrKyBiL2RyYmQvZHJiZF9tYWluLmMKQEAgLTQ5
NiwxNCArNDk2LDE4IEBAIGludCBfZHJiZF9yZXF1ZXN0X3N0YXRlKGRyYmRfZGV2KiBtZGV2LCBk
cmJkX3N0YXRlX3QgbWFzaywgZHJiZF9zdGF0ZV90IHZhbCwKIAkJCWlmKCBmICYgQ2hnU3RhdGVW
ZXJib3NlICkgcHJpbnRfc3RfZXJyKG1kZXYsb3MsbnMscnYpOwogCQkJcmV0dXJuIHJ2OwogCQl9
CisKIAkJc3Bpbl9sb2NrX2lycXNhdmUoJm1kZXYtPnJlcV9sb2NrLGZsYWdzKTsKIAkJb3MgPSBt
ZGV2LT5zdGF0ZTsKIAkJbnMuaSA9IChvcy5pICYgfm1hc2suaSkgfCB2YWwuaTsKKwkJcnYgPSBf
ZHJiZF9zZXRfc3RhdGUobWRldiwgbnMsIGYpOworCiAJCWRyYmRfc3RhdGVfdW5sb2NrKG1kZXYp
OwogCX0KKwllbHNlIHsKKwkJcnYgPSBfZHJiZF9zZXRfc3RhdGUobWRldiwgbnMsIGYpOworCX0K
IAotCXJ2ID0gX2RyYmRfc2V0X3N0YXRlKG1kZXYsIG5zLCBmKTsKLQlucyA9IG1kZXYtPnN0YXRl
OwogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJm1kZXYtPnJlcV9sb2NrLGZsYWdzKTsKIAogCXJl
dHVybiBydjsKLS0gCjEuNS40LnJjMQoK

------_=_NextPart_001_01C8765C.D847F28A--
