Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 840F01063E4D
	for <drbd-dev@lists.linbit.com>; Mon,  5 Oct 2009 11:50:57 +0200 (CEST)
Resent-Message-ID: <20091005095057.GC8038@barkeeper1-xen.linbit>
Date: Mon, 5 Oct 2009 01:45:36 -0700 (PDT)
From: david@lang.hm
To: Jens Axboe <jens.axboe@oracle.com>
In-Reply-To: <20091005063138.GO26573@kernel.dk>
Message-ID: <alpine.DEB.2.00.0910050138351.9391@asgard.lang.hm>
References: <20091005143552.977a2d4d.sfr@canb.auug.org.au>
	<20091005063138.GO26573@kernel.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [Drbd-dev] linux-next: block/drbd tree build failure
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, 5 Oct 2009, Jens Axboe wrote:

> On Mon, Oct 05 2009, Stephen Rothwell wrote:
>> Hi Jens,
>>
>> Today's linux-next build (x86_64 allmodconfig) failed like this:
>>
>> drivers/block/drbd/drbd_req.c: In function '_drbd_start_io_acct':
>> drivers/block/drbd/drbd_req.c:43: error: subscripted value is neither array nor pointer
>> drivers/block/drbd/drbd_req.c: In function '_drbd_end_io_acct':
>> drivers/block/drbd/drbd_req.c:56: error: subscripted value is neither array nor pointer
>>
>> I reported a similar error against the dbd tree, which was fixed, but now
>> the commit that caused that error has been reverted and thus we get
>> this :-(
>>
>> I have reverted the drbd commits from the block tree for today.
>
> That's probably my fault, not drbd. I moved it to a new branch since it
> isn't going into 2.6.32, and perhaps dropped that fix along the way.
> I'll look into it.


what needs to happen to get drbd accepted at this point? It sounded like 
they had the tree in good shape to be merged, except for the desire that 
was expressed to have them re-work all existing raid implementations 
before adding their code (and it sounded like that was not going to be 
allowed to hold it up)

David Lang

