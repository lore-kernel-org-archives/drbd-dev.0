Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri, 20 Dec 2013 13:28:59 +0100
Message-Id: <1387542563-6833-3-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1387542563-6833-1-git-send-email-philipp.reisner@linbit.com>
References: <1387542563-6833-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 02/26] idr: Add new function idr_is_empty()
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

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 include/linux/idr.h |    1 +
 lib/idr.c           |   10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index 871a213..9c95d21 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -85,6 +85,7 @@ void idr_remove(struct idr *idp, int id);
 void idr_free(struct idr *idp, int id);
 void idr_destroy(struct idr *idp);
 void idr_init(struct idr *idp);
+bool idr_is_empty(struct idr *idp);
 
 /**
  * idr_preload_end - end preload section started with idr_preload()
diff --git a/lib/idr.c b/lib/idr.c
index bfe4db4..1ba4956 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -869,6 +869,16 @@ void idr_init(struct idr *idp)
 }
 EXPORT_SYMBOL(idr_init);
 
+static int idr_has_entry(int id, void *p, void *data)
+{
+	return 1;
+}
+
+bool idr_is_empty(struct idr *idp)
+{
+	return !idr_for_each(idp, idr_has_entry, NULL);
+}
+EXPORT_SYMBOL(idr_is_empty);
 
 /**
  * DOC: IDA description
-- 
1.7.9.5

