Return-Path: <lars.ellenberg@linbit.com>
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Date: Thu, 20 Dec 2018 17:23:44 +0100
Message-Id: <20181220162344.8430-18-lars.ellenberg@linbit.com>
In-Reply-To: <20181220162344.8430-1-lars.ellenberg@linbit.com>
References: <20181220162344.8430-1-lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 17/17] drbd: Change
	drbd_request_detach_interruptible's return type to int
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

From: Nathan Chancellor <natechancellor@gmail.com>

Clang warns when an implicit conversion is done between enumerated
types:

drivers/block/drbd/drbd_state.c:708:8: warning: implicit conversion from
enumeration type 'enum drbd_ret_code' to different enumeration type
'enum drbd_state_rv' [-Wenum-conversion]
                rv = ERR_INTR;
                   ~ ^~~~~~~~

drbd_request_detach_interruptible's only call site is in the return
statement of adm_detach, which returns an int. Change the return type of
drbd_request_detach_interruptible to match, silencing Clang's warning.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/block/drbd/drbd_state.c | 6 ++----
 drivers/block/drbd/drbd_state.h | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 883155657273..2b4c0db5d867 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -688,11 +688,9 @@ request_detach(struct drbd_device *device)
 			CS_VERBOSE | CS_ORDERED | CS_INHIBIT_MD_IO);
 }
 
-enum drbd_state_rv
-drbd_request_detach_interruptible(struct drbd_device *device)
+int drbd_request_detach_interruptible(struct drbd_device *device)
 {
-	enum drbd_state_rv rv;
-	int ret;
+	int ret, rv;
 
 	drbd_suspend_io(device); /* so no-one is stuck in drbd_al_begin_io */
 	wait_event_interruptible(device->state_wait,
diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_state.h
index b2a390ba73a0..f87371e55e68 100644
--- a/drivers/block/drbd/drbd_state.h
+++ b/drivers/block/drbd/drbd_state.h
@@ -162,8 +162,7 @@ static inline int drbd_request_state(struct drbd_device *device,
 }
 
 /* for use in adm_detach() (drbd_adm_detach(), drbd_adm_down()) */
-enum drbd_state_rv
-drbd_request_detach_interruptible(struct drbd_device *device);
+int drbd_request_detach_interruptible(struct drbd_device *device);
 
 enum drbd_role conn_highest_role(struct drbd_connection *connection);
 enum drbd_role conn_highest_peer(struct drbd_connection *connection);
-- 
2.17.1

