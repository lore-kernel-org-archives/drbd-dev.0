Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Sep 2006 18:49:34 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671038B07C7@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD-8: crash due to incorrect thread termination
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

I reported the issue with threads being stopped synchronously from the
wrong context a while ago but now I've found an actual case that causes
a panic() - if BOTH sides are detached, and you attach one side, the
other will crash apparently because the code attempts to synchronously
stop the sender thread, fails, then discards all the network connection
data as the sender thread is still attempting to use it...

Just thought I'd pass on an easy test case (since I don't know how to
fix this one ;-).

Simon

console log from side doing attach:

Sep 14 18:44:01 penn kernel: drbd0: Found 6 transactions (324 active
extents) in activity log.
Sep 14 18:44:01 penn kernel: drbd0: max_segment_size ( =3D BIO size ) =
=3D
32768
Sep 14 18:44:01 penn kernel: drbd0: reading of bitmap took 1 jiffies
Sep 14 18:44:01 penn kernel: drbd0: recounting of set bits took
additional 0 jiffies
Sep 14 18:44:01 penn kernel: drbd0: 0 KB marked out-of-sync by on disk
bit-map.
Sep 14 18:44:01 penn kernel: drbd0: data >>> ReportSizes (d 0MiB, u
0MiB, c 15007MiB, max bio 8000, q order 0)
Sep 14 18:44:01 penn kernel: drbd0: data >>> ReportState (s 28a { role(
Secondary ) peer( Secondary ) conn( Connected ) disk( Attaching ) pdsk(
Diskless )})
Sep 14 18:44:01 penn kernel: drbd0: sock was reset by peer

from side that crashes:

Sep 14 18:44:01 teller kernel: drbd0: some backing storage is needed
Sep 14 18:44:01 teller kernel: drbd0: peer( Secondary -> Unknown ) conn(
Connected -> StandAlone ) pdsk( Diskless -> DUnknown )=20
Sep 14 18:44:01 teller kernel: drbd0: drbd_thread_stop: drbd0_receiver
[4885]: drbd0_receiver 1 -> 2; 1
Sep 14 18:44:01 teller kernel: drbd0: ASSERT( !wait ) in
/sandbox/sgraham/sn/drbd-panic/platform/drbd/8.0/drbd/drbd_main.c:1100
Sep 14 18:44:01 teller kernel:  [<c01050a1>] show_trace+0x21/0x30
Sep 14 18:44:01 teller kernel:  [<c01051de>] dump_stack+0x1e/0x20
Sep 14 18:44:01 teller kernel:  [<f12aa6af>]
_drbd_thread_stop+0x16f/0x1b0 [drbd]
Sep 14 18:44:01 teller kernel:  [<f12aa163>] after_state_ch+0x773/0x920
[drbd]
Sep 14 18:44:01 teller kernel:  [<f12a8753>] drbd_change_state+0xa3/0xc0
[drbd]
Sep 14 18:44:01 teller kernel:  [<f12a8798>] drbd_force_state+0x28/0x30
[drbd]
Sep 14 18:44:01 teller kernel:  [<f12a0265>] receive_sizes+0x4e5/0x7a0
[drbd]
Sep 14 18:44:01 teller kernel:  [<f12a1419>] drbdd+0x49/0x140 [drbd]
Sep 14 18:44:01 teller kernel:  [<f12a2135>] drbdd_init+0xe5/0x120
[drbd]
Sep 14 18:44:01 teller kernel:  [<f12aa37b>] drbd_thread_setup+0x6b/0xc0
[drbd]
Sep 14 18:44:01 teller kernel:  [<c0102d9d>]
kernel_thread_helper+0x5/0x18
Sep 14 18:44:01 teller kernel: drbd0: drbd_thread_stop: drbd0_receiver
[4885]: drbd0_worker 1 -> 2; 1
Sep 14 18:44:01 teller kernel: drbd0: worker terminated
Sep 14 18:44:01 teller kernel: drbd0: drbd_thread_stop: drbd0_receiver
[4885]: drbd0_receiver 2 -> 2; 1
Sep 14 18:44:01 teller kernel: drbd0: drbd_thread_stop: drbd0_receiver
[4885]: NULL 0 -> 2; 1
Sep 14 18:44:01 teller kernel: drbd0: drbd_bm_resize called with
capacity =3D=3D 0
Sep 14 18:44:01 teller kernel: drbd0: drbd_thread_stop: drbd0_receiver
[4885]: drbd0_receiver 2 -> 2; 0
Sep 14 18:44:01 teller kernel: drbd0: error receiving ReportSizes, l:
32!
Sep 14 18:44:01 teller kernel: drbd0: drbd_thread_stop: drbd0_receiver
[4885]: drbd0_asender 1 -> 2; 1
Sep 14 18:44:01 teller kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000004
Sep 14 18:44:01 teller kernel:  printing eip:
Sep 14 18:44:01 teller kernel: c03dd67d
Sep 14 18:44:01 teller kernel: *pde =3D ma 00000000 pa fffff000
Sep 14 18:44:01 teller kernel: Oops: 0002 [#1]
Sep 14 18:44:01 teller kernel: Modules linked in: drbd ipmi_devintf
ipmi_si ipmi_msghandler video thermal processor fan button battery ac
e1000
Sep 14 18:44:01 teller kernel: CPU:    0
Sep 14 18:44:01 teller kernel: EIP:    0061:[<c03dd67d>]    Not tainted
VLI
Sep 14 18:44:01 teller kernel: EFLAGS: 00010246   (2.6.16.13-xen0 #1)=20
Sep 14 18:44:01 teller kernel: EIP is at sk_wait_data+0x8d/0xc0
Sep 14 18:44:01 teller kernel: eax: 00000000   ebx: 00000000   ecx:
00000000   edx: eb2c6054
Sep 14 18:44:01 teller kernel: esi: eb2c6000   edi: eb131d88   ebp:
eb131db4   esp: eb131d68
Sep 14 18:44:01 teller kernel: ds: 007b   es: 007b   ss: 0069
Sep 14 18:44:02 teller kernel: Process drbd0_asender (pid: 4887,
threadinfo=3Deb130000 task=3Deb54f570)
Sep 14 18:44:02 teller kernel: Stack: <0>00000000 eb54f570 c012da30
eb131d94 eb131d94 eb131d9c c04161b0 eb2c6000=20
Sep 14 18:44:02 teller kernel:        00000000 eb54f570 c012da30
eb967518 eb967518 eb131db4 c04069fd eb2c6000=20
Sep 14 18:44:02 teller kernel:        00000000 00000000 eb2c6000
eb131e08 c0406f23 eb2c6000 eb131df4 eb967500=20
Sep 14 18:44:02 teller kernel: Call Trace:
Sep 14 18:44:02 teller kernel:  [<c010515a>]
show_stack_log_lvl+0xaa/0xe0
Sep 14 18:44:02 teller kernel:  [<c010536e>] show_registers+0x18e/0x210
Sep 14 18:44:02 teller kernel:  [<c0105569>] die+0xd9/0x180
Sep 14 18:44:02 teller kernel:  [<c0112ccc>] do_page_fault+0x3cc/0x68e
Sep 14 18:44:02 teller kernel:  [<c0104d7f>] error_code+0x2b/0x30
Sep 14 18:44:02 teller kernel:  [<c0406f23>] tcp_recvmsg+0x393/0x720
Sep 14 18:44:02 teller kernel:  [<c03dddfd>]
sock_common_recvmsg+0x4d/0x70
Sep 14 18:44:02 teller kernel:  [<c03da1db>] sock_recvmsg+0xcb/0x100
Sep 14 18:44:02 teller kernel:  [<f129cb05>] drbd_recv_short+0x85/0xc0
[drbd]
Sep 14 18:44:02 teller kernel:  [<f12a2abc>] drbd_asender+0x10c/0x496
[drbd]
Sep 14 18:44:02 teller kernel:  [<f12aa37b>] drbd_thread_setup+0x6b/0xc0
[drbd]
Sep 14 18:44:02 teller kernel:  [<c0102d9d>]
kernel_thread_helper+0x5/0x18
Sep 14 18:44:02 teller kernel: Code: 00 0f ba 68 04 01 89 f0 8d 5e 54 e8
de 05 00 00 39 5e 54 74 2f 89 f0 e8 82 05 00 00 39 5e 54 0f 95 c0 0f b6
d8 8b 86 f0 00 00 00 <0f> ba 70 04 01 8b 46 38 89 fa e8 34 03 d5 ff 83
c4 40 89 d8 5b=20
Sep 14 18:44:02 teller kernel:  <0>Fatal exception: panic in 5 seconds
