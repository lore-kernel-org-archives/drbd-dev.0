Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9C6B31056332
	for <drbd-dev@lists.linbit.com>; Mon,  9 Oct 2017 16:16:35 +0200 (CEST)
Received: by mail-wm0-f46.google.com with SMTP id m72so11782394wmc.0
	for <drbd-dev@lists.linbit.com>; Mon, 09 Oct 2017 07:16:35 -0700 (PDT)
Date: Mon, 9 Oct 2017 16:08:27 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: Jia-Ju Bai <baijiaju1990@163.com>
Message-ID: <20171009140827.jlr5hwsrofn7x4ld@rck.sh>
References: <1507080798-16585-1-git-send-email-baijiaju1990@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507080798-16585-1-git-send-email-baijiaju1990@163.com>
Cc: lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com,
	philipp.reisner@linbit.com, linux-kernel@vger.kernel.org
Subject: Re: [Drbd-dev] [PATCH] block/drbd: Fix a sleep-in-atomic bug in
 drbd_bcast_event
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Oct 04, 2017 at 09:33:18AM +0800, Jia-Ju Bai wrote:
> The driver may sleep under a RCU lock, and the function call path is:
> drbd_sync_handshake (acquire the RCU lock)
>   drbd_asb_recover_1p
>     drbd_khelper
>       drbd_bcast_event
>         genlmsg_new(GFP_NOIO) --> may sleep
> 
> To fix it, GFP_NOIO is replaced with GFP_ATOMIC.
> This bug is found by my static analysis tool and my code review.
> 
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
> ---
>  drivers/block/drbd/drbd_nl.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index a12f77e..713c965 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -4537,7 +4537,7 @@ void drbd_bcast_event(struct drbd_device *device, const struct sib_info *sib)
>  	int err = -ENOMEM;
>  
>  	seq = atomic_inc_return(&drbd_genl_seq);
> -	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_NOIO);
> +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_ATOMIC);
>  	if (!msg)
>  		goto failed;

Hi Jia-Ju,

thanks for reporting that. I fixed that by narrowing the scope of the
rcu_lock in drbd_sync_handshake() while keeping the code down the rabbit
hole untouched. This has the benefit that it fixes all your 3 cases.

As usual, we will send that upstream soon.

Thanks, rck
