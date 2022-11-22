Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
	[209.85.221.47])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 09507421743
	for <drbd-dev@lists.linbit.com>; Tue, 22 Nov 2022 13:01:53 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id s5so7166701wru.1
	for <drbd-dev@lists.linbit.com>; Tue, 22 Nov 2022 04:01:53 -0800 (PST)
Message-ID: <feff21b0-e583-4df3-7c38-4990ee60c3e4@linbit.com>
Date: Tue, 22 Nov 2022 13:01:52 +0100
MIME-Version: 1.0
To: Wang ShaoBo <bobo.shaobowang@huawei.com>
References: <20221122030427.731308-1-bobo.shaobowang@huawei.com>
	<20221122030427.731308-3-bobo.shaobowang@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20221122030427.731308-3-bobo.shaobowang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, lars.ellenberg@linbit.com,
	liwei391@huawei.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 2/2] drbd: destroy workqueue when drbd
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

Am 22.11.22 um 04:04 schrieb Wang ShaoBo:
> A submitter workqueue is dynamically allocated by init_submitter()
> called by drbd_create_device(), we should destroy it when this
> device is not needed or destroyed.
> 
> Fixes: 113fef9e20e0 ("drbd: prepare to queue write requests on a submit worker")
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  drivers/block/drbd/drbd_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 78cae4e75af1..2d6b6d1c5ff4 100644
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
> @@ -2807,6 +2809,8 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
>  	put_disk(disk);
>  out_no_disk:
>  	kref_put(&resource->kref, drbd_destroy_resource);
> +	if (device->submit.wq)
> +		destroy_workqueue(device->submit.wq);
>  	kfree(device);
>  	return err;
>  }

Thanks, that is better.

Just one more nitpick: in drbd_create_device, we usually order the
allocations/frees in a "last in, first out" fashion. That is, data
should be released in the reverse order that it was allocated. This also
helps with error handling, which is what the out_* labels are used for.

So maybe we can put that destroy_workqueue() under its own out_* label
and make sure it gets freed first in the cleanup section (since it gets
allocated last).

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
