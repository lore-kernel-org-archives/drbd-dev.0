Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f174.google.com (mail-wr0-f174.google.com
	[209.85.128.174])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E66C3105732A
	for <drbd-dev@lists.linbit.com>; Thu,  3 May 2018 16:57:04 +0200 (CEST)
Received: by mail-wr0-f174.google.com with SMTP id g21-v6so17937226wrb.8
	for <drbd-dev@lists.linbit.com>; Thu, 03 May 2018 07:57:04 -0700 (PDT)
Date: Thu, 3 May 2018 16:57:02 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Sarah Newman <srn@prgmr.com>
Message-ID: <20180503145702.GY10032@soda.linbit>
References: <e7b77f18-0457-3bf9-0198-90c8239e342c@prgmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7b77f18-0457-3bf9-0198-90c8239e342c@prgmr.com>
Cc: philipp.reisner@linbit.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] WARNING: do not call blocking ops when !TASK_RUNNING
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

On Sun, Apr 29, 2018 at 06:07:43PM -0700, Sarah Newman wrote:
> This warning is from an LTS branch - 4.9.95 with a couple of unrelated patches on top, but I can't find why it would have been fixed in mainline.
> 
> I think it's from the mutex_lock in drbd_main.c:conn_prepare_command(). I am not certain of the correct resolution.
> 
> It looks like I can reproduce it reliably, so if anyone has a proposed fix I can test it.

Thanks.

The issue here is:
in drbd_worker.c, wait_for_work(), we do a
for (;;) 
    prepare_to_wait(&connection->sender_work.q_wait, &wait, TASK_INTERRUPTIBLE);
    some conditions...
       maybe break;
    maybe_send_barrier()
    	if (some condition) return early;
    	mutex_lock()
	the actual send
	mutex_unlock()

    schedule();

The mutex_lock itself may want to set_current_state(),
and wait for the mutex.
The DEBUG sanity checking does not like that, for (good) reasons.

But in this case, the worst (I think) that can happen is that we wait
for the mutex, do our send, come back from maybe_send_barrier() with
task state back at TASK_RUNNING, the schedule() becomes only a schedule,
and does not wait for any event, we loop, set it back to
TASK_INTERRUPTIBLE, go one extra time through the conditions, and then
schedule with that task state for real, waiting for some "work" to wake
us up.

In my opinion, while ugly, still harmless.

A possible change would be to convert the body of our for (;;) loop
there into some wait_event() condition function.

An other possible change could be to explicitly finish_wait() early,
do tha maybe_send_barrier, and continue:

diff --git a/drbd/drbd_worker.c b/drbd/drbd_worker.c
index c23c3b073621..12586ed15f46 100644
--- a/drbd/drbd_worker.c
+++ b/drbd/drbd_worker.c
@@ -2176,9 +2176,12 @@ static void wait_for_work(struct drbd_connection *connection, struct list_head *
 			connection->send.current_epoch_nr;
 		spin_unlock_irq(&connection->resource->req_lock);
 
-		if (send_barrier)
+		if (send_barrier) {
+			finish_wait(&connection->sender_work.q_wait, &wait);
 			maybe_send_barrier(connection,
 					connection->send.current_epoch_nr + 1);
+			continue;
+		}
 
 		if (test_bit(DEVICE_WORK_PENDING, &connection->flags))
 			break;

> The below is with CONFIG_DEBUG_LOCK_ALLOC and CONFIG_DEBUG_ATOMIC_SLEEP on.
> 
> [  627.522124] ------------[ cut here ]------------
> [  627.522211] WARNING: CPU: 0 PID: 6880 at kernel/sched/core.c:7736 __might_sleep+0x80/0x90
> [  627.522308] do not call blocking ops when !TASK_RUNNING; state=1 set at [<ffffffff810fa8b0>] prepare_to_wait+0x30/0x90
> [  627.522427] Modules linked in: 8021q garp mrp nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack xt_physdev ip6table_filter ip6_tables
> xen_pciback xen_netback xen_gntdev xen_gntalloc xenfs xen_privcmd xen_evtchn xen_blkback xen_acpi_processor tun sch_htb raid456 async_raid6_recov
> async_memcpy async_pq async_xor xor async_tx raid6_pq raid10 fuse ext2 ebt_mark ebt_ip ebt_arp ebtable_nat ebtable_filter ebtables drbd lru_cache
> libcrc32c cls_fw br_netfilter bridge stp llc iTCO_wdt iTCO_vendor_support pcspkr intel_pch_thermal i2c_i801 i2c_smbus lpc_ich igb shpchp joydev fjes
> ipmi_si ipmi_msghandler mei_me mei ioatdma ixgbe mdio dca mlx4_ib ib_core mlx4_en ptp pps_core raid1 mlx4_core mxm_wmi wmi ast ttm
> [  627.523246] CPU: 0 PID: 6880 Comm: drbd_w_resource Not tainted 4.9.95+ #1
> [  627.523286] Hardware name: Supermicro Super Server/X10SDV-4C-TLN4F, BIOS 1.1c 10/03/2016
> [  627.523334]  ffffc90043ddfba8 ffffffff81432f87 ffffc90043ddfbf8 0000000000000000
> [  627.523417]  ffffc90043ddfbe8 ffffffff810ae2e1 00001e38818ef630 ffffffff81cdade8
> [  627.523476]  000000000000026c 0000000000000000 0000000000000000 0000000000000000
> [  627.523533] Call Trace:
> [  627.523560]  [<ffffffff81432f87>] dump_stack+0x63/0x8c
> [  627.523593]  [<ffffffff810ae2e1>] __warn+0xd1/0xf0
> [  627.523623]  [<ffffffff810ae34f>] warn_slowpath_fmt+0x4f/0x60
> [  627.523658]  [<ffffffff810fa8b0>] ? prepare_to_wait+0x30/0x90
> [  627.523731]  [<ffffffff810fa8b0>] ? prepare_to_wait+0x30/0x90
> [  627.523766]  [<ffffffff810da040>] __might_sleep+0x80/0x90
> [  627.523798]  [<ffffffff818eac2c>] mutex_lock_nested+0x3c/0x350
> [  627.523833]  [<ffffffff811065fa>] ? lock_release+0x26a/0x3f0
> [  627.523866]  [<ffffffff81106307>] ? lock_acquire+0xe7/0x170
> [  627.523907]  [<ffffffffc026a406>] ? wait_for_work+0x166/0x350 [drbd]
> [  627.523954]  [<ffffffffc0288afc>] conn_prepare_command+0x1c/0x60 [drbd]
> [  627.523996]  [<ffffffffc0269b1e>] drbd_send_barrier+0x1e/0x80 [drbd]
> [  627.524036]  [<ffffffffc026a4bb>] wait_for_work+0x21b/0x350 [drbd]
> [  627.524076]  [<ffffffffc026a30f>] ? wait_for_work+0x6f/0x350 [drbd]
> [  627.524112]  [<ffffffff810fad40>] ? prepare_to_wait_event+0xf0/0xf0
> [  627.524153]  [<ffffffffc026fba6>] drbd_worker+0x336/0x410 [drbd]
> [  627.524199]  [<ffffffffc0286fc0>] ? drbd_destroy_connection+0x160/0x160 [drbd]
> [  627.524245]  [<ffffffffc028701a>] drbd_thread_setup+0x5a/0x150 [drbd]
> [  627.524286]  [<ffffffffc0286fc0>] ? drbd_destroy_connection+0x160/0x160 [drbd]
> [  627.524327]  [<ffffffff810d10bf>] kthread+0x10f/0x130
> [  627.524366]  [<ffffffff810d0fb0>] ? kthread_park+0x60/0x60
> [  627.524411]  [<ffffffff81003a29>] ? do_syscall_64+0x79/0x190
> [  627.524453]  [<ffffffff818ef6b7>] ret_from_fork+0x57/0x70
> [  627.524582] ---[ end trace 72c3eb79f0bc22b8 ]---

> Thanks, Sarah

Cheers,

-- 
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD® and LINBIT® are registered trademarks of LINBIT
