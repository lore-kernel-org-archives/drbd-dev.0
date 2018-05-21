Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 719571005433
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2018 15:40:49 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id j4-v6so9160942wme.1
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2018 06:40:49 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	y63-v6sm10233990edy.63.2018.05.23.06.40.47
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 23 May 2018 06:40:48 -0700 (PDT)
Resent-Message-ID: <20180523134047.GV499@soda.linbit>
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5B8D01018D73
	for <drbd-dev@lists.linbit.com>; Mon, 21 May 2018 20:40:04 +0200 (CEST)
Date: Mon, 21 May 2018 11:39:36 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Kent Overstreet <kent.overstreet@gmail.com>
Message-ID: <20180521183936.GJ23858@magnolia>
References: <20180520222558.7053-1-kent.overstreet@gmail.com>
	<20180520222558.7053-12-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180520222558.7053-12-kent.overstreet@gmail.com>
Cc: axboe@kernel.dk, hch@infradead.org, linux-raid@vger.kernel.org,
	snitzer@redhat.com, linux-kernel@vger.kernel.org, colyli@suse.de,
	linux-block@vger.kernel.org, clm@fb.com, neilb@suse.com,
	bacik@fb.com, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 11/12] xfs: convert to
	bioset_init()/mempool_init()
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

On Sun, May 20, 2018 at 06:25:57PM -0400, Kent Overstreet wrote:
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>

Looks ok, I guess...
Acked-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_aops.c  |  2 +-
>  fs/xfs/xfs_aops.h  |  2 +-
>  fs/xfs/xfs_super.c | 11 +++++------
>  3 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 0ab824f574..102463543d 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -594,7 +594,7 @@ xfs_alloc_ioend(
>  	struct xfs_ioend	*ioend;
>  	struct bio		*bio;
>  
> -	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_PAGES, xfs_ioend_bioset);
> +	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_PAGES, &xfs_ioend_bioset);
>  	xfs_init_bio_from_bh(bio, bh);
>  
>  	ioend = container_of(bio, struct xfs_ioend, io_inline_bio);
> diff --git a/fs/xfs/xfs_aops.h b/fs/xfs/xfs_aops.h
> index 69346d460d..694c85b038 100644
> --- a/fs/xfs/xfs_aops.h
> +++ b/fs/xfs/xfs_aops.h
> @@ -18,7 +18,7 @@
>  #ifndef __XFS_AOPS_H__
>  #define __XFS_AOPS_H__
>  
> -extern struct bio_set *xfs_ioend_bioset;
> +extern struct bio_set xfs_ioend_bioset;
>  
>  /*
>   * Types of I/O for bmap clustering and I/O completion tracking.
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index d714240529..f643d76db5 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -63,7 +63,7 @@
>  #include <linux/parser.h>
>  
>  static const struct super_operations xfs_super_operations;
> -struct bio_set *xfs_ioend_bioset;
> +struct bio_set xfs_ioend_bioset;
>  
>  static struct kset *xfs_kset;		/* top-level xfs sysfs dir */
>  #ifdef DEBUG
> @@ -1845,10 +1845,9 @@ MODULE_ALIAS_FS("xfs");
>  STATIC int __init
>  xfs_init_zones(void)
>  {
> -	xfs_ioend_bioset = bioset_create(4 * MAX_BUF_PER_PAGE,
> +	if (bioset_init(&xfs_ioend_bioset, 4 * MAX_BUF_PER_PAGE,
>  			offsetof(struct xfs_ioend, io_inline_bio),
> -			BIOSET_NEED_BVECS);
> -	if (!xfs_ioend_bioset)
> +			BIOSET_NEED_BVECS))
>  		goto out;
>  
>  	xfs_log_ticket_zone = kmem_zone_init(sizeof(xlog_ticket_t),
> @@ -1997,7 +1996,7 @@ xfs_init_zones(void)
>   out_destroy_log_ticket_zone:
>  	kmem_zone_destroy(xfs_log_ticket_zone);
>   out_free_ioend_bioset:
> -	bioset_free(xfs_ioend_bioset);
> +	bioset_exit(&xfs_ioend_bioset);
>   out:
>  	return -ENOMEM;
>  }
> @@ -2029,7 +2028,7 @@ xfs_destroy_zones(void)
>  	kmem_zone_destroy(xfs_btree_cur_zone);
>  	kmem_zone_destroy(xfs_bmap_free_item_zone);
>  	kmem_zone_destroy(xfs_log_ticket_zone);
> -	bioset_free(xfs_ioend_bioset);
> +	bioset_exit(&xfs_ioend_bioset);
>  }
>  
>  STATIC int __init
> -- 
> 2.17.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
