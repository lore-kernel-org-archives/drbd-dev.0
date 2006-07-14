Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C6A788.CA04B515"
Date: Fri, 14 Jul 2006 17:02:10 -0400
Message-ID: <342BAC0A5467384983B586A6B0B376710333A704@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Running drbdmeta non-interactively
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6A788.CA04B515
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C6A788.CA04B515"


------_=_NextPart_002_01C6A788.CA04B515
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Currently, drbdmeta always prompts for confirmation before updating
meta-data - this is fine for interactive use but if you want to
initialize meta-data programmatically (as part of provisioning a box for
example) it causes problems. I would propose adding a "-force" option to
drbdmeta that overrides this and assumes a 'yes' answer to all
questions.

I have coded this and a patch for trunk is attached.

Simon

 <<drbdmeta-bug665.patch>>=20

------_=_NextPart_002_01C6A788.CA04B515
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7226.0">
<TITLE>Running drbdmeta non-interactively</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">Currently, drbdmeta always prompts for confirmation =
before updating meta-data</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
SIZE=3D2 FACE=3D"Tahoma">&#8211;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Tahoma"> this is fine for interactive use but if you =
want to initialize meta-data programmatically (as part of provisioning a =
box for example) it causes problems. I would propose adding =
a</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Tahoma">&#8220;&#8212;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Tahoma">force</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Tahoma">&#8221;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Tahoma"> option to drbdmeta that overrides this and =
assumes a</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Tahoma">&#8216;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">yes</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">&#8217;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma"> answer to all questions.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Tahoma">I have =
coded this and a patch for trunk is attached.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">Simon</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Arial" SIZE=3D2 COLOR=3D"#000000"> =
&lt;&lt;drbdmeta-bug665.patch&gt;&gt; </FONT></SPAN></P>

</BODY>
</HTML>
------_=_NextPart_002_01C6A788.CA04B515--

------_=_NextPart_001_01C6A788.CA04B515
Content-Type: application/octet-stream;
	name="drbdmeta-bug665.patch"
Content-Transfer-Encoding: base64
Content-Description: drbdmeta-bug665.patch
Content-Disposition: attachment;
	filename="drbdmeta-bug665.patch"

SW5kZXg6IGRyYmRtZXRhLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gZHJiZG1ldGEuYwkocmV2aXNpb24gMzA1
MCkKKysrIGRyYmRtZXRhLmMJKHdvcmtpbmcgY29weSkKQEAgLTM2LDYgKzM2LDcgQEAKICNpbmNs
dWRlIDxzdGRsaWIuaD4KICNpbmNsdWRlIDxzdGRpby5oPgogI2luY2x1ZGUgPGVycm5vLmg+Cisj
aW5jbHVkZSA8Z2V0b3B0Lmg+CiAjaW5jbHVkZSA8c3RyaW5nLmg+CiAjaW5jbHVkZSA8dW5pc3Rk
Lmg+CiAjaW5jbHVkZSA8ZmNudGwuaD4KQEAgLTUwLDYgKzUxLDEzIEBACiBleHRlcm4gRklMRSog
eXlpbjsKIFlZU1RZUEUgeXlsdmFsOwogCitpbnQgICAgIGZvcmNlID0gMDsKKworc3RydWN0IG9w
dGlvbiBtZXRhb3B0W10gPSB7CisgICAgeyAiZm9yY2UiLCAgbm9fYXJndW1lbnQsICAgIDAsICdm
JyB9LAorICAgIHsgTlVMTCwgICAgIDAsICAgICAgICAgICAgICAwLCAwIH0sCit9OworCiAjZGVm
aW5lIFBBR0VfU0laRSAgZ2V0cGFnZXNpemUoKQogI2RlZmluZSBQQUdFX01BU0sgICh+KFBBR0Vf
U0laRS0xKSkKICNkZWZpbmUgUEFHRV9BTElHTihhZGRyKQkoKChhZGRyKStQQUdFX1NJWkUtMSkm
UEFHRV9NQVNLKQpAQCAtNzkyLDExICs4MDAsMTkgQEAKIAlzaXplX3QgbiA9IDA7CiAJaW50IG9r
OwogCi0JcHJpbnRmKCJcbiVzXG5bbmVlZCB0byB0eXBlICclcycgdG8gY29uZmlybV0gIiwgdGV4
dCwgeWVzKTsKLQlvayA9IGdldGxpbmUoJmFuc3dlciwmbixzdGRpbikgPT0gTiAmJgotCSAgICAg
c3RybmNtcChhbnN3ZXIseWVzLE4tMSkgPT0gMDsKLQlpZiAoYW5zd2VyKSBmcmVlKGFuc3dlcik7
Ci0JcHJpbnRmKCJcbiIpOworICAgICAgICBwcmludGYoIlxuJXNcbiIsIHRleHQpOworCisgICAg
ICAgIGlmIChmb3JjZSkgeworICAgICAgICAgICAgcHJpbnRmKCIqKiogY29uZmlybWF0aW9uIGZv
cmNlZCB2aWEgLS1mb3JjZSBvcHRpb24gKioqXG4iKTsKKyAgICAgICAgICAgIG9rID0gMTsKKyAg
ICAgICAgfQorICAgICAgICBlbHNlIHsKKyAgICAgICAgICAgIHByaW50ZigiW25lZWQgdG8gdHlw
ZSAnJXMnIHRvIGNvbmZpcm1dICIsIHllcyk7CisgICAgICAgICAgICBvayA9IGdldGxpbmUoJmFu
c3dlciwmbixzdGRpbikgPT0gTiAmJgorICAgICAgICAgICAgICAgIHN0cm5jbXAoYW5zd2VyLHll
cyxOLTEpID09IDA7CisgICAgICAgICAgICBpZiAoYW5zd2VyKSBmcmVlKGFuc3dlcik7CisgICAg
ICAgICAgICBwcmludGYoIlxuIik7CisgICAgICAgIH0KIAlyZXR1cm4gb2s7CiB9CiAKQEAgLTIy
NzgsNyArMjI5NCw3IEBACiAJc2l6ZV90IGk7CiAKIAlwcmludGYKLQkgICAgKCJcblVTQUdFOiAl
cyBERVZJQ0UgRk9STUFUIFtGT1JNQVQgQVJHUy4uLl0gQ09NTUFORCBbQ01EIEFSR1MuLi5dXG4i
LAorCSAgICAoIlxuVVNBR0U6ICVzIFstLWZvcmNlXSBERVZJQ0UgRk9STUFUIFtGT1JNQVQgQVJH
Uy4uLl0gQ09NTUFORCBbQ01EIEFSR1MuLi5dXG4iLAogCSAgICAgcHJvZ25hbWUpOwogCiAJcHJp
bnRmKCJcbkZPUk1BVFM6XG4iKTsKQEAgLTI0MDgsMTQgKzI0MjQsMzIgQEAKIAlpZiAoYXJnYyA8
IDQpCiAJCXByaW50X3VzYWdlX2FuZF9leGl0KCk7CiAKKyAgICAgICAgLyogQ2hlY2sgZm9yIG9w
dGlvbnMgKGUuZy4gLS1mb3JjZSkgKi8KKyAgICAgICAgd2hpbGUgKDEpIHsKKyAgICAgICAgICAg
IGludCBjID0gZ2V0b3B0X2xvbmcoYXJnYyxhcmd2LG1ha2Vfb3B0c3RyaW5nKG1ldGFvcHQsMCks
bWV0YW9wdCwwKTsKKworICAgICAgICAgICAgaWYgKGMgPT0gLTEpCisgICAgICAgICAgICAgICAg
YnJlYWs7CisKKyAgICAgICAgICAgIHN3aXRjaCAoYykgeworICAgICAgICAgICAgY2FzZSAnZic6
CisgICAgICAgICAgICAgICAgZm9yY2UgPSAxOworICAgICAgICAgICAgICAgIGJyZWFrOworICAg
ICAgICAgICAgZGVmYXVsdDoKKyAgICAgICAgICAgICAgICBwcmludF91c2FnZV9hbmRfZXhpdCgp
OworICAgICAgICAgICAgICAgIGJyZWFrOworICAgICAgICAgICAgfQorICAgICAgICB9CisKKyAg
ICAgICAgLy8gTmV4dCBhcmd1bWVudCB0byBwcm9jZXNzIGlzIHNwZWNpZmllZCBieSBvcHRpbmQu
Li4KKyAgICAgICAgYWkgPSBvcHRpbmQ7CisKIAkvKiBGSVhNRSBzaG91bGQgaGF2ZSBhICJkcmJk
X2NmZ19uZXciIGFuZCBhICJkcmJkX2NmZ19mcmVlIgogCSAqIGZ1bmN0aW9uLCBtYXliZSBldmVu
IGEgImdldCIgYW5kICJwdXQiID8KIAkgKi8KIAljZmcgPSBjYWxsb2MoMSwgc2l6ZW9mKHN0cnVj
dCBmb3JtYXQpKTsKLQljZmctPmRyYmRfZGV2X25hbWUgPSBhcmd2WzFdOworCWNmZy0+ZHJiZF9k
ZXZfbmFtZSA9IGFyZ3ZbYWkrK107CiAKLQkvKiBhcmd2WzBdIGlzIHByb2duYW1lLCBhcmd2WzFd
IHdhcyBkcmJkX2Rldl9uYW1lLiAqLwotCWFpID0gMjsKIAlpZiAocGFyc2VfZm9ybWF0KGNmZywg
YXJndiArIGFpLCBhcmdjIC0gYWksICZhaSkpIHsKIAkJLyogcGFyc2UgaGFzIGFscmVhZHkgcHJp
bnRlZCBzb21lIGVycm9yIG1lc3NhZ2UgKi8KIAkJZXhpdCgyMCk7Cg==

------_=_NextPart_001_01C6A788.CA04B515--
