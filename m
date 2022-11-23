Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
	[209.85.221.42])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 193114252F3
	for <drbd-dev@lists.linbit.com>; Wed, 23 Nov 2022 11:16:38 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id x5so24587667wrt.7
	for <drbd-dev@lists.linbit.com>; Wed, 23 Nov 2022 02:16:38 -0800 (PST)
Message-ID: <e396a423-97e7-2b50-21e3-7ac4070b6d9a@linbit.com>
Date: Wed, 23 Nov 2022 11:16:37 +0100
MIME-Version: 1.0
Content-Language: en-US
To: Wang ShaoBo <bobo.shaobowang@huawei.com>
References: <20221123020355.2470160-1-bobo.shaobowang@huawei.com>
	<20221123020355.2470160-3-bobo.shaobowang@huawei.com>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20221123020355.2470160-3-bobo.shaobowang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, lars.ellenberg@linbit.com,
	liwei391@huawei.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v3 2/2] drbd: destroy workqueue when drbd
	device was freed
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

Am 23.11.22 um 03:03 schrieb Wang ShaoBo:
> A submitter workqueue is dynamically allocated by init_submitter()
> called by drbd_create_device(), we should destroy it when this
> device is not needed or destroyed.
> 
> Fixes: 113fef9e20e0 ("drbd: prepare to queue write requests on a submit worker")
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
> 
> v3:
>   - add out_* label for destroy_workqueue().
> 
>  drivers/block/drbd/drbd_main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 78cae4e75af1..677240232684 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -2217,6 +2217,8 @@ void drbd_destroy_device(struct kref *kref)
>  		kref_put(&peer_device->connection->kref, drbd_destroy_connection);
>  		kfree(peer_device);
>  	}
> +	if (device->submit.wq)
> +		destroy_workqueue(device->submit.wq);
>  	kfree(device);
>  	kref_put(&resource->kref, drbd_destroy_resource);
>  }
> @@ -2771,7 +2773,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
>  
>  	err = add_disk(disk);
>  	if (err)
> -		goto out_idr_remove_from_resource;
> +		goto out_destroy_workqueue;
>  
>  	/* inherit the connection state */
>  	device->state.conn = first_connection(resource)->cstate;
> @@ -2785,6 +2787,8 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
>  	drbd_debugfs_device_add(device);
>  	return NO_ERROR;
>  
> +out_destroy_workqueue:
> +	destroy_workqueue(device->submit.wq);
>  out_idr_remove_from_resource:
>  	for_each_connection_safe(connection, n, resource) {
>  		peer_device = idr_remove(&connection->peer_devices, vnr);

Thanks!

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
