Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 08DC81050584
	for <drbd-dev@lists.linbit.com>; Tue, 10 Mar 2015 11:38:39 +0100 (CET)
Date: Tue, 10 Mar 2015 11:38:38 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: David Rientjes <rientjes@google.com>
Message-ID: <20150310103838.GB3961@soda.linbit>
References: <alpine.DEB.2.10.1503071623250.31688@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1503071623250.31688@chino.kir.corp.google.com>
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
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

On Sat, Mar 07, 2015 at 04:24:02PM -0800, David Rientjes wrote:
> mempool_alloc() does not support __GFP_ZERO since elements may come from
> memory that has already been released by mempool_free().
> 
> Remove __GFP_ZERO from mempool_alloc() in drbd_req_new() and properly
> initialize it to 0.

We used to have the explicit memset there,
but then changed that, because

I was under the impression that since
2007-07-17 d07dbea, Slab allocators: support __GFP_ZERO in all allocators
it was supported?

	Lars Ellenberg

