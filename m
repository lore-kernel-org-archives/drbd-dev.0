Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 44E24101E062
	for <drbd-dev@lists.linbit.com>; Tue,  7 Oct 2014 16:51:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 383303C3E1F
	for <drbd-dev@lists.linbit.com>; Tue,  7 Oct 2014 16:51:07 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id G8_jCgBG8P9I for <drbd-dev@lists.linbit.com>;
	Tue,  7 Oct 2014 16:51:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 1AF843C4383
	for <drbd-dev@lists.linbit.com>; Tue,  7 Oct 2014 16:51:07 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FzJs8T1V0NuA for <drbd-dev@lists.linbit.com>;
	Tue,  7 Oct 2014 16:51:07 +0200 (CEST)
Received: from soda.linbit (unknown [217.196.73.213])
	by zimbra13.linbit.com (Postfix) with ESMTPS id EFB803C3E1F
	for <drbd-dev@lists.linbit.com>; Tue,  7 Oct 2014 16:51:06 +0200 (CEST)
Resent-Message-ID: <20141007145106.GG8574@soda.linbit>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
	[140.211.169.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4467B101E048
	for <drbd-dev@lists.linbit.com>; Mon,  6 Oct 2014 01:56:07 +0200 (CEST)
Date: Sun, 5 Oct 2014 16:47:01 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <20141005234701.GA23078@kroah.com>
References: <026a6017e1b052f58cf908fc2f63aea7@de.mcbf.net>
	<2120692.Pa81LKFuHn@fat-tyre>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2120692.Pa81LKFuHn@fat-tyre>
Cc: Jens Axboe <axboe@kernel.dk>, David Mohr <david@mcbf.net>,
	stable@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: fix regression 'out of mem,
 failed to invoke fence-peer helper'
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

On Wed, Oct 01, 2014 at 11:32:29AM +0200, Philipp Reisner wrote:
> From: Lars Ellenberg <lars.ellenberg@linbit.com>
> 
> Stable info:
>   This patch landed in upstream with v3.16 as commit
>   bbc1c5e8ad6dfebf9d13b8a4ccdf66c92913eac9
>   it should go into v3.14+
> 
> Since linux kernel 3.13, kthread_run() internally uses
> wait_for_completion_killable().  We sometimes may use kthread_run()
> while we still have a signal pending, which we used to kick our threads
> out of potentially blocking network functions, causing kthread_run() to
> mistake that as a new fatal signal and fail.
> 
> Fix: flush_signals() before kthread_run().
> 
> Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
> Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  drivers/block/drbd/drbd_nl.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index 1b35c45..3f2e167 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -544,6 +544,12 @@ void conn_try_outdate_peer_async(struct drbd_connection *connection)
>         struct task_struct *opa;
> 
>         kref_get(&connection->kref);
> +       /* We may just have force_sig()'ed this thread
> +        * to get it out of some blocking network function.
> +        * Clear signals; otherwise kthread_run(), which internally uses
> +        * wait_on_completion_killable(), will mistake our pending signal
> +        * for a new fatal signal and fail. */
> +       flush_signals(current);
>         opa = kthread_run(_try_outdate_peer_async, connection, "drbd_async_h");
>         if (IS_ERR(opa)) {
>                 drbd_err(connection, "out of mem, failed to invoke fence-peer helper\n");

This doesn't apply to 3.16-stable or 3.14-stable, can you please provide
a working backport?

thanks,


greg k-h
