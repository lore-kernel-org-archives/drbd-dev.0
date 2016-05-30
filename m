Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 461341056447
	for <drbd-dev@lists.linbit.com>; Tue, 31 May 2016 11:47:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 31E673EB2B4
	for <drbd-dev@lists.linbit.com>; Tue, 31 May 2016 11:47:54 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 7xxMQLzsBLVx for <drbd-dev@lists.linbit.com>;
	Tue, 31 May 2016 11:47:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 158443F68C0
	for <drbd-dev@lists.linbit.com>; Tue, 31 May 2016 11:47:54 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pGGrwZ3vj3iC for <drbd-dev@lists.linbit.com>;
	Tue, 31 May 2016 11:47:54 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id E02D23EB2B4
	for <drbd-dev@lists.linbit.com>; Tue, 31 May 2016 11:47:53 +0200 (CEST)
Resent-Message-ID: <20160531094753.GE3235@soda.linbit>
Received: from mail-pf0-f173.google.com (mail-pf0-f173.google.com
	[209.85.192.173]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 5BB041056444
	for <drbd-dev@lists.linbit.com>; Mon, 30 May 2016 15:43:25 +0200 (CEST)
Received: by mail-pf0-f173.google.com with SMTP id f144so52237889pfa.3
	for <drbd-dev@lists.linbit.com>; Mon, 30 May 2016 06:43:25 -0700 (PDT)
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 30 May 2016 21:34:28 +0800
Message-Id: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
Cc: Christoph Hellwig <hch@infradead.org>, Michal Hocko <mhocko@suse.com>,
	Jan Kara <jack@suse.cz>, Mike Snitzer <snitzer@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Ming Lei <ming.lei@canonical.com>, NeilBrown <neilb@suse.com>,
	Sagi Grimberg <sagig@mellanox.com>,
	Steven Whitehouse <swhiteho@redhat.com>,
	linux-block@vger.kernel.org, Joe Thornber <ejt@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Shaohua Li <shli@fb.com>,
	Tejun Heo <tj@kernel.org>, Keith Busch <keith.busch@intel.com>,
	"open list:XFS FILESYSTEM" <xfs@oss.sgi.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH v6 0/8] block: prepare for multipage bvecs
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

2) remove BIO_MAX_SECTORS and makre BIO_MAX_SIZE as obsolete, and
now there is only one user for each. Once multipage bvecs is introduced,
one bio may hold lots of sectors, and we should always use sort of
BIO_MAX_VECS which should be introduced in future and is similiar
with current BIO_MAX_PAGES.

The only functional change is iterate_bvec():lib/iov_iter.c

xfstests(-a auto) over loop aio is run for ext4/xfs to verify 
the change and no regression found with this patchset.

V6:
	- rebased on v4.7-rc1
	- add reviewed-by tag
	- mark BIO_MAX_SIZE as obsolete instead of removing because
	dm-tree adds one usage now

V5:
	- use bvec's iterator to figure new base vec address and
	update 'skip' correctly
	- run xfstests(-a auto) on loop aio/dio for verifying
	the change in iterate_bvec(), and no regression reported
	- use stree-ng to trigger heavy swap over swapfile to verify
	change in iterate_bvec() too, looks everything is fine
V4:
	- make xfstests cover xfs
	- rebase on for-next of block tree
V3:
	- include kenrel.h & bug.h in bvec.h for fix comiling failure on arm
	as reported by 0day ktest
	- build test on arm & arm64

V2:
	- rename bvec_iter.h as bvec.h
	- always include bvec.h into blk_types.h as suggested by Christoph

V1:
	- don't move BIO_MAX_* to bvec_iter.h as pointed out by Christoph
	- run xfstests against v4.6-rc1-next-20160329
	- add Reviewed-by
	- for 1,4 and 5, Reviewd-by not added, Christoph still expressed
	'this looks fine to me.'


Ming Lei (8):
  block: move bvec iterator into include/linux/bvec.h
  block: move two bvec structure into bvec.h
  block: mark 1st parameter of bvec_iter_advance as const
  iov_iter: use bvec iterator to implement iterate_bvec()
  fs: xfs: replace BIO_MAX_SECTORS with BIO_MAX_PAGES
  block: bio: remove BIO_MAX_SECTORS
  block: drbd: avoid to use BIO_MAX_SIZE
  block: mark BIO_MAX_SIZE as obsolete

 drivers/block/drbd/drbd_int.h |  4 +-
 fs/xfs/xfs_buf.c              |  4 +-
 include/linux/bio.h           | 58 ++++----------------------
 include/linux/blk_types.h     | 22 +---------
 include/linux/bvec.h          | 96 +++++++++++++++++++++++++++++++++++++++++++
 lib/iov_iter.c                | 45 +++++++-------------
 6 files changed, 122 insertions(+), 107 deletions(-)
 create mode 100644 include/linux/bvec.h

-- 
1.9.1

