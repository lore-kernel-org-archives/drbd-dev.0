Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CA5B40.1CD355BC"
Date: Sun, 1 Nov 2009 17:10:24 -0500
Message-ID: <BC2F8964429F14468EA0E6D6CF00E8C9390D64@EXHQ.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Supporting blktrace in DRBD
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA5B40.1CD355BC
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01CA5B40.1CD355BC"


------_=_NextPart_002_01CA5B40.1CD355BC
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I've been using blktrace to investigate performance of DRBD and have
found a few places where DRBD needs to issue blktrace API calls that it
does not - usually, the library routines in ll_rw_blk.c make these calls
on behalf of block devices but those like DRBD that write their own
routines need to also make some trace calls. Specifically, DRBD needs to
trace request completion and calls to lower level unplug routines (it's
hard to be sure but it looks to me like the caller of the unplug routine
is supposed to make the trace call).

=20

Patch against 8.2 (and tested with kernel 2.6.18) attached for your
review

Simon

=20


------_=_NextPart_002_01CA5B40.1CD355BC
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
xmlns:odc=3D"urn:schemas-microsoft-com:office:odc" =
xmlns:oa=3D"urn:schemas-microsoft-com:office:activation" =
xmlns:html=3D"http://www.w3.org/TR/REC-html40" =
xmlns:q=3D"http://schemas.xmlsoap.org/soap/envelope/" =
xmlns:rtc=3D"http://microsoft.com/officenet/conferencing" =
xmlns:D=3D"DAV:" xmlns:Repl=3D"http://schemas.microsoft.com/repl/" =
xmlns:mt=3D"http://schemas.microsoft.com/sharepoint/soap/meetings/" =
xmlns:x2=3D"http://schemas.microsoft.com/office/excel/2003/xml" =
xmlns:ppda=3D"http://www.passport.com/NameSpace.xsd" =
xmlns:ois=3D"http://schemas.microsoft.com/sharepoint/soap/ois/" =
xmlns:dir=3D"http://schemas.microsoft.com/sharepoint/soap/directory/" =
xmlns:ds=3D"http://www.w3.org/2000/09/xmldsig#" =
xmlns:dsp=3D"http://schemas.microsoft.com/sharepoint/dsp" =
xmlns:udc=3D"http://schemas.microsoft.com/data/udc" =
xmlns:xsd=3D"http://www.w3.org/2001/XMLSchema" =
xmlns:sub=3D"http://schemas.microsoft.com/sharepoint/soap/2002/1/alerts/"=
 xmlns:ec=3D"http://www.w3.org/2001/04/xmlenc#" =
xmlns:sp=3D"http://schemas.microsoft.com/sharepoint/" =
xmlns:sps=3D"http://schemas.microsoft.com/sharepoint/soap/" =
xmlns:xsi=3D"http://www.w3.org/2001/XMLSchema-instance" =
xmlns:udcs=3D"http://schemas.microsoft.com/data/udc/soap" =
xmlns:udcxf=3D"http://schemas.microsoft.com/data/udc/xmlfile" =
xmlns:udcp2p=3D"http://schemas.microsoft.com/data/udc/parttopart" =
xmlns:wf=3D"http://schemas.microsoft.com/sharepoint/soap/workflow/" =
xmlns:dsss=3D"http://schemas.microsoft.com/office/2006/digsig-setup" =
xmlns:dssi=3D"http://schemas.microsoft.com/office/2006/digsig" =
xmlns:mdssi=3D"http://schemas.openxmlformats.org/package/2006/digital-sig=
nature" =
xmlns:mver=3D"http://schemas.openxmlformats.org/markup-compatibility/2006=
" xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns:mrels=3D"http://schemas.openxmlformats.org/package/2006/relationshi=
ps" xmlns:spwp=3D"http://microsoft.com/sharepoint/webpartpages" =
xmlns:ex12t=3D"http://schemas.microsoft.com/exchange/services/2006/types"=
 =
xmlns:ex12m=3D"http://schemas.microsoft.com/exchange/services/2006/messag=
es" =
xmlns:pptsl=3D"http://schemas.microsoft.com/sharepoint/soap/SlideLibrary/=
" =
xmlns:spsl=3D"http://microsoft.com/webservices/SharePointPortalServer/Pub=
lishedLinksService" xmlns:Z=3D"urn:schemas-microsoft-com:" =
xmlns:st=3D"&#1;" xmlns=3D"http://www.w3.org/TR/REC-html40">

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

<p class=3DMsoNormal>I&#8217;ve been using blktrace to investigate =
performance of
DRBD and have found a few places where DRBD needs to issue blktrace API =
calls
that it does not &#8211; usually, the library routines in ll_rw_blk.c =
make
these calls on behalf of block devices but those like DRBD that write =
their own
routines need to also make some trace calls. Specifically, DRBD needs to =
trace
request completion and calls to lower level unplug routines (it&#8217;s =
hard to
be sure but it looks to me like the caller of the unplug routine is =
supposed to
make the trace call).<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Patch against 8.2 (and tested with kernel 2.6.18) =
attached
for your review<o:p></o:p></p>

<p class=3DMsoNormal>Simon<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------_=_NextPart_002_01CA5B40.1CD355BC--

------_=_NextPart_001_01CA5B40.1CD355BC
Content-Type: application/octet-stream;
	name="blktrace.patch"
Content-Transfer-Encoding: base64
Content-Description: blktrace.patch
Content-Disposition: attachment;
	filename="blktrace.patch"

ZGlmZiAtLWdpdCBhL2RyYmQvZHJiZF9pbnQuaCBiL2RyYmQvZHJiZF9pbnQuaAppbmRleCA2OGM1
NDI3Li5jOGU3Y2E4IDEwMDY0NAotLS0gYS9kcmJkL2RyYmRfaW50LmgKKysrIGIvZHJiZC9kcmJk
X2ludC5oCkBAIC05MCw2ICs5MCw3IEBAIGV4dGVybiBjaGFyIHVzZXJtb2RlX2hlbHBlcltdOwog
CiAjaW5jbHVkZSA8bGludXgvYmxrZGV2Lmg+CiAjaW5jbHVkZSA8bGludXgvYmlvLmg+CisjaW5j
bHVkZSA8bGludXgvYmxrdHJhY2VfYXBpLmg+CiAKIC8vIFhYWCBkbyB3ZSBuZWVkIHRoaXM/CiAj
aWZuZGVmIFRSVUUKQEAgLTIxMjIsOCArMjE0NiwxMiBAQCBzdGF0aWMgaW5saW5lIGludCBkcmJk
X3F1ZXVlX29yZGVyX3R5cGUoc3RydWN0IGRyYmRfY29uZiAqbWRldikKICAqLwogc3RhdGljIGlu
bGluZSB2b2lkIGRyYmRfYmxrX3J1bl9xdWV1ZShzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSkKIHsK
LQlpZiAocSAmJiBxLT51bnBsdWdfZm4pCisJaWYgKHEgJiYgcS0+dW5wbHVnX2ZuKSB7CisJCS8q
IENhbGxlciBvZiB1bnBsdWcgaXMgcmVzcG9uc2libGUgZm9yIHRyYWNpbmcuLi4gKi8KKwkJYmxr
X2FkZF90cmFjZV9wZHVfaW50KHEsIEJMS19UQV9VTlBMVUdfSU8sIE5VTEwsCisJCQkJICAgICAg
cS0+cnEuY291bnRbUkVBRF0gKyBxLT5ycS5jb3VudFtXUklURV0pOwogCQlxLT51bnBsdWdfZm4o
cSk7CisJfQogfQogCiBzdGF0aWMgaW5saW5lIHZvaWQgZHJiZF9raWNrX2xvKHN0cnVjdCBkcmJk
X2NvbmYgKm1kZXYpCmRpZmYgLS1naXQgYS9kcmJkL2RyYmRfcmVxLmMgYi9kcmJkL2RyYmRfcmVx
LmMKaW5kZXggYjhiYWQwOS4uNzRmZTkwNSAxMDA2NDQKLS0tIGEvZHJiZC9kcmJkX3JlcS5jCisr
KyBiL2RyYmQvZHJiZF9yZXEuYwpAQCAtMzA2LDYgKzMwNiw3IEBAIHN0YXRpYyB2b2lkIF9jb21w
bGV0ZV9tYXN0ZXJfYmlvKHN0cnVjdCBkcmJkX2NvbmYgKm1kZXYsCiAJc3RydWN0IGRyYmRfcmVx
dWVzdCAqcmVxLCBpbnQgZXJyb3IpCiB7CiAJZHVtcF9iaW8obWRldiwgcmVxLT5tYXN0ZXJfYmlv
LCAxKTsKKwlibGtfYWRkX3RyYWNlX2JpbyhtZGV2LT5ycV9xdWV1ZSwgcmVxLT5tYXN0ZXJfYmlv
LCBCTEtfVEFfQ09NUExFVEUpOwogCWJpb19lbmRpbyhyZXEtPm1hc3Rlcl9iaW8sIGVycm9yKTsK
IAlyZXEtPm1hc3Rlcl9iaW8gPSBOVUxMOwogCWRlY19hcF9iaW8obWRldik7CkBAIC04NzksNiAr
ODgyLDcgQEAgU1RBVElDIGludCBkcmJkX21ha2VfcmVxdWVzdF9jb21tb24oc3RydWN0IGRyYmRf
Y29uZiAqbWRldiwgc3RydWN0IGJpbyAqYmlvKQogCQkvKiBvbmx5IHBhc3MgdGhlIGVycm9yIHRv
IHRoZSB1cHBlciBsYXllcnMuCiAJCSAqIGlmIHVzZXIgY2Fubm90IGhhbmRsZSBpbyBlcnJvcnMs
IHRoYXRzIG5vdCBvdXIgYnVzaW5lc3MuICovCiAJCUVSUigiY291bGQgbm90IGttYWxsb2MoKSBy
ZXFcbiIpOworCQlibGtfYWRkX3RyYWNlX2JpbyhtZGV2LT5ycV9xdWV1ZSwgYmlvLCBCTEtfVEFf
Q09NUExFVEUpOwogCQliaW9fZW5kaW8oYmlvLCAtRU5PTUVNKTsKIAkJcmV0dXJuIDA7CiAJfQpA
QCAtMTA2OCw2ICsxMDcyLDcgQEAgYWxsb2NhdGVfYmFycmllcjoKIAkJCWRlY19hcF9wZW5kaW5n
KG1kZXYpOwogCQlfZHJiZF9lbmRfaW9fYWNjdChtZGV2LCByZXEpOwogCQkvKiBUSElOSzogZG8g
d2Ugd2FudCB0byBmYWlsIGl0ICgtRUlPKSwgb3IgcHJldGVuZCBzdWNjZXNzPyAqLworCQlibGtf
YWRkX3RyYWNlX2JpbyhtZGV2LT5ycV9xdWV1ZSwgcmVxLT5tYXN0ZXJfYmlvLCBCTEtfVEFfQ09N
UExFVEUpOwogCQliaW9fZW5kaW8ocmVxLT5tYXN0ZXJfYmlvLCAwKTsKIAkJcmVxLT5tYXN0ZXJf
YmlvID0gTlVMTDsKIAkJZGVjX2FwX2JpbyhtZGV2KTsKQEAgLTExMTEsNiArMTExNiw3IEBAIGFs
bG9jYXRlX2JhcnJpZXI6CiAKIGZhaWxfYW5kX2ZyZWVfcmVxOgogCWtmcmVlKGIpOworCWJsa19h
ZGRfdHJhY2VfYmlvKG1kZXYtPnJxX3F1ZXVlLCBiaW8sIEJMS19UQV9DT01QTEVURSk7CiAJYmlv
X2VuZGlvKGJpbywgZXJyKTsKIAlkcmJkX3JlcV9mcmVlKHJlcSk7CiAJcmV0dXJuIDA7CkBAIC0x
MTY4LDYgKzExNzQsNyBAQCBpbnQgZHJiZF9tYWtlX3JlcXVlc3RfMjYoc3RydWN0IHJlcXVlc3Rf
cXVldWUgKnEsIHN0cnVjdCBiaW8gKmJpbykKIAlzdHJ1Y3QgZHJiZF9jb25mICptZGV2ID0gKHN0
cnVjdCBkcmJkX2NvbmYgKikgcS0+cXVldWVkYXRhOwogCiAJaWYgKGRyYmRfZmFpbF9yZXF1ZXN0
X2Vhcmx5KG1kZXYsIGJpb19kYXRhX2RpcihiaW8pICYgV1JJVEUpKSB7CisJCWJsa19hZGRfdHJh
Y2VfYmlvKG1kZXYtPnJxX3F1ZXVlLCBiaW8sIEJMS19UQV9DT01QTEVURSk7CiAJCWJpb19lbmRp
byhiaW8sIC1FUEVSTSk7CiAJCXJldHVybiAwOwogCX0KQEAgLTExODIsNiArMTE4OSw3IEBAIGlu
dCBkcmJkX21ha2VfcmVxdWVzdF8yNihzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSwgc3RydWN0IGJp
byAqYmlvKQogCSAqLwogCWlmICh1bmxpa2VseShiaW9fYmFycmllcihiaW8pICYmIHRlc3RfYml0
KE5PX0JBUlJJRVJfU1VQUCwgJm1kZXYtPmZsYWdzKSkpIHsKIAkJLyogV0FSTigiUmVqZWN0aW5n
IGJhcnJpZXIgcmVxdWVzdCBhcyB1bmRlcmx5aW5nIGRldmljZSBkb2VzIG5vdCBzdXBwb3J0XG4i
KTsgKi8KKwkJYmxrX2FkZF90cmFjZV9iaW8obWRldi0+cnFfcXVldWUsIGJpbywgQkxLX1RBX0NP
TVBMRVRFKTsKIAkJYmlvX2VuZGlvKGJpbywgLUVPUE5PVFNVUFApOwogCQlyZXR1cm4gMDsKIAl9
CkBAIC0xMjEwLDYgKzEyMTgsNyBAQCBpbnQgZHJiZF9tYWtlX3JlcXVlc3RfMjYoc3RydWN0IHJl
cXVlc3RfcXVldWUgKnEsIHN0cnVjdCBiaW8gKmJpbykKIAkJICAgICIodmNudD0ldSxpZHg9JXUs
c2l6ZT0ldSxzZWN0b3I9JWxsdSlcbiIsCiAJCSAgICBiaW8tPmJpX3ZjbnQsIGJpby0+YmlfaWR4
LCBiaW8tPmJpX3NpemUsCiAJCSAgICAodW5zaWduZWQgbG9uZyBsb25nKWJpby0+Ymlfc2VjdG9y
KTsKKwkJYmxrX2FkZF90cmFjZV9iaW8obWRldi0+cnFfcXVldWUsIGJpbywgQkxLX1RBX0NPTVBM
RVRFKTsKIAkJYmlvX2VuZGlvKGJpbywgLUVJTlZBTCk7CiAJCXJldHVybiAwOwogCX0gZWxzZSB7
Cg==

------_=_NextPart_001_01CA5B40.1CD355BC--
