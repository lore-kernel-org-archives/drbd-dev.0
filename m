Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 341A31056446
	for <drbd-dev@lists.linbit.com>; Tue,  3 May 2016 12:50:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 1CD2540F006
	for <drbd-dev@lists.linbit.com>; Tue,  3 May 2016 12:50:02 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id YLPPqYiKWf4O for <drbd-dev@lists.linbit.com>;
	Tue,  3 May 2016 12:50:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id D92E340F008
	for <drbd-dev@lists.linbit.com>; Tue,  3 May 2016 12:50:01 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OY7FBm9fT-0T for <drbd-dev@lists.linbit.com>;
	Tue,  3 May 2016 12:50:01 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id AAA3740F006
	for <drbd-dev@lists.linbit.com>; Tue,  3 May 2016 12:50:01 +0200 (CEST)
Resent-Message-ID: <20160503105001.GF16459@soda.linbit>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3586A1056312
	for <drbd-dev@lists.linbit.com>; Tue,  3 May 2016 03:04:00 +0200 (CEST)
Received: from mail-yw0-f182.google.com ([209.85.161.182])
	by youngberry.canonical.com with esmtpsa
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <ming.lei@canonical.com>) id 1axOkp-0002f5-OU
	for drbd-dev@lists.linbit.com; Tue, 03 May 2016 01:03:59 +0000
Received: by mail-yw0-f182.google.com with SMTP id t10so5720156ywa.0
	for <drbd-dev@lists.linbit.com>; Mon, 02 May 2016 18:03:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1460928615-20894-1-git-send-email-ming.lei@canonical.com>
References: <1460928615-20894-1-git-send-email-ming.lei@canonical.com>
Date: Tue, 3 May 2016 09:03:58 +0800
Message-ID: <CACVXFVOw2dnO0tw5n2dPXUQh_tkGLCo742AXpJ8mMQG6LQZVUA@mail.gmail.com>
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@fb.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	Mike Snitzer <snitzer@redhat.com>, Ming Lei <ming.lei@canonical.com>,
	"open list:XFS FILESYSTEM" <xfs@oss.sgi.com>,
	linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Shaohua Li <shli@fb.com>, Tejun Heo <tj@kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH v5 0/8] block: prepare for multipage bvecs
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

On Mon, Apr 18, 2016 at 5:29 AM, Ming Lei <ming.lei@canonical.com> wrote:
> Hi,
>
> Interests[1] have been shown in multipage bvecs, so this patchset
> try to prepare for the support and do two things:
>
> 1) the 1st 4 patches use bvec iterator to implement iterate_bvec(),
> then we can drop the non-standard way for iterating bvec, which
> can be thought as a good cleanup for lib/iov_iter.c
>
> 2) remove BIO_MAX_SECTORS & BIO_MAX_SIZE, and now there is only
> one user for each. Once multipage bvecs is introduced, one bio
> may hold lots of sectors, and we should always use sort of BIO_MAX_VECS
> which should be introduced in future and is similiar with current
> BIO_MAX_PAGES.
>
> The only functional change is iterate_bvec():lib/iov_iter.c
>
> xfstests(-a auto) over loop aio is run for ext4/xfs to verify
> the change and no regression found with this patchset.
>
> Jens, I am confidant this time, so please give it a go if no one
> objects. I appreciate someone(AI? or anyone) can give a review on
> the patch 4/8 about iterate_bvec() change.
>
> V5:
>         - use bvec's iterator to figure new base vec address and
>         update 'skip' correctly
>         - run xfstests(-a auto) on loop aio/dio for verifying
>         the change in iterate_bvec(), and no regression reported
>         - use stree-ng to trigger heavy swap over swapfile to verify
>         change in iterate_bvec() too, looks everything is fine

Hi Jens,

Any possibility to make v5 into v4.7 so that we can move on about
multipage bvecs?

BTW, even though not considering mp bvecs, this patchset is still a
good cleanup.

thanks,
Ming

> V4:
>         - make xfstests cover xfs
>         - rebase on for-next of block tree
> V3:
>         - include kenrel.h & bug.h in bvec.h for fix comiling failure on arm
>         as reported by 0day ktest
>         - build test on arm & arm64
>
> V2:
>         - rename bvec_iter.h as bvec.h
>         - always include bvec.h into blk_types.h as suggested by Christoph
>
> V1:
>         - don't move BIO_MAX_* to bvec_iter.h as pointed out by Christoph
>         - run xfstests against v4.6-rc1-next-20160329
>         - add Reviewed-by
>         - for 1,4 and 5, Reviewd-by not added, Christoph still expressed
>         'this looks fine to me.'
>
>
> Ming Lei (8):
>   block: move bvec iterator into include/linux/bvec.h
>   block: move two bvec structure into bvec.h
>   block: mark 1st parameter of bvec_iter_advance as const
>   iov_iter: use bvec iterator to implement iterate_bvec()
>   fs: xfs: replace BIO_MAX_SECTORS with BIO_MAX_PAGES
>   block: bio: remove BIO_MAX_SECTORS
>   block: drbd: avoid to use BIO_MAX_SIZE
>   block: bio: remove BIO_MAX_SIZE
>
>  drivers/block/drbd/drbd_int.h |  4 +-
>  fs/xfs/xfs_buf.c              |  4 +-
>  include/linux/bio.h           | 52 -----------------------
>  include/linux/blk_types.h     | 22 +---------
>  include/linux/bvec.h          | 96 +++++++++++++++++++++++++++++++++++++++++++
>  lib/iov_iter.c                | 45 +++++++-------------
>  6 files changed, 115 insertions(+), 108 deletions(-)
>  create mode 100644 include/linux/bvec.h
>
> --
> 1.9.1
>
