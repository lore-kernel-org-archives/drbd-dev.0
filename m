Return-Path: <snitzer@redhat.com>
Received: from us-smtp-delivery-124.mimecast.com
	(us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id DFD76420026
	for <drbd-dev@lists.linbit.com>; Wed,  2 Feb 2022 20:42:39 +0100 (CET)
Received: by mail-qt1-f198.google.com with SMTP id
	e28-20020ac8415c000000b002c5e43ca6b7so156670qtm.9
	for <drbd-dev@lists.linbit.com>; Wed, 02 Feb 2022 11:42:35 -0800 (PST)
Date: Wed, 2 Feb 2022 14:42:33 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <YfreqbCOPYFrQm73@redhat.com>
References: <20220202160109.108149-1-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20220202160109.108149-1-hch@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Pavel Begunkov <asml.silence@gmail.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] improve the bio cloning interface v2
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

On Wed, Feb 02 2022 at 11:00P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> Hi Jens,
> 
> this series changes the bio cloning interface to match the rest changes
> to the bio allocation interface and passes the block_device and operation
> to the cloning helpers.  In addition it renames the cloning helpers to
> be more descriptive.
> 
> To get there it requires a bit of refactoring in the device mapper code.
> 
> Changes since v1:
>  - rebased to the lastest for-5.18/block tree
>  - fix a fatal double initialization in device mapper
> 
> A git tree is also available here:
> 
>     git://git.infradead.org/users/hch/block.git bio_alloc-cleanup-part2
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/bio_alloc-cleanup-part2
> 
> Diffstat:
>  Documentation/block/biodoc.rst   |    5 -
>  block/bio-integrity.c            |    1 
>  block/bio.c                      |  106 +++++++++++++-----------
>  block/blk-crypto.c               |    1 
>  block/blk-mq.c                   |    4 
>  block/bounce.c                   |    3 
>  drivers/block/drbd/drbd_req.c    |    5 -
>  drivers/block/drbd/drbd_worker.c |    4 
>  drivers/block/pktcdvd.c          |    4 
>  drivers/md/bcache/request.c      |    6 -
>  drivers/md/dm-cache-target.c     |   26 ++----
>  drivers/md/dm-crypt.c            |   11 +-
>  drivers/md/dm-zoned-target.c     |    3 
>  drivers/md/dm.c                  |  166 +++++++++++++--------------------------
>  drivers/md/md-faulty.c           |    4 
>  drivers/md/md-multipath.c        |    4 
>  drivers/md/md.c                  |    5 -
>  drivers/md/raid1.c               |   34 +++----
>  drivers/md/raid10.c              |   16 +--
>  drivers/md/raid5.c               |    4 
>  fs/btrfs/extent_io.c             |    4 
>  include/linux/bio.h              |    6 -
>  22 files changed, 183 insertions(+), 239 deletions(-)
> 

Looks good, for all:

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

I have some DM core changes for 5.18 that I need to make and this
patchset offers enough DM churn that I'd like to base my changes
ontop.  So I'd appreciate it if this patchset could land in block's
for-5.18 ASAP.

Thanks,
Mike

