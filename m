Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C75062.772C8817"
Date: Wed, 14 Feb 2007 13:03:43 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C8F9@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: Panic in drbd_bm_write_sect() after an io error
	during resync.
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C75062.772C8817
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
We are overwelmed with panic's after io errors. Seem mdev->bc is null
due to some race condition.  Here is one instance:
=20
Two node cluster, node A and Node B. Syncsource is node A. While syncing
Reads are issued on Node B.  I/O errosrs start to occur
on node A,  Node A panics :
=20
Feb 11 03:15:49 drbd0: Sending NegRSDReply. sector 11620032s.
Feb 11 03:15:49 drbd0: Notified peer that my disk is broken.
Feb 11 03:15:58 end_request: I/O error, dev sda, sector 59856375
Feb 11 03:16:10 end_request: I/O error, dev sda, sector 59856383
Feb 11 03:16:10 drbd0: Local IO failed. Detaching...
Feb 11 03:16:10 Unable to handle kernel NULL pointer dereference at
virtual address 00000010
Feb 11 03:16:10  printing eip:
Feb 11 03:16:10 ee3d0b0b
Feb 11 03:16:10 299ba000 -> *pde =3D 00000000:7f512001
Feb 11 03:16:10 00512000 -> *pme =3D 00000000:00000000
Feb 11 03:16:10 Oops: 0000 [#1]
Feb 11 03:16:10 SMP=20
Feb 11 03:16:10 Modules linked in: drbd cn bridge ipv6 ipmi_devintf
ipmi_si ipmi_msghandler i2c_dev i2c_core binfmt_misc dm_mirror video
thermal processor fan container button battery ac shpchp pci_hotplug
e1000 piix ide_cd cdrom sg raid1 dm_mod ide_disk mptscsih mptsas mptspi
mptfc mptscsi mptbase sd_mod scsi_mod
Feb 11 03:16:10 CPU:    0
Feb 11 03:16:10 EIP:    0061:[<ee3d0b0b>]    Tainted: GF    VLI
Feb 11 03:16:10 EFLAGS: 00010292  (2.6.16.29-xen #1)=20
Feb 11 03:16:10 EIP is at drbd_bm_write_sect+0x1b/0x1f0 [drbd]
Feb 11 03:16:10 eax: 00000000  ebx: eb925000  ecx: 00000000  edx:
000001bd
Feb 11 03:16:10 esi: eb925000  edi: eb92502c  ebp: eae77f50  esp:
eae77f1c
Feb 11 03:16:10 ds: 007b  es: 007b  ss: 0069
Feb 11 03:16:10 Process drbd0_worker (pid: 5777, threadinfo=3Deae76000
task=3Dc060b570)
Feb 11 03:16:10 Stack: <0>c0136f00 eae77f20 eae77f20 ffffffff ffffffff
e7ea3550 00000000 000001bd=20
Feb 11 03:16:10        00000000 000001bd eb925000 eb667980 eb92502c
eae77f74 ee3e2080 eb385d40=20
Feb 11 03:16:10        eb92502c eae77f74 ee3e6606 00000005 eb667980
eb925000 eae77fc0 ee3d4cae=20
Feb 11 03:16:10 Call Trace:
Feb 11 03:16:10  [<c0105401>] show_stack_log_lvl+0xa1/0xe0
Feb 11 03:16:10  [<c01055f1>] show_registers+0x181/0x200
Feb 11 03:16:10  [<c0105810>] die+0x100/0x1a0
Feb 11 03:16:10  [<c01156f6>] do_page_fault+0x3c6/0x8b1
Feb 11 03:16:10  [<c0105067>] error_code+0x2b/0x30
Feb 11 03:16:10  [<ee3e2080>] w_update_odbm+0x100/0x220 [drbd]
Feb 11 03:16:10  [<ee3d4cae>] drbd_worker+0x2de/0x4b5 [drbd]
Feb 11 03:16:10  [<ee3e70fc>] drbd_thread_setup+0x8c/0x100 [drbd]
Feb 11 03:16:10  [<c0102e95>] kernel_thread_helper+0x5/0x10
Feb 11 03:16:10 Code: 89 c8 5b 5d c3 8d 74 26 00 8d bc 27 00 00 00 00 55
89 e5 57 56 89 c6 53 83 ec 28 89 55 e8 c7 45 ec 00 00 00 00 89 55 f0 8b
40 14 <8b> 50 10 8b 48 14 01 55 e8 11 4d ec 8b 40 54 c7 45 e0 00 00 00=20
Feb 11 03:16:10  <0>Fatal exception: panic in 5 seconds

Thanks,
=20
EM--

------_=_NextPart_001_01C75062.772C8817
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.5730.11" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D800325117-14022007>Hi=20
all,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D800325117-14022007>We are =
overwelmed=20
with panic's after io errors. Seem mdev-&gt;bc is null due to some race=20
condition.&nbsp; Here is one instance:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D800325117-14022007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D800325117-14022007>Two =
node cluster,=20
node A and Node B. Syncsource is node A. While syncing Reads are issued =
on Node=20
B.&nbsp; I/O errosrs start to occur</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D800325117-14022007>on =
node A,&nbsp;=20
Node A panics :</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D800325117-14022007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D800325117-14022007><FONT=20
face=3D"Times New Roman" size=3D3>Feb 11 03:15:49 drbd0: Sending =
NegRSDReply. sector=20
11620032s.<BR>Feb 11 03:15:49 drbd0: Notified peer that my disk is=20
broken.<BR>Feb 11 03:15:58 end_request: I/O error, dev sda, sector=20
59856375<BR>Feb 11 03:16:10 end_request: I/O error, dev sda, sector=20
59856383<BR>Feb 11 03:16:10 drbd0: Local IO failed. Detaching...<BR>Feb =
11=20
03:16:10 Unable to handle kernel NULL pointer dereference at virtual =
address=20
00000010<BR>Feb 11 03:16:10&nbsp; printing eip:<BR>Feb 11 03:16:10=20
ee3d0b0b<BR>Feb 11 03:16:10 299ba000 -&gt; *pde =3D =
00000000:7f512001<BR>Feb 11=20
03:16:10 00512000 -&gt; *pme =3D 00000000:00000000<BR>Feb 11 03:16:10 =
Oops: 0000=20
[#1]<BR>Feb 11 03:16:10 SMP <BR>Feb 11 03:16:10 Modules linked in: drbd =
cn=20
bridge ipv6 ipmi_devintf ipmi_si ipmi_msghandler i2c_dev i2c_core =
binfmt_misc=20
dm_mirror video thermal processor fan container button battery ac shpchp =

pci_hotplug e1000 piix ide_cd cdrom sg raid1 dm_mod ide_disk mptscsih =
mptsas=20
mptspi mptfc mptscsi mptbase sd_mod scsi_mod<BR>Feb 11 03:16:10 =
CPU:&nbsp;=20
&nbsp; 0<BR>Feb 11 03:16:10 EIP:&nbsp; &nbsp; =
0061:[&lt;ee3d0b0b&gt;]&nbsp;=20
&nbsp; Tainted: GF&nbsp; &nbsp; VLI<BR>Feb 11 03:16:10 EFLAGS: =
00010292&nbsp;=20
(2.6.16.29-xen #1) <BR>Feb 11 03:16:10 EIP is at =
drbd_bm_write_sect+0x1b/0x1f0=20
[drbd]<BR>Feb 11 03:16:10 eax: 00000000&nbsp; ebx: eb925000&nbsp; ecx:=20
00000000&nbsp; edx: 000001bd<BR>Feb 11 03:16:10 esi: eb925000&nbsp; edi: =

eb92502c&nbsp; ebp: eae77f50&nbsp; esp: eae77f1c<BR>Feb 11 03:16:10 ds:=20
007b&nbsp; es: 007b&nbsp; ss: 0069<BR>Feb 11 03:16:10 Process =
drbd0_worker (pid:=20
5777, threadinfo=3Deae76000 task=3Dc060b570)<BR>Feb 11 03:16:10 Stack:=20
&lt;0&gt;c0136f00 eae77f20 eae77f20 ffffffff ffffffff e7ea3550 00000000 =
000001bd=20
<BR>Feb 11 03:16:10&nbsp; &nbsp; &nbsp; &nbsp; 00000000 000001bd =
eb925000=20
eb667980 eb92502c eae77f74 ee3e2080 eb385d40 <BR>Feb 11 03:16:10&nbsp; =
&nbsp;=20
&nbsp; &nbsp; eb92502c eae77f74 ee3e6606 00000005 eb667980 eb925000 =
eae77fc0=20
ee3d4cae <BR>Feb 11 03:16:10 Call Trace:<BR>Feb 11 03:16:10&nbsp;=20
[&lt;c0105401&gt;] show_stack_log_lvl+0xa1/0xe0<BR>Feb 11 03:16:10&nbsp; =

[&lt;c01055f1&gt;] show_registers+0x181/0x200<BR>Feb 11 03:16:10&nbsp;=20
[&lt;c0105810&gt;] die+0x100/0x1a0<BR>Feb 11 03:16:10&nbsp; =
[&lt;c01156f6&gt;]=20
do_page_fault+0x3c6/0x8b1<BR>Feb 11 03:16:10&nbsp; [&lt;c0105067&gt;]=20
error_code+0x2b/0x30<BR>Feb 11 03:16:10&nbsp; [&lt;ee3e2080&gt;]=20
w_update_odbm+0x100/0x220 [drbd]<BR>Feb 11 03:16:10&nbsp; =
[&lt;ee3d4cae&gt;]=20
drbd_worker+0x2de/0x4b5 [drbd]<BR>Feb 11 03:16:10&nbsp; =
[&lt;ee3e70fc&gt;]=20
drbd_thread_setup+0x8c/0x100 [drbd]<BR>Feb 11 03:16:10&nbsp; =
[&lt;c0102e95&gt;]=20
kernel_thread_helper+0x5/0x10<BR>Feb 11 03:16:10 Code: 89 c8 5b 5d c3 8d =
74 26=20
00 8d bc 27 00 00 00 00 55 89 e5 57 56 89 c6 53 83 ec 28 89 55 e8 c7 45 =
ec 00 00=20
00 00 89 55 f0 8b 40 14 &lt;8b&gt; 50 10 8b 48 14 01 55 e8 11 4d ec 8b =
40 54 c7=20
45 e0 00 00 00 <BR>Feb 11 03:16:10&nbsp; &lt;0&gt;Fatal exception: panic =
in 5=20
seconds</FONT><BR></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D800325117-14022007>Thanks,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D800325117-14022007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D800325117-14022007>EM--</DIV></SPAN></FONT></BODY></HTML>

------_=_NextPart_001_01C75062.772C8817--
