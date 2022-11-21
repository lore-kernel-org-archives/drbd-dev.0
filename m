Return-Path: <axboe@kernel.dk>
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
	[209.85.214.175])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8C3F94203A1
	for <drbd-dev@lists.linbit.com>; Mon, 21 Nov 2022 15:30:47 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id 4so10776276pli.0
	for <drbd-dev@lists.linbit.com>; Mon, 21 Nov 2022 06:30:47 -0800 (PST)
Message-ID: <c0e639ea-caa0-f76c-c369-0d22a49047ca@kernel.dk>
Date: Mon, 21 Nov 2022 07:30:44 -0700
MIME-Version: 1.0
Content-Language: en-US
To: Wang ShaoBo <bobo.shaobowang@huawei.com>
References: <20221121115047.3828385-1-bobo.shaobowang@huawei.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221121115047.3828385-1-bobo.shaobowang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, liwei391@huawei.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RESEND PATCH] drbd: destroy workqueue when drbd
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

On 11/21/22 4:50 AM, Wang ShaoBo wrote:
> A submitter workqueue is dynamically allocated by init_submitter()
> called by drbd_create_device(), we should destroy it when this
> device is not needed or destroyed.
> 
> Fixes: 113fef9e20e0 ("drbd: prepare to queue write requests on a submit worker")
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
> 
> Changes in RESEND:
>   put destroy_workqueue() before memset(device, ...)
> 
>  drivers/block/drbd/drbd_main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 8532b839a343..082bc34cd317 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -2217,7 +2217,12 @@ void drbd_destroy_device(struct kref *kref)
>  		kref_put(&peer_device->connection->kref, drbd_destroy_connection);
>  		kfree(peer_device);
>  	}
> +
> +	if (device->submit.wq)
> +		destroy_workqueue(device->submit.wq);
> +
>  	memset(device, 0xfd, sizeof(*device));
> +
>  	kfree(device);

Maybe you can send a separate patch killing that very odd (and useless)
memset as well?

-- 
Jens Axboe


