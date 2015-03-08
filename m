Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E202B105059C
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 00:08:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id DE6AB44D30A
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 00:08:12 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id i4EUBX9EqVvC for <drbd-dev@lists.linbit.com>;
	Fri, 13 Mar 2015 00:08:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id BF0A644D391
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 00:08:12 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OHNU4A32E08v for <drbd-dev@lists.linbit.com>;
	Fri, 13 Mar 2015 00:08:12 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 952F744D39A
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 00:08:12 +0100 (CET)
Resent-Message-ID: <20150312230812.GQ3961@soda.linbit>
Received: from mail-ie0-f175.google.com (mail-ie0-f175.google.com
	[209.85.223.175]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E864A1028A59
	for <drbd-dev@lists.linbit.com>; Sun,  8 Mar 2015 02:27:46 +0100 (CET)
Received: by iery20 with SMTP id y20so1551287ier.0
	for <drbd-dev@lists.linbit.com>; Sat, 07 Mar 2015 17:27:45 -0800 (PST)
Date: Sat, 7 Mar 2015 17:27:43 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Jens Axboe <axboe@fb.com>
In-Reply-To: <54FB9FE2.5040707@fb.com>
Message-ID: <alpine.DEB.2.10.1503071724050.4711@chino.kir.corp.google.com>
References: <alpine.DEB.2.10.1503071623250.31688@chino.kir.corp.google.com>
	<54FB98F3.2050308@fb.com>
	<alpine.DEB.2.10.1503071650270.2926@chino.kir.corp.google.com>
	<54FB9FE2.5040707@fb.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, drbd-user@lists.linbit.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [patch 1/2] block,
	drbd: fix drbd_req_new() initialization
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

On Sat, 7 Mar 2015, Jens Axboe wrote:

> >>> mempool_alloc() does not support __GFP_ZERO since elements may come from
> >>> memory that has already been released by mempool_free().
> >>>
> >>> Remove __GFP_ZERO from mempool_alloc() in drbd_req_new() and properly
> >>> initialize it to 0.
> >>
> >> You should add it to mempool instead, avoid having this issue show up for
> >> other folks as well. It'd be trivial to do. Normal ->alloc() should honor
> >> __GFP_ZERO, just do the same manually for removing an item from the internal
> >> pool.
> >>
> > 
> > Umm, it's not trivial to do and wouldn't make sense to do it.  Mempools 
> 
> Uhm, it would make sense, though.
> 

Disagree, I don't think we should extend mempool to know the element size, 
modify every user of mempool to pass it in, and keep it consistent with 
mempool_alloc_t for the benefit of __GFP_ZERO for this one buggy caller.  
Most users don't need __GFP_ZERO and just overwrite the entire element 
after mempool_alloc() and it would be an unnecessary overhead to even 
check for the bit set.  So it wouldn't make sense in terms of performance 
or maintainability.

> > don't know the element size, in other words it wouldn't know the length to 
> > memset() to 0 for mempool_alloc().  It shouldn't be modified to know the 
> > element size since elements are allocated by the implementation of 
> > mempool_alloc_t and they could easily become inconsistent.  This patch is 
> > what you want to merge, really.
> > 
> 
> I forgot we don't have the size in there. Then I would suggest adding a
> WARN_ON() for __GFP_ZERO being set in mempool_alloc(), at the very least.
> 

There is, it's a VM_WARN_ON_ONCE() that will show up if you configure 
CONFIG_DEBUG_VM.
