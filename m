Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6BA23.165A6D91"
Date: Mon, 7 Aug 2006 09:12:06 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671034711CD@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD 8 rejects some state changes that it shouldn't
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6BA23.165A6D91
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

In general, the state change code does the right thing in refusing
invalid state changes, however there are some cases where it rejects a
change that cannot really be rejected - for example, if the peer tells
you that it has gone diskless, it's really not possible to refuse the
state change - here's an example:

drbd15: State change failed: Refusing to be inconsistent on both
nodesdrbd15:   state =3D { cs:SyncTarget st:Secondary/Primary
ds:Inconsistent/UpToDate r--- }drbd15:  wanted =3D { cs:SyncTarget
st:Secondary/Primary ds:Inconsistent/Diskless r--- }
I'm not sure how important this is but it definitely results in the
local state being incorrect. I'm not totally sure but I suspect you
should always let the peer state change by setting the ChgStateHard flag
in the call to drbd_change_state in receive_req_state?

Simon

------_=_NextPart_001_01C6BA23.165A6D91
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
<TITLE>DRBD 8 rejects some state changes that it shouldn't</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Tahoma">In =
g</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">eneral, the state change code does the right thing in =
refusing invalid state changes, however there are some cases where it =
rejects a change that cannot really be rejected</FONT></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Tahoma">&#8211;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma"> for example, if the peer tells you that it has gone =
diskless, it</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">&#8217;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">s really not possible to refuse the state =
change</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Tahoma">&#8211;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma"> here</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">&#8217;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">s an example:</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Tahoma">drbd15: =
State change failed: Refusing to be inconsistent on both =
nodesdrbd15:&nbsp;&nbsp; state =3D { cs:SyncTarget st:Secondary/Primary =
ds:Inconsistent/UpToDate r--- }drbd15:&nbsp; wanted =3D { cs:SyncTarget =
st:Secondary/Primary ds:Inconsistent/Diskless r--- }</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">I</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">&#8217;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">m not sure how important this is but it definitely =
results in the local state being incorrect. I</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Tahoma">&#8217;</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Tahoma">m not totally sure but I =
suspect you should always let the peer state change</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Tahoma"> by setting the =
ChgStateHard flag in the call to drbd_change_state in =
receive_req_state?</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">Simon</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

</BODY>
</HTML>
------_=_NextPart_001_01C6BA23.165A6D91--
