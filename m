Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f175.google.com (mail-wr0-f175.google.com
	[209.85.128.175]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id EA26E1056332
	for <drbd-dev@lists.linbit.com>; Wed,  1 Mar 2017 14:06:21 +0100 (CET)
Received: by mail-wr0-f175.google.com with SMTP id u108so29753571wrb.3
	for <drbd-dev@lists.linbit.com>; Wed, 01 Mar 2017 05:06:21 -0800 (PST)
Received: from soda.linbit ([86.59.100.100])
	by smtp.gmail.com with ESMTPSA id 17sm6559571wru.16.2017.03.01.05.06.19
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 Mar 2017 05:06:19 -0800 (PST)
Date: Wed, 1 Mar 2017 14:06:14 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20170301130614.GH10667@soda.linbit>
References: <alpine.LRH.2.11.1702281620050.16946@mail.ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.11.1702281620050.16946@mail.ewheeler.net>
Subject: Re: [Drbd-dev] BUG: NULL pointer dereference triggered by drbdsetup
 events2
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

On Tue, Feb 28, 2017 at 04:28:46PM -0800, Eric Wheeler wrote:
> Hello all,
> 
> We found a relatively easy to reproduce bug that crashes the kernel. Start 
> with all of the resources down and only the DRBD module loaded and run the 
> following:
> 
> drbdadm up foo
> drbdsetup events2 foo | true
> drbdadm down foo; ls -d /sys/devices/virtual/bdi/147:7740
> drbdadm up foo
> 
> The backtrace is below. The ls above simply illustrates the problem. After 
> a down, the sysfs entry should not exist. The bug manifests because 
> add_disk attempts to create the same sysfs entry but it cannot and fails 
> up the stack. I have a feeling that the interface used by events2 is 
> holding open a reference count after down so the sysfs entry is never 
> removed.
> 
> We are piping into true because it fails quickly without reading any 
> stdio, so perhaps the kernel is blocked trying to flush a buffer into 
> userspace and never releases a resource count (speculation).
> 
> This was tested using the 4.10.1 kernel with userspace tools 
> drbd-utils-8.9.4. I suspect this could be worked around in userspace, but 
> it would be ideal if the kernel module could be fixed up to prevent a 
> crash.
> 
> Please let me know if you need additional information or if I can provide 
> any other testing.
> 
> Thank you for your help!

The "events2" part of drbd 8.4 was a "backport" from drbd 9.
I found this apparently relevant commit in our DRBD 9 repo.

In our out-of-tree 8.4 code, we later dropped the .done parts again,
for compat with RHEL 5, which is likely why this fix fell through.

I basically only re-diffed and compile-tested for current upstream kernel.
Does this help already, or do we need to dig deeper?

Thanks,
	Lars


commit 74635bbfbd03546f19ed015cec6e470062af44af
Author: Lars Ellenberg <lars.ellenberg@linbit.com>
Date:   Wed Jul 27 14:53:00 2016 +0200

    drbd: fix potential refcount leak, add missing drbd_adm_get_initial_state_done
    
    If some drbdsetup events2 / wait-* command aborts early,
    or the netlink socket currently in .dumpit = drbd_adm_get_initial_state
    is destroyed early for some other reason,
    the cleanup code inside that .dumpit function would never run,
    and we end up with a reference count leak.
    
    Move cleanup to .done = drbd_adm_get_initial_state_done.

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index f35db29..115b468 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -84,6 +84,7 @@ int drbd_adm_dump_connections_done(struct netlink_callback *cb);
 int drbd_adm_dump_peer_devices(struct sk_buff *skb, struct netlink_callback *cb);
 int drbd_adm_dump_peer_devices_done(struct netlink_callback *cb);
 int drbd_adm_get_initial_state(struct sk_buff *skb, struct netlink_callback *cb);
+int drbd_adm_get_initial_state_done(struct netlink_callback *cb);
 
 #include <linux/drbd_genl_api.h>
 #include "drbd_nla.h"
@@ -4932,6 +4933,21 @@ static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
+int drbd_adm_get_initial_state_done(struct netlink_callback *cb)
+{
+	LIST_HEAD(head);
+	if (cb->args[0]) {
+		struct drbd_state_change *state_change =
+			(struct drbd_state_change *)cb->args[0];
+		cb->args[0] = 0;
+
+		/* connect list to head */
+		list_add(&head, &state_change->list);
+		free_state_changes(&head);
+	}
+	return 0;
+}
+
 int drbd_adm_get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct drbd_resource *resource;
@@ -4940,14 +4956,6 @@ int drbd_adm_get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
 	if (cb->args[5] >= 1) {
 		if (cb->args[5] > 1)
 			return get_initial_state(skb, cb);
-		if (cb->args[0]) {
-			struct drbd_state_change *state_change =
-				(struct drbd_state_change *)cb->args[0];
-
-			/* connect list to head */
-			list_add(&head, &state_change->list);
-			free_state_changes(&head);
-		}
 		return 0;
 	}
 
diff --git a/include/linux/drbd_genl.h b/include/linux/drbd_genl.h
index c934d3a..aa9bf5d 100644
--- a/include/linux/drbd_genl.h
+++ b/include/linux/drbd_genl.h
@@ -521,6 +521,7 @@ GENL_op(
 	DRBD_ADM_GET_INITIAL_STATE, 38,
 	GENL_op_init(
 	        .dumpit = drbd_adm_get_initial_state,
+	        .done = drbd_adm_get_initial_state_done,
 	),
 	GENL_tla_expected(DRBD_NLA_CFG_CONTEXT, DRBD_GENLA_F_MANDATORY))
 
