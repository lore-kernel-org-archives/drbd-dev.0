Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
	[209.85.208.47])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C7B3C4204BE
	for <drbd-dev@lists.linbit.com>; Wed, 22 Jun 2022 16:12:56 +0200 (CEST)
Received: by mail-ed1-f47.google.com with SMTP id o10so24101133edi.1
	for <drbd-dev@lists.linbit.com>; Wed, 22 Jun 2022 07:12:56 -0700 (PDT)
Message-ID: <b628a808-bb07-c94f-9d70-6bd4eb4be690@linbit.com>
Date: Wed, 22 Jun 2022 16:12:54 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Xiang wangx <wangxiang@cdjrlc.com>
References: <20220616143227.4004-1-wangxiang@cdjrlc.com>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220616143227.4004-1-wangxiang@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: Fix typo in comment
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

Am 16.06.22 um 16:32 schrieb Xiang wangx:
> Delete the redundant word 'and'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>  drivers/block/drbd/drbd_bitmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
> index 9e060e49b3f8..8afdde400e37 100644
> --- a/drivers/block/drbd/drbd_bitmap.c
> +++ b/drivers/block/drbd/drbd_bitmap.c
> @@ -86,7 +86,7 @@ struct drbd_bitmap {
>  
>  	/* exclusively to be used by __al_write_transaction(),
>  	 * drbd_bm_mark_for_writeout() and
> -	 * and drbd_bm_write_hinted() -> bm_rw() called from there.
> +	 * drbd_bm_write_hinted() -> bm_rw() called from there.
>  	 */
>  	unsigned int n_bitmap_hints;
>  	unsigned int al_bitmap_hints[AL_UPDATES_PER_TRANSACTION];

Thanks!

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
