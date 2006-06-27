Return-Path: <Simon.Graham@stratus.com>
Received: from EXNAR.corp.stratus.com (exnar.corp.stratus.com
	[134.111.200.165])
	by mailhub5.stratus.com (8.12.11/8.12.11) with ESMTP id k5RKE4n3022261
	for <drbd-dev@lists.linbit.com>; Tue, 27 Jun 2006 16:14:05 -0400
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C69A26.409D8256"
Content-class: urn:content-classes:message
Date: Tue, 27 Jun 2006 16:13:56 -0400
Message-ID: <342BAC0A5467384983B586A6B0B376710309E7F1@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@linbit.com>
Subject: [Drbd-dev] Problems at boot time with drbd-8
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C69A26.409D8256
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I've been working on getting the pre-release version of DRBD8 up on my
system and have run into a couple of minor problems... first of all, I
found that drbdadm dies with a segfault when running 'drbdadm adjust
all' at boot time - turns out this is because the underlying 'drbdsetup
/dev/drbd0 show' command returns "# not configured" at that time - the
parsing of this into a resource structure by drbdadm leaves the
running->me field NULL and we then trip over an attempt to strcmp the
name of the device with the configured name - after some checking, I
found that this problem is actually fixed in the trunk so I moved
forward to there, BUT there are still a couple of issues with startup,
namely:

1.	The routine convert_after_option (in drbdadm_main.c) ends up
being called twice when the 'drbdadm adjust all' command is issued -
once when comparing with the current running config and then again if a
sync operation is actually kicked off - unforturnately, this routine
actually crashes if the name stored in the after option is not a valid
resource name (which of course it isn't after it's been converted the
first time). I fixed this simply by not doing the conversion if the name
does not represent a valid resource - if it truly is a bad resource name
then the later attempt to use it will fail.
2.	The new code added to check IP addresses (verify_ips in
drbdadm_main.c) is not properly initializing the sin_addr local variable
which should have the IP address of the local system - thus this routine
always fails and you get the 'OOPS: the IP address x.y.z.a isn't
configure/up on your system!' error message.
3.	The definition & use of INVALID_IP_IS_INVALID_CONF are
inconsistent; the definition defines it as zero and implies this means
the option is disabled whereas the .c file uses #ifdef to check if it is
enabled. I think this should be #if instead.=20

Attached is a patch that fixes these.
Simon


Index: user/drbdadm_main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- user/drbdadm_main.c	(revision 2739)
+++ user/drbdadm_main.c	(working copy)
@@ -794,6 +794,12 @@
 struct d_resource* res_by_name(const char *name);
=20
 // Need to convert after from resourcename to minor_number.
+// NOTE: this _may_ already have been done (for example, adjust
+//       processing will call this, then may start a syncer op
+//       which will call it again for the same resource). This is
+//       detected by attempting to locate the resource structure
+//       for the resource -- if this fails, we assume the tx has
+//       already been done.
 void convert_after_option(struct d_resource* res)
 {
   struct d_option* opt;
@@ -802,9 +808,13 @@
=20
   if ( (opt =3D find_opt(res->sync_options, "after")) ) {
     char *ptr;
-
ssprintf(ptr,"%d",dt_minor_of_dev(res_by_name(opt->value)->me->device));
-    free(opt->value);
-    opt->value=3Dstrdup(ptr);
+    struct d_resource *ares =3D res_by_name(opt->value);
+
+    if (ares) {
+        ssprintf(ptr,"%d",dt_minor_of_dev(ares->me->device));
+        free(opt->value);
+        opt->value=3Dstrdup(ptr);
+    }
   }
 }
=20
@@ -1293,6 +1303,7 @@
   const char *my_ip;
=20
   my_ip =3D res->me->address;
+  sin_addr.s_addr =3D inet_addr(my_ip);
=20
   /* does DRBD support inet6? */
   family =3D AF_INET;
@@ -1316,7 +1327,7 @@
=20
   if (valid =3D=3D 0) {
     fprintf(stderr, "OOPS, the IP address %s isn't configure/up on your
system!\n", my_ip);
-#ifdef INVALID_IP_IS_INVALID_CONF
+#if INVALID_IP_IS_INVALID_CONF
     config_valid =3D 0;
 #endif
   }



------_=_NextPart_001_01C69A26.409D8256
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
<TITLE>Problems at boot time with drbd-8</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">I&#8217;ve been working on getting the pre-release =
version of DRBD8 up on my system and have run into a couple =
of</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Tahoma">minor</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Tahoma">problems&#8230; first of all, I found that drbdadm dies =
with a segfault when running &#8216;drbdadm adjust all&#8217; at boot =
time &#8211; turns out this is because the underlying &#8216;drbdsetup =
/dev/drbd0 show&#8217; command returns &#8220;# not configured&#8221; at =
that time &#8211; the parsing of this into a resource =
structure</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma"> by drbdadm</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Tahoma"> leaves the running-&gt;me field NULL and we =
then trip over an attempt to strcmp the name of the device with the =
configured name &#8211; after some checking, I found that this problem =
is actually fixed in the trunk so I moved forward to there, BUT there =
are still a couple of issues with startup, namely:</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Tahoma">The routine convert_after_option</FONT></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Tahoma">(in =
drbdadm_main.c)</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Tahoma">ends up being called twice when the &#8216;drbdadm =
adjust all&#8217; command is issued &#8211; once when comparing with the =
current running config and then again if a sync operation is actually =
kicked off &#8211; unforturnately, this routine actually crashes if the =
name stored in the after option is not a valid resource name (which of =
course it isn&#8217;t after it&#8217;s been converted the first time). I =
fixed this simply by not doing the conversion if the name does not =
represent a valid resource &#8211; if it truly is a bad resource name =
then the later attempt to use it will fail.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Tahoma">The new code added to =
check IP addresses (</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">verify_ips in drbdadm_main.c) is not =
properly</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Tahoma">initializing</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Tahoma"> the sin_addr local variable which should have =
the IP address of the local system</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Tahoma"></FONT></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Tahoma">&#8211;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma"> thus this routine always fails and you get =
the</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Tahoma">&#8216;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">OOPS: the IP address x.y.z.a isn</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Tahoma">&#8217;</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Tahoma">t configure/up on your =
system!</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">&#8217;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma"> error message.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">3.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Tahoma">The definition &amp; use =
of INVALID_IP_IS_INVALID_CONF</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Tahoma"> are inconsistent; the definition defines it as =
zero and implies this means the option is disabled whereas the .c file =
uses #ifdef to check if it is enabled. I think this should be #if =
instead.</FONT></SPAN><SPAN LANG=3D"en-us"> </SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">Attached is a patch that fixes these.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Tahoma">Simon</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>
<BR>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">Index: user/drbdadm_main.c</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</FONT></SPAN></=
P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier New">--- =
user/drbdadm_main.c (revision 2739)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier New">+++ =
user/drbdadm_main.c (working copy)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier New">@@ -794,6 =
+794,12 @@</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">&nbsp;struct d_resource* res_by_name(const char =
*name);</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">&nbsp;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier New">&nbsp;// =
Need to convert after from resourcename to =
minor_number.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier New">+// NOTE: =
this _may_ already have been done (for example, adjust</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">+//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; processing will call this, =
then may start a syncer op</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">+//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; which will call it again =
for the same resource). This is</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">+//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; detected by attempting to =
locate the resource structure</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">+//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for the resource -- if this =
fails, we assume the tx has</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">+//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; already been =
done.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier New">&nbsp;void =
convert_after_option(struct d_resource* res)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">&nbsp;{</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">&nbsp;&nbsp; struct d_option* opt;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier New">@@ -802,9 =
+808,13 @@</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">&nbsp;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">&nbsp;&nbsp; if ( (opt =3D find_opt(res-&gt;sync_options, =
&quot;after&quot;)) ) {</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp; char *ptr;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">-&nbsp;&nbsp;&nbsp; =
ssprintf(ptr,&quot;%d&quot;,dt_minor_of_dev(res_by_name(opt-&gt;value)-&g=
t;me-&gt;device));</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">-&nbsp;&nbsp;&nbsp; free(opt-&gt;value);</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">-&nbsp;&nbsp;&nbsp; opt-&gt;value=3Dstrdup(ptr);</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">+&nbsp;&nbsp;&nbsp; struct d_resource *ares =3D =
res_by_name(opt-&gt;value);</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">+</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">+&nbsp;&nbsp;&nbsp; if (ares) {</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ssprintf(ptr,&quot;%d&quot;,dt_minor_of_dev(ares-&gt;me-&gt;device));</FO=
NT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
free(opt-&gt;value);</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
opt-&gt;value=3Dstrdup(ptr);</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">+&nbsp;&nbsp;&nbsp; }</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">&nbsp;&nbsp; }</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">&nbsp;}</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">&nbsp;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier New">@@ -1293,6 =
+1303,7 @@</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">&nbsp;&nbsp; const char *my_ip;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">&nbsp;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">&nbsp;&nbsp; my_ip =3D res-&gt;me-&gt;address;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier New">+&nbsp; =
sin_addr.s_addr =3D inet_addr(my_ip);</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">&nbsp;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">&nbsp;&nbsp; /* does DRBD support inet6? */</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">&nbsp;&nbsp; family =3D AF_INET;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier New">@@ -1316,7 =
+1327,7 @@</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">&nbsp;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">&nbsp;&nbsp; if (valid =3D=3D 0) {</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;OOPS, the IP address =
%s isn't configure/up on your system!\n&quot;, my_ip);</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier New">-#ifdef =
INVALID_IP_IS_INVALID_CONF</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier New">+#if =
INVALID_IP_IS_INVALID_CONF</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp; config_valid =3D 0;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">&nbsp;#endif</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Courier =
New">&nbsp;&nbsp; }</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

</BODY>
</HTML>
------_=_NextPart_001_01C69A26.409D8256--
