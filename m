Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
	[209.85.221.44])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id EED46160922
	for <drbd-dev@lists.linbit.com>; Thu, 19 Feb 2026 15:53:55 +0100 (CET)
Received: by mail-wr1-f44.google.com with SMTP id
	ffacd0b85a97d-43626796202so988254f8f.3
	for <drbd-dev@lists.linbit.com>; Thu, 19 Feb 2026 06:53:55 -0800 (PST)
Message-ID: <2b87cbab-49e2-4290-8784-b771e90e016f@linbit.com>
Date: Thu, 19 Feb 2026 15:53:53 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] drbd: fix a null-pointer dereference when the request
	event in drbd_request_endio() is READ_COMPLETED_WITH_ERROR
To: Tuo Li <islituo@gmail.com>, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, axboe@kernel.dk
References: <20260104165355.151864-1-islituo@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20260104165355.151864-1-islituo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
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

On 1/4/26 17:53, Tuo Li wrote:
> In drbd_request_endio(), the request event what can be set to
> READ_COMPLETED_WITH_ERROR. In this case, __req_mod() is invoked with a NULL
> peer_device:
> 
>    __req_mod(req, what, NULL, &m);
> 
> When handling READ_COMPLETED_WITH_ERROR, __req_mod() unconditionally calls
> drbd_set_out_of_sync():
> 
>    case READ_COMPLETED_WITH_ERROR:
>      drbd_set_out_of_sync(peer_device, req->i.sector, req->i.size);
> 
> The drbd_set_out_of_sync() macro expands to __drbd_change_sync():
> 
>    #define drbd_set_out_of_sync(peer_device, sector, size) \
> 	__drbd_change_sync(peer_device, sector, size, SET_OUT_OF_SYNC)
> 
> However, __drbd_change_sync() assumes a valid peer_device and immediately
> dereferences it:
> 
>    struct drbd_device *device = peer_device->device;
> 
> If peer_device is NULL, this results in a NULL-pointer dereference.
> 
> Fix this by adding a NULL check in __req_mod() before calling
> drbd_set_out_of_sync().

Thank you for the report and patch.
The bug analysis is correct, but the fix is not.

> 
> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
>   drivers/block/drbd/drbd_req.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
> index d15826f6ee81..aa3da2733f14 100644
> --- a/drivers/block/drbd/drbd_req.c
> +++ b/drivers/block/drbd/drbd_req.c
> @@ -621,7 +621,8 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
>   		break;
>   
>   	case READ_COMPLETED_WITH_ERROR:
> -		drbd_set_out_of_sync(peer_device, req->i.sector, req->i.size);
> +		if (peer_device)
> +			drbd_set_out_of_sync(peer_device, req->i.sector, req->i.size);
>   		drbd_report_io_error(device, req);
>   		__drbd_chk_io_error(device, DRBD_READ_ERROR);
>   		fallthrough;

In this code path, peer_device is *always* NULL -- the only caller that
sets READ_COMPLETED_WITH_ERROR is drbd_request_endio(), which always
passes NULL for peer_device. So this NULL check effectively turns the
drbd_set_out_of_sync() call into dead code.

Silently skipping the call here means we lose out-of-sync tracking
for local read errors, which is a data consistency problem.

The proper fix is to obtain the peer_device via 
first_peer_device(device), like in a similar path in drbd_req_destroy 
(drbd_req.c:125).

case READ_COMPLETED_WITH_ERROR:
	drbd_set_out_of_sync(first_peer_device(device),
			     req->i.sector, req->i.size);

Regards,
Christoph

--
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
