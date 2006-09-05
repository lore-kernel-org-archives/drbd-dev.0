Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD-8 - system hangs when NegDReply received
Date: Tue, 5 Sep 2006 16:47:13 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671038AF9EA@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Graham, Simon" <Simon.Graham@stratus.com>,
	<drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

In addition, a while after the system hung, it paniced with an invalid
address in drbd_fail_pending_reads called from w_disconnect - panic msg
is attached (I assume this happened because things were stuck so
PingAcks were not being sent so the partner system disconnected).=20

This looks to me like the temporary list of requests to complete setup
in this routine is corrupted somehow.=20

Any suggestions?
Simon

drbd0: State change from bad state. Error would be: 'Refusing to be
Primary without at least one UpToDate disk'
drbd0:  old =3D { cs:BrokenPipe st:Primary/Unknown ds:Diskless/DUnknown
r--- }
drbd0:  new =3D { cs:Unconnected st:Primary/Unknown ds:Diskless/DUnknown
r--- }
 [<c01050a1>] show_trace+0x21/0x30
 [<c01051de>] dump_stack+0x1e/0x20
 [<f1285e38>] _drbd_set_state+0xa08/0xa20 [drbd]
 [<f127e393>] drbd_disconnect+0x223/0x310 [drbd]
 [<f127ed18>] drbdd_init+0x78/0x120 [drbd]
 [<f128681b>] drbd_thread_setup+0x6b/0xc0 [drbd]
 [<c0102d9d>] kernel_thread_helper+0x5/0x18
drbd0: No access to good data anymore.
Unable to handle kernel paging request at virtual address 00100104
 printing eip:
f1277408
*pde =3D ma 00000000 pa fffff000
Oops: 0002 [#1]
Modules linked in: drbd ipmi_devintf ipmi_si ipmi_msghandler video
thermal processor fan button battery ac
CPU:    0
EIP:    0061:[<f1277408>]    Not tainted VLI
EFLAGS: 00010297   (2.6.16.13-xen0 #1)=20
EIP is at drbd_fail_pending_reads+0x78/0x240 [drbd]
eax: 00100100   ebx: ec5eff60   ecx: ec883f48   edx: ec883f48
esi: ef85fc00   edi: 00000002   ebp: ec883f5c   esp: ec883f34
ds: 007b   es: 007b   ss: 0069
Process drbd0_worker (pid: 4118, threadinfo=3Dec882000 task=3Defcdeab0)
Stack: <0>e9dfae10 ee9f9520 fffffffb eca596a4 ef85fc00 ec5eff60 e9dfae10
ef85fc00=20
       ee9f9740 ef85fc38 ec883f7c f127760b ef85fc00 ef85fc38 ec883f7c
c045bd8a=20
       ee9f9740 ef85fc00 ec883fc0 f1278176 ef85fc00 ee9f9740 00000001
00000000=20
Call Trace:
 [<c010515a>] show_stack_log_lvl+0xaa/0xe0
 [<c010536e>] show_registers+0x18e/0x210
 [<c0105569>] die+0xd9/0x180
 [<c0112ccc>] do_page_fault+0x3cc/0x68e
 [<c0104d7f>] error_code+0x2b/0x30
 [<f127760b>] w_disconnect+0x3b/0x2d0 [drbd]
 [<f1278176>] drbd_worker+0x156/0x487 [drbd]
 [<f128681b>] drbd_thread_setup+0x6b/0xc0 [drbd]
 [<c0102d9d>] kernel_thread_helper+0x5/0x18
Code: d2 75 e0 8b be 38 03 00 00 43 83 fb 0e 7e c4 31 c0 b9 0f 00 00 00
f3 ab 8b 5d ec 8d 45 ec 39 c3 0f 84 ad 00 00 00 8b 53 04 8b 03 <89> 50
04 89 02 8b 53 18 b8 fb ff ff ff c7 03 00 01 10 00 c7 43=20
 <0>Fatal exception: panic in 5 seconds

