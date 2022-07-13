Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
	[209.85.208.47])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5B28C420FB1
	for <drbd-dev@lists.linbit.com>; Wed, 13 Jul 2022 14:25:41 +0200 (CEST)
Received: by mail-ed1-f47.google.com with SMTP id fd6so13865715edb.5
	for <drbd-dev@lists.linbit.com>; Wed, 13 Jul 2022 05:25:41 -0700 (PDT)
Message-ID: <1304fd58-1577-3f27-0ee8-64964bd54467@linbit.com>
Date: Wed, 13 Jul 2022 14:25:38 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20220713055317.1888500-1-hch@lst.de>
	<20220713055317.1888500-4-hch@lst.de>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220713055317.1888500-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>, linux-block@vger.kernel.org,
	Song Liu <song@kernel.org>, Andreas Dilger <adilger.kernel@dilger.ca>,
	Joel Becker <jlbec@evilplan.org>, Jan Kara <jack@suse.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	linux-ext4@vger.kernel.org, Jack Wang <jinpu.wang@ionos.com>,
	ocfs2-devel@oss.oracle.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 3/9] drbd: stop using bdevname in
	drbd_report_io_error
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

Am 13.07.22 um 07:53 schrieb Christoph Hellwig:
> Just use the %pg format specifier instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/drbd/drbd_req.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
> index e64bcfba30ef3..6d8dd14458c69 100644
> --- a/drivers/block/drbd/drbd_req.c
> +++ b/drivers/block/drbd/drbd_req.c
> @@ -523,16 +523,14 @@ static void mod_rq_state(struct drbd_request *req, struct bio_and_error *m,
>  
>  static void drbd_report_io_error(struct drbd_device *device, struct drbd_request *req)
>  {
> -        char b[BDEVNAME_SIZE];
> -
>  	if (!__ratelimit(&drbd_ratelimit_state))
>  		return;
>  
> -	drbd_warn(device, "local %s IO error sector %llu+%u on %s\n",
> +	drbd_warn(device, "local %s IO error sector %llu+%u on %pg\n",
>  			(req->rq_state & RQ_WRITE) ? "WRITE" : "READ",
>  			(unsigned long long)req->i.sector,
>  			req->i.size >> 9,
> -			bdevname(device->ldev->backing_bdev, b));
> +			device->ldev->backing_bdev);
>  }
>  
>  /* Helper for HANDED_OVER_TO_NETWORK.

For the drbd part:

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

Thanks.

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
