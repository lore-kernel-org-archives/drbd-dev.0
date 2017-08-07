Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8BC3B1057FF5
	for <drbd-dev@lists.linbit.com>; Mon,  7 Aug 2017 15:12:55 +0200 (CEST)
Received: by mail-wm0-f42.google.com with SMTP id t201so6880567wmt.1
	for <drbd-dev@lists.linbit.com>; Mon, 07 Aug 2017 06:12:55 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100])
	by smtp.gmail.com with ESMTPSA id x81sm7679222wmg.5.2017.08.07.06.07.51
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 07 Aug 2017 06:07:51 -0700 (PDT)
Resent-Message-ID: <20170807130750.GH25125@soda.linbit>
Received: from esa1.dell-outbound.iphmx.com (esa1.dell-outbound.iphmx.com
	[68.232.153.90])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3C7F71057FE8
	for <drbd-dev@lists.linbit.com>; Mon,  7 Aug 2017 10:24:21 +0200 (CEST)
From: "Venkateshaiah, Ranganatha" <Ranganatha.Venkatesh@Dell.com>
Received: from maildlpprd51.lss.emc.com (maildlpprd51.lss.emc.com
	[10.106.48.155])
	by mailuogwprd54.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0)
	with ESMTP id v775sD2U026125
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <drbd-dev@lists.linbit.com>; Mon, 7 Aug 2017 01:54:14 -0400
Received: from mailusrhubprd52.lss.emc.com (mailusrhubprd52.lss.emc.com
	[10.106.48.25]) by maildlpprd51.lss.emc.com (RSA Interceptor)
	for <drbd-dev@lists.linbit.com>; Mon, 7 Aug 2017 01:53:24 -0400
Received: from MXHUB205.corp.emc.com (MXHUB205.corp.emc.com [10.253.68.31])
	by mailusrhubprd52.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0)
	with ESMTP id v775s4nt007261
	(version=TLSv1.2 cipher=AES128-SHA256 bits=128 verify=FAIL)
	for <drbd-dev@lists.linbit.com>; Mon, 7 Aug 2017 01:54:04 -0400
To: "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Date: Mon, 7 Aug 2017 05:54:03 +0000
Message-ID: <51A32CC3BE64BC488E01AC3BDCB9F0A301CE8A57@MX205CL03.corp.emc.com>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_51A32CC3BE64BC488E01AC3BDCB9F0A301CE8A57MX205CL03corpem_"
MIME-Version: 1.0
Subject: [Drbd-dev] Need info  on below ERROR messages
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

--_000_51A32CC3BE64BC488E01AC3BDCB9F0A301CE8A57MX205CL03corpem_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

     I'm using SLES11 SP1 Enterprise server edition. Below kernel error mes=
sages are keep on logging in the log.  Could you please let me know the rea=
son and fix  for the below error message.
     Could you please help me out on this.


    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

    [494837.186385] Modules linked in: af_packet bonding iscsi_ibft iscsi_b=
oot_sysfs
ip6t_REJECT xt_tcpudp nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_raw ipt_REJ=
ECT iptable_raw xt_CT iptable_filter ip6table_mangle nf_conntrack_ipv4
nf_defrag_ipv4 ip_tables xt_conntrack nf_conntrack ip6table_filter ip6_tabl=
es x_tables ext4 crc16 mbcache jbd2 mgag200 i2c_algo_bit ttm drm_kms_helper
drm syscopyarea sysfillrect sysimgblt ipmi_devintf joydev iTCO_wdt bnx2 iTC=
O_vendor_support i7core_edac gpio_ich edac_core ioatdma dca serio_raw shpch=
p
lpc_ich mfd_core ipmi_si ipmi_msghandler button coretemp pcspkr kvm process=
or crc32c_intel dcdbas(X) btrfs xor raid6_pq sr_mod cdrom ata_generic hid_g=
eneric
usbhid sd_mod ata_piix ahci libahci uhci_hcd ehci_pci ehci_hcd usbcore liba=
ta megaraid_sas usb_common sg scsi_mod autofs4

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Regards,
Ranganath


--_000_51A32CC3BE64BC488E01AC3BDCB9F0A301CE8A57MX205CL03corpem_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; I&#8217;m using SLES11 SP1 =
Enterprise server edition. Below kernel error messages are keep on logging =
in the log. &nbsp;Could you please let me know the reason and fix &nbsp;for=
 the below error message.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; Could you please help me ou=
t on this. &nbsp;&nbsp;&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; [494837.186385] Modules linked in=
: af_packet bonding iscsi_ibft iscsi_boot_sysfs
<o:p></o:p></p>
<p class=3D"MsoNormal">ip6t_REJECT xt_tcpudp nf_conntrack_ipv6 nf_defrag_ip=
v6 ip6table_raw ipt_REJECT iptable_raw xt_CT iptable_filter ip6table_mangle=
 nf_conntrack_ipv4
<o:p></o:p></p>
<p class=3D"MsoNormal">nf_defrag_ipv4 ip_tables xt_conntrack nf_conntrack i=
p6table_filter ip6_tables x_tables ext4 crc16 mbcache jbd2 mgag200 i2c_algo=
_bit ttm drm_kms_helper
<o:p></o:p></p>
<p class=3D"MsoNormal">drm syscopyarea sysfillrect sysimgblt ipmi_devintf j=
oydev iTCO_wdt bnx2 iTCO_vendor_support i7core_edac gpio_ich edac_core ioat=
dma dca serio_raw shpchp
<o:p></o:p></p>
<p class=3D"MsoNormal">lpc_ich mfd_core ipmi_si ipmi_msghandler button core=
temp pcspkr kvm processor crc32c_intel dcdbas(X) btrfs xor raid6_pq sr_mod =
cdrom ata_generic hid_generic
<o:p></o:p></p>
<p class=3D"MsoNormal">usbhid sd_mod ata_piix ahci libahci uhci_hcd ehci_pc=
i ehci_hcd usbcore libata megaraid_sas usb_common sg scsi_mod autofs4<o:p><=
/o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Ranganath<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_51A32CC3BE64BC488E01AC3BDCB9F0A301CE8A57MX205CL03corpem_--
