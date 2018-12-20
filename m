Return-Path: <lars.ellenberg@linbit.com>
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Date: Thu, 20 Dec 2018 17:23:29 +0100
Message-Id: <20181220162344.8430-3-lars.ellenberg@linbit.com>
In-Reply-To: <20181220162344.8430-1-lars.ellenberg@linbit.com>
References: <20181220162344.8430-1-lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 02/17] drbd: must not use connection after
	kref_put(&connection->kref)
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

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_state.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 0813c654c893..18d53fe60d1d 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -2109,9 +2109,8 @@ static int w_after_conn_state_ch(struct drbd_work *w, int unused)
 			spin_unlock_irq(&connection->resource->req_lock);
 		}
 	}
-	kref_put(&connection->kref, drbd_destroy_connection);
-
 	conn_md_sync(connection);
+	kref_put(&connection->kref, drbd_destroy_connection);
 
 	return 0;
 }
-- 
2.17.1

