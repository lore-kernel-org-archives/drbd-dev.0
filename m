Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 10 Oct 2011 13:55:02 +0200
Message-Id: <1318247706-7732-10-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1318247706-7732-1-git-send-email-philipp.reisner@linbit.com>
References: <1318247706-7732-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 09/13] drbd: Remove unused GENLA_F_MAY_IGNORE flag
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 include/linux/genl_magic_struct.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/include/linux/genl_magic_struct.h b/include/linux/genl_magic_struct.h
index ba911da..f3c3425 100644
--- a/include/linux/genl_magic_struct.h
+++ b/include/linux/genl_magic_struct.h
@@ -40,11 +40,6 @@ extern void CONCAT_(GENL_MAGIC_FAMILY, _genl_unregister)(void);
  * yet implemented features, if newer userland tries to use them even though
  * the genl_family version clearly indicates they are not available.
  *
- * @GENLA_F_MAY_IGNORE: To clearly document the fact, for good measure.
- * To be used for API extensions for things that have sane defaults,
- * so newer userland can still talk to older kernel, knowing it will
- * silently ignore these attributes if not yet known.
- *
  * NOTE: These flags overload
  *   NLA_F_NESTED		(1 << 15)
  *   NLA_F_NET_BYTEORDER	(1 << 14)
@@ -55,7 +50,6 @@ extern void CONCAT_(GENL_MAGIC_FAMILY, _genl_unregister)(void);
  * See also: nla_type()
  */
 enum {
-	GENLA_F_MAY_IGNORE	= 0,
 	GENLA_F_MANDATORY	= 1 << 14,
 	GENLA_F_REQUIRED	= 1 << 15,
 
-- 
1.7.4.1

