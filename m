Return-Path: <jlayton@kernel.org>
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C040942030E
	for <drbd-dev@lists.linbit.com>; Wed, 23 Feb 2022 16:44:17 +0100 (CET)
Message-ID: <ccc81eb5c23f933137c5da8d5050540cc54e58f0.camel@kernel.org>
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Andrew Morton <akpm@linux-foundation.org>,
	Jan Kara <jack@suse.cz>, Wu Fengguang <fengguang.wu@intel.com>, Jaegeuk Kim
	<jaegeuk@kernel.org>,  Chao Yu <chao@kernel.org>, Ilya Dryomov
	<idryomov@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Trond Myklebust
	<trond.myklebust@hammerspace.com>, Anna Schumaker
	<anna.schumaker@netapp.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>, Philipp Reisner
	<philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>
Date: Wed, 23 Feb 2022 10:43:42 -0500
In-Reply-To: <164549983739.9187.14895675781408171186.stgit@noble.brown>
References: <164549971112.9187.16871723439770288255.stgit@noble.brown>
	<164549983739.9187.14895675781408171186.stgit@noble.brown>
Content-Type: text/plain; charset="ISO-8859-15"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
	linux-ext4@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 06/11] ceph: remove reliance on bdi congestion
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

On Tue, 2022-02-22 at 14:17 +1100, NeilBrown wrote:
> The bdi congestion tracking in not widely used and will be removed.
> 
> CEPHfs is one of a small number of filesystems that uses it, setting
> just the async (write) congestion flags at what it determines are
> appropriate times.
> 
> The only remaining effect of the async flag is to cause (some)
> WB_SYNC_NONE writes to be skipped.
> 
> So instead of setting the flag, set an internal flag and change:
>  - .writepages to do nothing if WB_SYNC_NONE and the flag is set
>  - .writepage to return AOP_WRITEPAGE_ACTIVATE if WB_SYNC_NONE
>     and the flag is set.
> 
> The writepages change causes a behavioural change in that pageout() can
> now return PAGE_ACTIVATE instead of PAGE_KEEP, so SetPageActive() will
> be called on the page which (I think) wil further delay the next attempt
> at writeout.  This might be a good thing.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

Maybe. I have to wonder whether all of this is really useful.

When things are congested we'll avoid trying to issue new writeback
requests. Note that we don't prevent new pages from being dirtied here -
- only their being written back.

This also doesn't do anything in the DIO or sync_write cases, so if we
lose caps or are doing DIO, we'll just keep churning out "unlimited"
writes in those cases anyway.

With ceph too, we're not likely to be dealing with a single server as
well. One OSD could be struggling to keep up but others are OK. Do we
really want to throttle writeback to the ones that are fine?

FWIW, the original patch that added this stuff was this:

commit 2baba25019ec564cd247af74013873d69a0b8190
Author: Yehuda Sadeh <yehuda@hq.newdream.net>
Date:   Fri Dec 18 13:51:57 2009 -0800

    ceph: writeback congestion control
    
    Set bdi congestion bit when amount of write data in flight exceeds adjustable
    threshold.
    
    Signed-off-by: Yehuda Sadeh <yehuda@hq.newdream.net>
    Signed-off-by: Sage Weil <sage@newdream.net>

...but it's pretty scant on details.

The only reason I can see to throttle writeback like this is to prevent
you from having too much memory tied up in writeback requests, but we
aren't limiting other requests in the same way.

Maybe we would do better to just rip this stuff out?

> ---
>  fs/ceph/addr.c  |   22 +++++++++++++---------
>  fs/ceph/super.c |    1 +
>  fs/ceph/super.h |    1 +
>  3 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index c98e5238a1b6..dc7af34640dd 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -563,7 +563,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
>  
>  	if (atomic_long_inc_return(&fsc->writeback_count) >
>  	    CONGESTION_ON_THRESH(fsc->mount_options->congestion_kb))
> -		set_bdi_congested(inode_to_bdi(inode), BLK_RW_ASYNC);
> +		fsc->write_congested = true;
>  
>  	req = ceph_osdc_new_request(osdc, &ci->i_layout, ceph_vino(inode), page_off, &len, 0, 1,
>  				    CEPH_OSD_OP_WRITE, CEPH_OSD_FLAG_WRITE, snapc,
> @@ -623,7 +623,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
>  
>  	if (atomic_long_dec_return(&fsc->writeback_count) <
>  	    CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
> -		clear_bdi_congested(inode_to_bdi(inode), BLK_RW_ASYNC);
> +		fsc->write_congested = false;
>  
>  	return err;
>  }
> @@ -635,6 +635,10 @@ static int ceph_writepage(struct page *page, struct writeback_control *wbc)
>  	BUG_ON(!inode);
>  	ihold(inode);
>  
> +	if (wbc->sync_mode == WB_SYNC_NONE &&
> +	    ceph_inode_to_client(inode)->write_congested)
> +		return AOP_WRITEPAGE_ACTIVATE;
> +
>  	wait_on_page_fscache(page);
>  
>  	err = writepage_nounlock(page, wbc);
> @@ -707,8 +711,7 @@ static void writepages_finish(struct ceph_osd_request *req)
>  			if (atomic_long_dec_return(&fsc->writeback_count) <
>  			     CONGESTION_OFF_THRESH(
>  					fsc->mount_options->congestion_kb))
> -				clear_bdi_congested(inode_to_bdi(inode),
> -						    BLK_RW_ASYNC);
> +				fsc->write_congested = false;
>  
>  			ceph_put_snap_context(detach_page_private(page));
>  			end_page_writeback(page);
> @@ -760,6 +763,10 @@ static int ceph_writepages_start(struct address_space *mapping,
>  	bool done = false;
>  	bool caching = ceph_is_cache_enabled(inode);
>  
> +	if (wbc->sync_mode == WB_SYNC_NONE &&
> +	    fsc->write_congested)
> +		return 0;
> +
>  	dout("writepages_start %p (mode=%s)\n", inode,
>  	     wbc->sync_mode == WB_SYNC_NONE ? "NONE" :
>  	     (wbc->sync_mode == WB_SYNC_ALL ? "ALL" : "HOLD"));
> @@ -954,11 +961,8 @@ static int ceph_writepages_start(struct address_space *mapping,
>  
>  			if (atomic_long_inc_return(&fsc->writeback_count) >
>  			    CONGESTION_ON_THRESH(
> -				    fsc->mount_options->congestion_kb)) {
> -				set_bdi_congested(inode_to_bdi(inode),
> -						  BLK_RW_ASYNC);
> -			}
> -
> +				    fsc->mount_options->congestion_kb))
> +				fsc->write_congested = true;
>  
>  			pages[locked_pages++] = page;
>  			pvec.pages[i] = NULL;
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index bf79f369aec6..4a3b77d049c7 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -802,6 +802,7 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
>  	fsc->have_copy_from2 = true;
>  
>  	atomic_long_set(&fsc->writeback_count, 0);
> +	fsc->write_congested = false;
>  
>  	err = -ENOMEM;
>  	/*
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 67f145e1ae7a..0bd97aea2319 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -121,6 +121,7 @@ struct ceph_fs_client {
>  	struct ceph_mds_client *mdsc;
>  
>  	atomic_long_t writeback_count;
> +	bool write_congested;
>  
>  	struct workqueue_struct *inode_wq;
>  	struct workqueue_struct *cap_wq;
> 
> 

-- 
Jeff Layton <jlayton@kernel.org>
