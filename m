Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (unknown [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id AE8822D9EA8A
	for <drbd-dev@lists.linbit.com>; Thu, 25 Jan 2007 23:26:28 +0100 (CET)
Date: Thu, 25 Jan 2007 23:26:30 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] oopses in 2.6.19.1
Message-ID: <20070125222630.GC8857@soda.linbit>
References: <20070110123116.GX15730@kwaak.net>
	<20070111171205.GC15730@kwaak.net>
	<20070111180322.GD15730@kwaak.net>
	<200701151806.20526.philipp.reisner@linbit.com>
	<20070116103749.GD9639@kwaak.net> <20070125174523.GD9639@kwaak.net>
	<20070125213210.GK7738@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070125213210.GK7738@soda.linbit>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2007-01-25 22:32:10 +0100
\ Lars Ellenberg:
> 
> first, there is 2.6.19.2 already.
> second, there is drbd 8.0.0 already.
> though, there have not been any interesting changes in this area since revision 2695,
> which you apparently use.

> > drbd0: conn( WFSyncUUID -> SyncTarget ) 
> > drbd0: Began resync as SyncTarget (will sync 1158770664 KB [289692666 bits set]).
> > drbd0: Writing meta data super block now.
> > eth1: no IPv6 routers present
> > eth0: no IPv6 routers present
> > ----------- [cut here ] --------- [please bite here ] ---------
> > Kernel BUG at ...ed/kernel/tyan-s2891/modules/drbd/drbd/lru_cache.c:312
> > invalid opcode: 0000 [1] SMP 
> > Call Trace:
> >  [<ffffffff88077ecf>] :drbd:drbd_rs_complete_io+0xcf/0x130
> >  [<ffffffff8806b94d>] :drbd:drbd_endio_write_sec+0x1bd/0x2d0
> 
> > RIP  [<ffffffff8807997f>] :drbd:lc_put+0x4f/0xc0
> >  NMI Watchdog detected LOCKUP on CPU 0
> > RIP: 0010:[<ffffffff8026b4ba>]  [<ffffffff8026b4ba>] _spin_lock_irqsave+0xa/0x20
> > Call Trace:
> >  [<ffffffff8807772b>] :drbd:__drbd_set_in_sync+0x1bb/0x2e0
> >  [<ffffffff88071048>] :drbd:e_end_resync_block+0x68/0x100
> >  [<ffffffff8806f50b>] :drbd:drbd_process_done_ee+0xdb/0x140
> >  [<ffffffff88071688>] :drbd:drbd_asender+0xe8/0x580

I'd love it if it were not a logic bug but rather drbd being not robust
and paranoid enough...

one posibility for this to happen would be:

being SyncTarget
requesting some resync blocks. this also does the drbd_rs_begin_io.
the SyncSource sends us some RSDataReply (with an ID of -1ULL, and
some sector offset).

we currently do not verify whether we expected this sector offset.
we just read in the data and submit them. [there is a FIXME paranoia
comment in place in receive_RSDataReply, though]

later, the drbd_endio_write_sec callback does the drbd_rs_complete_io
for the corresponding resync extent.

now, if that extent was in the resync lru because we used it before,
but the RSDataReply would be for a sector we had not requested [*],
the refcnt is likely to be imbalanced, and we might BUG_ON it being zero,
in lc_put...

[*] how that could happen, I don't know yet...

in any case, regardless of this being a logic bug, (smp) race condition
or anything else, we need to become more robust there:

Index: drbd_actlog.c
===================================================================
--- drbd_actlog.c	(revision 2715)
+++ drbd_actlog.c	(working copy)
@@ -1098,6 +1098,13 @@
 		return;
 	}
 
+	if(bm_ext->lce.refcnt == 0) {
+		spin_unlock_irqrestore(&mdev->al_lock,flags);
+		ERR("drbd_rs_complete_io(,%llu [=%u]) called, but refcnt is 0!?\n",
+				(unsigned long long)sector, enr);
+		return;
+	}
+
 	if( lc_put(mdev->resync,(struct lc_element *)bm_ext) == 0 ) {
 		clear_bit(BME_LOCKED,&bm_ext->flags);
 		clear_bit(BME_NO_WRITES,&bm_ext->flags);

(not dared to commit this, in case this all was nonsense...
I feel too tired now)

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
