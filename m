Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C80471.632897BF"
Date: Mon, 1 Oct 2007 17:24:02 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F479FA@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] drbdsetup  events patch to announce Split-brain
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C80471.632897BF
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C80471.632897BF"


------_=_NextPart_002_01C80471.632897BF
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
Included here is a small patch that I find useful when monitoring with
drbdsetup().  It adds the ability to generate an netlink event to user
space when drbd Split-brain and disconnect.  Based on that event we can
then take action. I could not find a more
convenient way to know that a split-brain occurred other then looking in
/var/log/messages.
=20
Thanks
=20
EM--

------_=_NextPart_002_01C80471.632897BF
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 11">
<meta name=3DOriginator content=3D"Microsoft Word 11">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C8044F.DD1A8790">
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
font-family:Arial'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Included here is a small patch that I find useful =
when
monitoring with <span class=3DSpellE><span =
class=3DGramE>drbdsetup</span></span><span
class=3DGramE>(</span>). <span =
style=3D'mso-spacerun:yes'>&nbsp;</span>It adds the
ability to generate <span class=3DGramE>an</span> <span =
class=3DSpellE>netlink</span>
event to user space when <span class=3DSpellE>drbd</span> Split-brain =
and
disconnect. <span style=3D'mso-spacerun:yes'>&nbsp;</span>Based on that =
event we can
then take action. I could not find a more<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>convenient</span></font></sp=
an><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> way to know
that a split-brain occurred other then looking in /<span =
class=3DSpellE>var</span>/log/messages.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>EM--<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_002_01C80471.632897BF--

------_=_NextPart_001_01C80471.632897BF
Content-Type: application/octet-stream;
	name="sb_event.patch"
Content-Transfer-Encoding: base64
Content-Description: sb_event.patch
Content-Disposition: attachment;
	filename="sb_event.patch"

SW5kZXg6IGRyYmQvZHJiZF9yZWNlaXZlci5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGRyYmQvZHJiZF9yZWNl
aXZlci5jCShyZXZpc2lvbiAxOTAxNikKKysrIGRyYmQvZHJiZF9yZWNlaXZlci5jCSh3b3JraW5n
IGNvcHkpCkBAIC0yMDExLDYgKzIwMTEsNyBAQAogCQlkcmJkX3V1aWRfZHVtcChtZGV2LCJzZWxm
IixtZGV2LT5iYy0+bWQudXVpZCk7CiAJCWRyYmRfdXVpZF9kdW1wKG1kZXYsInBlZXIiLG1kZXYt
PnBfdXVpZCk7CiAJCWRyYmRfZm9yY2Vfc3RhdGUobWRldixOUyhjb25uLERpc2Nvbm5lY3Rpbmcp
KTsKKyAgICAgICAgICAgICAgZHJiZF9iY2FzdF9zcGxpdF9icmFpbihtZGV2LDEpOy8vVGVsbCB1
c2VyIHdlIHNwbGl0IGJyYWluZWQgCiAJCXJldHVybiBjb25uX21hc2s7CiAJfQogCkluZGV4OiBk
cmJkL2RyYmRfbmwuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBkcmJkL2RyYmRfbmwuYwkocmV2aXNpb24gMTkw
MTYpCisrKyBkcmJkL2RyYmRfbmwuYwkod29ya2luZyBjb3B5KQpAQCAtMTc1OSw2ICsxNzU5LDQx
IEBACiAJY25fbmV0bGlua19zZW5kKGNuX3JlcGx5LCBDTl9JRFhfRFJCRCwgR0ZQX0tFUk5FTCk7
CiB9CiAKK3ZvaWQgZHJiZF9iY2FzdF9zcGxpdF9icmFpbihkcmJkX2RldiAqbWRldixpbnQgZmxh
ZykKK3sKKwljaGFyIGJ1ZmZlcltzaXplb2Yoc3RydWN0IGNuX21zZykrCisJCSAgICBzaXplb2Yo
c3RydWN0IGRyYmRfbmxfY2ZnX3JlcGx5KSsKKwkJICAgIHNpemVvZihzdHJ1Y3Qgc3BsaXRfYnJh
aW5fdGFnX2xlbl9zdHJ1Y3QpKworCQkgICAgc2l6ZW9mKHNob3J0IGludCldOworCXN0cnVjdCBj
bl9tc2cgKmNuX3JlcGx5ID0gKHN0cnVjdCBjbl9tc2cgKikgYnVmZmVyOworCXN0cnVjdCBkcmJk
X25sX2NmZ19yZXBseSogcmVwbHkgPSAoc3RydWN0IGRyYmRfbmxfY2ZnX3JlcGx5Kiljbl9yZXBs
eS0+ZGF0YTsKKwl1bnNpZ25lZCBzaG9ydCAqdGwgPSByZXBseS0+dGFnX2xpc3Q7CisJaW50IHZh
bCA9IGZsYWc7CisgICAgICAgCisJKnRsKysgPSBUX3NwbGl0X2JyYWluOworCSp0bCsrID0gc2l6
ZW9mKGludCk7CisgICAgICAgbWVtY3B5KHRsLCAmdmFsLCBzaXplb2YoaW50KSk7CisJdGw9KHVu
c2lnbmVkIHNob3J0KikoKGNoYXIqKXRsICsgc2l6ZW9mKGludCkpOworCSp0bCsrID0gVFRfRU5E
OyAvKiBDbG9zZSB0aGUgdGFnIGxpc3QgKi8KKworCWNuX3JlcGx5LT5pZC5pZHggPSBDTl9JRFhf
RFJCRDsKKwljbl9yZXBseS0+aWQudmFsID0gQ05fVkFMX0RSQkQ7CisKKwljbl9yZXBseS0+c2Vx
ID0gYXRvbWljX2FkZF9yZXR1cm4oMSwmZHJiZF9ubF9zZXEpOworCWNuX3JlcGx5LT5hY2sgPSAw
OyAvLyBub3QgdXNlZCBoZXJlLgorCWNuX3JlcGx5LT5sZW4gPSBzaXplb2Yoc3RydWN0IGRyYmRf
bmxfY2ZnX3JlcGx5KSArCisJCShpbnQpKChjaGFyKil0bCAtIChjaGFyKilyZXBseS0+dGFnX2xp
c3QpOworCWNuX3JlcGx5LT5mbGFncyA9IDA7CisKKwlyZXBseS0+cGFja2V0X3R5cGUgPSBQX3Nw
bGl0X2JyYWluOworCXJlcGx5LT5taW5vciA9IG1kZXZfdG9fbWlub3IobWRldik7CisJcmVwbHkt
PnJldF9jb2RlID0gTm9FcnJvcjsKKworCVRSQUNFKFRyYWNlVHlwZU5sLCBUcmFjZUx2bFN1bW1h
cnksIG5sX3RyYWNlX3JlcGx5KGNuX3JlcGx5KTspOworCisJY25fbmV0bGlua19zZW5kKGNuX3Jl
cGx5LCBDTl9JRFhfRFJCRCwgR0ZQX0tFUk5FTCk7Cit9CisKIHZvaWQgZHJiZF9iY2FzdF9zeW5j
X3Byb2dyZXNzKGRyYmRfZGV2ICptZGV2KQogewogCWNoYXIgYnVmZmVyW3NpemVvZihzdHJ1Y3Qg
Y25fbXNnKSsKSW5kZXg6IGRyYmQvbGludXgvZHJiZF9ubC5oCj09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGRyYmQv
bGludXgvZHJiZF9ubC5oCShyZXZpc2lvbiAxOTAxNikKKysrIGRyYmQvbGludXgvZHJiZF9ubC5o
CSh3b3JraW5nIGNvcHkpCkBAIC05Nyw2ICs5NywxMCBAQAogCUlOVEVHRVIoCTQzLAlUX01BWV9J
R05PUkUsCXN5bmNfcHJvZ3Jlc3MpCiApCiAKK1BBQ0tFVChzcGxpdF9icmFpbiwgMjQsCisJSU5U
RUdFUigJNDQsCVRfTUFZX0lHTk9SRSwJc3BsaXRfYnJhaW4pCispCisKICN1bmRlZiBQQUNLRVQK
ICN1bmRlZiBJTlRFR0VSCiAjdW5kZWYgSU5UNjQKSW5kZXg6IGRyYmQvZHJiZF9pbnQuaAo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09Ci0tLSBkcmJkL2RyYmRfaW50LmgJKHJldmlzaW9uIDE5MDE2KQorKysgZHJiZC9kcmJk
X2ludC5oCSh3b3JraW5nIGNvcHkpCkBAIC0xNDE3LDYgKzE0MTcsNyBAQAogaW50IF9faW5pdCBk
cmJkX25sX2luaXQodm9pZCk7CiB2b2lkIGRyYmRfYmNhc3Rfc3RhdGUoZHJiZF9kZXYgKm1kZXYp
Owogdm9pZCBkcmJkX2JjYXN0X3N5bmNfcHJvZ3Jlc3MoZHJiZF9kZXYgKm1kZXYpOwordm9pZCBk
cmJkX2JjYXN0X3NwbGl0X2JyYWluKGRyYmRfZGV2ICptZGV2LGludCBmbGFnKTsKIAogLyoKICAq
IGlubGluZSBoZWxwZXIgZnVuY3Rpb25zCkluZGV4OiB1c2VyL2RyYmRzZXR1cC5jCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KLS0tIHVzZXIvZHJiZHNldHVwLmMJKHJldmlzaW9uIDE5MDE2KQorKysgdXNlci9kcmJkc2V0
dXAuYwkod29ya2luZyBjb3B5KQpAQCAtMTIzMSw2ICsxMjMxLDE0IEBACiAJCQkJc3luY2VkICUg
MTApOwogCQl9IGVsc2UgZnByaW50ZihzdGRlcnIsIk1pc3NpbmcgdGFnICE/XG4iKTsKIAkJYnJl
YWs7CisJY2FzZSBQX3NwbGl0X2JyYWluOgorCQlpZiAoY29uc3VtZV90YWdfaW50KFRfc3BsaXRf
YnJhaW4sIHJlcGx5LT50YWdfbGlzdCwgJnN5bmNlZCkpIHsKKwkJCXByaW50ZigiJXUgU0IgJWQg
JWRcbiIsIAorCQkJCXNlcSwKKwkJCQlyZXBseS0+bWlub3IsCisJCQkJc3luY2VkKTsKKwkJfSBl
bHNlIGZwcmludGYoc3RkZXJyLCJNaXNzaW5nIHRhZyAhP1xuIik7CisJCWJyZWFrOwogCWRlZmF1
bHQ6CiAJCXByaW50ZigiJXUgPz8gJWQgPG90aGVyIG1lc3NhZ2U+XG4iLHNlcSwgcmVwbHktPm1p
bm9yKTsKIAkJYnJlYWs7Cg==

------_=_NextPart_001_01C80471.632897BF--
