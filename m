Return-Path: <gregkh@linuxfoundation.org>
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E994A420625
	for <drbd-dev@lists.linbit.com>; Thu, 12 May 2022 15:45:44 +0200 (CEST)
To: axboe@kernel.dk, drbd-dev@lists.linbit.com, gregkh@linuxfoundation.org,
	lars.ellenberg@linbit.com, lee.jones@linaro.org,
	nathan@kernel.org, philipp.reisner@linbit.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 12 May 2022 15:37:13 +0200
Message-ID: <1652362633208176@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: stable-commits@vger.kernel.org
Subject: [Drbd-dev] Patch "block: drbd: drbd_nl: Make conversion to 'enum
	drbd_ret_code' explicit" has been added to the 4.14-stable tree
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


This is a note to let you know that I've just added the patch titled

    block: drbd: drbd_nl: Make conversion to 'enum drbd_ret_code' explicit

to the 4.14-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     block-drbd-drbd_nl-make-conversion-to-enum-drbd_ret_code-explicit.patch
and it can be found in the queue-4.14 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 1f1e87b4dc4598eac57a69868534b92d65e47e82 Mon Sep 17 00:00:00 2001
From: Lee Jones <lee.jones@linaro.org>
Date: Fri, 12 Mar 2021 10:55:26 +0000
Subject: block: drbd: drbd_nl: Make conversion to 'enum drbd_ret_code' explicit
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lee Jones <lee.jones@linaro.org>

commit 1f1e87b4dc4598eac57a69868534b92d65e47e82 upstream.

Fixes the following W=1 kernel build warning(s):

 from drivers/block/drbd/drbd_nl.c:24:
 drivers/block/drbd/drbd_nl.c: In function ‘drbd_adm_set_role’:
 drivers/block/drbd/drbd_nl.c:793:11: warning: implicit conversion from ‘enum drbd_state_rv’ to ‘enum drbd_ret_code’ [-Wenum-conversion]
 drivers/block/drbd/drbd_nl.c:795:11: warning: implicit conversion from ‘enum drbd_state_rv’ to ‘enum drbd_ret_code’ [-Wenum-conversion]
 drivers/block/drbd/drbd_nl.c: In function ‘drbd_adm_attach’:
 drivers/block/drbd/drbd_nl.c:1965:10: warning: implicit conversion from ‘enum drbd_state_rv’ to ‘enum drbd_ret_code’ [-Wenum-conversion]
 drivers/block/drbd/drbd_nl.c: In function ‘drbd_adm_connect’:
 drivers/block/drbd/drbd_nl.c:2690:10: warning: implicit conversion from ‘enum drbd_state_rv’ to ‘enum drbd_ret_code’ [-Wenum-conversion]
 drivers/block/drbd/drbd_nl.c: In function ‘drbd_adm_disconnect’:
 drivers/block/drbd/drbd_nl.c:2803:11: warning: implicit conversion from ‘enum drbd_state_rv’ to ‘enum drbd_ret_code’ [-Wenum-conversion]

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com
Cc: linux-block@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Link: https://lore.kernel.org/r/20210312105530.2219008-8-lee.jones@linaro.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Cc: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/drbd/drbd_nl.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -774,9 +774,11 @@ int drbd_adm_set_role(struct sk_buff *sk
 	mutex_lock(&adm_ctx.resource->adm_mutex);
 
 	if (info->genlhdr->cmd == DRBD_ADM_PRIMARY)
-		retcode = drbd_set_role(adm_ctx.device, R_PRIMARY, parms.assume_uptodate);
+		retcode = (enum drbd_ret_code)drbd_set_role(adm_ctx.device,
+						R_PRIMARY, parms.assume_uptodate);
 	else
-		retcode = drbd_set_role(adm_ctx.device, R_SECONDARY, 0);
+		retcode = (enum drbd_ret_code)drbd_set_role(adm_ctx.device,
+						R_SECONDARY, 0);
 
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
 	genl_lock();
@@ -1941,7 +1943,7 @@ int drbd_adm_attach(struct sk_buff *skb,
 	drbd_flush_workqueue(&connection->sender_work);
 
 	rv = _drbd_request_state(device, NS(disk, D_ATTACHING), CS_VERBOSE);
-	retcode = rv;  /* FIXME: Type mismatch. */
+	retcode = (enum drbd_ret_code)rv;
 	drbd_resume_io(device);
 	if (rv < SS_SUCCESS)
 		goto fail;
@@ -2671,7 +2673,8 @@ int drbd_adm_connect(struct sk_buff *skb
 	}
 	rcu_read_unlock();
 
-	retcode = conn_request_state(connection, NS(conn, C_UNCONNECTED), CS_VERBOSE);
+	retcode = (enum drbd_ret_code)conn_request_state(connection,
+					NS(conn, C_UNCONNECTED), CS_VERBOSE);
 
 	conn_reconfig_done(connection);
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
@@ -2777,7 +2780,7 @@ int drbd_adm_disconnect(struct sk_buff *
 	mutex_lock(&adm_ctx.resource->adm_mutex);
 	rv = conn_try_disconnect(connection, parms.force_disconnect);
 	if (rv < SS_SUCCESS)
-		retcode = rv;  /* FIXME: Type mismatch. */
+		retcode = (enum drbd_ret_code)rv;
 	else
 		retcode = NO_ERROR;
 	mutex_unlock(&adm_ctx.resource->adm_mutex);


Patches currently in stable-queue which might be from lee.jones@linaro.org are

queue-4.14/block-drbd-drbd_nl-make-conversion-to-enum-drbd_ret_code-explicit.patch
