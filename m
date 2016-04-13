Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 207121056445
	for <drbd-dev@lists.linbit.com>; Thu, 14 Apr 2016 13:25:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 0CB5D40A598
	for <drbd-dev@lists.linbit.com>; Thu, 14 Apr 2016 13:25:59 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id cCWOUI2-LF5h for <drbd-dev@lists.linbit.com>;
	Thu, 14 Apr 2016 13:25:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id E2CFF40A599
	for <drbd-dev@lists.linbit.com>; Thu, 14 Apr 2016 13:25:58 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id R_Gouap9URdj for <drbd-dev@lists.linbit.com>;
	Thu, 14 Apr 2016 13:25:58 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id B920C40A591
	for <drbd-dev@lists.linbit.com>; Thu, 14 Apr 2016 13:25:58 +0200 (CEST)
Resent-Message-ID: <20160414112558.GJ3078@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E165C1051881
	for <drbd-dev@lists.linbit.com>; Wed, 13 Apr 2016 21:36:36 +0200 (CEST)
From: mchristi@redhat.com
To: linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
	konrad.wilk@oracle.com, drbd-dev@lists.linbit.com,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	linux-raid@vger.kernel.org, dm-devel@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-mtd@lists.infradead.org,
	target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	osd-dev@open-osd.org, xfs@oss.sgi.com, ocfs2-devel@oss.oracle.com
Date: Wed, 13 Apr 2016 14:35:46 -0500
Message-Id: <1460576188-5751-1-git-send-email-mchristi@redhat.com>
Subject: [Drbd-dev] [PATCH 00/42] v5: separate operations from flags in the
	bio/request structs
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

The following patches begin to cleanup the request->cmd_flags and
bio->bi_rw mess. We currently use cmd_flags to specify the operation,
attributes and state of the request. For bi_rw we use it for similar
info and also the priority but then also have another bi_flags field
for state. At some point, we abused them so much we just made cmd_flags
64 bits, so we could add more.

The following patches seperate the operation (read, write discard,
flush, etc) from cmd_flags/bi_rw.

This patchset was made against linux-next from today April 13
(git tag next-20160413).

I put a git tree here:
https://github.com/mikechristie/linux-kernel.git
The patches are in the op branch.

v5:
1. Missed crypto fs submit_bio_wait call.
2. Change nfs bi_rw check to bi_op.
3. btrfs. Convert finish_parity_scrub.
4. Reworked against Jens's QUEUE_FLAG patches so I could drop my similar
code.
5. Separated the core block layer change into multiple patches for
merging, elevator, stats, mq and non mq request allocation to try
and make it easier to read.

v4:
1. Rebased to current linux-next tree.

v3:

1. Used "=" instead of "|="  to setup bio bi_rw.
2. Removed __get_request cmd_flags compat code.
3. Merged initial dm related changes requested by Mike Snitzer.
4. Fixed ubd kbuild errors in flush related patches.
5. Fix 80 char col issues in several patches.
6. Fix issue with one of the btrfs patches where it looks like I reverted
a patch when trying to fix a merge error.

v2

1. Dropped arguments from submit_bio, and had callers setup
bio.
2. Add REQ_OP_FLUSH for request_fn users and renamed REQ_FLUSH
to REQ_PREFLUSH for make_request_fn users.
3. Dropped bio/rq_data_dir functions, and added a op_is_write
function instead.


