Return-Path: <axboe@kernel.dk>
Received: from mail-pd0-f171.google.com (mail-pd0-f171.google.com
	[209.85.192.171]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id CA0021011B9B
	for <drbd-dev@lists.linbit.com>; Wed, 25 Mar 2015 03:31:54 +0100 (CET)
Received: by pdbcz9 with SMTP id cz9so12674969pdb.3
	for <drbd-dev@lists.linbit.com>; Tue, 24 Mar 2015 19:31:52 -0700 (PDT)
Message-ID: <551216F1.4010907@kernel.dk>
Date: Tue, 24 Mar 2015 20:01:21 -0600
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: David Rientjes <rientjes@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
References: <alpine.DEB.2.10.1503241620190.21805@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.10.1503241620190.21805@chino.kir.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
	drbd-user@lists.linbit.com, Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [patch resend 1/3] block: allocate request memory
 local to request queue
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

On 03/24/2015 05:21 PM, David Rientjes wrote:
> blk_init_rl() allocates a mempool using mempool_create_node() with node
> local memory.  This only allocates the mempool and element list locally
> to the requeue queue node.
>
> What we really want to do is allocate the request itself local to the
> queue.  To do this, we need our own alloc and free functions that will
> allocate from request_cachep and pass the request queue node in to prefer
> node local memory.

Applied to for-4.1/core, thanks.

-- 
Jens Axboe

