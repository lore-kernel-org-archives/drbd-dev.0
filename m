Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id C99E92DF6261
	for <drbd-dev@lists.linbit.com>; Wed, 30 Jan 2008 09:42:47 +0100 (CET)
Date: Wed, 30 Jan 2008 09:42:47 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] One more issue with the latest 8.0 tree in git
Message-ID: <20080130084247.GB5727@barkeeper1.linbit>
References: <342BAC0A5467384983B586A6B0B37671080C8EFC@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B37671080C8EFC@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Jan 29, 2008 at 11:35:47PM -0500, Graham, Simon wrote:
> Continuing to test the latest 8.0 code from git, I am running into the
> following assert a lot:
> 
> Jan 29 17:43:50 drbd11: Got NegAck packet. Peer is in troubles?
> Jan 29 17:43:50 drbd11: drbd_bm_test_bit: (({ unsigned long flags; do {
> (flags) = ((HYPERVISOR_shared_info->vcpu_info +
> ((current_thread_info()->cpu)))->evtchn_upcall_mask); } while (0);
> raw_irqs_disabled_flags(flags); })) in
> /sandbox/sgraham/sn/drbd-git/platform/drbd/src/dist/BUILD/drbd-8.0.8/drb
> d/drbd_bitmap.c:964
> Jan 29 17:43:50  [<c010640a>] show_trace_log_lvl+0x1a/0x30
> Jan 29 17:43:50  [<c0106b42>] show_trace+0x12/0x20
> Jan 29 17:43:50  [<c0106ba9>] dump_stack+0x19/0x20
> Jan 29 17:43:50  [<f152ef34>] drbd_bm_test_bit+0x254/0x260 [drbd]
> Jan 29 17:43:50  [<f153e509>] drbd_rs_failed_io+0x1b9/0x3a0 [drbd]
> Jan 29 17:43:50  [<f15379c1>] got_NegAck+0x281/0x3a0 [drbd]
> Jan 29 17:43:50  [<f15382c8>] drbd_asender+0x2f8/0x5b0 [drbd]
> Jan 29 17:43:50  [<f1549a90>] drbd_thread_setup+0xb0/0x170 [drbd]
> Jan 29 17:43:50  [<c0103005>] kernel_thread_helper+0x5/0x10
> Jan 29 17:43:50  =======================
> 
> This is hitting the following test in drbd_bm_test_bit:
> 
> 	D_BUG_ON(irqs_disabled());
> 	spin_lock_irq(&b->bm_lock);
> 
> I think because this routine is called from places that call
> spin_lock_irq() before calling it... Should we just change the
> spin_lock_irq() here to spin_lock_irqsave() and remove the D_BUG_ON?

thanks. see git.drbd.org:

4ad7ed376fbd1b713127237909737f9ae6bb7d77
	fix potential spin_unlock without corresponding spin_lock
0b1c24c299b21322f7074cb01dc14def8722f12c
	spin_lock_irqsave in drbd_bm_test_bit;
	new drbd_bm_count_bits to avoid looping over the bm spinlock.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
