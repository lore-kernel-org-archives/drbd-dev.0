Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 1C55A1056312
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2016 10:56:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 09D672B7169
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2016 10:56:00 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 24aqvFetB1fg for <drbd-dev@lists.linbit.com>;
	Thu, 31 Mar 2016 10:55:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id E26233FC133
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2016 10:55:59 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id F1iA81YGCfKD for <drbd-dev@lists.linbit.com>;
	Thu, 31 Mar 2016 10:55:59 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id B8C0B2B7169
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2016 10:55:59 +0200 (CEST)
Resent-Message-ID: <20160331085559.GA18788@soda.linbit>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
	[209.85.192.195]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BC47F1056332
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2016 18:17:28 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id n5so7837359pfn.1
	for <drbd-dev@lists.linbit.com>; Wed, 30 Mar 2016 09:17:28 -0700 (PDT)
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Thu, 31 Mar 2016 00:17:09 +0800
Message-Id: <1459354637-17415-1-git-send-email-ming.lei@canonical.com>
Cc: Christoph Hellwig <hch@infradead.org>, Boaz Harrosh <boaz@plexistor.com>,
	Dave Chinner <david@fromorbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, xfs@oss.sgi.com,
	linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Anton Altaparmakov <anton@tuxera.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v1 0/8] block: prepare for multipage bvecs
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
then we can drop the non-standard way for iterating bvec, which
can be thought as a good cleanup for lib/iov_iter.c

2) remove BIO_MAX_SECTORS & BIO_MAX_SIZE, and now there is only
one user for each. Once multipage bvecs is introduced, one bio
may hold lots of sectors, and we should always use sort of BIO_MAX_VECS
which should be introduced in future and is similiar with current
BIO_MAX_PAGES.

xfstests(-a auto) have been run and no regression found by this
patchset against linus v4.6-rc1-next-20160329.

V1:
	- don't move BIO_MAX_* to bvec_iter.h as pointed out by Christoph
	- run xfstests against v4.6-rc1-next-20160329
	- add Reviewed-by
	- for 1,4 and 5, Reviewd-by not added, Christoph still expressed
	'this looks fine to me.'

 drivers/block/drbd/drbd_int.h |  4 ++--
 fs/xfs/xfs_buf.c              |  4 +---
 include/linux/bio.h           | 53 +----------------------------------------
 include/linux/blk_types.h     |  4 ++--
 include/linux/bvec_iter.h     | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/iov_iter.c                | 31 +++++++++---------------
 6 files changed, 92 insertions(+), 79 deletions(-)

Thanks,
Ming

