Return-Path: <mmazur@kernel.pl>
Received: from srv.axeos.nl (srv.axeos.nl [83.98.196.54])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0CD1C101AC76
	for <drbd-dev@lists.linbit.com>; Thu,  3 Jul 2014 19:49:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by localhost.srv.axeos.nl (Postfix) with ESMTP id C741F140F4
	for <drbd-dev@lists.linbit.com>; Thu,  3 Jul 2014 19:49:22 +0200 (CEST)
Received: from srv.axeos.nl ([127.0.0.1])
	by localhost (srv.axeos.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9rsp3WHh-lbb for <drbd-dev@lists.linbit.com>;
	Thu,  3 Jul 2014 19:49:12 +0200 (CEST)
Received: from mmaszyna.localnet (vpn.axeos.nl [83.98.196.63])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by srv.axeos.nl (Postfix) with ESMTPSA
	for <drbd-dev@lists.linbit.com>; Thu,  3 Jul 2014 19:49:12 +0200 (CEST)
From: Mariusz Mazur <mmazur@kernel.pl>
To: drbd-dev@lists.linbit.com
Date: Thu, 3 Jul 2014 19:49:09 +0200
References: <201407031507.18336.mmazur@kernel.pl>
	<20140703134417.GI11700@soda.linbit>
	<20140703135439.GJ11700@soda.linbit>
In-Reply-To: <20140703135439.GJ11700@soda.linbit>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201407031949.10263.mmazur@kernel.pl>
Subject: Re: [Drbd-dev] stonith-related regression introduced around kernel
	3.13, with 3.15.3 still affected
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

On Thu of July 3 2014, Lars Ellenberg wrote:

> Would you please try this patch:
> 
> diff --git a/drbd/drbd_nl.c b/drbd/drbd_nl.c
> index 9e6adaa..88f480c 100644
> --- a/drbd/drbd_nl.c
> +++ b/drbd/drbd_nl.c
> @@ -586,6 +586,7 @@ void conn_try_outdate_peer_async(struct drbd_connection
> *connection) struct task_struct *opa;
> 
>  	kref_get(&connection->kref);
> +	flush_pending_signals();
>  	opa = kthread_run(_try_outdate_peer_async, connection, "drbd_async_h");
>  	if (IS_ERR(opa)) {
>  		drbd_err(connection, "out of mem, failed to invoke fence-peer
> helper\n");

There's no such function in the kernel.


--mmazur
