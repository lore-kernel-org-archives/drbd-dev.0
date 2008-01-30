Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Jan 2008 23:35:47 -0500
Message-ID: <342BAC0A5467384983B586A6B0B37671080C8EFC@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] One more issue with the latest 8.0 tree in git
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Continuing to test the latest 8.0 code from git, I am running into the
following assert a lot:

Jan 29 17:43:50 drbd11: Got NegAck packet. Peer is in troubles?
Jan 29 17:43:50 drbd11: drbd_bm_test_bit: (({ unsigned long flags; do {
(flags) =3D ((HYPERVISOR_shared_info->vcpu_info +
((current_thread_info()->cpu)))->evtchn_upcall_mask); } while (0);
raw_irqs_disabled_flags(flags); })) in
/sandbox/sgraham/sn/drbd-git/platform/drbd/src/dist/BUILD/drbd-8.0.8/drb
d/drbd_bitmap.c:964
Jan 29 17:43:50  [<c010640a>] show_trace_log_lvl+0x1a/0x30
Jan 29 17:43:50  [<c0106b42>] show_trace+0x12/0x20
Jan 29 17:43:50  [<c0106ba9>] dump_stack+0x19/0x20
Jan 29 17:43:50  [<f152ef34>] drbd_bm_test_bit+0x254/0x260 [drbd]
Jan 29 17:43:50  [<f153e509>] drbd_rs_failed_io+0x1b9/0x3a0 [drbd]
Jan 29 17:43:50  [<f15379c1>] got_NegAck+0x281/0x3a0 [drbd]
Jan 29 17:43:50  [<f15382c8>] drbd_asender+0x2f8/0x5b0 [drbd]
Jan 29 17:43:50  [<f1549a90>] drbd_thread_setup+0xb0/0x170 [drbd]
Jan 29 17:43:50  [<c0103005>] kernel_thread_helper+0x5/0x10
Jan 29 17:43:50  =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This is hitting the following test in drbd_bm_test_bit:

	D_BUG_ON(irqs_disabled());
	spin_lock_irq(&b->bm_lock);

I think because this routine is called from places that call
spin_lock_irq() before calling it... Should we just change the
spin_lock_irq() here to spin_lock_irqsave() and remove the D_BUG_ON?

Simon
