Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
	[209.85.221.49])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 243004252F2
	for <drbd-dev@lists.linbit.com>; Wed, 23 Nov 2022 11:16:02 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id x5so24585212wrt.7
	for <drbd-dev@lists.linbit.com>; Wed, 23 Nov 2022 02:16:02 -0800 (PST)
Message-ID: <7d972801-148a-87b2-9fe1-9992b943916f@linbit.com>
Date: Wed, 23 Nov 2022 11:16:00 +0100
MIME-Version: 1.0
Content-Language: en-US
To: Wang ShaoBo <bobo.shaobowang@huawei.com>
References: <20221123020355.2470160-1-bobo.shaobowang@huawei.com>
	<20221123020355.2470160-2-bobo.shaobowang@huawei.com>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20221123020355.2470160-2-bobo.shaobowang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, lars.ellenberg@linbit.com,
	liwei391@huawei.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v3 1/2] drbd: remove call to memset before
 free device/resource/connection
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
> This revert c2258ffc56f2 ("drbd: poison free'd device, resource and
> connection structs"), add memset is odd here for debugging, there are
> some methods to accurately show what happened, such as kdump.
> 
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  drivers/block/drbd/drbd_main.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 8532b839a343..78cae4e75af1 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -2217,7 +2217,6 @@ void drbd_destroy_device(struct kref *kref)
>  		kref_put(&peer_device->connection->kref, drbd_destroy_connection);
>  		kfree(peer_device);
>  	}
> -	memset(device, 0xfd, sizeof(*device));
>  	kfree(device);
>  	kref_put(&resource->kref, drbd_destroy_resource);
>  }
> @@ -2309,7 +2308,6 @@ void drbd_destroy_resource(struct kref *kref)
>  	idr_destroy(&resource->devices);
>  	free_cpumask_var(resource->cpu_mask);
>  	kfree(resource->name);
> -	memset(resource, 0xf2, sizeof(*resource));
>  	kfree(resource);
>  }
>  
> @@ -2650,7 +2648,6 @@ void drbd_destroy_connection(struct kref *kref)
>  	drbd_free_socket(&connection->data);
>  	kfree(connection->int_dig_in);
>  	kfree(connection->int_dig_vv);
> -	memset(connection, 0xfc, sizeof(*connection));
>  	kfree(connection);
>  	kref_put(&resource->kref, drbd_destroy_resource);
>  }

Thanks!

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
