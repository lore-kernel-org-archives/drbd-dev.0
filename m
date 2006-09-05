Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6D126.854370BE"
Date: Tue, 5 Sep 2006 16:04:30 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671038AF9DF@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD-8 - system hangs when NegDReply received
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6D126.854370BE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

If the local (primary) is diskless and the remote system rejects a read
request with a NegDReply, it seems that the system hangs; inspecting the
code, I see that it does appear to complete the original request with a
failure BUT there are a couple of other calls made in the normal case
that are not being done in the case of a NegDReply; dec_ap_bio(mdev) and
dec_ap_pending(mdev) - I note that both of these can signal events so
perhaps the problem here is that other threads are blocked waiting for
this event which never gets signaled???

If this is the problem then the fix is trivial - add the two missing
lines following the drbd_end_bio() call in got_NegDReply().
Simon

------_=_NextPart_001_01C6D126.854370BE
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
<TITLE>DRBD-8 - system hangs when NegDReply received</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Tahoma">If the =
local (primary) is diskless and the remote system rejects a read request =
with a NegDReply, it seems that the system hangs</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Tahoma">; inspecting the code, I =
see that it does appear to complete the original request with a failure =
BUT there are a couple of other calls made in the</FONT></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Tahoma">normal</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Tahoma"> case that are not being =
done in the case of a NegDReply;</FONT></SPAN><SPAN LANG=3D"en-us"> =
<FONT SIZE=3D2 FACE=3D"Tahoma">dec_ap_bio(mdev) and =
dec_ap_pending(mdev)</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Tahoma">&#8211;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma"> I note that both of these can signal events so perhaps =
the problem here is that other threads are blocked =
wai</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">ting for this event which never gets</FONT></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Tahoma">signaled</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Tahoma">???</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Tahoma">If this =
is the problem then the fix is trivial</FONT></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Tahoma">&#8211;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma"> add the two missing lines following the drbd_end_bio() =
call in got_NegDReply().</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">Simon</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

</BODY>
</HTML>
------_=_NextPart_001_01C6D126.854370BE--
