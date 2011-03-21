Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1D53310570C9
	for <drbd-dev@lists.linbit.com>; Mon, 21 Mar 2011 09:51:25 +0100 (CET)
Resent-Message-ID: <20110321085121.GF28441@barkeeper1-xen.linbit>
Received: from tservice.net.ru (unknown [195.178.208.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 27018105714A
	for <drbd-dev@lists.linbit.com>; Mon, 21 Mar 2011 06:27:01 +0100 (CET)
Date: Mon, 21 Mar 2011 08:27:00 +0300
From: Evgeniy Polyakov <zbr@ioremap.net>
To: Ken-ichirou MATSUZAWA <chamas@h4.dion.ne.jp>
Message-ID: <20110321052700.GA13236@ioremap.net>
References: <87vczde0rg.wl%chamas@h4.dion.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vczde0rg.wl%chamas@h4.dion.ne.jp>
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

On Mon, Mar 21, 2011 at 10:10:59AM +0900, Ken-ichirou MATSUZAWA (chamas@h4.dion.ne.jp) wrote:
> I did not know where I should post, here is my starting point. I
> started to try DRBD on lxc but did not work. I thought first thing
> to do is makeing connector to net namespace aware. Appended patch
> may have many issue but I noticed only a few though. 
> 
> First this does not add connector sock to struct net, but just
> holding sock as a list and send message to all net namespace. I
> referred lib/kobject_uevent.c

You are holding rcu lock during skb allocation, which is not permitted
for GFP_KERNEL, which may lead to a deadlock. Also netlink_broadcast()
may sleep if allocation policy permits.

-- 
	Evgeniy Polyakov
