Return-Path: <mmazur@kernel.pl>
Received: from srv.axeos.nl (srv.axeos.nl [83.98.196.54])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CF7BC101AC75
	for <drbd-dev@lists.linbit.com>; Mon,  7 Jul 2014 10:41:38 +0200 (CEST)
From: Mariusz Mazur <mmazur@kernel.pl>
To: drbd-dev@lists.linbit.com,
 Jacek Konieczny <jkonieczny@eggsoft.pl>
Date: Mon, 7 Jul 2014 10:41:33 +0200
References: <201407031507.18336.mmazur@kernel.pl>
	<201407031949.10263.mmazur@kernel.pl>
	<20140704114257.GK11700@soda.linbit>
In-Reply-To: <20140704114257.GK11700@soda.linbit>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201407071041.33545.mmazur@kernel.pl>
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

On Fri of July 4 2014, Lars Ellenberg wrote:

> Yeah, sorry, typo, leave off the pending-.
> 
> It's flush_signals(current);
> 
> diff --git a/drbd/drbd_nl.c b/drbd/drbd_nl.c
> index 9e6adaa..d8b83d7 100644
> --- a/drbd/drbd_nl.c
> +++ b/drbd/drbd_nl.c
> @@ -586,6 +586,7 @@ void conn_try_outdate_peer_async(struct drbd_connection
> *connection) struct task_struct *opa;
> 
>  	kref_get(&connection->kref);
> +	flush_signals(current);
>  	opa = kthread_run(_try_outdate_peer_async, connection, "drbd_async_h");
>  	if (IS_ERR(opa)) {
>  		drbd_err(connection, "out of mem, failed to invoke fence-peer
> helper\n");

Yup, this worked. Should it maybe get sent upstream to the kernel? :)


--mmazur
