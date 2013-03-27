Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 27 Mar 2013 14:08:33 +0100
Message-Id: <1364389729-17559-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1364389729-17559-1-git-send-email-philipp.reisner@linbit.com>
References: <1364389729-17559-1-git-send-email-philipp.reisner@linbit.com>
Cc: George Spelvin <linux@horizon.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 01/17] idr: document exit conditions on
	idr_for_each_entry better
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

From: George Spelvin <linux@horizon.com>

And some manual common subexpression elimination which may help the
compiler produce smaller code.

Signed-off-by: George Spelvin <linux@horizon.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 include/linux/idr.h |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index 2640c7e..6ece058 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -122,11 +122,13 @@ static inline void *idr_find(struct idr *idr, int id)
  * @idp:     idr handle
  * @entry:   the type * to use as cursor
  * @id:      id entry's key
+ *
+ * @entry and @id do not need to be initialized before the loop, and
+ * after normal terminatinon @entry is left with the value NULL.  This
+ * is convenient for a "not found" value.
  */
-#define idr_for_each_entry(idp, entry, id)				\
-	for (id = 0, entry = (typeof(entry))idr_get_next((idp), &(id)); \
-	     entry != NULL;                                             \
-	     ++id, entry = (typeof(entry))idr_get_next((idp), &(id)))
+#define idr_for_each_entry(idp, entry, id)			\
+	for (id = 0; ((entry) = idr_get_next(idp, &(id))) != NULL; ++id)
 
 /*
  * Don't use the following functions.  These exist only to suppress
-- 
1.7.9.5

