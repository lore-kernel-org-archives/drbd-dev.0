Return-Path: <jack@suse.cz>
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 31019420164
	for <drbd-dev@lists.linbit.com>; Thu, 10 Feb 2022 11:09:23 +0100 (CET)
Date: Thu, 10 Feb 2022 11:02:22 +0100
From: Jan Kara <jack@suse.cz>
To: NeilBrown <neilb@suse.de>
Message-ID: <20220210100222.f2nmwwb5pcfmejvw@quack3.lan>
References: <164447124918.23354.17858831070003318849.stgit@noble.brown>
	<164447147264.23354.2763356897218946255.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164447147264.23354.2763356897218946255.stgit@noble.brown>
Cc: Jan Kara <jack@suse.cz>, linux-doc@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	drbd-dev@lists.linbit.com, Paolo Valente <paolo.valente@linaro.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org,
	Chao Yu <chao@kernel.org>, linux-block@vger.kernel.org,
	linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
	ceph-devel@vger.kernel.org, Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nfs@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Wu Fengguang <fengguang.wu@intel.com>,
	Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [Drbd-dev] [PATCH 10/11] block/bfq-iosched.c: use "false"
 rather than "BLK_RW_ASYNC"
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

On Thu 10-02-22 16:37:52, NeilBrown wrote:
> bfq_get_queue() expects a "bool" for the third arg, so pass "false"
> rather than "BLK_RW_ASYNC" which will soon be removed.
> 
> Acked-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: NeilBrown <neilb@suse.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 0c612a911696..4e645ae1e066 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5448,7 +5448,7 @@ static void bfq_check_ioprio_change(struct bfq_io_cq *bic, struct bio *bio)
>  	bfqq = bic_to_bfqq(bic, false);
>  	if (bfqq) {
>  		bfq_release_process_ref(bfqd, bfqq);
> -		bfqq = bfq_get_queue(bfqd, bio, BLK_RW_ASYNC, bic, true);
> +		bfqq = bfq_get_queue(bfqd, bio, false, bic, true);
>  		bic_set_bfqq(bic, bfqq, false);
>  	}
>  
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
