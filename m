Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A1142103B4CD
	for <drbd-dev@lists.linbit.com>; Thu, 18 Oct 2012 13:06:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 96C501B40FB
	for <drbd-dev@lists.linbit.com>; Thu, 18 Oct 2012 13:06:45 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TSiOuD-xtz9b for <drbd-dev@lists.linbit.com>;
	Thu, 18 Oct 2012 13:06:45 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 814641B40F5
	for <drbd-dev@lists.linbit.com>; Thu, 18 Oct 2012 13:06:45 +0200 (CEST)
Date: Thu, 18 Oct 2012 13:06:45 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20121018110645.GQ9562@soda.linbit>
References: <20121011205555.GT4662@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20121011205555.GT4662@suse.de>
Subject: Re: [Drbd-dev] MSG_NEW_PACKET flag?
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Oct 11, 2012 at 10:55:55PM +0200, Lars Marowsky-Bree wrote:
> https://lkml.org/lkml/2012/6/29/204
> 
> Could/would drbd benefit from this?

Sure.
As Andreas writes in that thread,

	The primary use case is fast Gigabit (10 or more) Ethernet connections
	with jumbo frames and switches that support them.  There, frames will go
	through unchanged and you can zero-copy receive all the time.

If the data is misaligned in the socket buffers,
we cannot effectively do zero copy receive.

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
