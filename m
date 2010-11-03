Return-Path: <BATV+8bc7b7cc9627fb935322+2628+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 1F21B105938B
	for <drbd-dev@lists.linbit.com>; Wed,  3 Nov 2010 17:53:36 +0100 (CET)
Date: Wed, 3 Nov 2010 12:10:59 -0400
From: Christoph Hellwig <hch@infradead.org>
To: Tejun Heo <tj@kernel.org>
Message-ID: <20101103161059.GA13621@infradead.org>
References: <1288628129-12811-1-git-send-email-tj@kernel.org>
	<1288628129-12811-5-git-send-email-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1288628129-12811-5-git-send-email-tj@kernel.org>
Cc: jack@suse.cz, leochen@broadcom.com, neilb@suse.de,
	heiko.carstens@de.ibm.com, dm-devel@redhat.com,
	adilger.kernel@dilger.ca, konishi.ryusuke@lab.ntt.co.jp,
	shaggy@linux.vnet.ibm.com, drbd-dev@lists.linbit.com,
	joel.becker@oracle.com, hch@infradead.org, aelder@sgi.com,
	mfasheh@suse.com, joern@logfs.org,
	reiserfs-devel@vger.kernel.org, viro@zeniv.linux.org.uk,
	swhiteho@redhat.com, chris.mason@oracle.com, axboe@kernel.dk,
	tytso@mit.edu, sbranden@broadcom.com, petero2@telia.com,
	linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
	akpm@linux-foundation.org
Subject: Re: [Drbd-dev] [PATCH 4/5] block: make blkdev_get/put() handle
	exclusive access
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Nov 01, 2010 at 05:15:28PM +0100, Tejun Heo wrote:
> * blkdev_get() is extended to include exclusive access management.
>   @holder argument is added and, if is @FMODE_EXCL specified, it will
>   gain exclusive access atomically w.r.t. other exclusive accesses.
> 
> * blkdev_put() is similarly extended.  It now takes @mode argument and
>   if @FMODE_EXCL is set, it releases an exclusive access.  Also, when
>   the last exclusive claim is released, the holder/slave symlinks are
>   removed automatically.

Could we get rid of FMODE_EXCL and just make a non-NULL holder field
mean to open it exlusively (and pass a holder to the blkdev_put to
release it)?

> * bd_link_disk_holder() remains the same but bd_unlink_disk_holder()
>   is no longer necessary and removed.

That's a rather asymetric interface.  What about having
blkdev_get_stacked that require a gendisk as holder and set up the
links underneath?


> open_bdev_exclusive() and open_by_devnum() can use further cleanup -
> rename to blkdev_get_by_path() and blkdev_get_by_devt() and drop
> special features.  Well, let's leave them for another day.

s/blkdev_get_by_devt/blkdev_get_by_dev/

And yes, that rename is a good idea and should go in ASAP after this
patch.

