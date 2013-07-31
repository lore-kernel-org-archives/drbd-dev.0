Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 31 Jul 2013 11:41:13 +0200
Message-Id: <1375263675-18410-4-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1375263675-18410-1-git-send-email-philipp.reisner@linbit.com>
References: <1375263675-18410-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 3/5] drbd: Fix adding of new minors with freshly
	created meta data
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

Online adding of new minors with freshly created meta data
to an resource with an established connection failed, with a
wrong state transition on one side on one side of the new minor.

Freshly created meta-data has a la_size (last agreed size) of 0.
When we online add such devices, the code wrongly got into
the code path for resyncing new storage that was added while
the disk was detached.

Fixed that by making the GREW from ZERO a special case.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h |    3 ++-
 drivers/block/drbd/drbd_nl.c  |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 2d7f608..0e06f0c 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1474,7 +1474,8 @@ enum determine_dev_size {
 	DS_ERROR = -1,
 	DS_UNCHANGED = 0,
 	DS_SHRUNK = 1,
-	DS_GREW = 2
+	DS_GREW = 2,
+	DS_GREW_FROM_ZERO = 3,
 };
 extern enum determine_dev_size
 drbd_determine_dev_size(struct drbd_conf *, enum dds_flags, struct resize_parms *) __must_hold(local);
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 8cc1e64..37dad18 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -955,7 +955,7 @@ drbd_determine_dev_size(struct drbd_conf *mdev, enum dds_flags flags, struct res
 	}
 
 	if (size > la_size_sect)
-		rv = DS_GREW;
+		rv = la_size_sect ? DS_GREW : DS_GREW_FROM_ZERO;
 	if (size < la_size_sect)
 		rv = DS_SHRUNK;
 
-- 
1.7.9.5

