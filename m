Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 476AB1011BF6
	for <drbd-dev@lists.linbit.com>; Thu, 25 Apr 2019 11:30:10 +0200 (CEST)
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x3P9U92R051880
	for <drbd-dev@lists.linbit.com>; Thu, 25 Apr 2019 18:30:09 +0900 (JST)
	(envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x3P9U901051871
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO)
	for <drbd-dev@lists.linbit.com>; Thu, 25 Apr 2019 18:30:09 +0900 (JST)
	(envelope-from penguin-kernel@i-love.sakura.ne.jp)
To: drbd-dev@lists.linbit.com
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <eec310e0-e0ca-6b18-7496-e9e3b6b29b63@i-love.sakura.ne.jp>
Date: Thu, 25 Apr 2019 18:30:05 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] Please test with CONFIG_PROVE_LOCKING=y
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

I found that simply doing

# mount /dev/drbd0 /mnt/

on the primary side causes a lockdep splat on the peer side.

[   16.930719] drbd: loading out-of-tree module taints kernel.
[   17.003845] drbd: initialized. Version: 9.0.17-1 (api:2/proto:86-114)
[   17.003849] drbd: GIT-hash: 46e8e3fc31b651fb56ea38134dcf14382fc43000 build by root@localhost.localdomain, 2019-04-24 15:26:32
[   17.003852] drbd: registered as block device major 147
[   17.031036] drbd r0: Starting worker thread (from drbdsetup [8212])
[   17.072004] drbd r0 alice: Starting sender thread (from drbdsetup [8218])
[   17.094178] drbd r0/0 drbd0: disk( Diskless -> Attaching )
[   17.094348] drbd r0/0 drbd0: Maximum number of peer devices = 1
[   17.098582] drbd r0: Method to ensure write ordering: flush
[   17.098635] drbd r0/0 drbd0: drbd_bm_resize called with capacity == 104852280
[   17.101095] drbd r0/0 drbd0: resync bitmap: bits=13106535 words=204790 pages=400
[   17.101101] drbd r0/0 drbd0: size = 50 GB (52426140 KB)
[   17.101103] drbd r0/0 drbd0: size = 50 GB (52426140 KB)
[   17.146454] drbd r0/0 drbd0: recounting of set bits took additional 1ms
[   17.146474] drbd r0/0 drbd0: disk( Attaching -> UpToDate )
[   17.146477] drbd r0/0 drbd0: attached to current UUID: 85033A04F8E8C728
[   17.151754] drbd r0 alice: conn( StandAlone -> Unconnected )
[   17.152160] drbd r0 alice: Starting receiver thread (from drbd_w_r0 [8213])
[   17.153240] drbd r0 alice: conn( Unconnected -> Connecting )
[   17.666117] drbd r0 alice: Handshake to peer 1 successful: Agreed network protocol version 114
[   17.666130] drbd r0 alice: Feature flags enabled on protocol level: 0xf TRIM THIN_RESYNC WRITE_SAME WRITE_ZEROES.
[   17.666297] drbd r0 alice: Starting ack_recv thread (from drbd_r_r0 [8237])
[   17.683576] drbd r0: Preparing cluster-wide state change 2247594057 (0->1 499/146)
[   17.684431] drbd r0: State change 2247594057: primary_nodes=0, weak_nodes=0
[   17.684436] drbd r0: Committing cluster-wide state change 2247594057 (0ms)
[   17.684450] drbd r0 alice: conn( Connecting -> Connected ) peer( Unknown -> Secondary )
[   17.701460] drbd r0/0 drbd0 alice: drbd_sync_handshake:
[   17.701471] drbd r0/0 drbd0 alice: self 85033A04F8E8C728:0000000000000000:B30C5F9909DD18EE:33CA8E1052CCCE58 bits:0 flags:20
[   17.701473] drbd r0/0 drbd0 alice: peer 85033A04F8E8C728:0000000000000000:B30C5F9909DD18EE:33CA8E1052CCCE58 bits:0 flags:120
[   17.701475] drbd r0/0 drbd0 alice: uuid_compare()=0 by rule 38
[   17.701485] drbd r0/0 drbd0 alice: pdsk( DUnknown -> UpToDate ) repl( Off -> Established )
[   22.910250] drbd r0 alice: Preparing remote state change 992752788
[   22.914015] drbd r0 alice: Committing remote state change 992752788 (primary_nodes=2)
[   22.914025] drbd r0 alice: peer( Secondary -> Primary )

[   23.039882] ========================================================
[   23.039906] WARNING: possible irq lock inversion dependency detected
[   23.039931] 5.0.0 #891 Tainted: G           O
[   23.039950] --------------------------------------------------------
[   23.039975] drbd_r_r0/8237 just changed the state of lock:
[   23.039997] 000000007cc227b6 (&(&connection->epoch_lock)->rlock){+.+.}, at: receive_Data+0x36b/0x1ca0 [drbd]
[   23.040049] but this lock was taken by another, SOFTIRQ-safe lock in the past:
[   23.040115]  (&(&resource->req_lock)->rlock){..-.}
[   23.040117]

and interrupts could create inverse lock ordering between them.

[   23.040176]
other info that might help us debug this:
[   23.040200]  Possible interrupt unsafe locking scenario:

[   23.040225]        CPU0                    CPU1
[   23.040243]        ----                    ----
[   23.040260]   lock(&(&connection->epoch_lock)->rlock);
[   23.040281]                                local_irq_disable();
[   23.040303]                                lock(&(&resource->req_lock)->rlock);
[   23.040330]                                lock(&(&connection->epoch_lock)->rlock);
[   23.040359]   <Interrupt>
[   23.040370]     lock(&(&resource->req_lock)->rlock);
[   23.040389]
 *** DEADLOCK ***

[   23.040412] no locks held by drbd_r_r0/8237.
[   23.040429]
the shortest dependencies between 2nd lock and 1st lock:
[   23.040459]  -> (&(&resource->req_lock)->rlock){..-.} ops: 270 {
[   23.041041]     IN-SOFTIRQ-W at:
[   23.041596]                       lock_acquire+0xd0/0x1f0
[   23.042142]                       _raw_spin_lock_irqsave+0x43/0x80
[   23.042700]                       drbd_request_endio+0x75/0x260 [drbd]
[   23.043269]                       bio_endio+0x15f/0x310
[   23.043810]                       blk_update_request+0xdf/0x3e0
[   23.044331]                       scsi_end_request+0x2f/0x360
[   23.044844]                       scsi_io_completion+0x89/0x5f0
[   23.045372]                       scsi_finish_command+0xd4/0x120
[   23.045885]                       scsi_softirq_done+0x140/0x160
[   23.046386]                       blk_done_softirq+0x85/0xb0
[   23.046849]                       __do_softirq+0xbe/0x455
[   23.047301]                       irq_exit+0xb7/0xc0
[   23.047734]                       smp_call_function_single_interrupt+0x16b/0x240
[   23.048190]                       call_function_single_interrupt+0xf/0x20
[   23.048654]                       _raw_spin_unlock_irq+0x29/0x40
[   23.049107]                       finish_task_switch+0x91/0x250
[   23.049551]                       __schedule+0x2a3/0x9b0
[   23.049978]                       schedule_idle+0x27/0x40
[   23.050353]                       do_idle+0x16e/0x2a0
[   23.050739]                       cpu_startup_entry+0x18/0x20
[   23.051106]                       rest_init+0x18c/0x260
[   23.051457]                       arch_call_rest_init+0x9/0xb
[   23.051832]                       start_kernel+0x497/0x4b8
[   23.052257]                       x86_64_start_reservations+0x24/0x26
[   23.052647]                       x86_64_start_kernel+0x6f/0x72
[   23.053044]                       secondary_startup_64+0xa4/0xb0
[   23.053395]     INITIAL USE at:
[   23.053759]                      lock_acquire+0xd0/0x1f0
[   23.054125]                      _raw_spin_lock_irq+0x3e/0x80
[   23.054502]                      drbd_create_device+0x682/0xb20 [drbd]
[   23.054872]                      drbd_adm_new_minor+0x118/0x330 [drbd]
[   23.055200]                      genl_family_rcv_msg+0x214/0x470
[   23.055528]                      genl_rcv_msg+0x47/0x90
[   23.055849]                      netlink_rcv_skb+0xcb/0x100
[   23.056185]                      genl_rcv+0x23/0x40
[   23.056492]                      netlink_unicast+0x17f/0x230
[   23.056782]                      netlink_sendmsg+0x2d4/0x3d0
[   23.057081]                      sock_sendmsg+0x33/0x40
[   23.057362]                      sock_write_iter+0x83/0xf0
[   23.057663]                      __vfs_write+0x117/0x1a0
[   23.057955]                      vfs_write+0xc2/0x1d0
[   23.058233]                      ksys_write+0x53/0xc0
[   23.058520]                      __x64_sys_write+0x15/0x20
[   23.058797]                      do_syscall_64+0x4a/0x180
[   23.059199]                      entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   23.059504]   }
[   23.059784]   ... key      at: [<ffffffffc07c9198>] __key.70128+0x0/0xfffffffffffe6e68 [drbd]
[   23.060080]   ... acquired at:
[   23.060342]    lock_acquire+0xd0/0x1f0
[   23.060615]    _raw_spin_lock+0x38/0x70
[   23.060872]    finish_state_change+0x987/0x17f0 [drbd]
[   23.061146]    ___end_state_change+0x166/0x4c0 [drbd]
[   23.061400]    __end_state_change+0x48/0xc0 [drbd]
[   23.061679]    change_cluster_wide_state+0x9ff/0x1290 [drbd]
[   23.061954]    change_cstate_es+0x88/0xc0 [drbd]
[   23.062217]    connect_work+0xf1/0x290 [drbd]
[   23.062508]    drbd_sender+0x1c0/0x500 [drbd]
[   23.062771]    drbd_thread_setup+0x12b/0x350 [drbd]
[   23.063044]    kthread+0x10b/0x140
[   23.063301]    ret_from_fork+0x24/0x30

[   23.063833] -> (&(&connection->epoch_lock)->rlock){+.+.} ops: 6 {
[   23.064118]    HARDIRQ-ON-W at:
[   23.064395]                     lock_acquire+0xd0/0x1f0
[   23.064666]                     _raw_spin_lock+0x38/0x70
[   23.064947]                     receive_Data+0x36b/0x1ca0 [drbd]
[   23.065197]                     drbd_receiver+0x534/0xe20 [drbd]
[   23.065456]                     drbd_thread_setup+0x12b/0x350 [drbd]
[   23.065699]                     kthread+0x10b/0x140
[   23.066018]                     ret_from_fork+0x24/0x30
[   23.066269]    SOFTIRQ-ON-W at:
[   23.066523]                     lock_acquire+0xd0/0x1f0
[   23.066768]                     _raw_spin_lock+0x38/0x70
[   23.067042]                     receive_Data+0x36b/0x1ca0 [drbd]
[   23.067295]                     drbd_receiver+0x534/0xe20 [drbd]
[   23.067563]                     drbd_thread_setup+0x12b/0x350 [drbd]
[   23.067815]                     kthread+0x10b/0x140
[   23.068080]                     ret_from_fork+0x24/0x30
[   23.068331]    INITIAL USE at:
[   23.068605]                    lock_acquire+0xd0/0x1f0
[   23.068960]                    _raw_spin_lock+0x38/0x70
[   23.069323]                    finish_state_change+0x987/0x17f0 [drbd]
[   23.069795]                    ___end_state_change+0x166/0x4c0 [drbd]
[   23.070077]                    __end_state_change+0x48/0xc0 [drbd]
[   23.070323]                    change_cluster_wide_state+0x9ff/0x1290 [drbd]
[   23.070591]                    change_cstate_es+0x88/0xc0 [drbd]
[   23.070857]                    connect_work+0xf1/0x290 [drbd]
[   23.071106]                    drbd_sender+0x1c0/0x500 [drbd]
[   23.071369]                    drbd_thread_setup+0x12b/0x350 [drbd]
[   23.071616]                    kthread+0x10b/0x140
[   23.071874]                    ret_from_fork+0x24/0x30
[   23.072117]  }
[   23.072367]  ... key      at: [<ffffffffc07c9130>] __key.70143+0x0/0xfffffffffffe6ed0 [drbd]
[   23.072630]  ... acquired at:
[   23.072955]    mark_lock+0x190/0x2a0
[   23.073205]    __lock_acquire+0x270/0x1220
[   23.073464]    lock_acquire+0xd0/0x1f0
[   23.073702]    _raw_spin_lock+0x38/0x70
[   23.073950]    receive_Data+0x36b/0x1ca0 [drbd]
[   23.074185]    drbd_receiver+0x534/0xe20 [drbd]
[   23.074430]    drbd_thread_setup+0x12b/0x350 [drbd]
[   23.074665]    kthread+0x10b/0x140
[   23.074904]    ret_from_fork+0x24/0x30

[   23.075367]
stack backtrace:
[   23.075812] CPU: 0 PID: 8237 Comm: drbd_r_r0 Tainted: G           O      5.0.0 #891
[   23.076042] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
[   23.076763] Call Trace:
[   23.077015]  dump_stack+0x67/0x95
[   23.077259]  print_irq_inversion_bug.part.37+0x1ac/0x1b8
[   23.077516]  check_usage_backwards+0x12b/0x140
[   23.077758]  ? print_shortest_lock_dependencies+0x210/0x210
[   23.078023]  mark_lock+0x190/0x2a0
[   23.078267]  __lock_acquire+0x270/0x1220
[   23.078528]  lock_acquire+0xd0/0x1f0
[   23.078813]  ? receive_Data+0x36b/0x1ca0 [drbd]
[   23.079075]  _raw_spin_lock+0x38/0x70
[   23.079340]  ? receive_Data+0x36b/0x1ca0 [drbd]
[   23.079590]  receive_Data+0x36b/0x1ca0 [drbd]
[   23.079970]  ? dtt_recv+0xef/0x280 [drbd_transport_tcp]
[   23.080221]  ? drbd_recv+0x3e/0x420 [drbd]
[   23.080497]  drbd_receiver+0x534/0xe20 [drbd]
[   23.080746]  ? drbd_receiver+0x30c/0xe20 [drbd]
[   23.081008]  ? sched_clock+0x9/0x10
[   23.081269]  drbd_thread_setup+0x12b/0x350 [drbd]
[   23.081520]  kthread+0x10b/0x140
[   23.081786]  ? _drbd_send_bio+0x240/0x240 [drbd]
[   23.082032]  ? kthread_cancel_delayed_work_sync+0x10/0x10
[   23.082286]  ret_from_fork+0x24/0x30

Although making below change seems to solve the lockdep splat,
I can't check the correctness because I don't know how drbd works.
Please test with CONFIG_PROVE_LOCKING=y and fix.

---
 drbd/drbd_receiver.c | 24 ++++++++++++++----------
 drbd/drbd_state.c    |  5 +++--
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index ccbaad9f..24d1733b 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -86,11 +86,12 @@ static void destroy_peer_ack_req(struct kref *kref);
 static struct drbd_epoch *previous_epoch(struct drbd_connection *connection, struct drbd_epoch *epoch)
 {
 	struct drbd_epoch *prev;
-	spin_lock(&connection->epoch_lock);
+	unsigned long flags;
+	spin_lock_irqsave(&connection->epoch_lock, flags);
 	prev = list_entry(epoch->list.prev, struct drbd_epoch, list);
 	if (prev == epoch || prev == connection->current_epoch)
 		prev = NULL;
-	spin_unlock(&connection->epoch_lock);
+	spin_unlock_irqrestore(&connection->epoch_lock, flags);
 	return prev;
 }
 
@@ -1189,8 +1190,9 @@ static enum finish_epoch drbd_may_finish_epoch(struct drbd_connection *connectio
 	int schedule_flush = 0;
 	enum finish_epoch rv = FE_STILL_LIVE;
 	struct drbd_resource *resource = connection->resource;
+	unsigned long flags;
 
-	spin_lock(&connection->epoch_lock);
+	spin_lock_irqsave(&connection->epoch_lock, flags);
 	do {
 		next_epoch = NULL;
 		finish = 0;
@@ -1241,9 +1243,9 @@ static enum finish_epoch drbd_may_finish_epoch(struct drbd_connection *connectio
 			if (!(ev & EV_CLEANUP)) {
 				/* adjust for nr requests already confirmed via P_CONFIRM_STABLE, if any. */
 				epoch_size -= atomic_read(&epoch->confirmed);
-				spin_unlock(&connection->epoch_lock);
+				spin_unlock_irqrestore(&connection->epoch_lock, flags);
 				drbd_send_b_ack(epoch->connection, epoch->barrier_nr, epoch_size);
-				spin_lock(&connection->epoch_lock);
+				spin_lock_irqsave(&connection->epoch_lock, flags);
 			}
 #if 0
 			/* FIXME: dec unacked on connection, once we have
@@ -1278,7 +1280,7 @@ static enum finish_epoch drbd_may_finish_epoch(struct drbd_connection *connectio
 		epoch = next_epoch;
 	} while (1);
 
-	spin_unlock(&connection->epoch_lock);
+	spin_unlock_irqrestore(&connection->epoch_lock, flags);
 
 	if (schedule_flush) {
 		struct flush_work *fw;
@@ -1808,6 +1810,7 @@ static int receive_Barrier(struct drbd_connection *connection, struct packet_inf
 	int rv, issue_flush;
 	struct p_barrier *p = pi->data;
 	struct drbd_epoch *epoch;
+	unsigned long flags;
 
 	tr_ops->hint(&connection->transport, DATA_STREAM, QUICKACK);
 	drbd_unplug_all_devices(connection);
@@ -1865,7 +1868,7 @@ static int receive_Barrier(struct drbd_connection *connection, struct packet_inf
 		return 0;
 	}
 
-	spin_lock(&connection->epoch_lock);
+	spin_lock_irqsave(&connection->epoch_lock, flags);
 	if (atomic_read(&connection->current_epoch->epoch_size)) {
 		list_add(&epoch->list, &connection->current_epoch->list);
 		connection->current_epoch = epoch;
@@ -1874,7 +1877,7 @@ static int receive_Barrier(struct drbd_connection *connection, struct packet_inf
 		/* The current_epoch got recycled while we allocated this one... */
 		kfree(epoch);
 	}
-	spin_unlock(&connection->epoch_lock);
+	spin_unlock_irqrestore(&connection->epoch_lock, flags);
 
 	return 0;
 }
@@ -2784,6 +2787,7 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 	struct drbd_peer_request_details d;
 	int op, op_flags;
 	int err, tp;
+	unsigned long flags;
 
 	peer_device = conn_peer_device(connection, pi->vnr);
 	if (!peer_device)
@@ -2883,7 +2887,7 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 	 */
 	op_flags &= ~DRBD_REQ_HARDBARRIER;
 
-	spin_lock(&connection->epoch_lock);
+	spin_lock_irqsave(&connection->epoch_lock, flags);
 	peer_req->epoch = connection->current_epoch;
 	atomic_inc(&peer_req->epoch->epoch_size);
 	atomic_inc(&peer_req->epoch->active);
@@ -2911,7 +2915,7 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 			}
 		}
 	}
-	spin_unlock(&connection->epoch_lock);
+	spin_unlock_irqrestore(&connection->epoch_lock, flags);
 
 	rcu_read_lock();
 	nc = rcu_dereference(connection->transport.net_conf);
diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
index 7b1deda2..52a29461 100644
--- a/drbd/drbd_state.c
+++ b/drbd/drbd_state.c
@@ -2430,11 +2430,12 @@ static void finish_state_change(struct drbd_resource *resource, struct completio
 				if (connection->epochs != 1)
 					some_peer_request_in_flight = true;
 				else if (!some_peer_request_in_flight) {
-					spin_lock(&connection->epoch_lock);
+					unsigned long flags;
+					spin_lock_irqsave(&connection->epoch_lock, flags);
 					if (connection->epochs != 1 ||
 					    atomic_read(&connection->current_epoch->epoch_size) != 0)
 						some_peer_request_in_flight = true;
-					spin_unlock(&connection->epoch_lock);
+					spin_unlock_irqrestore(&connection->epoch_lock, flags);
 				}
 				break;
 			case C_STANDALONE:
-- 
2.16.5
