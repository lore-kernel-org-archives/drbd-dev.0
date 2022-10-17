Return-Path: <axboe@kernel.dk>
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
	[209.85.216.42])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CAC1D4201A5
	for <drbd-dev@lists.linbit.com>; Mon, 17 Oct 2022 16:22:44 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
	o17-20020a17090aac1100b0020d98b0c0f4so13007855pjq.4
	for <drbd-dev@lists.linbit.com>; Mon, 17 Oct 2022 07:22:44 -0700 (PDT)
Message-ID: <79b12322-4298-2a2f-c126-a00071e31f1d@kernel.dk>
Date: Mon, 17 Oct 2022 08:22:41 -0600
MIME-Version: 1.0
To: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
References: <20221017090154.15696-1-christoph.boehmwalder@linbit.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221017090154.15696-1-christoph.boehmwalder@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: Store op in drbd_peer_request
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

On 10/17/22 3:01 AM, Christoph B?hmwalder wrote:
> diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
> index 4d661282ff41..0f8e3b94a635 100644
> --- a/drivers/block/drbd/drbd_int.h
> +++ b/drivers/block/drbd/drbd_int.h
> @@ -395,6 +395,7 @@ struct drbd_peer_request {
>  	struct drbd_peer_device *peer_device;
>  	struct drbd_epoch *epoch; /* for writes */
>  	struct page *pages;
> +	unsigned int opf; /* to be used as bi_opf */

Why isn't this blk_opf_t?

-- 
Jens Axboe
