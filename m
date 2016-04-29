Return-Path: <Ludovic.Beliveau@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 834F61056453
	for <drbd-dev@lists.linbit.com>; Fri, 29 Apr 2016 17:15:11 +0200 (CEST)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u3TEmlTQ023301
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <drbd-dev@lists.linbit.com>; Fri, 29 Apr 2016 07:48:48 -0700 (PDT)
From: "Beliveau, Ludovic" <Ludovic.Beliveau@windriver.com>
To: "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Date: Fri, 29 Apr 2016 14:48:47 +0000
Message-ID: <0ABA934FAB0ECA4C8903465033D3FFC73C176E5B@ALA-MBA.corp.ad.wrs.com>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_0ABA934FAB0ECA4C8903465033D3FFC73C176E5BALAMBAcorpadwrs_"
MIME-Version: 1.0
Subject: [Drbd-dev] OCF script in drbd-utils-8.9.6
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--_000_0ABA934FAB0ECA4C8903465033D3FFC73C176E5BALAMBAcorpadwrs_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

The OCF script in drbd-utils-8.9.6 seems to be outdated since it's referrin=
g to commands that are no longer supported (in our case "sh-status").

In more details: scripts/drbd.ocf uses '$DRBDSETUP sh-status "$DRBD_RESOURC=
E"' (or '$DRBDSETUP "$DRBD_DEVICES" sh-status' - depending on the config).

But we are getting "invalid command" when trying to execute those commands =
manually.  According to the help text, those commands are indeed not existe=
nt.

Has anybody also ran into this situation ?  I'm not sure what is the proper=
 fix.

Regards,
/ludovic

--_000_0ABA934FAB0ECA4C8903465033D3FFC73C176E5BALAMBAcorpadwrs_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The OCF script in drbd-utils-8.9.6 seems to be outda=
ted since it&#8217;s referring to commands that are no longer supported (in=
 our case &#8220;sh-status&#8221;).<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">In more details: scripts/drbd.ocf uses &#8216;$DRBDS=
ETUP sh-status &quot;$DRBD_RESOURCE&quot;&#8217; (or &#8216;$DRBDSETUP &quo=
t;$DRBD_DEVICES&quot; sh-status&#8217; &#8211; depending on the config).<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">But we are getting &#8220;invalid command&#8221; whe=
n trying to execute those commands manually.&nbsp; According to the help te=
xt, those commands are indeed not existent.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Has anybody also ran into this situation ?&nbsp; I&#=
8217;m not sure what is the proper fix.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">/ludovic<o:p></o:p></p>
</div>
</body>
</html>

--_000_0ABA934FAB0ECA4C8903465033D3FFC73C176E5BALAMBAcorpadwrs_--
