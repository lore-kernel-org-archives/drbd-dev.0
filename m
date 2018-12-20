Return-Path: <lars.ellenberg@linbit.com>
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Date: Thu, 20 Dec 2018 17:23:39 +0100
Message-Id: <20181220162344.8430-13-lars.ellenberg@linbit.com>
In-Reply-To: <20181220162344.8430-1-lars.ellenberg@linbit.com>
References: <20181220162344.8430-1-lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 12/17] drbd: fix print_st_err()'s prototype to
	match the definition
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

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

print_st_err() is defined with its 4th argument taking an
'enum drbd_state_rv' but its prototype use an int for it.

Fix this by using 'enum drbd_state_rv' in the prototype too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Roland Kammerer <roland.kammerer@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_state.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_state.h
index ea58301d0895..b2a390ba73a0 100644
--- a/drivers/block/drbd/drbd_state.h
+++ b/drivers/block/drbd/drbd_state.h
@@ -131,7 +131,7 @@ extern enum drbd_state_rv _drbd_set_state(struct drbd_device *, union drbd_state
 					  enum chg_state_flags,
 					  struct completion *done);
 extern void print_st_err(struct drbd_device *, union drbd_state,
-			union drbd_state, int);
+			union drbd_state, enum drbd_state_rv);
 
 enum drbd_state_rv
 _conn_request_state(struct drbd_connection *connection, union drbd_state mask, union drbd_state val,
-- 
2.17.1

