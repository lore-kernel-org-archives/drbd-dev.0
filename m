Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3F05F1055F57
	for <drbd-dev@lists.linbit.com>; Thu,  6 Dec 2012 13:26:13 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu, 06 Dec 2012 13:26:12 +0100
Message-ID: <1885288.8qXv8iGatm@fat-tyre>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [GIT PULL] drbd Kconfig update and minor fixes
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

The following changes since commit 84ad6845fbb1248228d3beab8084e4b5f6f82b1d:

  Merge branch 'stable/for-jens-3.8' of git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen into for-3.8/drivers (2012-12-01 09:42:41 +0100)

are available in the git repository at:


  git://git.drbd.org/linux-drbd.git for-jens

for you to fetch changes up to d2ec180c23a5a1bfe34d8638b0342a47c00cf70f:

  drbd: update Kconfig to match current dependencies (2012-12-06 13:08:29 +0100)

----------------------------------------------------------------
Lars Ellenberg (2):
      drbd: respect no-md-barriers setting also when changed online via disk-options
      drbd: update Kconfig to match current dependencies

Philipp Reisner (3):
      drbd: Remove obsolete check
      drbd: close race between drbd_set_role and drbd_connect
      drbd: Fix drbdsetup wait-connect, wait-sync etc... commands

 drivers/block/drbd/Kconfig         |   10 ++++++----
 drivers/block/drbd/drbd_main.c     |    2 +-
 drivers/block/drbd/drbd_nl.c       |   16 +++++++++++-----
 drivers/block/drbd/drbd_receiver.c |   10 ++++++++++
 4 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
index df09837..7845bd6 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -2,13 +2,14 @@
 # DRBD device driver configuration
 #
 
-comment "DRBD disabled because PROC_FS, INET or CONNECTOR not selected"
-	depends on PROC_FS='n' || INET='n' || CONNECTOR='n'
+comment "DRBD disabled because PROC_FS or INET not selected"
+	depends on PROC_FS='n' || INET='n'
 
 config BLK_DEV_DRBD
 	tristate "DRBD Distributed Replicated Block Device support"
-	depends on PROC_FS && INET && CONNECTOR
+	depends on PROC_FS && INET
 	select LRU_CACHE
+	select LIBCRC32C
 	default n
 	help
 
@@ -58,7 +59,8 @@ config DRBD_FAULT_INJECTION
 	  32	data read
 	  64	read ahead
 	  128	kmalloc of bitmap
-	  256	allocation of EE (epoch_entries)
+	  256	allocation of peer_requests
+	  512	insert data corruption on receiving side
 
 	  fault_devs: bitmask of minor numbers
 	  fault_rate: frequency in percent
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 52de26d..8c13eeb 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -840,7 +840,7 @@ int _drbd_send_uuids(struct drbd_conf *mdev, u64 uuid_flags)
 	}
 	spin_lock_irq(&mdev->ldev->md.uuid_lock);
 	for (i = UI_CURRENT; i < UI_SIZE; i++)
-		p->uuid[i] = mdev->ldev ? cpu_to_be64(mdev->ldev->md.uuid[i]) : 0;
+		p->uuid[i] = cpu_to_be64(mdev->ldev->md.uuid[i]);
 	spin_unlock_irq(&mdev->ldev->md.uuid_lock);
 
 	mdev->comm_bm_set = drbd_bm_total_weight(mdev);
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 76bb3a6..2af26fc 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1230,6 +1230,11 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
 	else
 		mdev->ldev->md.flags |= MDF_AL_DISABLED;
 
+	if (new_disk_conf->md_flushes)
+		clear_bit(MD_NO_FUA, &mdev->flags);
+	else
+		set_bit(MD_NO_FUA, &mdev->flags);
+
 	drbd_bump_write_ordering(mdev->tconn, WO_bdev_flush);
 
 	drbd_md_sync(mdev);
@@ -3292,11 +3297,12 @@ void drbd_bcast_event(struct drbd_conf *mdev, const struct sib_info *sib)
 	unsigned seq;
 	int err = -ENOMEM;
 
-	if (sib->sib_reason == SIB_SYNC_PROGRESS &&
-	    time_after(jiffies, mdev->rs_last_bcast + HZ))
-		mdev->rs_last_bcast = jiffies;
-	else
-		return;
+	if (sib->sib_reason == SIB_SYNC_PROGRESS) {
+		if (time_after(jiffies, mdev->rs_last_bcast + HZ))
+			mdev->rs_last_bcast = jiffies;
+		else
+			return;
+	}
 
 	seq = atomic_inc_return(&drbd_genl_seq);
 	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_NOIO);
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 1599a1a..a9eccfc 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1037,6 +1037,16 @@ randomize:
 	rcu_read_lock();
 	idr_for_each_entry(&tconn->volumes, mdev, vnr) {
 		kref_get(&mdev->kref);
+		/* Prevent a race between resync-handshake and
+		 * being promoted to Primary.
+		 *
+		 * Grab and release the state mutex, so we know that any current
+		 * drbd_set_role() is finished, and any incoming drbd_set_role
+		 * will see the STATE_SENT flag, and wait for it to be cleared.
+		 */
+		mutex_lock(mdev->state_mutex);
+		mutex_unlock(mdev->state_mutex);
+
 		rcu_read_unlock();
 
 		if (discard_my_data)

