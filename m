Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7453F.EA4D41C0"
Date: Wed, 31 Jan 2007 08:58:41 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C8D9@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8:Panics in lc_find due to null lc after Scsi
	MEDIUM_ERROR I.O error.
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7453F.EA4D41C0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This one is automatic.  During a read an IO errors occured.  The
specific error is ATA stat/err 0x51/40 translated into SCSI error
0x3/11/04 or Medium error/Read error/auto-reallocation failed.  This
error appears to be a ATA Uncorectable ECC error...So though the read
may have completed,
the data is not validated.  This is just for completeness in helping to
understand this. The main issue is that drbd ends up with a Null lc.
Here is
the stack trace.  Also see Simon Graham very good analysis after:
=20
Jan 30 11:05:46 bo kernel: ------------[ cut here ]------------
Jan 30 11:05:46 bo kernel: kernel BUG at
/sandbox/emontros/devel/trunk_drbd8/platform/drbd/src/drbd/lru_cache.c:1
20!
Jan 30 11:05:46 bo kernel: invalid opcode: 0000 [#1]
Jan 30 11:05:46 bo kernel: SMP
Jan 30 11:05:46 bo kernel: Modules linked in: drbd cn bridge ipv6
ipmi_devintf ipmi_si ipmi_msghandler binfmt_misc dm_mirror video thermal
processor fan container button battery ac hw_random i2c_i801 i2c_core
shpchp pci_hotplug e1000 piix ide_cd cdrom raid1 dm_mod ide_disk
ata_piix libata sd_mod scsi_mod
Jan 30 11:05:46 bo kernel: CPU:    0
Jan 30 11:05:46 bo kernel: EIP:    0061:[<ee3ad1c4>]    Tainted: GF
VLI
Jan 30 11:05:46 bo kernel: EFLAGS: 00010046  (2.6.16.29-xen #1)
Jan 30 11:05:46 bo kernel: EIP is at lc_find+0x44/0x50 [drbd]
Jan 30 11:05:46 bo kernel: eax: 00000000  ebx: 00000000  ecx: ec8e13b0
edx: 00000058
Jan 30 11:05:46 bo kernel: esi: 00000058  edi: ec8e13b0  ebp: c59b9f08
esp: c59b9f00
Jan 30 11:05:46 bo kernel: ds: 007b  es: 007b  ss: 0069
Jan 30 11:05:46 bo kernel: Process drbd1_worker (pid: 6253,
threadinfo=3Dc59b8000 task=3Dc586e570)
Jan 30 11:05:46 bo kernel: Stack: <0>00000058 ec8e1000 c59b9f44 ee3ac5bd
c59b9f44 00000000 c586e570 c0137100
Jan 30 11:05:46 bo kernel:        c59b9f20 00000058 00000000 00000000
002c0000 00000000 eb121e74 ec8e1000
Jan 30 11:05:46 bo kernel:        ec8e1000 c59b9f74 ee39cd16 c59b9f5c
c59b9f74 00000005 ed6e6820 ec8e102c
Jan 30 11:05:46 bo kernel: Call Trace:
Jan 30 11:05:46 bo kernel:  [<c0105431>] show_stack_log_lvl+0xa1/0xe0
Jan 30 11:05:46 bo kernel:  [<c0105621>] show_registers+0x181/0x200
Jan 30 11:05:46 bo kernel:  [<c0105840>] die+0x100/0x1a0
Jan 30 11:05:46 bo kernel:  [<c0105961>] do_trap+0x81/0xc0
Jan 30 11:05:46 bo kernel:  [<c0105c45>] do_invalid_op+0xa5/0xb0
Jan 30 11:05:46 bo kernel:  [<c0105097>] error_code+0x2b/0x30
Jan 30 11:05:46 bo kernel:  [<ee3ac5bd>] drbd_rs_complete_io+0x5d/0x130
[drbd]
Jan 30 11:05:46 bo kernel:  [<ee39cd16>] w_e_end_rsdata_req+0x26/0x390
[drbd]
Jan 30 11:05:46 bo kernel:  [<ee39dcae>] drbd_worker+0x2de/0x4b5 [drbd]
Jan 30 11:05:46 bo kernel:  [<ee3b010c>] drbd_thread_setup+0x8c/0x100
[drbd]
Jan 30 11:05:46 bo kernel:  [<c0102ec5>] kernel_thread_helper+0x5/0x10
Jan 30 11:05:46 bo kernel: Code: c3 ff ff ff 8b 44 83 4c eb 0d 8b 10 0f
18 02 90 39 70 14 74 08 89 d0 85 c0 75 ef 31 c0 5b 5e 5d c3 0f 0b 79 00
30 f2 3b ee eb d0 <0f> 0b 78 00 30 f2 3b ee
eb bf 89 f6 55 31 d2 89 e5 53 39 00 74
Jan 30 11:05:46 bo kernel:  <0>Fatal exception: panic in 5 seconds

Here is Simon original analysis that may help track this:
looks like another instance of the same bug we fixed in the data path -
you can't look at mdev->resync or mdev->act_log without first getting a
local reference on the mdev... the way they fixed it previously was to
make sure this is done before calling drbd_al_complete_io in all cases -
just need to do the same with drbd_rs_complete_io as well I think.

There are three places where I think this is not done:

1.    got_NegRSDReply in drbd_receiver.c
2.    w_make_resync_request in drbd_worker.c
3.    w_e_end_rsdata_req - this is the one we actually crashed on here.

Taking each one in turn:
1. got_NegRSDReply -- possibly add inc_local_if_state()/dec_local()?
Make sure you still call
  dec_rs_pending() though -- only drbd_rs_complete_io() and
drbd_rs_failed_io() should
  be protected with the inc_local_if_state(Failed).
2. w_make_resync_request -- this one I think we need to defer to Linbit;
this is
  a complex routine and it's possible it wont ever be called when the
local disk
  has been detached (the detach should stop the resync!) - However; I am
concerned
  there is a race condition where we could be in this routine when the
disk gets
  detached and we have no local ref on the mdev.
3. w_e_end_rsdata_req -- this is run as a worker item at the end of
processing
  a resync data request -- the bio completion routine is
drbd_endio_read_sec
  and this is decrementing the local count on the mdev before the work
item
  runs -- I think the right fix here is to move the dec_local() from
this
  routine into w_e_end_rsdata_req after dec_unacked() is called (note
that
  there are TWO exits paths from this routine that do this - fix both!)

Note that we should report this asap to Linbit -- there may be some
other places where mdev->resync is accessed without the proper
protection...=20
=20

------_=_NextPart_001_01C7453F.EA4D41C0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.5730.11" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D973544613-31012007>This =
one is=20
automatic.&nbsp; During a read an IO errors occured.&nbsp; The specific =
error is=20
ATA stat/err 0x51/40 translated into SCSI error 0x3/11/04 or Medium =
error/Read=20
error/auto-reallocation failed.&nbsp; This error appears to be a ATA=20
Uncorectable ECC error...So though the read may have=20
completed,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D973544613-31012007>the =
data is not=20
validated.&nbsp; This is just for completeness in helping to understand =
this.=20
The main issue is that drbd ends up with a Null lc.&nbsp; Here=20
is</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D973544613-31012007>the =
stack=20
trace.&nbsp; Also see Simon Graham very good analysis =
after:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D973544613-31012007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D973544613-31012007><FONT=20
face=3D"Times New Roman" size=3D3>Jan 30 11:05:46 bo kernel: =
------------[ cut here=20
]------------<BR>Jan 30 11:05:46 bo kernel: kernel BUG at=20
/sandbox/emontros/devel/trunk_drbd8/platform/drbd/src/drbd/lru_cache.c:12=
0!<BR>Jan=20
30 11:05:46 bo kernel: invalid opcode: 0000 [#1]<BR>Jan 30 11:05:46 bo =
kernel:=20
SMP<BR>Jan 30 11:05:46 bo kernel: Modules linked in: drbd cn bridge ipv6 =

ipmi_devintf ipmi_si ipmi_msghandler binfmt_misc dm_mirror video thermal =

processor fan container button battery ac hw_random i2c_i801 i2c_core =
shpchp=20
pci_hotplug e1000 piix ide_cd cdrom raid1 dm_mod ide_disk ata_piix =
libata sd_mod=20
scsi_mod<BR>Jan 30 11:05:46 bo kernel: CPU:&nbsp; &nbsp; 0<BR>Jan 30 =
11:05:46 bo=20
kernel: EIP:&nbsp; &nbsp; 0061:[&lt;ee3ad1c4&gt;]&nbsp; &nbsp; Tainted: =
GF&nbsp;=20
&nbsp; VLI<BR>Jan 30 11:05:46 bo kernel: EFLAGS: 00010046&nbsp; =
(2.6.16.29-xen=20
#1)<BR>Jan 30 11:05:46 bo kernel: EIP is at lc_find+0x44/0x50 =
[drbd]<BR>Jan 30=20
11:05:46 bo kernel: eax: 00000000&nbsp; ebx: 00000000&nbsp; ecx: =
ec8e13b0&nbsp;=20
edx: 00000058<BR>Jan 30 11:05:46 bo kernel: esi: 00000058&nbsp; edi:=20
ec8e13b0&nbsp; ebp: c59b9f08&nbsp; esp: c59b9f00<BR>Jan 30 11:05:46 bo =
kernel:=20
ds: 007b&nbsp; es: 007b&nbsp; ss: 0069<BR>Jan 30 11:05:46 bo kernel: =
Process=20
drbd1_worker (pid: 6253, threadinfo=3Dc59b8000 task=3Dc586e570)<BR>Jan =
30 11:05:46=20
bo kernel: Stack: &lt;0&gt;00000058 ec8e1000 c59b9f44 ee3ac5bd c59b9f44 =
00000000=20
c586e570 c0137100<BR>Jan 30 11:05:46 bo kernel:&nbsp; &nbsp; &nbsp; =
&nbsp;=20
c59b9f20 00000058 00000000 00000000 002c0000 00000000 eb121e74 =
ec8e1000<BR>Jan=20
30 11:05:46 bo kernel:&nbsp; &nbsp; &nbsp; &nbsp; ec8e1000 c59b9f74 =
ee39cd16=20
c59b9f5c c59b9f74 00000005 ed6e6820 ec8e102c<BR>Jan 30 11:05:46 bo =
kernel: Call=20
Trace:<BR>Jan 30 11:05:46 bo kernel:&nbsp; [&lt;c0105431&gt;]=20
show_stack_log_lvl+0xa1/0xe0<BR>Jan 30 11:05:46 bo kernel:&nbsp;=20
[&lt;c0105621&gt;] show_registers+0x181/0x200<BR>Jan 30 11:05:46 bo=20
kernel:&nbsp; [&lt;c0105840&gt;] die+0x100/0x1a0<BR>Jan 30 11:05:46 bo=20
kernel:&nbsp; [&lt;c0105961&gt;] do_trap+0x81/0xc0<BR>Jan 30 11:05:46 bo =

kernel:&nbsp; [&lt;c0105c45&gt;] do_invalid_op+0xa5/0xb0<BR>Jan 30 =
11:05:46 bo=20
kernel:&nbsp; [&lt;c0105097&gt;] error_code+0x2b/0x30<BR>Jan 30 11:05:46 =
bo=20
kernel:&nbsp; [&lt;ee3ac5bd&gt;] drbd_rs_complete_io+0x5d/0x130 =
[drbd]<BR>Jan 30=20
11:05:46 bo kernel:&nbsp; [&lt;ee39cd16&gt;] =
w_e_end_rsdata_req+0x26/0x390=20
[drbd]<BR>Jan 30 11:05:46 bo kernel:&nbsp; [&lt;ee39dcae&gt;]=20
drbd_worker+0x2de/0x4b5 [drbd]<BR>Jan 30 11:05:46 bo kernel:&nbsp;=20
[&lt;ee3b010c&gt;] drbd_thread_setup+0x8c/0x100 [drbd]<BR>Jan 30 =
11:05:46 bo=20
kernel:&nbsp; [&lt;c0102ec5&gt;] kernel_thread_helper+0x5/0x10<BR>Jan 30 =

11:05:46 bo kernel: Code: c3 ff ff ff 8b 44 83 4c eb 0d 8b 10 0f 18 02 =
90 39 70=20
14 74 08 89 d0 85 c0 75 ef 31 c0 5b 5e 5d c3 0f 0b 79 00 30 f2 3b ee eb =
d0=20
&lt;0f&gt; 0b 78 00 30 f2 3b ee<BR>eb bf 89 f6 55 31 d2 89 e5 53 39 00 =
74<BR>Jan=20
30 11:05:46 bo kernel:&nbsp; &lt;0&gt;Fatal exception: panic in 5=20
seconds</FONT><BR></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D973544613-31012007>Here =
is Simon=20
original analysis that may help track this:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D973544613-31012007><FONT=20
face=3D"Times New Roman" size=3D3>looks like another instance of the =
same bug we=20
fixed in the data path &#8211; you can&#8217;t look at mdev-&gt;resync =
or mdev-&gt;act_log=20
without first getting a local reference on the mdev&#8230; the way they =
fixed it=20
previously was to make sure this is done before calling =
drbd_al_complete_io in=20
all cases &#8211; just need to do the same with drbd_rs_complete_io as =
well I=20
think.<BR><BR>There are three places where I think this is not=20
done:<BR><BR>1.&nbsp;&nbsp;&nbsp;&nbsp;got_NegRSDReply in=20
drbd_receiver.c<BR>2.&nbsp;&nbsp;&nbsp;&nbsp;w_make_resync_request in=20
drbd_worker.c<BR>3.&nbsp;&nbsp;&nbsp;&nbsp;w_e_end_rsdata_req - this is =
the one=20
we actually crashed on here.<BR><BR>Taking each one in turn:<BR>1.=20
got_NegRSDReply -- possibly add inc_local_if_state()/dec_local()? Make =
sure you=20
still call<BR>&nbsp; dec_rs_pending() though -- only =
drbd_rs_complete_io() and=20
drbd_rs_failed_io() should<BR>&nbsp; be protected with the=20
inc_local_if_state(Failed).<BR>2. w_make_resync_request -- this one I =
think we=20
need to defer to Linbit; this is<BR>&nbsp; a complex routine and it's =
possible=20
it wont ever be called when the local disk<BR>&nbsp; has been detached =
(the=20
detach should stop the resync!) - However; I am concerned<BR>&nbsp; =
there is a=20
race condition where we could be in this routine when the disk =
gets<BR>&nbsp;=20
detached and we have no local ref on the mdev.<BR>3. w_e_end_rsdata_req =
-- this=20
is run as a worker item at the end of processing<BR>&nbsp; a resync data =
request=20
-- the bio completion routine is drbd_endio_read_sec<BR>&nbsp; and this =
is=20
decrementing the local count on the mdev before the work item<BR>&nbsp; =
runs --=20
I think the right fix here is to move the dec_local() from =
this<BR>&nbsp;=20
routine into w_e_end_rsdata_req after dec_unacked() is called (note=20
that<BR>&nbsp; there are TWO exits paths from this routine that do this =
- fix=20
both!)<BR><BR>Note that we should report this asap to Linbit -- there =
may be=20
some other places where mdev-&gt;resync is accessed without the proper=20
protection... </FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D973544613-31012007><FONT=20
face=3D"Times New Roman" =
size=3D3></FONT>&nbsp;</DIV></SPAN></FONT></BODY></HTML>

------_=_NextPart_001_01C7453F.EA4D41C0--
