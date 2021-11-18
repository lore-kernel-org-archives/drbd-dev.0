Return-Path: <dan.carpenter@oracle.com>
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
	[205.220.177.32])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CB8A6420952
	for <drbd-dev@lists.linbit.com>; Thu, 18 Nov 2021 16:24:12 +0100 (CET)
Date: Thu, 18 Nov 2021 11:49:30 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: agruen@linbit.com
Message-ID: <20211118084930.GB24550@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
MIME-Version: 1.0
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [bug report] drbd: Backport the "status" command
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

Hello Andreas Gruenbacher,

The patch a55bbd375d18: "drbd: Backport the "status" command" from
Aug 28, 2014, leads to the following Smatch static checker warning:

drivers/block/drbd/drbd_nl.c:3424 drbd_adm_dump_devices() warn: 'resource_filter' could be an error pointer
drivers/block/drbd/drbd_nl.c:3513 drbd_adm_dump_connections() warn: 'resource_filter' could be an error pointer
drivers/block/drbd/drbd_nl.c:3674 drbd_adm_dump_peer_devices() warn: 'resource_filter' could be an error pointer

drivers/block/drbd/drbd_nl.c
    3410 int drbd_adm_dump_devices(struct sk_buff *skb, struct netlink_callback *cb)
    3411 {
    3412         struct nlattr *resource_filter;
    3413         struct drbd_resource *resource;
    3414         struct drbd_device *device;
    3415         int minor, err, retcode;
    3416         struct drbd_genlmsghdr *dh;
    3417         struct device_info device_info;
    3418         struct device_statistics device_statistics;
    3419         struct idr *idr_to_search;
    3420 
    3421         resource = (struct drbd_resource *)cb->args[0];
    3422         if (!cb->args[0] && !cb->args[1]) {
    3423                 resource_filter = find_cfg_context_attr(cb->nlh, T_ctx_resource_name);
--> 3424                 if (resource_filter) {

The find_cfg_context_attr() function returns both NULL and error
pointers.  It if returns an error pointer here then that will lead to a
crash.  None of the callers check for error pointers.

    3425                         retcode = ERR_RES_NOT_KNOWN;
    3426                         resource = drbd_find_resource(nla_data(resource_filter));
    3427                         if (!resource)
    3428                                 goto put_result;
    3429                         cb->args[0] = (long)resource;
    3430                 }
    3431         }
    3432 
    3433         rcu_read_lock();
    3434         minor = cb->args[1];

regards,
dan carpenter
