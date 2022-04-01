Return-Path: <philipp.reisner@linbit.com>
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
	[209.85.128.49])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7350242017F
	for <drbd-dev@lists.linbit.com>; Fri,  1 Apr 2022 14:31:30 +0200 (CEST)
Received: by mail-wm1-f49.google.com with SMTP id r7so1601680wmq.2
	for <drbd-dev@lists.linbit.com>; Fri, 01 Apr 2022 05:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220401083637.2407766-1-lv.ruyi@zte.com.cn>
In-Reply-To: <20220401083637.2407766-1-lv.ruyi@zte.com.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Fri, 1 Apr 2022 14:31:18 +0200
Message-ID: <CADGDV=Wf9MpS7_3C6=RNTBO5rqxjtWOz170=7K215R9X38yc5w@mail.gmail.com>
To: cgel.zte@gmail.com
Content-Type: text/plain; charset="UTF-8"
Cc: Jens Axboe <axboe@kernel.dk>, Lv Ruyi <lv.ruyi@zte.com.cn>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Zeal Robot <zealci@zte.com.cn>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] block: fix potential dereference null pointer
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

Hi Lv Ruyi,

This patch does not make sense to me. A request can only get "TO_BE_SENT"
when the connection is established with the corresponding
cstate. Establishing a connection can only work if net_conf is set. net_conf
can be exchanged to a new one, but never become NULL.

Please share more details why you think this NULL check is necessary here?



On Fri, Apr 1, 2022 at 10:36 AM <cgel.zte@gmail.com> wrote:
>
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>
> rcu_dereference may return NULL, so check the returned pointer.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>  drivers/block/drbd/drbd_req.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
> index e1e58e91ee58..8ab6da155e2f 100644
> --- a/drivers/block/drbd/drbd_req.c
> +++ b/drivers/block/drbd/drbd_req.c
> @@ -577,6 +577,10 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
>                 D_ASSERT(device, !(req->rq_state & RQ_NET_MASK));
>                 rcu_read_lock();
>                 nc = rcu_dereference(connection->net_conf);
> +               if (!nc) {
> +                       rcu_read_unlock();
> +                       break;
> +               }
>                 p = nc->wire_protocol;
>                 rcu_read_unlock();
>                 req->rq_state |=
> @@ -690,6 +694,10 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
>                 /* close the epoch, in case it outgrew the limit */
>                 rcu_read_lock();
>                 nc = rcu_dereference(connection->net_conf);
> +               if (!nc) {
> +                       rcu_read_unlock();
> +                       break;
> +               }
>                 p = nc->max_epoch_size;
>                 rcu_read_unlock();
>                 if (connection->current_tle_writes >= p)
> --
> 2.25.1
>
