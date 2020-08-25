Return-Path: <srn@prgmr.com>
Received: from mail.prgmr.com (mail.prgmr.com [71.19.149.6])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AECE5420D89
	for <drbd-dev@lists.linbit.com>; Wed, 26 Aug 2020 01:47:05 +0200 (CEST)
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com, axboe@kernel.dk
References: <20200819054926.30758-1-srn@prgmr.com>
From: Sarah Newman <srn@prgmr.com>
Message-ID: <71f60e04-8470-ae0d-3bda-17572b569b28@prgmr.com>
Date: Tue, 25 Aug 2020 16:47:03 -0700
MIME-Version: 1.0
In-Reply-To: <20200819054926.30758-1-srn@prgmr.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] block: drbd: add missing kref_get in
 handle_write_conflicts
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

On 8/18/20 10:49 PM, Sarah Newman wrote:
> The other place that drbd_send_acks_wf was called from already
> calls kref_get.
> 
> This can be reproduced with the following for an existing
> connection:
> 
> drbdsetup net-options local_addr remote_addr \
>    --protocol=C \
>    --allow-two-primaries
> 
> drbsetup primary minor
> dd if=/dev/drbd<minor> of=sector bs=512 count=1
> while true; do dd if=sector of=/dev/drbd<minor>; done
> 
> During this, if we have function tracing enabled for e_send_superseded, it
>    triggers:
> 
> $ sudo cat /sys/kernel/tracing/trace_pipe
>      kworker/u4:2-14838 [001] .... 113244.465689: e_send_superseded <-drbd_finish_peer_reqs
>      kworker/u4:2-14838 [001] .... 113244.468237: e_send_superseded <-drbd_finish_peer_reqs
>      kworker/u4:2-14838 [001] .... 113244.482757: e_send_superseded <-drbd_finish_peer_reqs
>      kworker/u4:1-15502 [001] .... 113244.485092: e_send_superseded <-drbd_finish_peer_reqs
> 
> This eventually results in behavior like:
> 
> [113418.435846] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [dd:15505]
> 
> Or a message similar to
> 
> block drbd0: ASSERT( device->open_cnt == 0 )
>    in drivers/block/drbd/drbd_main.c:2232
> 
> Signed-off-by: Sarah Newman <srn@prgmr.com>
> ---
>   drivers/block/drbd/drbd_receiver.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index 2b3103c30857..1ad693a5aab5 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -2531,7 +2531,11 @@ static int handle_write_conflicts(struct drbd_device *device,
>   			peer_req->w.cb = superseded ? e_send_superseded :
>   						   e_send_retry_write;
>   			list_add_tail(&peer_req->w.list, &device->done_ee);
> -			queue_work(connection->ack_sender, &peer_req->peer_device->send_acks_work);
> +			/* put is in drbd_send_acks_wf() */
> +			kref_get(&device->kref);
> +			if (!queue_work(connection->ack_sender,
> +					&peer_req->peer_device->send_acks_work))
> +				kref_put(&device->kref, drbd_destroy_device);
>   
>   			err = -ENOENT;
>   			goto out;
> 

Added linux-block as a CC. I can resend this patch if necessary.

Checking in to see if any changes or additional testing is required for this patch before it's accepted.

Thanks, Sarah
