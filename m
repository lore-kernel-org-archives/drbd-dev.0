Return-Path: <lars.ellenberg@linbit.com>
Received: from racke.linbit (office.linbit [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 99F6A2E089A8
	for <drbd-dev@lists.linbit.com>; Mon, 14 Apr 2008 23:43:47 +0200 (CEST)
Date: Mon, 14 Apr 2008 23:44:18 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] - DRBD 8.0: Add standard disk counters to
	DRBD devices
Message-ID: <20080414214418.GB11768@racke.local>
References: <342BAC0A5467384983B586A6B0B3767108F031F6@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B3767108F031F6@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Apr 14, 2008 at 02:58:26PM -0400, Graham, Simon wrote:
> The attached patch adds support for the standard disk stats (as reported
> in /proc/diskstats et al) at the DRBD device level - this is nice
> because it can be used to show the actual response times etc at that
> level, after both local and remote (and meta data) I/O is done. These
> numbers also show up in the standard sar data for disk I/O.

wonderful :)
had been somewhere on my todo list for month, 
never got around even to look at it, though.
thanks!

> It was a little trickier than I thought because getting the right values
> for the various time fields is not obvious but in the end I copied what
> md and ll_rw_blk.c do and the numbers certainly look correct now. There
> are also a few error paths at the top of make_request that do not count
> bio's that are failed early - since I need to hold the mdev request lock
> when manipulating the counters, I put the code in after the lock was
> already acquired which leaves a few error paths that are not counted.
> However, the normal paths are there, so I think it's OK.

that sounds perfectly reasonable.

Content-Description: 0003-Add-support-for-standard-disk-stats-to-DRBD-devices.patch
> From 0b35a81ccda06c6711cdf3cbae1a0cff033ca25e Mon Sep 17 00:00:00 2001
> From: Simon P. Graham <Simon.Graham@stratus.com>
> Date: Mon, 14 Apr 2008 10:35:33 -0400
> Subject: [PATCH] Add support for standard disk stats to DRBD devices
> 
> ---
>  drbd/drbd_int.h |    1 +
>  drbd/drbd_req.c |   38 ++++++++++++++++++++++++++++++++++++++
>  drbd/drbd_req.h |    1 +
>  3 files changed, 40 insertions(+), 0 deletions(-)
> 
> diff --git a/drbd/drbd_int.h b/drbd/drbd_int.h
> index 8f693f3..05edc55 100644
> --- a/drbd/drbd_int.h
> +++ b/drbd/drbd_int.h
> @@ -629,6 +629,7 @@ struct drbd_request {
>  	struct bio *master_bio;       /* master bio pointer */
>  	unsigned long rq_state; /* see comments above _req_mod() */
>  	int seq_num;
> +	unsigned long start_time;
>  };

yes, structures keep growing ...
somewhen we need to clean it all up again.

>  struct drbd_barrier {
> diff --git a/drbd/drbd_req.c b/drbd/drbd_req.c
> index f06a0e4..d75b674 100644
> --- a/drbd/drbd_req.c
> +++ b/drbd/drbd_req.c
> @@ -105,6 +105,37 @@ void _print_req_mod(drbd_request_t *req,drbd_req_event_t what)
>  #define print_req_mod(T,W)
>  #endif
>  
> +/* Update disk stats at start of I/O request */
> +static inline void _drbd_start_io_acct(drbd_dev *mdev, drbd_request_t *req, struct bio *bio)
> +{
> +	int rw = bio_data_dir(bio);
> +
> +	MUST_HOLD(&mdev->req_lock)
> +
> +	disk_stat_inc(mdev->vdisk, ios[rw]);
> +	disk_stat_add(mdev->vdisk, sectors[rw], bio_sectors(bio));
> +	preempt_disable();

we are inside a spin_lock, no need to manipulate preempt,
there is no preemptible spin_lock yet.

> +	disk_round_stats(mdev->vdisk);
> +	preempt_enable();
> +	mdev->vdisk->in_flight++;
> +}
> +
> +/* Update disk stats when completing request upwards */
> +static inline void _drbd_end_io_acct(drbd_dev *mdev, drbd_request_t *req)
> +{
> +	int rw = bio_data_dir(req->master_bio);
> +	unsigned long duration = jiffies - req->start_time;
> +
> +	MUST_HOLD(&mdev->req_lock)
> +
> +	preempt_disable();

same here.

> +	disk_round_stats(mdev->vdisk);
> +	preempt_enable();
> +	mdev->vdisk->in_flight--;
> +
> +	disk_stat_add(mdev->vdisk, ticks[rw], duration);
> +}
> +
>  static void _req_is_done(drbd_dev *mdev, drbd_request_t *req, const int rw)
>  {
>  	const unsigned long s = req->rq_state;
> @@ -335,6 +366,9 @@ void _req_may_be_done(drbd_request_t *req, int error)
>  		 * then again, if it is a READ, it is not in the TL at all.
>  		 * is it still leagal to complete a READ during freeze? */
>  
> +		/* Update disk stats */
> +		_drbd_end_io_acct(mdev, req);
> +
>  		_complete_master_bio(mdev,req,
>  			  ok ? 0 : ( error ? error : -EIO ) );
>  	} else {
> @@ -956,6 +990,9 @@ drbd_make_request_common(drbd_dev *mdev, struct bio *bio)
>  	}
>  
>  
> +	/* Update disk stats */
> +	_drbd_start_io_acct(mdev, req, bio);
> +
>  	/* _maybe_start_new_epoch(mdev);
>  	 * If we need to generate a write barrier packet, we have to add the
>  	 * new epoch (barrier) object, and queue the barrier packet for sending,
> @@ -1012,6 +1049,7 @@ drbd_make_request_common(drbd_dev *mdev, struct bio *bio)
>  			local = 0;
>  		}
>  		if (remote) dec_ap_pending(mdev);
> +		_drbd_end_io_acct(mdev, req);
>  		/* THINK: do we want to fail it (-EIO), or pretend success? */
>  		bio_endio(req->master_bio, 0);
>  		req->master_bio = NULL;
> diff --git a/drbd/drbd_req.h b/drbd/drbd_req.h
> index 1d981b2..74d8dc1 100644
> --- a/drbd/drbd_req.h
> +++ b/drbd/drbd_req.h
> @@ -284,6 +284,7 @@ static inline drbd_request_t* drbd_req_new(drbd_dev *mdev, struct bio *bio_src)
>  		req->epoch       = 0;
>  		req->sector      = bio->bi_sector;
>  		req->size        = bio->bi_size;
> +		req->start_time  = jiffies;
>  		INIT_HLIST_NODE(&req->colision);
>  		INIT_LIST_HEAD(&req->tl_requests);
>  
> -- 
> 1.5.4-rc1.GIT
> 

> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev


-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
