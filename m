Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C79324.72285269"
Subject: RE: [Drbd-dev] DRBD8: panic accessing NULL lru cache
Date: Thu, 10 May 2007 12:57:28 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C4543D1599@EXNA.corp.stratus.com>
References: <BD7042533C2F8943A6A4257A9E31C454F478EC@EXNA.corp.stratus.com>
	20070510125938.GC16300@barkeeper1.linbit
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Lars Ellenberg" <lars.ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C79324.72285269
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Lars,
Thanks! I will test and let you know if any issues.
=20
EM--

________________________________

From: drbd-dev-bounces@linbit.com on behalf of Lars Ellenberg
Sent: Thu 5/10/2007 8:59 AM
To: drbd-dev@linbit.com
Subject: Re: [Drbd-dev] DRBD8: panic accessing NULL lru cache



On Wed, May 09, 2007 at 05:40:10PM -0400, Montrose, Ernest wrote:
> But the lc entry was freed by the time  we called =
drbd_al_to_on_disk_bm().  If
> this is correct, I am still not sure
> how to best fix this.

thanks for triggering this :)
my proposed fix is comitted as svn r2884.
(untested)

--
: Lars Ellenberg                            Tel +43-1-8178292-0  :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
__
please use the "List-Reply" function of your email client.
_______________________________________________
drbd-dev mailing list
drbd-dev@lists.linbit.com
http://lists.linbit.com/mailman/listinfo/drbd-dev



------_=_NextPart_001_01C79324.72285269
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">=0A=
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">=0A=
<HTML>=0A=
<HEAD>=0A=
=0A=
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7234.20">=0A=
<TITLE>Re: [Drbd-dev] DRBD8: panic accessing NULL lru cache</TITLE>=0A=
</HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText38882 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 =
size=3D2>Lars,</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Thanks! I will test and let =
you know if any =0A=
issues.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>EM--</FONT></DIV></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT face=3DTahoma size=3D2><B>From:</B> drbd-dev-bounces@linbit.com on =
behalf of =0A=
Lars Ellenberg<BR><B>Sent:</B> Thu 5/10/2007 8:59 AM<BR><B>To:</B> =0A=
drbd-dev@linbit.com<BR><B>Subject:</B> Re: [Drbd-dev] DRBD8: panic =
accessing =0A=
NULL lru cache<BR></FONT><BR></DIV>=0A=
<DIV>=0A=
<P><FONT size=3D2>On Wed, May 09, 2007 at 05:40:10PM -0400, Montrose, =
Ernest =0A=
wrote:<BR>&gt; But the lc entry was freed by the time&nbsp; we called =0A=
drbd_al_to_on_disk_bm().&nbsp; If<BR>&gt; this is correct, I am still =
not =0A=
sure<BR>&gt; how to best fix this.<BR><BR>thanks for triggering this =
:)<BR>my =0A=
proposed fix is comitted as svn r2884.<BR>(untested)<BR><BR>--<BR>: Lars =0A=
Ellenberg&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
Tel +43-1-8178292-0&nbsp; :<BR>: LINBIT Information Technologies =0A=
GmbH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Fax +43-1-8178292-82 :<BR>: =
Vivenotgasse 48, =0A=
A-1120 Vienna/Europe&nbsp;&nbsp;&nbsp; <A =0A=
href=3D"http://www.linbit.com">http://www.linbit.com</A> =
:<BR>__<BR>please use the =0A=
"List-Reply" function of your email =0A=
client.<BR>_______________________________________________<BR>drbd-dev =
mailing =0A=
list<BR>drbd-dev@lists.linbit.com<BR><A =0A=
href=3D"http://lists.linbit.com/mailman/listinfo/drbd-dev">http://lists.l=
inbit.com/mailman/listinfo/drbd-dev</A><BR></FONT></P></DIV>=0A=
=0A=
</BODY>=0A=
</HTML>
------_=_NextPart_001_01C79324.72285269--
