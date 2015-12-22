Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 81D0A10556A0
	for <drbd-dev@lists.linbit.com>; Tue, 22 Dec 2015 15:14:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 6F687484992
	for <drbd-dev@lists.linbit.com>; Tue, 22 Dec 2015 15:14:16 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id l2KeVPCHgwS7 for <drbd-dev@lists.linbit.com>;
	Tue, 22 Dec 2015 15:14:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 4D7FD484994
	for <drbd-dev@lists.linbit.com>; Tue, 22 Dec 2015 15:14:16 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gde9lhNqv6El for <drbd-dev@lists.linbit.com>;
	Tue, 22 Dec 2015 15:14:16 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 1500E484992
	for <drbd-dev@lists.linbit.com>; Tue, 22 Dec 2015 15:14:16 +0100 (CET)
Resent-Message-ID: <20151222141415.GD28982@soda.linbit>
Received: from mail-lf0-f42.google.com (mail-lf0-f42.google.com
	[209.85.215.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9502610562DA
	for <drbd-dev@lists.linbit.com>; Tue, 22 Dec 2015 02:14:23 +0100 (CET)
Received: by mail-lf0-f42.google.com with SMTP id p203so121673078lfa.0
	for <drbd-dev@lists.linbit.com>; Mon, 21 Dec 2015 17:14:22 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 22 Dec 2015 10:06:14 +0900
Message-ID: <CAHRYDjgyCcQEA0usvC+oxgtUE=n__4UbxeZUe3694s6P_BdYQQ@mail.gmail.com>
From: =?UTF-8?B?6rmA7ISx7J2A?= <sekim@mantech.co.kr>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/related; boundary=001a114123e65279f80527723627
Cc: =?UTF-8?B?67CV7ISx7ZmY?= <shpark@mantech.co.kr>,
	=?UTF-8?B?6rmA7J6s7ZeM?= <jhkim@mantech.co.kr>,
	=?UTF-8?B?7KeE7ZiE7J20?= <jhlee@mantech.co.kr>,
	Windows DRBD <wdrbd@mantech.co.kr>,
	Philipp Reisner <philipp.reisner@linbit.com>
Subject: [Drbd-dev] [CASE 12] 2 primary split-brain is not detected
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

--001a114123e65279f80527723627
Content-Type: multipart/alternative; boundary=001a114123e65279f30527723626

--001a114123e65279f30527723626
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

I am Software Manager in Mantech, and testing drbd 9.

some problems are occurred. CASE 12 is one of them.

[CASE 12] 2 primary split-brain is not detected.

Env:
- Linux VM 2 nodes
- Linux drbd version 9.0.0

Test scenario:

- 2 node's status is uptodate

node 1node 2drbdadm disconnect r0 drbdadm primary r0 copy files on
node1   drbdadm
primary r0 copy files on node2
drbdadm connect r0

- at this point, we predicted that 2 primary split-brain is occurred and
drbd9 detect it.

But split-brain is not occurred, not detected. no debug log.
Just retry connection log is showing between two nodes.

Question is :

1) How can I test 2 primary split-brain situation ?

2) Does support 2 primary split-brain in drbd9 ?


PS)

http://drbd.linbit.com/users-guide-9.0/s-configure-split-brain-behavior.htm=
l#s-split-brain-notification

drbd9's manual describe 'after-sb-2pri' option.

Thanks,


Best Regards
Sungeun Kim




[image: =EC=84=A4=EB=AA=85: logo]

=EA=B8=B0=EC=88=A0=EC=97=B0=EA=B5=AC=EC=86=8C / DRBD=ED=8C=80        Mobile=
 : 010-2813-4843

*=EA=B9=80 =EC=84=B1 =EC=9D=80 **=EC=B0=A8=EC=9E=A5               sekim@man=
tech.co.kr <sekim@mantech.co.kr>*

=EC=84=9C=EC=9A=B8=ED=8A=B9=EB=B3=84=EC=8B=9C =EC=84=B1=EB=8F=99=EA=B5=AC =
=EC=84=B1=EC=88=98=EC=9D=BC=EB=A1=9C4=EA=B8=B8 25 =EC=84=9C=EC=9A=B8=EC=88=
=B2=EC=BD=94=EC=98=A4=EB=A1=B1=EB=94=94=EC=A7=80=ED=84=B8=ED=83=80=EC=9B=8C=
 12=EC=B8=B5

Tel : 02-2136-6913 / Fax : 02-575-4858 / =EC=BD=9C=EC=84=BC=ED=84=B0 : 1833=
-7790

http://www.mantech.co.kr

[image: =EB=B3=B8=EB=AC=B8 =EC=9D=B4=EB=AF=B8=EC=A7=80 1]

--001a114123e65279f30527723626
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>I am Software Manager in Mantech=
, and testing drbd 9.</div><div><br></div><div>some problems are occurred. =
CASE 12 is one of them.</div><div><br></div><div>[CASE 12] 2 primary split-=
brain is not detected.</div><div><br></div><div>Env:</div><div>- Linux VM 2=
 nodes=C2=A0</div><div>- Linux drbd version 9.0.0</div><div><br></div><div>=
Test scenario:</div><div><br></div><div>- 2 node&#39;s status is uptodate=
=C2=A0</div><div><br></div><div><table class=3D"" style=3D"border-collapse:=
collapse;margin:5px 0px 5px 2px;width:auto;color:rgb(51,51,51);font-family:=
Arial,sans-serif;font-size:14px;line-height:20px"><tbody><tr><th class=3D""=
 style=3D"border:1px solid rgb(204,204,204);padding:3px 4px;text-align:cent=
er;background:rgb(245,245,245)">node 1</th><th class=3D"" style=3D"border:1=
px solid rgb(204,204,204);padding:3px 4px;text-align:center;background:rgb(=
245,245,245)">node 2</th></tr><tr><td class=3D"" style=3D"border:1px solid =
rgb(204,204,204);padding:3px 4px">drbdadm disconnect r0</td><td class=3D"" =
style=3D"border:1px solid rgb(204,204,204);padding:3px 4px">=C2=A0</td></tr=
><tr><td class=3D"" style=3D"border:1px solid rgb(204,204,204);padding:3px =
4px">drbdadm primary r0</td><td class=3D"" style=3D"border:1px solid rgb(20=
4,204,204);padding:3px 4px">=C2=A0</td></tr><tr><td class=3D"" style=3D"bor=
der:1px solid rgb(204,204,204);padding:3px 4px">copy files on node1=C2=A0</=
td><td class=3D"" style=3D"border:1px solid rgb(204,204,204);padding:3px 4p=
x">=C2=A0</td></tr><tr><td class=3D"" style=3D"border:1px solid rgb(204,204=
,204);padding:3px 4px">=C2=A0</td><td class=3D"" style=3D"border:1px solid =
rgb(204,204,204);padding:3px 4px">drbdadm primary r0</td></tr><tr><td class=
=3D"" style=3D"border:1px solid rgb(204,204,204);padding:3px 4px">=C2=A0</t=
d><td class=3D"" style=3D"border:1px solid rgb(204,204,204);padding:3px 4px=
">copy files on node2=C2=A0<br></td></tr><tr><td class=3D"" style=3D"border=
:1px solid rgb(204,204,204);padding:3px 4px">drbdadm connect r0</td><td cla=
ss=3D"" style=3D"border:1px solid rgb(204,204,204);padding:3px 4px">=C2=A0<=
/td></tr></tbody></table></div><div><br></div><div>- at this point, we pred=
icted that 2 primary split-brain is occurred and drbd9 detect it.</div><div=
><br></div><div>But split-brain is not occurred, not detected. no debug log=
.=C2=A0<br></div><div>Just retry connection log is showing between two node=
s.<br></div><div><br></div><div>Question is :<br></div><div><br></div><div>=
1) How can I test 2 primary split-brain situation ?</div><div><br></div><di=
v>2) Does support 2 primary split-brain in drbd9 ?</div><div><br></div><div=
><br></div><div><div>PS)</div><div><br></div><div><a href=3D"http://drbd.li=
nbit.com/users-guide-9.0/s-configure-split-brain-behavior.html#s-split-brai=
n-notification">http://drbd.linbit.com/users-guide-9.0/s-configure-split-br=
ain-behavior.html#s-split-brain-notification</a><br></div><div><br></div><d=
iv>drbd9&#39;s manual describe &#39;after-sb-2pri&#39; option.=C2=A0</div><=
/div><div><br></div><div>Thanks,</div><div><br></div><div><br></div><div>Be=
st Regards</div><div>Sungeun Kim=C2=A0</div><div><br></div><div>=C2=A0</div=
><div>=C2=A0<br></div><div><div><div class=3D"gmail_signature"><div dir=3D"=
ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"ltr"><div dir=
=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr=
"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div =
dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><p style=3D"=
margin:0cm 0cm 0pt"><img src=3D"cid:image001.png@01D0F522.B2A586F0" alt=3D"=
=EC=84=A4=EB=AA=85: logo"></p><p style=3D"margin:0cm 0cm 0.0001pt;backgroun=
d-image:initial;background-repeat:initial"><font face=3D"verdana, sans-seri=
f"><span style=3D"font-size:10pt;color:black">=EA=B8=B0=EC=88=A0=EC=97=B0=
=EA=B5=AC=EC=86=8C<span lang=3D"EN-US">=C2=A0</span><span lang=3D"EN-US">/=
=C2=A0</span>DRBD=ED=8C=80<span lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Mobile=C2=A0: 010-2813-4843</span></span><span lang=3D"EN-U=
S" style=3D"font-size:10.5pt;color:rgb(136,136,136)"></span></font></p><p s=
tyle=3D"margin:0cm 0cm 0pt"></p><p style=3D"margin:0cm 0cm 0.0001pt;backgro=
und-image:initial;background-repeat:initial"><font face=3D"verdana, sans-se=
rif"><b><span style=3D"font-size:10.5pt;color:black">=EA=B9=80 =EC=84=B1 =
=EC=9D=80<span lang=3D"EN-US">=C2=A0</span></span></b><b><span style=3D"fon=
t-size:10pt;color:black">=EC=B0=A8=EC=9E=A5<span lang=3D"EN-US">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0<a href=3D"mailto:sekim@m=
antech.co.kr" target=3D"_blank">sekim@mantech.co.kr</a></span></span></b><s=
pan lang=3D"EN-US" style=3D"font-size:10.5pt;color:rgb(136,136,136)"></span=
></font></p><p style=3D"margin:0cm 0cm 0.0001pt;line-height:21px"><font col=
or=3D"#000000" face=3D"verdana, sans-serif"><span style=3D"font-size:8pt;li=
ne-height:16px">=EC=84=9C=EC=9A=B8=ED=8A=B9=EB=B3=84=EC=8B=9C =EC=84=B1=EB=
=8F=99=EA=B5=AC =EC=84=B1=EC=88=98=EC=9D=BC=EB=A1=9C<span lang=3D"EN-US">4<=
/span>=EA=B8=B8<span lang=3D"EN-US">=C2=A025=C2=A0</span>=EC=84=9C=EC=9A=B8=
=EC=88=B2=EC=BD=94=EC=98=A4=EB=A1=B1=EB=94=94=EC=A7=80=ED=84=B8=ED=83=80=EC=
=9B=8C<span lang=3D"EN-US">=C2=A012</span>=EC=B8=B5<span lang=3D"EN-US">=C2=
=A0</span></span><span lang=3D"EN-US" style=3D"font-size:8pt;line-height:16=
px">=C2=A0 =C2=A0 =C2=A0=C2=A0</span></font></p><p style=3D"margin:0cm 0cm =
0.0001pt;line-height:21px"><font color=3D"#000000" face=3D"verdana, sans-se=
rif"><span lang=3D"EN-US" style=3D"font-size:8pt;line-height:16px">Tel : 02=
-2136-6913 / Fax : 02-575-4858 / =EC=BD=9C=EC=84=BC=ED=84=B0 : 1833-7790</s=
pan></font></p><p style=3D"margin:0cm 0cm 0.0001pt;line-height:21px"><span =
lang=3D"EN-US" style=3D"color:rgb(0,0,0);font-family:verdana,sans-serif;fon=
t-size:8pt;line-height:16px"><a href=3D"http://www.mantech.co.kr/" style=3D=
"color:rgb(17,85,204)" target=3D"_blank">http://www.mantech.co.kr</a></span=
><span lang=3D"EN-US" style=3D"color:rgb(0,0,0);font-family:verdana,sans-se=
rif;font-size:8pt;line-height:16px">=C2=A0</span><font color=3D"#000000" fa=
ce=3D"verdana, sans-serif"><span lang=3D"EN-US" style=3D"font-size:8pt;line=
-height:16px"><br></span></font></p><p style=3D"margin:0cm 0cm 0.0001pt;lin=
e-height:21px"><img src=3D"cid:ii_150a68c3811acf54" alt=3D"=EB=B3=B8=EB=AC=
=B8 =EC=9D=B4=EB=AF=B8=EC=A7=80 1" width=3D"400" height=3D"160" style=3D"li=
ne-height: normal;"><br></p></div></div></div></div></div></div></div></div=
></div></div></div></div></div></div></div></div></div></div></div></div></=
div>
</div></div>

--001a114123e65279f30527723626--

--001a114123e65279f80527723627
Content-Type: message/external-body; access-type=x-mutt-deleted;
	expiration="Tue, 22 Dec 2015 15:13:48 +0100"; length=21924

Content-Type: image/png; name="image.png"
Content-Disposition: inline; filename="image.png"
Content-Transfer-Encoding: base64
Content-ID: <ii_150a68c3811acf54>
X-Attachment-Id: ii_150a68c3811acf54


--001a114123e65279f80527723627
Content-Type: message/external-body; access-type=x-mutt-deleted;
	expiration="Tue, 22 Dec 2015 15:13:48 +0100"; length=6139

Content-Type: image/png; name="image001.png"
Content-Disposition: inline; filename="image001.png"
Content-Transfer-Encoding: base64
Content-ID: <image001.png@01D0F522.B2A586F0>
X-Attachment-Id: 1b04d787799a09e8_0.0.1


--001a114123e65279f80527723627--
