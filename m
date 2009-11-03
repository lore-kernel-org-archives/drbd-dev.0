Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9FC081011BBE
	for <drbd-dev@lists.linbit.com>; Tue,  3 Nov 2009 15:09:44 +0100 (CET)
Date: Tue, 3 Nov 2009 15:09:44 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20091103140944.GF12242@barkeeper1-xen.linbit>
References: <BC2F8964429F14468EA0E6D6CF00E8C9390DAC@EXHQ.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BC2F8964429F14468EA0E6D6CF00E8C9390DAC@EXHQ.corp.stratus.com>
Subject: Re: [Drbd-dev] Primary/Diskless node cannot reconnect
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Nov 03, 2009 at 07:40:44AM -0500, Graham, Simon wrote:
> > 
> > No.
> > The correct fix for your problem probably is not only this,
> > but some addition to the "exposed data uuid" stuff as well.
> > 
> > Because it is Primary, there may be cached pages,
> > file system and applications usually have a rough idea
> > what data they expect to live where.
> > 
> > What this is supposed to do is avoid a timewarp into stale data,
> > if you lose network first, hum along for hours,
> > and then lose the disk as well.
> > 
> > Or vice versa.
> > 
> > You are then only allowed to attach or connect to the
> > data you had last access to, not to the other set,
> > as the other set would mean a time warp into stale data.
> > 
> 
> Good point -- if you lose the network first then I agree. However, if
> you lose the primary side disk first then I don't think you can hit this
> 'time warp'.


Sure you can.
You could first lose the disk, then lose the link,
and then admin tries to attach the disk.

And the latter now needs to fail.

If the "exposed data uuid" (mdev->ed_uuid) does not match the
"to be connected to" uuid, or the "to be attached" uuid,
respectively, connecting or attaching is refused.

Which is what that check does, or at least is supposed to do.

> My first thought when looking at this was to NOT attempt to update the
> current UUID on the Primary if it is diskless when you lose the
> connection - however, this doesn't work in the specific case that caused
> us to see this problem -- in that case, we had a DRBD device sitting on
> a physical disk which had actually gone bad; however, we didn't see this
> until we tried to write the meta-data with the updated UUID when we lost
> the network connection...
> 
> Maybe we just need to back out the UUID update if you cant flush it to
> disk...

Please try to reproduce whatever issue you have had with drbd-8.3.5.
I was under the impression all combinations of how things can go wrong
here would have been excercised and found to work.

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
