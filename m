Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 850B7105647D
	for <drbd-dev@lists.linbit.com>; Tue,  7 Mar 2017 04:28:28 +0100 (CET)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Tue,  7 Mar 2017 11:27:52 +0800
Message-Id: <1488857279-29079-2-git-send-email-nwang@suse.com>
In-Reply-To: <1488857279-29079-1-git-send-email-nwang@suse.com>
References: <1488857279-29079-1-git-send-email-nwang@suse.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [Drbd-dev] [Patch v0 1/8] Remove bio_set_op_attrs
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

In 93c5bdf7, bio_set_op_attrs changed from define to inline.
Then dropped by use flag directly. Also clean the old value
for the new op and op_flags.
Use REQ_SYNC instead of WRITE_SYNC.

This patch in drbd-kernel-compat.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com 

---
 drbd_wrappers.h               | 13 +++++++++++--
 tests/have_bio_set_op_attrs.c | 11 +++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)
 create mode 100644 tests/have_bio_set_op_attrs.c

diff --git a/drbd_wrappers.h b/drbd_wrappers.h
index 1d9289f..0489e7f 100644
--- a/drbd_wrappers.h
+++ b/drbd_wrappers.h
@@ -719,7 +719,7 @@ static inline void blk_queue_write_cache(struct request_queue *q, bool enabled,
  * bi_opf (some kernel version) -> data packet flags -> bi_opf (other kernel version)
  */
 
-#if defined(bio_set_op_attrs)
+#ifdef COMPAT_HAVE_BIO_SET_OP_ATTRS
 /* Linux 4.8 split bio OPs and FLAGs {{{2 */
 
 #define DRBD_REQ_PREFLUSH	REQ_PREFLUSH
@@ -872,12 +872,21 @@ static inline void blk_queue_write_cache(struct request_queue *q, bool enabled,
 #define DRBD_REQ_WSAME		0
 #endif
 
+#ifdef COMPAT_HAVE_BIO_SET_OP_ATTRS
+#ifndef WRITE_FLUSH
+#define bio_set_op_attrs(bio, op, op_flags) do {        \
+	(bio)->bi_opf = op | op_flags;              \
+} while (0)
+#define WRITE_FLUSH (REQ_SYNC | DRBD_REQ_PREFLUSH)
+#endif
+#else
 #ifndef WRITE_FLUSH
 #ifndef WRITE_SYNC
 #error  FIXME WRITE_SYNC undefined??
 #endif
 #define WRITE_FLUSH       (WRITE_SYNC | DRBD_REQ_PREFLUSH)
 #endif
+#endif
 
 #ifndef REQ_NOIDLE
 /* introduced in aeb6faf (2.6.30), relevant for CFQ */
@@ -885,7 +894,7 @@ static inline void blk_queue_write_cache(struct request_queue *q, bool enabled,
 #endif
 
 
-#ifndef bio_set_op_attrs /* compat for Linux before 4.8 {{{2 */
+#ifndef COMPAT_HAVE_BIO_SET_OP_ATTRS /*compat for Linux before 4.8 {{{2 */
 
 #define bi_opf bi_rw
 
diff --git a/tests/have_bio_set_op_attrs.c b/tests/have_bio_set_op_attrs.c
new file mode 100644
index 0000000..6aa0781
--- /dev/null
+++ b/tests/have_bio_set_op_attrs.c
@@ -0,0 +1,11 @@
+#include <linux/bio.h>
+
+/*
+ * bio_set_op_attrs() change to inline since 93c5bdf7 (4.10-rc1)
+ */
+void test(void)
+{
+	struct bio *bio = NULL;
+
+	bio_set_op_attrs(bio, 0, 0);
+}
-- 
1.8.5.6

