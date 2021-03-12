Return-Path: <lee.jones@linaro.org>
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
	[209.85.221.54])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B3DDB420308
	for <drbd-dev@lists.linbit.com>; Fri, 12 Mar 2021 11:55:39 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id x16so1522143wrn.4
	for <drbd-dev@lists.linbit.com>; Fri, 12 Mar 2021 02:55:39 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Date: Fri, 12 Mar 2021 10:55:23 +0000
Message-Id: <20210312105530.2219008-5-lee.jones@linaro.org>
In-Reply-To: <20210312105530.2219008-1-lee.jones@linaro.org>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 04/11] block: drbd: drbd_state: Fix some function
	documentation issues
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Fixes the following W=1 kernel build warning(s):

 drivers/block/drbd/drbd_state.c:913: warning: Function parameter or member 'connection' not described in 'is_valid_soft_transition'
 drivers/block/drbd/drbd_state.c:913: warning: Excess function parameter 'device' description in 'is_valid_soft_transition'
 drivers/block/drbd/drbd_state.c:1054: warning: Function parameter or member 'warn' not described in 'sanitize_state'
 drivers/block/drbd/drbd_state.c:1054: warning: Excess function parameter 'warn_sync_abort' description in 'sanitize_state'
 drivers/block/drbd/drbd_state.c:1703: warning: Function parameter or member 'state_change' not described in 'after_state_ch'

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com
Cc: linux-block@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/block/drbd/drbd_state.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 0067d328f0b56..b8a27818ab3f8 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -904,9 +904,9 @@ is_valid_state(struct drbd_device *device, union drbd_state ns)
  * is_valid_soft_transition() - Returns an SS_ error code if the state transition is not possible
  * This function limits state transitions that may be declined by DRBD. I.e.
  * user requests (aka soft transitions).
- * @device:	DRBD device.
- * @ns:		new state.
  * @os:		old state.
+ * @ns:		new state.
+ * @connection:  DRBD connection.
  */
 static enum drbd_state_rv
 is_valid_soft_transition(union drbd_state os, union drbd_state ns, struct drbd_connection *connection)
@@ -1044,7 +1044,7 @@ static void print_sanitize_warnings(struct drbd_device *device, enum sanitize_st
  * @device:	DRBD device.
  * @os:		old state.
  * @ns:		new state.
- * @warn_sync_abort:
+ * @warn:	placeholder for returned state warning.
  *
  * When we loose connection, we have to set the state of the peers disk (pdsk)
  * to D_UNKNOWN. This rule and many more along those lines are in this function.
@@ -1696,6 +1696,7 @@ static bool lost_contact_to_peer_data(enum drbd_disk_state os, enum drbd_disk_st
  * @os:		old state.
  * @ns:		new state.
  * @flags:	Flags
+ * @state_change: state change to broadcast
  */
 static void after_state_ch(struct drbd_device *device, union drbd_state os,
 			   union drbd_state ns, enum chg_state_flags flags,
-- 
2.27.0

