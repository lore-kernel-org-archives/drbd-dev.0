Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A87AF1011B9B
	for <drbd-dev@lists.linbit.com>; Mon, 17 Nov 2014 13:28:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 970463C7772
	for <drbd-dev@lists.linbit.com>; Mon, 17 Nov 2014 13:28:51 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id rOLu3cm1MEc9 for <drbd-dev@lists.linbit.com>;
	Mon, 17 Nov 2014 13:28:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 78B723C7781
	for <drbd-dev@lists.linbit.com>; Mon, 17 Nov 2014 13:28:51 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ymiWgJvOqENK for <drbd-dev@lists.linbit.com>;
	Mon, 17 Nov 2014 13:28:51 +0100 (CET)
Received: from localhost (rck.rck.sh [78.142.181.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id 2C0A42ACDF3
	for <drbd-dev@lists.linbit.com>; Mon, 17 Nov 2014 13:28:39 +0100 (CET)
Date: Mon, 17 Nov 2014 13:28:36 +0100
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20141117122836.GT2136@rck.sh>
References: <20141116143543.GA26665@miriup.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141116143543.GA26665@miriup.de>
Subject: Re: [Drbd-dev] [PATCH] Correctly skip interface indexes larger than
 256
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

On Sun, Nov 16, 2014 at 06:35:43PM +0400, Dirk Tilger wrote:
> -		X32(08) X32(08) X32(08) X32(08) " %*02x %*02x %*02x %*02x %s",
> +		X32(08) X32(08) X32(08) X32(08) " %*x %*x %*x %*x %s",

Are numbers larger than 0xff even possible?

We read the string from "/proc/net/if_inet6", and to me it looks like
the interfaces limits the input range to values <= 255 [1].

Would be great if you could provide an example where it really makes a
difference, i.e. how to get lager values than 255 in the ignored format
string positions.

Regards, rck

[1] http://www.tldp.org/HOWTO/Linux+IPv6-HOWTO/proc-net.html
