Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
	[209.85.218.48])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1A2A5420FDF
	for <drbd-dev@lists.linbit.com>; Wed,  6 Apr 2022 21:07:32 +0200 (CEST)
Received: by mail-ej1-f48.google.com with SMTP id qh7so6177664ejb.11
	for <drbd-dev@lists.linbit.com>; Wed, 06 Apr 2022 12:07:32 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  6 Apr 2022 21:07:10 +0200
Message-Id: <20220406190715.1938174-3-christoph.boehmwalder@linbit.com>
In-Reply-To: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
References: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Arnd Bergmann <arnd@arndb.de>, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 2/7] drbd: address enum mismatch warnings
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

From: Arnd Bergmann <arnd@arndb.de>

gcc -Wextra warns about mixing drbd_state_rv with drbd_ret_code
in a couple of places:

drivers/block/drbd/drbd_nl.c: In function 'drbd_adm_set_role':
drivers/block/drbd/drbd_nl.c:777:14: warning: comparison between 'enum drbd_state_rv' and 'enum drbd_ret_code' [-Wenum-compare]
  777 |  if (retcode != NO_ERROR)
      |              ^~
drivers/block/drbd/drbd_nl.c:784:12: warning: implicit conversion from 'enum drbd_ret_code' to 'enum drbd_state_rv' [-Wenum-conversion]
  784 |    retcode = ERR_MANDATORY_TAG;
      |            ^
drivers/block/drbd/drbd_nl.c: In function 'drbd_adm_attach':
drivers/block/drbd/drbd_nl.c:1965:10: warning: implicit conversion from 'enum drbd_state_rv' to 'enum drbd_ret_code' [-Wenum-conversion]
 1965 |  retcode = rv;  /* FIXME: Type mismatch. */
      |          ^
drivers/block/drbd/drbd_nl.c: In function 'drbd_adm_connect':
drivers/block/drbd/drbd_nl.c:2690:10: warning: implicit conversion from 'enum drbd_state_rv' to 'enum drbd_ret_code' [-Wenum-conversion]
 2690 |  retcode = conn_request_state(connection, NS(conn, C_UNCONNECTED), CS_VERBOSE);
      |          ^
drivers/block/drbd/drbd_nl.c: In function 'drbd_adm_disconnect':
drivers/block/drbd/drbd_nl.c:2803:11: warning: implicit conversion from 'enum drbd_state_rv' to 'enum drbd_ret_code' [-Wenum-conversion]
 2803 |   retcode = rv;  /* FIXME: Type mismatch. */
      |           ^

In each case, both are passed into drbd_adm_finish(), which just takes
a 32-bit integer and is happy with either, presumably intentionally.

Restructure the code to pass either type directly in there in most
cases, avoiding the warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 02030c9c4d3b..074b884ec225 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -770,6 +770,7 @@ int drbd_adm_set_role(struct sk_buff *skb, struct genl_info *info)
 	struct set_role_parms parms;
 	int err;
 	enum drbd_ret_code retcode;
+	enum drbd_state_rv rv;
 
 	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_MINOR);
 	if (!adm_ctx.reply_skb)
@@ -790,14 +791,14 @@ int drbd_adm_set_role(struct sk_buff *skb, struct genl_info *info)
 	mutex_lock(&adm_ctx.resource->adm_mutex);
 
 	if (info->genlhdr->cmd == DRBD_ADM_PRIMARY)
-		retcode = (enum drbd_ret_code)drbd_set_role(adm_ctx.device,
-						R_PRIMARY, parms.assume_uptodate);
+		rv = drbd_set_role(adm_ctx.device, R_PRIMARY, parms.assume_uptodate);
 	else
-		retcode = (enum drbd_ret_code)drbd_set_role(adm_ctx.device,
-						R_SECONDARY, 0);
+		rv = drbd_set_role(adm_ctx.device, R_SECONDARY, 0);
 
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
 	genl_lock();
+	drbd_adm_finish(&adm_ctx, info, rv);
+	return 0;
 out:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
@@ -2502,6 +2503,7 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 	struct drbd_resource *resource;
 	struct drbd_connection *connection;
 	enum drbd_ret_code retcode;
+	enum drbd_state_rv rv;
 	int i;
 	int err;
 
@@ -2621,12 +2623,11 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 	}
 	rcu_read_unlock();
 
-	retcode = (enum drbd_ret_code)conn_request_state(connection,
-					NS(conn, C_UNCONNECTED), CS_VERBOSE);
+	rv = conn_request_state(connection, NS(conn, C_UNCONNECTED), CS_VERBOSE);
 
 	conn_reconfig_done(connection);
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
-	drbd_adm_finish(&adm_ctx, info, retcode);
+	drbd_adm_finish(&adm_ctx, info, rv);
 	return 0;
 
 fail:
@@ -2734,11 +2735,12 @@ int drbd_adm_disconnect(struct sk_buff *skb, struct genl_info *info)
 
 	mutex_lock(&adm_ctx.resource->adm_mutex);
 	rv = conn_try_disconnect(connection, parms.force_disconnect);
-	if (rv < SS_SUCCESS)
-		retcode = (enum drbd_ret_code)rv;
-	else
-		retcode = NO_ERROR;
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
+	if (rv < SS_SUCCESS) {
+		drbd_adm_finish(&adm_ctx, info, rv);
+		return 0;
+	}
+	retcode = NO_ERROR;
  fail:
 	drbd_adm_finish(&adm_ctx, info, retcode);
 	return 0;
-- 
2.35.1

