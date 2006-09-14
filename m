Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6D811.E5E349EC"
Date: Thu, 14 Sep 2006 11:24:36 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671038B06E2@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD-8: attach seems to be broken
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6D811.E5E349EC
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'm not running the absolute latest but some change in the past day
seems to have broken attach after detach - the state goes to Attaching
and never transitions to UpToDate. I haven't been able to figure out how
the side doing the attach is actually supposed to transition - it's
somewhere in receive_state() I think but it eludes me for the moment. I
can see that on the other side, receipt of ReportState when the peer
says it's disk state is Attaching causes it to send ReportState in reply
which the comments says causes the peer to promote from
Attaching->UpToDate but I cant see how that actually happens...

At the moment, I'm using revision 2423 which is just one back from the
tip and looking at the diffs for that, I don't see anything that would
fix this issue.

Any suggestions?
/simgr

------_=_NextPart_001_01C6D811.E5E349EC
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
<TITLE>DRBD-8: attach seems to be broken</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">I</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">&#8217;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">m not running the absolute latest but some change in the =
past day seems to have broken attach after detach</FONT></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Tahoma">&#8211;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma"> the state goes to Attaching and never transitions to =
UpToDate. I haven</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">&#8217;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">t been able to figure out how the side doing the =
attach</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Tahoma">is actually supposed to transition</FONT></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Tahoma">&#8211;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma"> it</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">&#8217;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">s somewhere in receive_state() I think but it eludes me =
for the moment.</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Tahoma">I can see that on the other side, receipt of ReportState =
when the peer says it</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">&#8217;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">s disk state is Attaching causes it to send ReportState =
in reply which the comments says causes the peer to promote from =
Attaching-&gt;U</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">pToDate but I cant see how that actually =
happens</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">&#8230;</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Tahoma">At the =
moment, I</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">&#8217;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">m using revision 2423 which is just one back from the =
tip and looking at the diffs for that, I</FONT></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Tahoma">don&#8217;t</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Tahoma"> see anything that would fix this =
issue.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Tahoma">Any =
suggestions?</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">/simgr</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

</BODY>
</HTML>
------_=_NextPart_001_01C6D811.E5E349EC--
