Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B22A1108889F
	for <drbd-dev@lists.linbit.com>; Tue,  3 Nov 2009 12:13:55 +0100 (CET)
Date: Tue, 3 Nov 2009 12:13:55 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20091103111355.GA12242@barkeeper1-xen.linbit>
References: <BC2F8964429F14468EA0E6D6CF00E8C9390D66@EXHQ.corp.stratus.com>
	<BC2F8964429F14468EA0E6D6CF00E8C9390DA7@EXHQ.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BC2F8964429F14468EA0E6D6CF00E8C9390DA7@EXHQ.corp.stratus.com>
Subject: Re: [Drbd-dev] Primary/Diskless node cannot reconnect
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Nov 02, 2009 at 10:47:54PM -0500, Graham, Simon wrote:
> > 8.2 is dead.
> 
> Hmmm... it hasn't stopped moving yet... are you saying you won't make
> any more fixes to it? 

Yes.

If we change something on the 8.0 branch, we sometimes still
merge it through the 8.2 branch first, as that helps in merging
it into the 8.3 one, because of all the whitespace changes and
constant renames ...

But if we fix something on 8.3, which would be relevant for 8.2,
we don't much care to merge it back.

"8.2.8" was officially 8.3.0, and no more 8.2 will happen.

> > has been fixed differently in 8.3 already,
> > where the corresponding code looks like
> > 
> >  if (mdev->state.conn < C_CONNECTED &&
> >             mdev->state.disk < D_INCONSISTENT &&
> >             mdev->state.role == R_PRIMARY &&
> >             (mdev->ed_uuid & ~((u64)1)) != (p_uuid[UI_CURRENT] &
> > ~((u64)1))) {
> > 
> 
> I must admit I haven't looked at 8.3 in any detail yet but that code you
> quote looks suspiciously like the 8.2 code to me -- D_DISKLESS is still
> a value less than D_INCONSISTENT...
> 
> Shouldn't this be:
> 
>   if (mdev->state.conn < C_CONNECTED &&
>              mdev->state.disk > D_DISKLESS &&
>              mdev->state.disk < D_INCONSISTENT &&
>              mdev->state.role == R_PRIMARY &&
>              (mdev->ed_uuid & ~((u64)1)) != (p_uuid[UI_CURRENT] &
> ~((u64)1))) {
> 
> To fix this same issue???

No.
The correct fix for your problem probably is not only this,
but some addition to the "exposed data uuid" stuff as well.

Because it is Primary, there may be cached pages,
file system and applications usually have a rough idea
what data they expect to live where.

What this is supposed to do is avoid a timewarp into stale data,
if you lose network first, hum along for hours,
and then lose the disk as well.

Or vice versa.

You are then only allowed to attach or connect to the
data you had last access to, not to the other set,
as the other set would mean a time warp into stale data.

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
