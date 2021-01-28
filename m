Return-Path: <djwong@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BE298420341
	for <drbd-dev@lists.linbit.com>; Thu, 28 Jan 2021 18:24:03 +0100 (CET)
Date: Thu, 28 Jan 2021 09:24:02 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Message-ID: <20210128172402.GO7698@magnolia>
References: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
	<20210128071133.60335-19-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128071133.60335-19-chaitanya.kulkarni@wdc.com>
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
Subject: Re: [Drbd-dev] [RFC PATCH 18/34] iomap: use bio_new in
	iomap_dio_bio_actor
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

On Wed, Jan 27, 2021 at 11:11:17PM -0800, Chaitanya Kulkarni wrote:
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  fs/iomap/direct-io.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index f6c557a1bd25..0737192f7e5c 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -267,9 +267,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  			goto out;
>  		}
>  
> -		bio = bio_alloc(GFP_KERNEL, nr_pages);
> -		bio_set_dev(bio, iomap->bdev);
> -		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
> +		bio = bio_new(iomap->bdev, iomap_sector(iomap, pos), 0, 0,
> +			      nr_pages, GFP_KERNEL);

op == 0?  It seems a little odd to me that we'd set the field to zero
and then construct bi_opf later.

It also strikes me as a little strange that bi_opf is combined from the
third and fourth parameters, but maybe some day you'll want to do some
parameter verification on debug kernels or something...?

--D

>  		bio->bi_write_hint = dio->iocb->ki_hint;
>  		bio->bi_ioprio = dio->iocb->ki_ioprio;
>  		bio->bi_private = dio;
> -- 
> 2.22.1
> 
