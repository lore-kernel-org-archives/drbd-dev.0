Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9D1A31056447
	for <drbd-dev@lists.linbit.com>; Fri,  6 May 2016 10:41:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 8BF1A3EF47F
	for <drbd-dev@lists.linbit.com>; Fri,  6 May 2016 10:41:09 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id JdLwigprTjJZ for <drbd-dev@lists.linbit.com>;
	Fri,  6 May 2016 10:41:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 684D13EF63F
	for <drbd-dev@lists.linbit.com>; Fri,  6 May 2016 10:41:09 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yOcOMu5GsR2h for <drbd-dev@lists.linbit.com>;
	Fri,  6 May 2016 10:41:09 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 3D6593EF47F
	for <drbd-dev@lists.linbit.com>; Fri,  6 May 2016 10:41:09 +0200 (CEST)
Resent-Message-ID: <20160506084108.GS16459@soda.linbit>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [149.20.54.216])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9C99B1051881
	for <drbd-dev@lists.linbit.com>;
	Wed,  4 May 2016 18:50:59 +0200 (CEST)
Date: Wed, 04 May 2016 12:50:57 -0400 (EDT)
Message-Id: <20160504.125057.1606520320212390037.davem@davemloft.net>
To: eric.dumazet@gmail.com
From: David Miller <davem@davemloft.net>
In-Reply-To: <1462372026.5535.344.camel@edumazet-glaptop3.roam.corp.google.com>
References: <20160504090529.GJ16459@soda.linbit> <5729EFBC.7040002@6wind.com>
	<1462372026.5535.344.camel@edumazet-glaptop3.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: netdev@vger.kernel.org, nicolas.dichtel@6wind.com,
	philipp.reisner@linbit.com, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH net-next v2] block/drbd: use
	nla_put_u64_64bit()
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

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Wed, 04 May 2016 07:27:06 -0700

> kernel was fine, and most user land apps were fine as well.

Userland should really not have to deal with garbage like this.

And because it quietly works just fine on x86-64, nothing makes
sure that applications will universally get this right anyways.

Better to align things properly and magically all of these issues
simply disappear.
