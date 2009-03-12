Return-Path: <DOLIVER1@qinetiq.com>
Received: from burn.qinetiq.com (burn.qinetiq.com [192.102.214.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E5AD3100EBE6
	for <drbd-dev@lists.linbit.com>; Thu, 12 Mar 2009 14:14:35 +0100 (CET)
Received: from unknown (HELO Frome-1.uncdmz.qinetiq.com) ([10.0.5.57])
	(envelope-sender <DOLIVER1@qinetiq.com>)
	by burn.qinetiq.com (qmail-ldap-1.03) with SMTP
	for <drbd-dev@lists.linbit.com>; 12 Mar 2009 13:07:55 -0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C9A313.8E466C7E"
Date: Thu, 12 Mar 2009 13:07:53 -0000
From: "Oliver Daniel" <DOLIVER1@qinetiq.com>
To: <drbd-dev@lists.linbit.com>
Message-Id: <20090312131445.E5AD3100EBE6@mail09.linbit.com>
Cc: Watts Mark <MWATTS@qinetiq.com>
Subject: [Drbd-dev] chkconfig kill priority in init script
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.


------_=_NextPart_001_01C9A313.8E466C7E
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C9A313.8E466C7E"


------_=_NextPart_002_01C9A313.8E466C7E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi there,
=20
I've just noticed a problem with the drbd init script in git and the RPM
in the CentOS extras tree (I know this is quite old).
=20
The kill priority of the chkconfig parameters (345 70 8) is not
recognised by the chkconfig that ships with RHEL 5.  This results in
drbd script being created as K00drdb in rc0.d and rc6.d, causing it to
be run before heartbeat, whose default is K05. =20
=20
If the chkconfig parameters are changed to "345 70 08", everything works
as expected.  I haven't checked the very latest source for chkconfig,
but I think it is very unlikely to cause a problem.
=20
Thanks,
Dan.
=20

The information contained in this E-Mail and any subsequent=20
correspondence is private and is intended solely for the intended=20
recipient(s).  The information in this communication may be=20
confidential and/or legally privileged.  Nothing in this e-mail is=20
intended to conclude a contract on behalf of QinetiQ or make QinetiQ=20
subject to any other legally binding commitments, unless the e-mail=20
contains an express statement to the contrary or incorporates a formal Pu=
rchase Order.

For those other than the recipient any disclosure, copying,=20
distribution, or any action taken or omitted to be taken in reliance=20
on such information is prohibited and may be unlawful.

Emails and other electronic communication with QinetiQ may be=20
monitored and recorded for business purposes including security, audit=20
and archival purposes.  Any response to this email indicates consent=20
to this.

Telephone calls to QinetiQ may be monitored or recorded for quality=20
control, security and other business purposes.

QinetiQ Limited
Registered in England & Wales: Company Number:3796233
Registered office: 85 Buckingham Gate, London SW1E 6PD, United Kingdom
Trading address: Cody Technology Park, Cody Building, Ively Road, Farnbor=
ough, Hampshire, GU14 0LX, United Kingdom=20
http://www.qinetiq.com/home/notices/legal.html

------_=_NextPart_002_01C9A313.8E466C7E
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii"=
>
<META content=3D"MSHTML 6.00.2900.3462" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D120504812-12032009><FONT face=3DArial size=3D2>Hi=20
there,</FONT></SPAN></DIV>
<DIV><SPAN class=3D120504812-12032009><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D120504812-12032009><FONT face=3DArial size=3D2>I've ju=
st noticed a=20
problem with the drbd init script in git and the RPM&nbsp;in the&nbsp;Cen=
tOS=20
extras tree (I know this is quite old).</FONT></SPAN></DIV>
<DIV><SPAN class=3D120504812-12032009><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D120504812-12032009><FONT face=3DArial size=3D2>The kil=
l priority of=20
the chkconfig parameters (345 70 8) is not recognised by the chkconfig th=
at=20
ships with&nbsp;RHEL 5.&nbsp; This results in drbd script being created a=
s=20
K00drdb in rc0.d and rc6.d, causing it to be run before heartbeat, whose =
default=20
is K05.&nbsp; </FONT></SPAN></DIV>
<DIV><SPAN class=3D120504812-12032009><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D120504812-12032009><FONT face=3DArial size=3D2>If the =
chkconfig=20
parameters are changed to "345 70 08", everything works as expected.&nbsp=
; I=20
haven't checked the very latest source for chkconfig, but I think it is v=
ery=20
unlikely to cause a problem.</FONT></SPAN></DIV>
<DIV><SPAN class=3D120504812-12032009><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D120504812-12032009><FONT face=3DArial=20
size=3D2>Thanks,</FONT></SPAN></DIV>
<DIV><SPAN class=3D120504812-12032009><FONT face=3DArial=20
size=3D2>Dan.</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<P>The information contained in this E-Mail and any subsequent=20
<BR>correspondence is private and is intended solely for the intended=20
<BR>recipient(s).&nbsp; The information in this communication may be=20
<BR>confidential and/or legally privileged.&nbsp; Nothing in this e-mail =
is=20
<BR>intended to conclude a contract on behalf of QinetiQ or make QinetiQ =

<BR>subject to any other legally binding commitments, unless the e-mail=20
<BR>contains an express statement to the contrary or incorporates a forma=
l=20
Purchase Order.</P>
<P>For those other than the recipient any disclosure, copying, <BR>distri=
bution,=20
or any action taken or omitted to be taken in reliance <BR>on such inform=
ation=20
is prohibited and may be unlawful.</P>
<P>Emails and other electronic communication with QinetiQ may be <BR>moni=
tored=20
and recorded for business purposes including security, audit <BR>and arch=
ival=20
purposes.&nbsp; Any response to this email indicates consent <BR>to this.=
</P>
<P>Telephone calls to QinetiQ may be monitored or recorded for quality=20
<BR>control, security and other business purposes.</P>
<P>QinetiQ Limited<BR>Registered in England &amp; Wales: Company=20
Number:3796233<BR>Registered office: 85 Buckingham Gate, London SW1E 6PD,=
=20United=20
Kingdom<BR>Trading address: Cody Technology Park, Cody Building, Ively Ro=
ad,=20
Farnborough, Hampshire, GU14 0LX, United Kingdom <BR><A=20
href=3D"http://www.qinetiq.com/home/notices/legal.html">http://www.qineti=
q.com/home/notices/legal.html</A><A=20
href=3D"http://www.QinetiQ.com/home/legal.html"></A></P>
</BODY></HTML>

------_=_NextPart_002_01C9A313.8E466C7E--

------_=_NextPart_001_01C9A313.8E466C7E
Content-Type: application/octet-stream;
	name="drbd.patch"
Content-Transfer-Encoding: base64
Content-Description: drbd.patch
Content-Disposition: attachment;
	filename="drbd.patch"

LS0tIHNjcmlwdHMvZHJiZC5vbGQJMjAwOS0wMy0xMiAxMjo1OTozNC4wMDAwMDAwMDAgKzAwMDAN
CisrKyBzY3JpcHRzL2RyYmQJMjAwOS0wMy0xMiAxMjo1OTozOC4wMDAwMDAwMDAgKzAwMDANCkBA
IC0xLDYgKzEsNiBAQA0KICMhL2Jpbi9iYXNoDQogIw0KLSMgY2hrY29uZmlnOiAzNDUgNzAgOA0K
KyMgY2hrY29uZmlnOiAzNDUgNzAgMDgNCiAjIGRlc2NyaXB0aW9uOiBMb2FkcyBhbmQgdW5sb2Fk
cyB0aGUgZHJiZCBtb2R1bGUNCiAjDQogIyBDb3ByaWdodCAyMDAxLTIwMDggTElOQklUIEluZm9y
bWF0aW9uIFRlY2hub2xvZ2llcw0K

------_=_NextPart_001_01C9A313.8E466C7E--
