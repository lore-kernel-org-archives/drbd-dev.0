Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
	[209.85.208.54])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5CA4B420317
	for <drbd-dev@lists.linbit.com>; Mon, 27 Jul 2020 09:17:01 +0200 (CEST)
Received: by mail-ed1-f54.google.com with SMTP id i26so8027032edv.4
	for <drbd-dev@lists.linbit.com>; Mon, 27 Jul 2020 00:17:01 -0700 (PDT)
Date: Mon, 27 Jul 2020 09:16:58 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Sarah Newman <srn@prgmr.com>
Message-ID: <20200727071658.GH4222@soda.linbit>
References: <308845ca-17a3-43d0-b7ad-80069d9bc17f@prgmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <308845ca-17a3-43d0-b7ad-80069d9bc17f@prgmr.com>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Bug(s) with Linux v5.4.46
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sun, Jul 26, 2020 at 08:55:10PM -0700, Sarah Newman wrote:

> 	kref_put(&device->kref, drbd_destroy_device);

At this point we are "sure" to still hold at least one
additional reference on device.

> 	del_gendisk(device->vdisk);
> 	synchronize_rcu();

which we put here:

> 	kref_put(&device->kref, drbd_destroy_device);


But what you present here shows that in your case that is not true.

There is nothing DRBD specific new in the mentioned kernel version.

> In drbd_destroy_device, there is the line:
> 
> memset(device, 0xfd, sizeof(*device));
> 
> So I think that drbd_destroy_device must have run before del_gendisk,
> and therefore the reference count for device->kref is unbalanced.

Looks like it.

> I do not know if this is related to the error message:
> 
>  ASSERTION FAILED: connection->current_epoch->list not empty
> 
> or not.
> 
> There were no error messages reported on the peer.
> 
> FYI, when we've run in debug mode we've seen some ODEBUG errors about
> freeing active objects around the time that DRBD resources were released.
> One was a work_struct and the other was a timer_list. I do not know if
> either of those are related.

You want to show them? Maybe they help in understanding what is going on here.


> The system in question is still up and running in an error state; is
> there any more information you want from it?

No.

But: is this "easily" reproducible? If so: how?

    Lars

