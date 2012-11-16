Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1C2181019A78
	for <drbd-dev@lists.linbit.com>; Fri, 16 Nov 2012 13:00:48 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 16 Nov 2012 13:00:47 +0100
Message-ID: <4004933.3JW9EKSjmn@fat-tyre>
In-Reply-To: <20121112190659.GA1865@elgon.mountain>
References: <20121112190659.GA1865@elgon.mountain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd: rcu_read_lock() and rcu_dereference() for
	tconn->net_conf
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Montag, 12. November 2012, 22:06:59 schrieb Dan Carpenter:
> Hello Philipp Reisner,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 44ed167da748: "drbd: rcu_read_lock() and rcu_dereference()
> for tconn->net_conf" from Apr 19, 2011, leads to the following Smatch
> complaint:
> 
> drivers/block/drbd/drbd_state.c:566 is_valid_state()
> 	 error: we previously assumed 'nc' could be null (see line 525)
> 
> drivers/block/drbd/drbd_state.c
>    524		nc = rcu_dereference(mdev->tconn->net_conf);
>    525		if (nc) {
>                     ^^
> New check.
> 
>    526			if (!nc->two_primaries && ns.role == R_PRIMARY) {
>    527				if (ns.peer == R_PRIMARY)
[...]
>    565		else if ((ns.conn == C_VERIFY_S || ns.conn == C_VERIFY_T) &&
>    566			 (nc->verify_alg[0] == 0))
>                           ^^^^^^^^^^^^^^
> New dereference.
> Probably a false positive, but it's not immediately obvious what's going
> on.  Maybe add a comment?
> 

For developers familiar with the DRBD code it is obvious that if an online
verify may start (ns.conn == C_VERIFY_S || ns.conn == C_VERIFY_T) we have
an established connection, and that implies that nc is not NULL.

So, yes, it is a false positive.

Best,
 Phil

