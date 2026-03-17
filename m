Return-Path: <ethantidmore06@gmail.com>
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
	[209.85.128.170])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 66411162774
	for <drbd-dev@lists.linbit.com>; Wed, 18 Mar 2026 00:23:24 +0100 (CET)
Received: by mail-yw1-f170.google.com with SMTP id
	00721157ae682-79a40fb9890so30973257b3.1
	for <drbd-dev@lists.linbit.com>; Tue, 17 Mar 2026 16:23:24 -0700 (PDT)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/4] drbd: Add check for error pointer
Date: Tue, 17 Mar 2026 18:23:18 -0500
Message-ID: <20260317232318.18923-5-ethantidmore06@gmail.com>
In-Reply-To: <20260317232318.18923-1-ethantidmore06@gmail.com>
References: <20260317232318.18923-1-ethantidmore06@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Ethan Tidmore <ethantidmore06@gmail.com>,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
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

The function find_cfg_context_attr() can return an error pointer or NULL
in its error path.

Change NULL check to IS_ERR_OR_NULL().

Detected by Smatch:
drivers/block/drbd/drbd_nl.c:6571 drbd_adm_dump_paths() error:
'resource_filter' dereferencing possible ERR_PTR()

Fixes: 626c95b0e2a23 ("drbd: rework netlink interface for DRBD 9 multi-peer config")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/block/drbd/drbd_nl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index c5e253820ccf..1f458eb972e9 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -6566,7 +6566,7 @@ static int drbd_adm_dump_paths(struct sk_buff *skb, struct netlink_callback *cb)
 	resource = (struct drbd_resource *)cb->args[0];
 	if (!cb->args[0]) {
 		resource_filter = find_cfg_context_attr(cb->nlh, T_ctx_resource_name);
-		if (resource_filter) {
+		if (!IS_ERR_OR_NULL(resource_filter)) {
 			retcode = ERR_RES_NOT_KNOWN;
 			resource = drbd_find_resource(nla_data(resource_filter));
 			if (!resource)
-- 
2.53.0

