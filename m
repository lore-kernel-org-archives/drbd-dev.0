Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 841FF1050594
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 00:06:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 77F5344D2AE
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 00:06:39 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id usCqz-LzQpuQ for <drbd-dev@lists.linbit.com>;
	Fri, 13 Mar 2015 00:06:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 58B0F44D38F
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 00:06:39 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id up6bFL5m7qt9 for <drbd-dev@lists.linbit.com>;
	Fri, 13 Mar 2015 00:06:39 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 3027F44D2AE
	for <drbd-dev@lists.linbit.com>; Fri, 13 Mar 2015 00:06:39 +0100 (CET)
Resent-Message-ID: <20150312230638.GK3961@soda.linbit>
Received: from mail-ig0-f169.google.com (mail-ig0-f169.google.com
	[209.85.213.169]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 5B72D1050597
	for <drbd-dev@lists.linbit.com>; Tue, 10 Mar 2015 20:29:01 +0100 (CET)
Received: by igkb16 with SMTP id b16so6738070igk.1
	for <drbd-dev@lists.linbit.com>; Tue, 10 Mar 2015 12:29:00 -0700 (PDT)
Date: Tue, 10 Mar 2015 12:28:58 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Jens Axboe <axboe@fb.com>, drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <20150310103838.GB3961@soda.linbit>
Message-ID: <alpine.DEB.2.10.1503101223090.29618@chino.kir.corp.google.com>
References: <alpine.DEB.2.10.1503071623250.31688@chino.kir.corp.google.com>
	<20150310103838.GB3961@soda.linbit>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Drbd-dev] [DRBD-user] [patch 1/2] block,
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

On Tue, 10 Mar 2015, Lars Ellenberg wrote:

> > mempool_alloc() does not support __GFP_ZERO since elements may come from
> > memory that has already been released by mempool_free().
> > 
> > Remove __GFP_ZERO from mempool_alloc() in drbd_req_new() and properly
> > initialize it to 0.
> 
> We used to have the explicit memset there,
> but then changed that, because
> 
> I was under the impression that since
> 2007-07-17 d07dbea, Slab allocators: support __GFP_ZERO in all allocators
> it was supported?
> 

The slab allocators do support __GFP_ZERO, and they can do so because they 
know the object size to zero.

The problem is that this is a mempool, not a slab cache.

The mempool layer, based on top of the slab allocator in this case, will 
preserve elements (slab objects) for contexts when allocation may not be 
possible.  mempool_alloc(GFP_NOIO) may be able to allocate from the slab 
allocator and the object will be properly zeroed.  However, if it has to 
fallback to the reserved pool then mempool_alloc() will pull an element 
that may have already been allocated and freed back to the reserved pool.

In that latter case, the memory contents of the element is what it was 
when freed, assuming no use-after-free issues.  It cannot be zeroed by the 
mempool layer since mempools do not know of the object size.  We can't 
special-case mempools based on the slab allocator since then we have a 
situation where __GFP_ZERO works on some mempools but not others.  The 
rule is that __GFP_ZERO is never guaranteed for mempool_alloc() and that's 
included in the comment of the function as well as a WARN_ON_ONCE() if 
CONFIG_DEBUG_VM is enabled.
