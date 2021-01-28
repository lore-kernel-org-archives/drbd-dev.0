Return-Path: <dave.kleikamp@oracle.com>
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1A2014207DE
	for <drbd-dev@lists.linbit.com>; Thu, 28 Jan 2021 13:44:04 +0100 (CET)
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com, xen-devel@lists.xenproject.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
	ocfs2-devel@oss.oracle.com, linux-pm@vger.kernel.org, linux-mm@kvack.org
References: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
	<20210128071133.60335-20-chaitanya.kulkarni@wdc.com>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Message-ID: <8d3f7e70-1c7a-567a-0e60-97bac846bf13@oracle.com>
Date: Thu, 28 Jan 2021 06:43:03 -0600
In-Reply-To: <20210128071133.60335-20-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Cc: shaggy@kernel.org, sergey.senozhatsky.work@gmail.com, snitzer@redhat.com,
	tiwai@suse.de, djwong@kernel.org, gustavoars@kernel.org,
	joseph.qi@linux.alibaba.com, pavel@ucw.cz,
	alex.shi@linux.alibaba.com, hch@lst.de, agk@redhat.com,
	naohiro.aota@wdc.com, sagi@grimberg.me, mark@fasheh.com,
	osandov@fb.com, ebiggers@kernel.org, ngupta@vflare.org,
	len.brown@intel.com, konrad.wilk@oracle.com, hare@suse.de,
	ming.lei@redhat.com, viro@zeniv.linux.org.uk,
	jefflexu@linux.alibaba.com, jaegeuk@kernel.org,
	konishi.ryusuke@gmail.com, bvanassche@acm.org, axboe@kernel.dk,
	damien.lemoal@wdc.com, jth@kernel.org, tytso@mit.edu,
	akpm@linux-foundation.org, martin.petersen@oracle.com,
	rjw@rjwysocki.net, philipp.reisner@linbit.com,
	minchan@kernel.org, tj@kernel.org, lars.ellenberg@linbit.com,
	roger.pau@citrix.com, asml.silence@gmail.com, jlbec@evilplan.org
Subject: Re: [Drbd-dev] [RFC PATCH 19/34] fs/jfs/jfs_logmgr.c: use bio_new
	in lbmRead
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

You probably don't need 4 patches to fs/jfs/. These can be combined into 
a single patch.

Dave

On 1/28/21 1:11 AM, Chaitanya Kulkarni wrote:
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>   fs/jfs/jfs_logmgr.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
> index 9330eff210e0..4481f3e33a3f 100644
> --- a/fs/jfs/jfs_logmgr.c
> +++ b/fs/jfs/jfs_logmgr.c
> @@ -1979,17 +1979,14 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
>   
>   	bp->l_flag |= lbmREAD;
>   
> -	bio = bio_alloc(GFP_NOFS, 1);
> -
> -	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
> -	bio_set_dev(bio, log->bdev);
> +	bio = bio_new(log->bdev, bp->l_blkno << (log->l2bsize - 9),
> +			REQ_OP_READ, 0, 1, GFP_NOFS);
>   
>   	bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
>   	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
>   
>   	bio->bi_end_io = lbmIODone;
>   	bio->bi_private = bp;
> -	bio->bi_opf = REQ_OP_READ;
>   	/*check if journaling to disk has been disabled*/
>   	if (log->no_integrity) {
>   		bio->bi_iter.bi_size = 0;
> 
