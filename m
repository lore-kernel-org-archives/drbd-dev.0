Return-Path: <lars@linbit.com>
Date: Fri, 20 Apr 2007 15:31:03 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: Sync hangs due to using freed ee
Message-ID: <20070420133103.GF12314@barkeeper1.linbit>
References: <BD7042533C2F8943A6A4257A9E31C45439C983@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C983@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Apr 19, 2007 at 06:03:25PM -0400, Montrose, Ernest wrote:
> Hi all,
> 
> This my second time actually reporting on this problem.  The first time I did
> not
> 
> Have much info other then the logs but this time I think I understand a bit
> more a bout the problem. 
> 
> So here it is.
> 
>  
> 
> Problem:
> We are syncing and we are the sync target.
> We submit a write io request and when it is done bio_endio calls
> drbd_endio_write_sec()
> When we access the sector field for the ee/bio in this routine it is poisoned
> because we have
> slab debugging turned on. The poison is 6d6d6d6d...This indicates that we are
> freeing the ee
> and then proceed to use it.
> The symtom is that we get:
> Apr 12 02:36:22  kernel: drbd1: drbd_rs_complete_io() called, but extent not
> found
> Apr 12 02:36:22  kernel: drbd1: al_complete_io() called on inactive extent
> 1532713819
> 
> and we loop forever with:
> Apr 12 02:43:19 ellwood kernel: drbd2: Retrying drbd_rs_del_all() later. refcnt
> =1
> 
> Well a look at the code yields:
> we add to the done_ee list in:
> ./src/drbd/drbd_receiver.c:    list_add_tail(&e->w.list,&mdev->done_ee);
> ./src/drbd/drbd_worker.c  :    list_add_tail(&e->w.list,&mdev->done_ee);
> 
> In ./src/drbd/drbd_receiver.c:receive_data() we add to the list and wake up the
> asender and return.  We do
> not attempt to use any ot the ee's after. So all maybe fine there.
> 
> However, in the ./src/drbd/drbd_worker.c:drbd_endio_write_sec() we add to the
> list and then we call
> drbd_rs_complete_io(mdev,e->sector)  and
> drbd_al_complete_io(mdev,e->sector) Using the ee after it was placed on the
> done list so it could
> potentially be freed.  I suspect it is being freed in process_done_ee() where
> drbd_free_ee is
> called.
> 
> Instrumentation shows that the bio and ee are intact at the beginning of
> drbd_endio_write_sec()
> as shown in the log below:
> 
> Apr 19 17:28:12 godzilla kernel: drbd1: drbd_endio_write_sec: EM-- XX BUG!! e->
> sector=7740398493674204011s cap_sector=10267584s size=1802201963 bytes_done=
> 32768  bio->bi_sector=774039849367420400
> 
> Apr 19 17:28:12 godzilla kernel:  [<c0105a67>] dump_stack+0x17/0x20
> Apr 19 17:28:12 godzilla kernel:  [<ee2d0caf>] drbd_endio_write_sec+0x16f/0x3a0
> [drbd]
> Apr 19 17:28:12 godzilla kernel:  [<c0177319>] bio_endio+0x59/0x90
> Apr 19 17:28:12 godzilla kernel:  [<ee0ab2b9>] dec_pending+0x39/0x70 [dm_mod]
> Apr 19 17:28:12 godzilla kernel:  [<ee0ab391>] clone_endio+0xa1/0xc0 [dm_mod]
> Apr 19 17:28:12 godzilla kernel:  [<c0177319>] bio_endio+0x59/0x90
> Apr 19 17:28:12 godzilla kernel:  [<c022638a>] __end_that_request_first+0xba/
> 0x330
> Apr 19 17:28:12 godzilla kernel:  [<c0226618>] end_that_request_chunk+0x8/0x10
> Apr 19 17:28:12 godzilla kernel:  [<ee0209f5>] scsi_end_request+0x25/0xe0
> [scsi_mod]
> Apr 19 17:28:12 godzilla kernel:  [<ee020c82>] scsi_io_completion+0xd2/0x3c0
> [scsi_mod]
> Apr 19 17:28:12 godzilla kernel:  [<ee06a02a>] sd_rw_intr+0x14a/0x2c0 [sd_mod]
> Notice the poisoned e->sector captured just before we call drbd_rs_complete_io
> with it.
> More importantly, notice the value of cap_sector which is what came out of the
> kernel when
> bio_endio called our callback.
> 
> What is the best way to fix this? Is it a matter of just moving list_add_tail(&
> e->w.list,&mdev->done_ee);
> to after we use e->sector?

thanks for this correct analysis!

the best fix I came up with is the patch below, already checked in,
though not yet tested.

delaying the list move would hurt performance, because it would delays the
WriteAck as long as the complete_something routines take, which may
involve a meta data transaction.
since these only need info on the sector number, not on the actual epoch
entry, I just introduced an e_sector = e->sector earlier.

does this make sense?
did you find some other similarly broken code pieces?

Index: drbd_worker.c
===================================================================
--- drbd_worker.c	(revision 2861)
+++ drbd_worker.c	(working copy)
@@ -106,8 +106,10 @@
 	unsigned long flags=0;
 	struct Tl_epoch_entry *e=NULL;
 	drbd_dev *mdev;
+	sector_t e_sector;
 	int do_wake;
 	int is_syncer_req;
+	int do_al_complete_io;
 
 	e = bio->bi_private;
 	mdev = e->mdev;
@@ -120,9 +122,22 @@
 	spin_lock_irqsave(&mdev->req_lock,flags);
 	mdev->writ_cnt += e->size >> 9;
 	is_syncer_req = is_syncer_block_id(e->block_id);
+
+	/* after we moved e to done_ee,
+	 * we may no longer access it,
+	 * it may be freed/reused already!
+	 * (as soon as we release the req_lock) */
+	e_sector = e->sector;
+	do_al_complete_io = e->flags & EE_CALL_AL_COMPLETE_IO;
+
 	list_del(&e->w.list); /* has been on active_ee or sync_ee */
 	list_add_tail(&e->w.list,&mdev->done_ee);
 
+	MTRACE(TraceTypeEE,TraceLvlAll,
+	       INFO("Moved EE (WRITE) to done_ee sec=%llus size=%u ee=%p\n",
+		    (unsigned long long)e->sector,e->size,e);
+	       );
+
 	/* No hlist_del_init(&e->colision) here, we did not send the Ack yet,
 	 * neither did we wake possibly waiting conflicting requests.
 	 * done from "drbd_process_done_ee" within the appropriate w.cb
@@ -137,19 +152,15 @@
 	if (error) __drbd_chk_io_error(mdev,FALSE);
 	spin_unlock_irqrestore(&mdev->req_lock,flags);
 
-	if(is_syncer_req) drbd_rs_complete_io(mdev,e->sector);
+	if (is_syncer_req) drbd_rs_complete_io(mdev,e_sector);
 
 	if (do_wake) wake_up(&mdev->ee_wait);
 
-	if(e->flags & EE_CALL_AL_COMPLETE_IO) drbd_al_complete_io(mdev,e->sector);
+	if (do_al_complete_io) drbd_al_complete_io(mdev,e_sector);
 
 	wake_asender(mdev);
 	dec_local(mdev);
 
-	MTRACE(TraceTypeEE,TraceLvlAll,
-	       INFO("Moved EE (WRITE) to done_ee sec=%llus size=%u ee=%p\n",
-		    (unsigned long long)e->sector,e->size,e);
-	       );
 	return 0;
 }
 

-- 
: Lars Ellenberg                            Tel +43-1-8178292-0  :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
__
please use the "List-Reply" function of your email client.
