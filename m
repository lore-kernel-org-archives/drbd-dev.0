Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Mon, 10 Oct 2011 13:55:04 +0200
Message-Id: <1318247706-7732-12-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1318247706-7732-1-git-send-email-philipp.reisner@linbit.com>
References: <1318247706-7732-1-git-send-email-philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 11/13] drbd: drbd_nla_check_mandatory(): Need to
	remove the DRBD_GENLA_F_MANDATORY flag first
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

From: Andreas Gruenbacher <agruen@linbit.com>

We need to remove the flag before checking for valid types.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 include/linux/genl_magic_func.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/genl_magic_func.h b/include/linux/genl_magic_func.h
index 99f4e95..2d38695 100644
--- a/include/linux/genl_magic_func.h
+++ b/include/linux/genl_magic_func.h
@@ -158,9 +158,9 @@ static inline int drbd_nla_check_mandatory(int maxtype, struct nlattr *nla)
 
 	nla_for_each_attr(nla, head, len, rem) {
 		if (nla->nla_type & DRBD_GENLA_F_MANDATORY) {
+			nla->nla_type &= ~DRBD_GENLA_F_MANDATORY;
 			if (nla_type(nla) > maxtype)
 				return -EOPNOTSUPP;
-			nla->nla_type &= ~DRBD_GENLA_F_MANDATORY;
 		}
 	}
 	return 0;
-- 
1.7.4.1

