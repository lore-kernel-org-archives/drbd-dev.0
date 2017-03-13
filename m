Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (prv3-mh.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2650C1056484
	for <drbd-dev@lists.linbit.com>; Mon, 13 Mar 2017 08:23:58 +0100 (CET)
From: Nick Wang <nwang@suse.com>
To: drbd-dev@lists.linbit.com
Date: Mon, 13 Mar 2017 15:23:23 +0800
Message-Id: <1489389811-31234-1-git-send-email-nwang@suse.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	Roland Kammerer <roland.kammerer@linbit.com>
Subject: [Drbd-dev] [Patch v1 0/8] Patches for compat drbd9 to kernel v4.10
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

Changelog of v1 compare to v0:
patch1: Remove the "error FIXME WRITE_SYNC undefined", since
        for the new kernels without WRITE_SYNC, can savely
        ignore it.
patch2 and patch3: Remove the wrapper of bdi_congested in v1,
        by removing the '&' directly.
patch4 and patch5: Use a warpper of refcount_* function,
        fallback to atomic_ when kernel not support.

Patches for drbd9 compatible to kernel4.10, including drbd,
drbd-kernel-compat and drbd-headers repos. Ordered as 
functionality, so may mix the three repos in one patch set.

block layer API and genetlink API have many changes in kernel v4.10.
93c5bdf7 and 70fd7614, bio_set_op_attrs change to inline 
    then obsolete by use flag directly.
dc3b17cc, use pointer to backing_dev_info in struct request_queue.
10383aea, use refcount_t for struct kref.
a07ea4d9 and 489111e5, statically initialize genetlink family.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: Roland Kammerer <roland.kammerer@linbit.com>
CC: drbd-dev@lists.linbit.com 
-- 
1.8.5.6

