Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6AA72.621EC079"
Date: Tue, 18 Jul 2006 09:59:21 -0400
Message-ID: <342BAC0A5467384983B586A6B0B376710333A9A3@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Large data requests
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6AA72.621EC079
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This seems too easy to be a bug, but I've been getting occasional errors
with DRBD-8 (latest trunk as of yesterday) like this:

Jul 17 16:25:03 jake kernel: drbd2: receive_DataReply: (data_size >
PAGE_SIZE) in /sandbox/sgraham/sn/trunk/drbd-8/drbd/drbd_receiver.c:1035

The line in question being:

	ERR_IF(data_size >  PAGE_SIZE) return FALSE;

in receive_DataReply. Now, one of the changes in DRBD-8 was to allow
requests up to 32K to be passed down and it looks to me like these are
just passed on to the remote side (if the local side does not have good
data) so it would be perfectly OK to receive a DataReply > 4KB in size -
is this just a left over assert that needs to be removed? Or did I miss
something?

/simgr

------_=_NextPart_001_01C6AA72.621EC079
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
<TITLE>Large data requests</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Tahoma">This =
seems t</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">o</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">o easy to be a bug, but I</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Tahoma">&#8217;</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Tahoma">ve been getting occasional =
errors with DRBD-8 (latest trunk as of yesterday) like =
this:</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Tahoma">Jul 17 =
16:25:03 jake kernel: drbd2: receive_DataReply: (data_size &gt; =
PAGE_SIZE) in =
/sandbox/sgraham/sn/trunk/drbd-8/drbd/drbd_receiver.c:1035</FONT></SPAN><=
SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Tahoma">The =
line in question being:</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Tahoma">ERR_IF(data_size &gt;&nbsp; PAGE_SIZE) return =
FALSE;</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Tahoma">in =
receive_DataReply. Now, one of the changes in DRBD-8 was to allow =
requests up to 32K to be passed down and it looks to me like these are =
just passed on to the remote side (if the local</FONT></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Tahoma">side does not have good =
data) so it would be perfectly OK to receive a DataReply &gt; 4KB in =
size</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Tahoma">&#8211;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma"> is this just a left over assert that needs to be =
removed? Or did I miss something?</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">/simgr</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

</BODY>
</HTML>
------_=_NextPart_001_01C6AA72.621EC079--
