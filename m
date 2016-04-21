Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 421381056462
	for <drbd-dev@lists.linbit.com>; Thu, 21 Apr 2016 16:42:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 3855940C6EC
	for <drbd-dev@lists.linbit.com>; Thu, 21 Apr 2016 16:42:54 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id p3S5F-5Xz1pF for <drbd-dev@lists.linbit.com>;
	Thu, 21 Apr 2016 16:42:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 1CD0B40C6EB
	for <drbd-dev@lists.linbit.com>; Thu, 21 Apr 2016 16:42:54 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KyvcHw462zdn for <drbd-dev@lists.linbit.com>;
	Thu, 21 Apr 2016 16:42:54 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id EA9BF40C6EA
	for <drbd-dev@lists.linbit.com>; Thu, 21 Apr 2016 16:42:53 +0200 (CEST)
Date: Thu, 21 Apr 2016 16:42:53 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160421144253.GX3078@soda.linbit>
References: <CAF6H8oFVMK8vNg9jTBwZRThPtkBBb83jLXcej99whLC92+uO7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6H8oFVMK8vNg9jTBwZRThPtkBBb83jLXcej99whLC92+uO7A@mail.gmail.com>
Subject: Re: [Drbd-dev] [CASE-41] After re-connected,
 despite of OOS remaining primary does not start re-synchronization
 or continues AHEAD mode.
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

On Thu, Apr 21, 2016 at 11:01:56PM +0900, Jaeheon Kim wrote:
> Hi,
> 
> We wrote some temporary solution to avoid "continues AHEAD mode problem".
> We cleared AHEAD_TO_SYNC_SOURCE and forced drbd_uuid_new_current
> at conn_disconnect.
> 
> Please check following codes;
> 
> 
> 1. drbd_disconnected()
> {
> 
>  .....
> 
> drbd_md_sync(device);
> 
> if (get_ldev(device)) {
>     drbd_bitmap_io(device, &drbd_bm_write_copy_pages, "write from
> disconnected",
>                  BM_LOCK_BULK | BM_LOCK_SINGLE_SLOT, peer_device);
>     put_ldev(device);
> }
> 
> #ifdef _WIN32_V9 // temporary patch (clear AHEAD_TO_SYNC_SOURCE flag)
> clear_bit(AHEAD_TO_SYNC_SOURCE, &device->flags); //  Windows DRBD
> #endif
> 
> }
> 
> 
> 
> 2. conn_disconnect()
> {
> 
> ... at the end of this function.
> 
> #ifdef _WIN32_V9 // (don't create uuid when primary is
> drbdadm-disconnected) temporary patch
> 
>  if( (resource->role[NOW] == R_PRIMARY)
>  {
>         test_and_clear_bit(NEW_CUR_UUID, &device->flags);
>         mutex_lock(&resource->conf_update);
>         drbd_uuid_new_current(device, false);
>         mutex_unlock(&resource->conf_update);
>  }
> #endif
> 
> }
> 
> What do you think about this idea?

that the AHEAD_TO_SYNC_SOURCE bit needs to be cleaned up in disconnect
seems very plausible.
But that may get racy with more than one peer,
given that they all share the same bit in device->flags.
That does not feel right either.


UUID gets bumped on first write after the need for a bump was detected.

It needs to be bumped immediately in certain situations, though.
At least when we lose the peer disk with replication link still intact,
Probably in more situations.
Maybe simply when we lose contact to the peer while being "ahead".

Though in that case, usually the disk states (peer would be expected to
be inconsistent, or at least out-of-date) should be enough to start the
resync. anyways, it would be correct to immediately bump the uuid
when disconnecting while "ahead", we know that in general we have a
different (more recent) on-disk state in that case, no need to wait
for yet an other write.
I'll need to double check whether that happens already?

    Lars

