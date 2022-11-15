Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
	[209.85.208.42])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id EC4BB42066F
	for <drbd-dev@lists.linbit.com>; Tue, 15 Nov 2022 15:05:47 +0100 (CET)
Received: by mail-ed1-f42.google.com with SMTP id l11so22025843edb.4
	for <drbd-dev@lists.linbit.com>; Tue, 15 Nov 2022 06:05:47 -0800 (PST)
Message-ID: <d0ff33bf-d39b-005c-ab62-42cae97e3b8c@linbit.com>
Date: Tue, 15 Nov 2022 15:05:46 +0100
MIME-Version: 1.0
To: Dan Carpenter <error27@gmail.com>
References: <Y3Jd5iZRbNQ9w6gm@kili>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <Y3Jd5iZRbNQ9w6gm@kili>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, kernel-janitors@vger.kernel.org,
	Andreas Gruenbacher <agruen@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: use after free in drbd_create_device()
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

Am 15.11.22 um 14:16 schrieb Dan Carpenter:
> The drbd_destroy_connection() frees the "connection" so use the _safe()
> iterator to prevent a use after free.
> 
> Fixes: b6f85ef9538b ("drbd: Iterate over all connections")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
> Smatch assumes that kref_put() generally calls the free function so it
> gets very confused by drbd_delete_device() which calls:
> 
> 	kref_put(&device->kref, drbd_destroy_device);
> 
> Four times in a row.  (Smatch has some checking for incremented
> reference counts but even there it assumes that people are going to hold
> one reference and not four).
> 
> drivers/block/drbd/drbd_main.c:2831 drbd_delete_device() error: dereferencing freed memory 'device'
> drivers/block/drbd/drbd_main.c:2833 drbd_delete_device() warn: passing freed memory 'device'
> drivers/block/drbd/drbd_main.c:2835 drbd_delete_device() error: dereferencing freed memory 'device'
> 
> The drbd_adm_get_status_all() function makes me itch as well.  It seems
> like we drop a reference and then take it again?
> 
> drivers/block/drbd/drbd_nl.c:4019 drbd_adm_get_status_all() warn: 'resource' was already freed.
> drivers/block/drbd/drbd_nl.c:4021 drbd_adm_get_status_all() warn: 'resource' was already freed.
> 
>  drivers/block/drbd/drbd_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index f3e4db16fd07..8532b839a343 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -2672,7 +2672,7 @@ static int init_submitter(struct drbd_device *device)
>  enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsigned int minor)
>  {
>  	struct drbd_resource *resource = adm_ctx->resource;
> -	struct drbd_connection *connection;
> +	struct drbd_connection *connection, *n;
>  	struct drbd_device *device;
>  	struct drbd_peer_device *peer_device, *tmp_peer_device;
>  	struct gendisk *disk;
> @@ -2789,7 +2789,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
>  	return NO_ERROR;
>  
>  out_idr_remove_from_resource:
> -	for_each_connection(connection, resource) {
> +	for_each_connection_safe(connection, n, resource) {
>  		peer_device = idr_remove(&connection->peer_devices, vnr);
>  		if (peer_device)
>  			kref_put(&connection->kref, drbd_destroy_connection);

Thanks!

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
