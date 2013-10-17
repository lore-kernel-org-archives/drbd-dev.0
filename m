Return-Path: <drbd@ew.ewheeler.org>
Received: from hapkido.dreamhost.com (hapkido.dreamhost.com [66.33.216.122])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id BFECA1056F69
	for <drbd-dev@lists.linbit.com>; Fri, 18 Oct 2013 01:01:00 +0200 (CEST)
Received: from homiemail-a2.g.dreamhost.com (caiajhbdcahe.dreamhost.com
	[208.97.132.74])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 9710278A
	for <drbd-dev@lists.linbit.com>; Thu, 17 Oct 2013 16:00:58 -0700 (PDT)
Date: Thu, 17 Oct 2013 16:00:54 -0700 (PDT)
From: Eric Wheeler <drbd@ew.ewheeler.org>
To: Lars Ellenberg <lars.ellenberg@linbit.com>
In-Reply-To: <20130927124748.GD16596@soda.linbit>
Message-ID: <alpine.DEB.2.00.1310171558200.1745@ware.dreamhost.com>
References: <alpine.DEB.2.00.1309261150420.47088@ware.dreamhost.com>
	<20130927124748.GD16596@soda.linbit>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD Trim/discard
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


On Fri, 27 Sep 2013, Lars Ellenberg wrote:
> On Thu, Sep 26, 2013 at 12:01:40PM -0700, Eric Wheeler wrote:
>> We would like to run DRBD backed by thin-provisioned volumes (think
>> ZFS or dm-thinp) which require discard support to dereference unused
>> block allocations.
>
> We are integrating DISCARD / TRIM support into our currently pending 
> DRBD 8.4.4 release, right now. Code changes expected to be pushed with 
> the RC2, latest early next week.
>
> Thanks for testing and feedback,

I just sat down to look into TRIM support in the git tree, none of the 
commits in the shortlog are obvious. Has this already been committed? If 
so, do you have a commit number or alternate git tree that I can pull 
down?

-Eric
