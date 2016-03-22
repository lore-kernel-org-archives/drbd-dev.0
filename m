Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C85491056432
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:52:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C2452406FDC
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:52:51 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id SCBltvpEQWy7 for <drbd-dev@lists.linbit.com>;
	Tue, 22 Mar 2016 11:52:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 6E66A406FF6
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:52:50 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uU-wXOzNNMlv for <drbd-dev@lists.linbit.com>;
	Tue, 22 Mar 2016 11:52:50 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 46A3A406FDC
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 11:52:50 +0100 (CET)
Resent-Message-ID: <20160322105248.GO4437@soda.linbit>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
	[209.85.192.194]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D144C1056332
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 07:29:43 +0100 (CET)
Received: by mail-pf0-f194.google.com with SMTP id q129so34584682pfb.3
	for <drbd-dev@lists.linbit.com>; Mon, 21 Mar 2016 23:29:43 -0700 (PDT)
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Date: Tue, 22 Mar 2016 14:12:21 +0800
Message-Id: <1458627149-12988-1-git-send-email-ming.lei@canonical.com>
Cc: Christoph Hellwig <hch@infradead.org>, Boaz Harrosh <boaz@plexistor.com>,
	Dave Chinner <david@fromorbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, xfs@oss.sgi.com,
	linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Anton Altaparmakov <anton@tuxera.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 0/8] block: prepare for multipage bvecs
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

Hi,

Interests[1] have been shown in multipage bvecs, so this patchset
try to prepare for the support and do two things:

1) the 1st 4 patches use bvec iterator to implement iterate_bvec(),
then we can drop the non-standard way for iterating bvec

2) remove BIO_MAX_SECTORS & BIO_MAX_SIZE, and now there is only
one user for each. Once multipage bvecs is introduced, one bio
may hold lots of sectors, and we should always use sort of BIO_MAX_VECS
which should be introduced in future and is similiar with current
BIO_MAX_PAGES.

xfstests(-a auto) have been run and no regression found by this
patchset against linus v4.5+.

 drivers/block/drbd/drbd_int.h |  4 +--
 fs/xfs/xfs_buf.c              |  2 +-
 include/linux/bio.h           | 55 +------------------------------
 include/linux/blk_types.h     |  4 +--
 include/linux/bvec_iter.h     | 77 +++++++++++++++++++++++++++++++++++++++++++
 lib/iov_iter.c                | 31 +++++++----------
 6 files changed, 94 insertions(+), 79 deletions(-)


[1], http://marc.info/?w=2&r=1&s=++[LSF%2FMM+ATTEND]+block%3A+multipage+bvecs&q=t


Thanks,
Ming

