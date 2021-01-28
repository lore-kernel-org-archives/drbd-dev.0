Return-Path: <djwong@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 16C17420341
	for <drbd-dev@lists.linbit.com>; Thu, 28 Jan 2021 18:21:53 +0100 (CET)
Date: Thu, 28 Jan 2021 09:21:51 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Message-ID: <20210128172151.GN7698@magnolia>
References: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
	<20210128071133.60335-28-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128071133.60335-28-chaitanya.kulkarni@wdc.com>
Cc: shaggy@kernel.org, jfs-discussion@lists.sourceforge.net,
	gustavoars@kernel.org, sergey.senozhatsky.work@gmail.com,
	snitzer@redhat.com, tiwai@suse.de,
	linux-nvme@lists.infradead.org, philipp.reisner@linbit.com,
	linux-mm@kvack.org, dm-devel@redhat.com,
	target-devel@vger.kernel.org, pavel@ucw.cz,
	alex.shi@linux.alibaba.com, hch@lst.de, agk@redhat.com,
	drbd-dev@lists.linbit.com, naohiro.aota@wdc.com,
	linux-nilfs@vger.kernel.org, sagi@grimberg.me,
	linux-scsi@vger.kernel.org, mark@fasheh.com,
	konrad.wilk@oracle.com, osandov@fb.com, ebiggers@kernel.org,
	xen-devel@lists.xenproject.org, ngupta@vflare.org,
	len.brown@intel.com, linux-pm@vger.kernel.org, hare@suse.de,
	ming.lei@redhat.com, linux-block@vger.kernel.org, tj@kernel.org,
	linux-fscrypt@vger.kernel.org, viro@zeniv.linux.org.uk,
	jefflexu@linux.alibaba.com, jaegeuk@kernel.org,
	jlbec@evilplan.org, konishi.ryusuke@gmail.com,
	bvanassche@acm.org, axboe@kernel.dk, damien.lemoal@wdc.com,
	tytso@mit.edu, akpm@linux-foundation.org,
	martin.petersen@oracle.com, joseph.qi@linux.alibaba.com,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, minchan@kernel.org,
	linux-fsdevel@vger.kernel.org, lars.ellenberg@linbit.com,
	jth@kernel.org, asml.silence@gmail.com,
	ocfs2-devel@oss.oracle.com, roger.pau@citrix.com
Subject: Re: [Drbd-dev] [RFC PATCH 27/34] xfs: use bio_new in
	xfs_buf_ioapply_map
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

On Wed, Jan 27, 2021 at 11:11:26PM -0800, Chaitanya Kulkarni wrote:
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_buf.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index f8400bbd6473..3ff6235e4f94 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -1507,12 +1507,10 @@ xfs_buf_ioapply_map(
>  	atomic_inc(&bp->b_io_remaining);
>  	nr_pages = min(total_nr_pages, BIO_MAX_PAGES);
>  
> -	bio = bio_alloc(GFP_NOIO, nr_pages);
> -	bio_set_dev(bio, bp->b_target->bt_bdev);
> -	bio->bi_iter.bi_sector = sector;
> +	bio = bio_new(bp->b_target->bt_bdev, sector, op, 0, nr_pages,
> +		      GFP_NOIO);
>  	bio->bi_end_io = xfs_buf_bio_end_io;
>  	bio->bi_private = bp;
> -	bio->bi_opf = op;
>  
>  	for (; size && nr_pages; nr_pages--, page_index++) {
>  		int	rbytes, nbytes = PAGE_SIZE - offset;
> -- 
> 2.22.1
> 
