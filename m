Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id AEDE4105717C
	for <drbd-dev@lists.linbit.com>; Wed, 23 Mar 2011 11:42:35 +0100 (CET)
Resent-Message-ID: <20110323104235.GK28441@barkeeper1-xen.linbit>
Received: from tservice.net.ru (cs-studio.ru [195.178.208.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 71026105715B
	for <drbd-dev@lists.linbit.com>; Mon, 21 Mar 2011 23:21:23 +0100 (CET)
Date: Tue, 22 Mar 2011 01:21:23 +0300
From: Evgeniy Polyakov <zbr@ioremap.net>
To: Ken-ichirou MATSUZAWA <chamas@h4.dion.ne.jp>
Message-ID: <20110321222122.GA12237@ioremap.net>
References: <87vczde0rg.wl%chamas@h4.dion.ne.jp>
	<20110321052700.GA13236@ioremap.net>
	<87vczcd5g0.wl%chamas@h4.dion.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vczcd5g0.wl%chamas@h4.dion.ne.jp>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD on container, lxc
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi.

On Mon, Mar 21, 2011 at 09:27:27PM +0900, Ken-ichirou MATSUZAWA (chamas@h4.dion.ne.jp) wrote:
> I had tried using mutex at first but it was failed on
> Documentation/connector/cn_test which call cn_netlink_send() from
> timer, softirq. Conseqently I use rcu lock but I did not know which
> is not permmited for GFP_KERNEL allocation.
> 
> I was thinking of lock issue and occured non-broadcating, spcifying
> netns on calling cn_netlink_send(), appended.
> 
> But it will not work with multiple container in this way, I am
> having thought what to do... copy list locally in the function? 
> Then, I have got mail

AFAICS we should only send messages directly to the namespace, which
originally hosted aplication which requested given event.

If there are multiple clients in different namespaces who bound to the
same event, then there will be multiple sockets each of which lives in
own namespace and this information is stored in the socket structure,
which you duplicated in cn_init

-- 
	Evgeniy Polyakov
