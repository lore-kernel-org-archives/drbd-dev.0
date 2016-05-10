Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 450BD1051881
	for <drbd-dev@lists.linbit.com>; Fri, 13 May 2016 14:48:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 03B1E40476C
	for <drbd-dev@lists.linbit.com>; Fri, 13 May 2016 14:48:52 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 1UuMKfsQAp6U for <drbd-dev@lists.linbit.com>;
	Fri, 13 May 2016 14:48:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id D8D634054C6
	for <drbd-dev@lists.linbit.com>; Fri, 13 May 2016 14:48:51 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KzkaN2Wl4AKS for <drbd-dev@lists.linbit.com>;
	Fri, 13 May 2016 14:48:51 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id A966140476C
	for <drbd-dev@lists.linbit.com>; Fri, 13 May 2016 14:48:51 +0200 (CEST)
Resent-Message-ID: <20160513124851.GI16459@soda.linbit>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [149.20.54.216])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8E45B1056443
	for <drbd-dev@lists.linbit.com>;
	Tue, 10 May 2016 17:39:55 +0200 (CEST)
Date: Tue, 10 May 2016 11:39:49 -0400 (EDT)
Message-Id: <20160510.113949.2077250222547175741.davem@davemloft.net>
To: lars.ellenberg@linbit.com
From: David Miller <davem@davemloft.net>
In-Reply-To: <20160510094023.GC16459@soda.linbit>
References: <20160509131547.GX16459@soda.linbit> <5731A561.6090509@6wind.com>
	<20160510094023.GC16459@soda.linbit>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: netdev@vger.kernel.org, nicolas.dichtel@6wind.com,
	philipp.reisner@linbit.com, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH net-next v3] block/drbd: align properly u64
 in nl messages
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

From: Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Tue, 10 May 2016 11:40:23 +0200

> If we introduce a new config option,
> we have to add it to the config scanner (one line),
> define min, max, default and scale (four short defines),
> and add it to the netlink definition here (one line).
> Done, rest of the code is generated,
> both on the kernel side,
> and on the drbd-utils side used to talk to the kernel.
> We found that to be very convenient.

But it entirely misses the core design point of netlink.

Sender and receive _DO NOT_ need to coordinate at all.  That's the
whole point.  So tightly coupling such coordination is going to run
you into all kinds of problems.

When implemented properly, the sender can emit whatever attributes it
knows about and can generate, and the receive scans the attributes one
by one and picks out the ones it understands and processes them.

If you go against this model then you have no clean way to extend
things whilst allowing existing software to continue working.

If the drbd stuff had been posting to the networking list, we really
would have screamed loudly about these auto-generates structs and
macros and whatnot.

Anyways, back to the topic, can you please just relent and come to some
kind of agreement about the fix for this alignment bug?  This is taking
a very long time and patches are just rotting in patchwork with no
resolution.

Thanks.
