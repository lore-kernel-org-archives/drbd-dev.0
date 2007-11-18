Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C82A38.5E277278"
Date: Sun, 18 Nov 2007 18:11:36 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C4543D15E5@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: disconnecting while already disconnecting can
	hang the receiver
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C82A38.5E277278
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C82A38.5E277278"


------_=_NextPart_002_01C82A38.5E277278
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,
There is problem that manifest itself this way:
=20
Consider 2 nodes A and B,  "A" issues a disconnect to r2, B gets into =
drbd_receiver.c: drbd_disconnect().  While B is disconnecting,
it gets a "disconnect" request for r2.  This hangs the receiver.
=20
I am thinking that we should just not allow the state transition to =
"disconnecting" if we are already doing so. We could redefine =
"Standalone" to mean
less then or equal to "TearDown" in some cases.  I include a patch to =
show this.
=20
Thanks,
=20
EM--

------_=_NextPart_002_01C82A38.5E277278
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"><HTML =
DIR=3Dltr><HEAD><META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1"></HEAD><BODY><DIV><FONT face=3D'Arial' =
color=3D#000000 size=3D2>Hi all,</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>There is problem that manifest itself =
this =0A=
way:</FONT></DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>Consider&nbsp;2 nodes A and B,&nbsp; "A" issues a disconnect to r2, =
B gets =0A=
into drbd_receiver.c: drbd_disconnect().&nbsp; While B is =
disconnecting,</DIV>=0A=
<DIV>it gets a "disconnect" request for r2.&nbsp; This hangs the =
receiver.</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>I am thinking that we should just not allow the state transition to =0A=
"disconnecting" if we are already doing so. We could redefine =
"Standalone" to =0A=
mean</DIV>=0A=
<DIV>less then or equal to "TearDown" in some cases.&nbsp; I include a =
patch to =0A=
show this.</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>Thanks,</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>EM--</DIV></BODY></HTML>
------_=_NextPart_002_01C82A38.5E277278--

------_=_NextPart_001_01C82A38.5E277278
Content-Type: text/plain;
	name="drbdsetup_hang.patch"
Content-Transfer-Encoding: base64
Content-Description: drbdsetup_hang.patch
Content-Disposition: attachment;
	filename="drbdsetup_hang.patch"

SW5kZXg6IGRyYmQvZHJiZF9tYWluLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gZHJiZC9kcmJkX21haW4uYwko
cmV2aXNpb24gMjA3MjMpCisrKyBkcmJkL2RyYmRfbWFpbi5jCSh3b3JraW5nIGNvcHkpCkBAIC01
ODksNyArNTg5LDcgQEAKIAlpZiggKG5zLmNvbm4gPT0gU3RhcnRpbmdTeW5jVCB8fCBucy5jb25u
ID09IFN0YXJ0aW5nU3luY1MgKSAmJgogCSAgICBvcy5jb25uID4gQ29ubmVjdGVkKSBydj1TU19S
ZXN5bmNSdW5uaW5nOwogCi0JaWYoIG5zLmNvbm4gPT0gRGlzY29ubmVjdGluZyAmJiBvcy5jb25u
ID09IFN0YW5kQWxvbmUpCisJaWYoIG5zLmNvbm4gPT0gRGlzY29ubmVjdGluZyAmJiBvcy5jb25u
IDw9IFRlYXJEb3duICkKIAkJcnY9U1NfQWxyZWFkeVN0YW5kQWxvbmU7CiAKIAlpZiggbnMuZGlz
ayA+IEF0dGFjaGluZyAmJiBvcy5kaXNrID09IERpc2tsZXNzKQo=

------_=_NextPart_001_01C82A38.5E277278--
