Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 96B054203F3
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:56:19 +0200 (CEST)
Received: by mail-wr1-f68.google.com with SMTP id y17so12253432wrn.11
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:56:19 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	u3sm13104566wmg.38.2020.06.13.02.56.18
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:56:18 -0700 (PDT)
Resent-Message-ID: <20200613095616.GD4222@soda.linbit>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 04C2A420313
	for <drbd-dev@lists.linbit.com>; Thu, 23 Apr 2020 12:06:39 +0200 (CEST)
Resent-Message-ID: <20200423090828.GV20760@hirez.programming.kicks-ass.net>
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20200423085735.GU20713@hirez.programming.kicks-ass.net>
References: <20200422112719.826676174@infradead.org>
	<20200422112831.515522261@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422112831.515522261@infradead.org>
Cc: juri.lelli@redhat.com, axboe@kernel.dk, vincent.guittot@linaro.org,
	rostedt@goodmis.org, dietmar.eggemann@arm.com,
	bsegall@google.com, mgorman@suse.de, tglx@linutronix.de,
	qais.yousef@arm.com
Subject: Re: [Drbd-dev] [PATCH 05/23] sched,
	drbd: Convert to sched_set_fifo*()
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
Date: Sat, 13 Jun 2020 09:56:45 -0000

On Wed, Apr 22, 2020 at 01:27:24PM +0200, Peter Zijlstra wrote:
> Because SCHED_FIFO is a broken scheduler model (see previous patches)
> take away the priority field, the kernel can't possibly make an
> informed decision.
> 
> In this case, use fifo_low, because it only cares about being above
> SCHED_NORMAL. Effectively changes prio from 2 to 1.
> 
> Cc: axboe@kernel.dk
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---
>  drivers/block/drbd/drbd_receiver.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -6020,9 +6020,8 @@ int drbd_ack_receiver(struct drbd_thread
>  	unsigned int header_size = drbd_header_size(connection);
>  	int expect   = header_size;
>  	bool ping_timeout_active = false;
> -	struct sched_param param = { .sched_priority = 2 };
>  
> -	rv = sched_setscheduler(current, SCHED_RR, &param);
> +	rv = sched_set_fifo_low(current);

As noted by Dietmar, I forgot to mention loosing RR in the changelog,
bad me.

In this case I'm not actually 100% sure, but there was no comment with
it that justified it being RR, and RR-SMP is not optimal (in fact it's
rather buggered).

In general RR is even more 'interesting' to get right thatn FIFO and
therefore I figured it probably didn't want to be RR, but given there
can be multiple of such threads, it might have been an attempt at
providing some sort of fairness between the multiple threads.

At the same time, if you're running the threads so hard that RR makes a
difference, it's unlikely there is any actual NORMAL time left and
things will be unhappy anyway.

Therefore, and me being lazy, make it FIFO.
