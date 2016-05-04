Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 58CCE1056447
	for <drbd-dev@lists.linbit.com>; Fri,  6 May 2016 10:41:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 505D03EFD03
	for <drbd-dev@lists.linbit.com>; Fri,  6 May 2016 10:41:18 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id bMQWj2B6K4Cg for <drbd-dev@lists.linbit.com>;
	Fri,  6 May 2016 10:41:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 30E763EFD4A
	for <drbd-dev@lists.linbit.com>; Fri,  6 May 2016 10:41:18 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mP_x5Y6BIGNL for <drbd-dev@lists.linbit.com>;
	Fri,  6 May 2016 10:41:18 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 07C2A3EFD03
	for <drbd-dev@lists.linbit.com>; Fri,  6 May 2016 10:41:17 +0200 (CEST)
Resent-Message-ID: <20160506084117.GT16459@soda.linbit>
Received: from mail-pf0-f169.google.com (mail-pf0-f169.google.com
	[209.85.192.169]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E96201051881
	for <drbd-dev@lists.linbit.com>; Wed,  4 May 2016 19:13:39 +0200 (CEST)
Received: by mail-pf0-f169.google.com with SMTP id c189so28412311pfb.3
	for <drbd-dev@lists.linbit.com>; Wed, 04 May 2016 10:13:39 -0700 (PDT)
Message-ID: <1462382016.5535.348.camel@edumazet-glaptop3.roam.corp.google.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
To: David Miller <davem@davemloft.net>
Date: Wed, 04 May 2016 10:13:36 -0700
In-Reply-To: <20160504.125057.1606520320212390037.davem@davemloft.net>
References: <20160504090529.GJ16459@soda.linbit> <5729EFBC.7040002@6wind.com>
	<1462372026.5535.344.camel@edumazet-glaptop3.roam.corp.google.com>
	<20160504.125057.1606520320212390037.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Wed, 2016-05-04 at 12:50 -0400, David Miller wrote:
> From: Eric Dumazet <eric.dumazet@gmail.com>
> Date: Wed, 04 May 2016 07:27:06 -0700
> 
> > kernel was fine, and most user land apps were fine as well.
> 
> Userland should really not have to deal with garbage like this.
> 
> And because it quietly works just fine on x86-64, nothing makes
> sure that applications will universally get this right anyways.
> 
> Better to align things properly and magically all of these issues
> simply disappear.

Sure, but in practice we end up consuming 16 bytes (instead of 12) per
u64 attribute, only on some arches. 33 % space overhead.

So maybe some dumps will abort on those arches, while on x86 the size of
skb might be below some magic limit.

I guess this is fine, we do not break ABI in any way.



