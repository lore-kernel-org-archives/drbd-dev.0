Return-Path: <BATV+ddbc6e1cf1a82b64ebec+5561+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4944D101E041
	for <drbd-dev@lists.linbit.com>; Wed, 14 Nov 2018 17:34:33 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 14 Nov 2018 17:02:19 +0100
Message-Id: <20181114160219.28328-17-hch@lst.de>
In-Reply-To: <20181114160219.28328-1-hch@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 16/16] block: remove the queue_lock indirection
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

With the legacy request path gone there is no good reason to keep
queue_lock as a pointer, we can always use the embedded lock now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bfq-cgroup.c      |  2 +-
 block/bfq-iosched.c     | 16 +++++------
 block/blk-cgroup.c      | 60 ++++++++++++++++++++---------------------
 block/blk-core.c        | 10 +------
 block/blk-ioc.c         | 14 +++++-----
 block/blk-iolatency.c   |  4 +--
 block/blk-mq-sched.c    |  4 +--
 block/blk-pm.c          | 20 +++++++-------
 block/blk-pm.h          |  6 ++---
 block/blk-sysfs.c       |  4 +--
 block/blk-throttle.c    | 22 +++++++--------
 drivers/block/pktcdvd.c |  4 +--
 drivers/ide/ide-pm.c    | 10 +++----
 include/linux/blkdev.h  |  8 +-----
 14 files changed, 85 insertions(+), 99 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 9fe5952d117d..a7a1712632b0 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -334,7 +334,7 @@ static void bfqg_stats_xfer_dead(struct bfq_group *bfqg)
 
 	parent = bfqg_parent(bfqg);
 
-	lockdep_assert_held(bfqg_to_blkg(bfqg)->q->queue_lock);
+	lockdep_assert_held(&bfqg_to_blkg(bfqg)->q->queue_lock);
 
 	if (unlikely(!parent))
 		return;
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index c7636cbefc85..67b22c924aee 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -399,9 +399,9 @@ static struct bfq_io_cq *bfq_bic_lookup(struct bfq_data *bfqd,
 		unsigned long flags;
 		struct bfq_io_cq *icq;
 
-		spin_lock_irqsave(q->queue_lock, flags);
+		spin_lock_irqsave(&q->queue_lock, flags);
 		icq = icq_to_bic(ioc_lookup_icq(ioc, q));
-		spin_unlock_irqrestore(q->queue_lock, flags);
+		spin_unlock_irqrestore(&q->queue_lock, flags);
 
 		return icq;
 	}
@@ -4034,7 +4034,7 @@ static void bfq_update_dispatch_stats(struct request_queue *q,
 	 * In addition, the following queue lock guarantees that
 	 * bfqq_group(bfqq) exists as well.
 	 */
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(&q->queue_lock);
 	if (idle_timer_disabled)
 		/*
 		 * Since the idle timer has been disabled,
@@ -4053,7 +4053,7 @@ static void bfq_update_dispatch_stats(struct request_queue *q,
 		bfqg_stats_set_start_empty_time(bfqg);
 		bfqg_stats_update_io_remove(bfqg, rq->cmd_flags);
 	}
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&q->queue_lock);
 }
 #else
 static inline void bfq_update_dispatch_stats(struct request_queue *q,
@@ -4637,11 +4637,11 @@ static void bfq_update_insert_stats(struct request_queue *q,
 	 * In addition, the following queue lock guarantees that
 	 * bfqq_group(bfqq) exists as well.
 	 */
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(&q->queue_lock);
 	bfqg_stats_update_io_add(bfqq_group(bfqq), bfqq, cmd_flags);
 	if (idle_timer_disabled)
 		bfqg_stats_update_idle_time(bfqq_group(bfqq));
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&q->queue_lock);
 }
 #else
 static inline void bfq_update_insert_stats(struct request_queue *q,
@@ -5382,9 +5382,9 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	}
 	eq->elevator_data = bfqd;
 
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(&q->queue_lock);
 	q->elevator = eq;
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&q->queue_lock);
 
 	/*
 	 * Our fallback bfqq if bfq_find_alloc_queue() runs into OOM issues.
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3ba23b9bfeb9..fa540f1cb9e0 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -147,7 +147,7 @@ struct blkcg_gq *blkg_lookup_slowpath(struct blkcg *blkcg,
 	blkg = radix_tree_lookup(&blkcg->blkg_tree, q->id);
 	if (blkg && blkg->q == q) {
 		if (update_hint) {
-			lockdep_assert_held(q->queue_lock);
+			lockdep_assert_held(&q->queue_lock);
 			rcu_assign_pointer(blkcg->blkg_hint, blkg);
 		}
 		return blkg;
@@ -170,7 +170,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 	int i, ret;
 
 	WARN_ON_ONCE(!rcu_read_lock_held());
-	lockdep_assert_held(q->queue_lock);
+	lockdep_assert_held(&q->queue_lock);
 
 	/* blkg holds a reference to blkcg */
 	if (!css_tryget_online(&blkcg->css)) {
@@ -268,7 +268,7 @@ struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 	struct blkcg_gq *blkg;
 
 	WARN_ON_ONCE(!rcu_read_lock_held());
-	lockdep_assert_held(q->queue_lock);
+	lockdep_assert_held(&q->queue_lock);
 
 	blkg = __blkg_lookup(blkcg, q, true);
 	if (blkg)
@@ -299,7 +299,7 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	struct blkcg_gq *parent = blkg->parent;
 	int i;
 
-	lockdep_assert_held(blkg->q->queue_lock);
+	lockdep_assert_held(&blkg->q->queue_lock);
 	lockdep_assert_held(&blkcg->lock);
 
 	/* Something wrong if we are trying to remove same group twice */
@@ -349,7 +349,7 @@ static void blkg_destroy_all(struct request_queue *q)
 {
 	struct blkcg_gq *blkg, *n;
 
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(&q->queue_lock);
 	list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
 
@@ -359,7 +359,7 @@ static void blkg_destroy_all(struct request_queue *q)
 	}
 
 	q->root_blkg = NULL;
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&q->queue_lock);
 }
 
 /*
@@ -454,10 +454,10 @@ void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
-		spin_lock_irq(blkg->q->queue_lock);
+		spin_lock_irq(&blkg->q->queue_lock);
 		if (blkcg_policy_enabled(blkg->q, pol))
 			total += prfill(sf, blkg->pd[pol->plid], data);
-		spin_unlock_irq(blkg->q->queue_lock);
+		spin_unlock_irq(&blkg->q->queue_lock);
 	}
 	rcu_read_unlock();
 
@@ -655,7 +655,7 @@ u64 blkg_stat_recursive_sum(struct blkcg_gq *blkg,
 	struct cgroup_subsys_state *pos_css;
 	u64 sum = 0;
 
-	lockdep_assert_held(blkg->q->queue_lock);
+	lockdep_assert_held(&blkg->q->queue_lock);
 
 	rcu_read_lock();
 	blkg_for_each_descendant_pre(pos_blkg, pos_css, blkg) {
@@ -698,7 +698,7 @@ struct blkg_rwstat blkg_rwstat_recursive_sum(struct blkcg_gq *blkg,
 	struct blkg_rwstat sum = { };
 	int i;
 
-	lockdep_assert_held(blkg->q->queue_lock);
+	lockdep_assert_held(&blkg->q->queue_lock);
 
 	rcu_read_lock();
 	blkg_for_each_descendant_pre(pos_blkg, pos_css, blkg) {
@@ -729,7 +729,7 @@ static struct blkcg_gq *blkg_lookup_check(struct blkcg *blkcg,
 					  struct request_queue *q)
 {
 	WARN_ON_ONCE(!rcu_read_lock_held());
-	lockdep_assert_held(q->queue_lock);
+	lockdep_assert_held(&q->queue_lock);
 
 	if (!blkcg_policy_enabled(q, pol))
 		return ERR_PTR(-EOPNOTSUPP);
@@ -750,7 +750,7 @@ static struct blkcg_gq *blkg_lookup_check(struct blkcg *blkcg,
  */
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   char *input, struct blkg_conf_ctx *ctx)
-	__acquires(rcu) __acquires(disk->queue->queue_lock)
+	__acquires(rcu) __acquires(&disk->queue->queue_lock)
 {
 	struct gendisk *disk;
 	struct request_queue *q;
@@ -778,7 +778,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	q = disk->queue;
 
 	rcu_read_lock();
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(&q->queue_lock);
 
 	blkg = blkg_lookup_check(blkcg, pol, q);
 	if (IS_ERR(blkg)) {
@@ -805,7 +805,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		}
 
 		/* Drop locks to do new blkg allocation with GFP_KERNEL. */
-		spin_unlock_irq(q->queue_lock);
+		spin_unlock_irq(&q->queue_lock);
 		rcu_read_unlock();
 
 		new_blkg = blkg_alloc(pos, q, GFP_KERNEL);
@@ -815,7 +815,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		}
 
 		rcu_read_lock();
-		spin_lock_irq(q->queue_lock);
+		spin_lock_irq(&q->queue_lock);
 
 		blkg = blkg_lookup_check(pos, pol, q);
 		if (IS_ERR(blkg)) {
@@ -843,7 +843,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	return 0;
 
 fail_unlock:
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&q->queue_lock);
 	rcu_read_unlock();
 fail:
 	put_disk_and_module(disk);
@@ -868,9 +868,9 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
  * with blkg_conf_prep().
  */
 void blkg_conf_finish(struct blkg_conf_ctx *ctx)
-	__releases(ctx->disk->queue->queue_lock) __releases(rcu)
+	__releases(&ctx->disk->queue->queue_lock) __releases(rcu)
 {
-	spin_unlock_irq(ctx->disk->queue->queue_lock);
+	spin_unlock_irq(&ctx->disk->queue->queue_lock);
 	rcu_read_unlock();
 	put_disk_and_module(ctx->disk);
 }
@@ -903,7 +903,7 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 		 */
 		off += scnprintf(buf+off, size-off, "%s ", dname);
 
-		spin_lock_irq(blkg->q->queue_lock);
+		spin_lock_irq(&blkg->q->queue_lock);
 
 		rwstat = blkg_rwstat_recursive_sum(blkg, NULL,
 					offsetof(struct blkcg_gq, stat_bytes));
@@ -917,7 +917,7 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 		wios = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_WRITE]);
 		dios = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_DISCARD]);
 
-		spin_unlock_irq(blkg->q->queue_lock);
+		spin_unlock_irq(&blkg->q->queue_lock);
 
 		if (rbytes || wbytes || rios || wios) {
 			has_stats = true;
@@ -1038,7 +1038,7 @@ void blkcg_destroy_blkgs(struct blkcg *blkcg)
 						struct blkcg_gq, blkcg_node);
 		struct request_queue *q = blkg->q;
 
-		if (spin_trylock(q->queue_lock)) {
+		if (spin_trylock(&q->queue_lock)) {
 			blkg_destroy(blkg);
 			spin_unlock(q->queue_lock);
 		} else {
@@ -1161,12 +1161,12 @@ int blkcg_init_queue(struct request_queue *q)
 
 	/* Make sure the root blkg exists. */
 	rcu_read_lock();
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(&q->queue_lock);
 	blkg = blkg_create(&blkcg_root, q, new_blkg);
 	if (IS_ERR(blkg))
 		goto err_unlock;
 	q->root_blkg = blkg;
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&q->queue_lock);
 	rcu_read_unlock();
 
 	if (preloaded)
@@ -1185,7 +1185,7 @@ int blkcg_init_queue(struct request_queue *q)
 	blkg_destroy_all(q);
 	return ret;
 err_unlock:
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&q->queue_lock);
 	rcu_read_unlock();
 	if (preloaded)
 		radix_tree_preload_end();
@@ -1200,7 +1200,7 @@ int blkcg_init_queue(struct request_queue *q)
  */
 void blkcg_drain_queue(struct request_queue *q)
 {
-	lockdep_assert_held(q->queue_lock);
+	lockdep_assert_held(&q->queue_lock);
 
 	/*
 	 * @q could be exiting and already have destroyed all blkgs as
@@ -1335,7 +1335,7 @@ int blkcg_activate_policy(struct request_queue *q,
 		}
 	}
 
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(&q->queue_lock);
 
 	list_for_each_entry(blkg, &q->blkg_list, q_node) {
 		struct blkg_policy_data *pd;
@@ -1347,7 +1347,7 @@ int blkcg_activate_policy(struct request_queue *q,
 		if (!pd)
 			swap(pd, pd_prealloc);
 		if (!pd) {
-			spin_unlock_irq(q->queue_lock);
+			spin_unlock_irq(&q->queue_lock);
 			goto pd_prealloc;
 		}
 
@@ -1361,7 +1361,7 @@ int blkcg_activate_policy(struct request_queue *q,
 	__set_bit(pol->plid, q->blkcg_pols);
 	ret = 0;
 
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&q->queue_lock);
 out_bypass_end:
 	if (q->mq_ops)
 		blk_mq_unfreeze_queue(q);
@@ -1390,7 +1390,7 @@ void blkcg_deactivate_policy(struct request_queue *q,
 	if (q->mq_ops)
 		blk_mq_freeze_queue(q);
 
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(&q->queue_lock);
 
 	__clear_bit(pol->plid, q->blkcg_pols);
 
@@ -1403,7 +1403,7 @@ void blkcg_deactivate_policy(struct request_queue *q,
 		}
 	}
 
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&q->queue_lock);
 
 	if (q->mq_ops)
 		blk_mq_unfreeze_queue(q);
diff --git a/block/blk-core.c b/block/blk-core.c
index 3f94c9de0252..92b6b200e9fb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -327,8 +327,6 @@ void blk_exit_queue(struct request_queue *q)
  */
 void blk_cleanup_queue(struct request_queue *q)
 {
-	spinlock_t *lock = q->queue_lock;
-
 	/* mark @q DYING, no new request or merges will be allowed afterwards */
 	mutex_lock(&q->sysfs_lock);
 	blk_set_queue_dying(q);
@@ -381,11 +379,6 @@ void blk_cleanup_queue(struct request_queue *q)
 
 	percpu_ref_exit(&q->q_usage_counter);
 
-	spin_lock_irq(lock);
-	if (q->queue_lock != &q->__queue_lock)
-		q->queue_lock = &q->__queue_lock;
-	spin_unlock_irq(lock);
-
 	/* @q is and will stay empty, shutdown and put */
 	blk_put_queue(q);
 }
@@ -524,8 +517,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	mutex_init(&q->blk_trace_mutex);
 #endif
 	mutex_init(&q->sysfs_lock);
-	spin_lock_init(&q->__queue_lock);
-	q->queue_lock = &q->__queue_lock;
+	spin_lock_init(&q->queue_lock);
 
 	init_waitqueue_head(&q->mq_freeze_wq);
 
diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index f91ca6b70d6a..5ed59ac6ae58 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -110,9 +110,9 @@ static void ioc_release_fn(struct work_struct *work)
 						struct io_cq, ioc_node);
 		struct request_queue *q = icq->q;
 
-		if (spin_trylock(q->queue_lock)) {
+		if (spin_trylock(&q->queue_lock)) {
 			ioc_destroy_icq(icq);
-			spin_unlock(q->queue_lock);
+			spin_unlock(&q->queue_lock);
 		} else {
 			spin_unlock_irqrestore(&ioc->lock, flags);
 			cpu_relax();
@@ -233,9 +233,9 @@ void ioc_clear_queue(struct request_queue *q)
 {
 	LIST_HEAD(icq_list);
 
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(&q->queue_lock);
 	list_splice_init(&q->icq_list, &icq_list);
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&q->queue_lock);
 
 	__ioc_clear_queue(&icq_list);
 }
@@ -326,7 +326,7 @@ struct io_cq *ioc_lookup_icq(struct io_context *ioc, struct request_queue *q)
 {
 	struct io_cq *icq;
 
-	lockdep_assert_held(q->queue_lock);
+	lockdep_assert_held(&q->queue_lock);
 
 	/*
 	 * icq's are indexed from @ioc using radix tree and hint pointer,
@@ -385,7 +385,7 @@ struct io_cq *ioc_create_icq(struct io_context *ioc, struct request_queue *q,
 	INIT_HLIST_NODE(&icq->ioc_node);
 
 	/* lock both q and ioc and try to link @icq */
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(&q->queue_lock);
 	spin_lock(&ioc->lock);
 
 	if (likely(!radix_tree_insert(&ioc->icq_tree, q->id, icq))) {
@@ -401,7 +401,7 @@ struct io_cq *ioc_create_icq(struct io_context *ioc, struct request_queue *q,
 	}
 
 	spin_unlock(&ioc->lock);
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&q->queue_lock);
 	radix_tree_preload_end();
 	return icq;
 }
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 8edf1b353ad1..5f7f1773be61 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -485,11 +485,11 @@ static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio)
 	bio_associate_blkcg(bio, &blkcg->css);
 	blkg = blkg_lookup(blkcg, q);
 	if (unlikely(!blkg)) {
-		spin_lock_irq(q->queue_lock);
+		spin_lock_irq(&q->queue_lock);
 		blkg = blkg_lookup_create(blkcg, q);
 		if (IS_ERR(blkg))
 			blkg = NULL;
-		spin_unlock_irq(q->queue_lock);
+		spin_unlock_irq(&q->queue_lock);
 	}
 	if (!blkg)
 		goto out;
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 66fda19be5a3..d084f731d104 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -37,9 +37,9 @@ void blk_mq_sched_assign_ioc(struct request *rq, struct bio *bio)
 	struct io_context *ioc = rq_ioc(bio);
 	struct io_cq *icq;
 
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(&q->queue_lock);
 	icq = ioc_lookup_icq(ioc, q);
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&q->queue_lock);
 
 	if (!icq) {
 		icq = ioc_create_icq(ioc, q, GFP_ATOMIC);
diff --git a/block/blk-pm.c b/block/blk-pm.c
index f8fdae01bea2..0a028c189897 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -89,12 +89,12 @@ int blk_pre_runtime_suspend(struct request_queue *q)
 	/* Switch q_usage_counter back to per-cpu mode. */
 	blk_mq_unfreeze_queue(q);
 
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(&q->queue_lock);
 	if (ret < 0)
 		pm_runtime_mark_last_busy(q->dev);
 	else
 		q->rpm_status = RPM_SUSPENDING;
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&q->queue_lock);
 
 	if (ret)
 		blk_clear_pm_only(q);
@@ -121,14 +121,14 @@ void blk_post_runtime_suspend(struct request_queue *q, int err)
 	if (!q->dev)
 		return;
 
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(&q->queue_lock);
 	if (!err) {
 		q->rpm_status = RPM_SUSPENDED;
 	} else {
 		q->rpm_status = RPM_ACTIVE;
 		pm_runtime_mark_last_busy(q->dev);
 	}
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&q->queue_lock);
 
 	if (err)
 		blk_clear_pm_only(q);
@@ -151,9 +151,9 @@ void blk_pre_runtime_resume(struct request_queue *q)
 	if (!q->dev)
 		return;
 
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(&q->queue_lock);
 	q->rpm_status = RPM_RESUMING;
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&q->queue_lock);
 }
 EXPORT_SYMBOL(blk_pre_runtime_resume);
 
@@ -176,7 +176,7 @@ void blk_post_runtime_resume(struct request_queue *q, int err)
 	if (!q->dev)
 		return;
 
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(&q->queue_lock);
 	if (!err) {
 		q->rpm_status = RPM_ACTIVE;
 		pm_runtime_mark_last_busy(q->dev);
@@ -184,7 +184,7 @@ void blk_post_runtime_resume(struct request_queue *q, int err)
 	} else {
 		q->rpm_status = RPM_SUSPENDED;
 	}
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&q->queue_lock);
 
 	if (!err)
 		blk_clear_pm_only(q);
@@ -207,10 +207,10 @@ EXPORT_SYMBOL(blk_post_runtime_resume);
  */
 void blk_set_runtime_active(struct request_queue *q)
 {
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(&q->queue_lock);
 	q->rpm_status = RPM_ACTIVE;
 	pm_runtime_mark_last_busy(q->dev);
 	pm_request_autosuspend(q->dev);
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&q->queue_lock);
 }
 EXPORT_SYMBOL(blk_set_runtime_active);
diff --git a/block/blk-pm.h b/block/blk-pm.h
index a8564ea72a41..ea5507d23e75 100644
--- a/block/blk-pm.h
+++ b/block/blk-pm.h
@@ -21,7 +21,7 @@ static inline void blk_pm_mark_last_busy(struct request *rq)
 
 static inline void blk_pm_requeue_request(struct request *rq)
 {
-	lockdep_assert_held(rq->q->queue_lock);
+	lockdep_assert_held(&rq->q->queue_lock);
 
 	if (rq->q->dev && !(rq->rq_flags & RQF_PM))
 		rq->q->nr_pending--;
@@ -30,7 +30,7 @@ static inline void blk_pm_requeue_request(struct request *rq)
 static inline void blk_pm_add_request(struct request_queue *q,
 				      struct request *rq)
 {
-	lockdep_assert_held(q->queue_lock);
+	lockdep_assert_held(&q->queue_lock);
 
 	if (q->dev && !(rq->rq_flags & RQF_PM))
 		q->nr_pending++;
@@ -38,7 +38,7 @@ static inline void blk_pm_add_request(struct request_queue *q,
 
 static inline void blk_pm_put_request(struct request *rq)
 {
-	lockdep_assert_held(rq->q->queue_lock);
+	lockdep_assert_held(&rq->q->queue_lock);
 
 	if (rq->q->dev && !(rq->rq_flags & RQF_PM))
 		--rq->q->nr_pending;
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 22fd086eba9f..1e370207a20e 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -238,10 +238,10 @@ queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
 	if (max_sectors_kb > max_hw_sectors_kb || max_sectors_kb < page_kb)
 		return -EINVAL;
 
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(&q->queue_lock);
 	q->limits.max_sectors = max_sectors_kb << 1;
 	q->backing_dev_info->io_pages = max_sectors_kb >> (PAGE_SHIFT - 10);
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&q->queue_lock);
 
 	return ret;
 }
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index a665b0950369..d0a23f0bb3ed 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1243,7 +1243,7 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 	bool dispatched;
 	int ret;
 
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(&q->queue_lock);
 	if (throtl_can_upgrade(td, NULL))
 		throtl_upgrade_state(td);
 
@@ -1266,9 +1266,9 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 			break;
 
 		/* this dispatch windows is still open, relax and repeat */
-		spin_unlock_irq(q->queue_lock);
+		spin_unlock_irq(&q->queue_lock);
 		cpu_relax();
-		spin_lock_irq(q->queue_lock);
+		spin_lock_irq(&q->queue_lock);
 	}
 
 	if (!dispatched)
@@ -1290,7 +1290,7 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 		queue_work(kthrotld_workqueue, &td->dispatch_work);
 	}
 out_unlock:
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&q->queue_lock);
 }
 
 /**
@@ -1314,11 +1314,11 @@ static void blk_throtl_dispatch_work_fn(struct work_struct *work)
 
 	bio_list_init(&bio_list_on_stack);
 
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(&q->queue_lock);
 	for (rw = READ; rw <= WRITE; rw++)
 		while ((bio = throtl_pop_queued(&td_sq->queued[rw], NULL)))
 			bio_list_add(&bio_list_on_stack, bio);
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&q->queue_lock);
 
 	if (!bio_list_empty(&bio_list_on_stack)) {
 		blk_start_plug(&plug);
@@ -2141,7 +2141,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	if (bio_flagged(bio, BIO_THROTTLED) || !tg->has_rules[rw])
 		goto out;
 
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(&q->queue_lock);
 
 	throtl_update_latency_buckets(td);
 
@@ -2224,7 +2224,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	}
 
 out_unlock:
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&q->queue_lock);
 out:
 	bio_set_flag(bio, BIO_THROTTLED);
 
@@ -2345,7 +2345,7 @@ static void tg_drain_bios(struct throtl_service_queue *parent_sq)
  * Dispatch all currently throttled bios on @q through ->make_request_fn().
  */
 void blk_throtl_drain(struct request_queue *q)
-	__releases(q->queue_lock) __acquires(q->queue_lock)
+	__releases(&q->queue_lock) __acquires(&q->queue_lock)
 {
 	struct throtl_data *td = q->td;
 	struct blkcg_gq *blkg;
@@ -2368,7 +2368,7 @@ void blk_throtl_drain(struct request_queue *q)
 	tg_drain_bios(&td->service_queue);
 
 	rcu_read_unlock();
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&q->queue_lock);
 
 	/* all bios now should be in td->service_queue, issue them */
 	for (rw = READ; rw <= WRITE; rw++)
@@ -2376,7 +2376,7 @@ void blk_throtl_drain(struct request_queue *q)
 						NULL)))
 			generic_make_request(bio);
 
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(&q->queue_lock);
 }
 
 int blk_throtl_init(struct request_queue *q)
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 9381f4e3b221..4adf4c8861cd 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2203,9 +2203,9 @@ static int pkt_open_dev(struct pktcdvd_device *pd, fmode_t write)
 		 * Some CDRW drives can not handle writes larger than one packet,
 		 * even if the size is a multiple of the packet size.
 		 */
-		spin_lock_irq(q->queue_lock);
+		spin_lock_irq(&q->queue_lock);
 		blk_queue_max_hw_sectors(q, pd->settings.size);
-		spin_unlock_irq(q->queue_lock);
+		spin_unlock_irq(&q->queue_lock);
 		set_bit(PACKET_WRITABLE, &pd->flags);
 	} else {
 		pkt_set_speed(pd, MAX_SPEED, MAX_SPEED);
diff --git a/drivers/ide/ide-pm.c b/drivers/ide/ide-pm.c
index a8c53c98252d..51fe10ac02fa 100644
--- a/drivers/ide/ide-pm.c
+++ b/drivers/ide/ide-pm.c
@@ -44,15 +44,15 @@ static int ide_pm_execute_rq(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(&q->queue_lock);
 	if (unlikely(blk_queue_dying(q))) {
 		rq->rq_flags |= RQF_QUIET;
 		scsi_req(rq)->result = -ENXIO;
-		spin_unlock_irq(q->queue_lock);
+		spin_unlock_irq(&q->queue_lock);
 		blk_mq_end_request(rq, BLK_STS_OK);
 		return -ENXIO;
 	}
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&q->queue_lock);
 	blk_execute_rq(q, NULL, rq, true);
 
 	return scsi_req(rq)->result ? -EIO : 0;
@@ -214,12 +214,12 @@ void ide_complete_pm_rq(ide_drive_t *drive, struct request *rq)
 	printk("%s: completing PM request, %s\n", drive->name,
 	       (ide_req(rq)->type == ATA_PRIV_PM_SUSPEND) ? "suspend" : "resume");
 #endif
-	spin_lock_irqsave(q->queue_lock, flags);
+	spin_lock_irqsave(&q->queue_lock, flags);
 	if (ide_req(rq)->type == ATA_PRIV_PM_SUSPEND)
 		blk_mq_stop_hw_queues(q);
 	else
 		drive->dev_flags &= ~IDE_DFLAG_BLOCKED;
-	spin_unlock_irqrestore(q->queue_lock, flags);
+	spin_unlock_irqrestore(&q->queue_lock, flags);
 
 	drive->hwif->rq = NULL;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 666c73b97b0d..7019360635d8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -446,13 +446,7 @@ struct request_queue {
 	 */
 	gfp_t			bounce_gfp;
 
-	/*
-	 * protects queue structures from reentrancy. ->__queue_lock should
-	 * _never_ be used directly, it is queue private. always use
-	 * ->queue_lock.
-	 */
-	spinlock_t		__queue_lock;
-	spinlock_t		*queue_lock;
+	spinlock_t		queue_lock;
 
 	/*
 	 * queue kobject
-- 
2.19.1

