Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 40DB21005434
	for <drbd-dev@lists.linbit.com>; Thu,  4 Oct 2012 14:54:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 39B721B435D
	for <drbd-dev@lists.linbit.com>; Thu,  4 Oct 2012 14:54:49 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Unq2jHUxLJUR for <drbd-dev@lists.linbit.com>;
	Thu,  4 Oct 2012 14:54:49 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 20E871B435C
	for <drbd-dev@lists.linbit.com>; Thu,  4 Oct 2012 14:54:49 +0200 (CEST)
Date: Thu, 4 Oct 2012 14:54:49 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20121004125449.GQ26479@soda.linbit>
References: <60051.ac1412ad.1349200050.nsm@goliat6.ugr.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60051.ac1412ad.1349200050.nsm@goliat6.ugr.es>
Subject: Re: [Drbd-dev] More than two nodes in one level
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Oct 02, 2012 at 07:47:30PM +0200, raulhp@ugr.es wrote:
> Hello,
> 
> I have seen in the Roadmap in www.drbd.org, that DRBD version 9 will
> include support for "More than two nodes in one level (ie without stacking
> device)." Is an implementation is similiar to "Three-way replication" of
> version 8.4?

The goal is obviously to *avoid* the stacking,
and still be able to support several peers "natively".

> Where I can see more information including the implementation of more than
> two nodes in one level.

We do not have it publicly available yet,
as it is not yet ready for general consumption.

Once we have a "beta", we'll announce it.
Don't ask for ETAs ;-)



Any specific reason you ask,
what is it you are trying to do?

Cheers,
	Lars

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com
