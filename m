Return-Path: <mcgrof@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BBC89420603
	for <drbd-dev@lists.linbit.com>; Wed,  1 Sep 2021 21:38:48 +0200 (CEST)
Date: Wed, 1 Sep 2021 12:38:27 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk, justin@coraid.com, geert@linux-m68k.org,
	ulf.hansson@linaro.org, hare@suse.de, tj@kernel.org,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
	johannes.berg@intel.com, chris.obbard@collabora.com,
	krisman@collabora.com, zhuyifei1999@gmail.com, thehajime@gmail.com,
	chris@zankel.net, jcmvbkbc@gmail.com, tim@cyberelk.net
Message-ID: <YS/Ws2iD1suaut39@bombadil.infradead.org>
References: <20210830221000.179369-1-mcgrof@kernel.org>
	<20210830221000.179369-16-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830221000.179369-16-mcgrof@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Cc: linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 15/15] pd: add error handling support for
	add_disk()
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

On Mon, Aug 30, 2021 at 03:10:00PM -0700, Luis Chamberlain wrote:
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/block/paride/pd.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
> index 500b89a4bdaf..226ed5c93b68 100644
> --- a/drivers/block/paride/pd.c
> +++ b/drivers/block/paride/pd.c
> @@ -938,8 +938,12 @@ static int pd_probe_drive(struct pd_unit *disk, int autoprobe, int port,
>  	if (ret)
>  		goto put_disk;
>  	set_capacity(disk->gd, disk->capacity);
> -	add_disk(disk->gd);
> +	ret = add_disk(disk->gd);
> +	if (ret)
> +		goto cleanup_disk;
>  	return 0;
> +cleanup_disk:
> +	blk_cleanup_disk(&disk);

This should be blk_cleanup_disk(disk->gd); Will fix up in my v2.

  Luis
