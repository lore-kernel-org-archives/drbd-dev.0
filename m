Return-Path: <msnitzer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A9BAA1057FD9
	for <drbd-dev@lists.linbit.com>; Thu, 23 Mar 2017 15:55:27 +0100 (CET)
Date: Thu, 23 Mar 2017 10:55:22 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20170323145522.GB17127@redhat.com>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323143341.31549-7-hch@lst.de>
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	lars.ellenberg@linbit.com, shli@kernel.org, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 06/23] dm-kcopyd: switch to use
	REQ_OP_WRITE_ZEROES
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

On Thu, Mar 23 2017 at 10:33am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> It seems like the code currently passes whatever it was using for writes
> to WRITE SAME.  Just switch it to WRITE ZEROES, although that doesn't
> need any payload.
> 
> Untested, and confused by the code, maybe someone who understands it
> better than me can help..
> 
> Not-yet-signed-off-by: Christoph Hellwig <hch@lst.de>

See commit 70d6c400a ("dm kcopyd: add WRITE SAME support to dm_kcopyd_zero")
drivers/md/dm-io.c:do_region() adjusts the WRITE SAME payload to be a
single page.

So you'd want to tweak dm-io.c accordingly for WRITE ZEROES (presummably
no payload?)

Mike

> ---
>  drivers/md/dm-kcopyd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/dm-kcopyd.c b/drivers/md/dm-kcopyd.c
> index 9e9d04cb7d51..f85846741d50 100644
> --- a/drivers/md/dm-kcopyd.c
> +++ b/drivers/md/dm-kcopyd.c
> @@ -733,11 +733,11 @@ int dm_kcopyd_copy(struct dm_kcopyd_client *kc, struct dm_io_region *from,
>  		job->pages = &zero_page_list;
>  
>  		/*
> -		 * Use WRITE SAME to optimize zeroing if all dests support it.
> +		 * Use WRITE ZEROES to optimize zeroing if all dests support it.
>  		 */
> -		job->rw = REQ_OP_WRITE_SAME;
> +		job->rw = REQ_OP_WRITE_ZEROES;
>  		for (i = 0; i < job->num_dests; i++)
> -			if (!bdev_write_same(job->dests[i].bdev)) {
> +			if (!bdev_write_zeroes_sectors(job->dests[i].bdev)) {
>  				job->rw = WRITE;
>  				break;
>  			}
> -- 
> 2.11.0
> 
