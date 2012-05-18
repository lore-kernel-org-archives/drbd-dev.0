Return-Path: <axboe@kernel.dk>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 397971013803
	for <drbd-dev@lists.linbit.com>; Fri, 18 May 2012 17:12:53 +0200 (CEST)
Date: Fri, 18 May 2012 16:22:26 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <20120518142226.GF6496@kernel.dk>
References: <4277851.LeAnKnANCB@fat-tyre>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4277851.LeAnKnANCB@fat-tyre>
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] drbd-8.3 updates
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, May 10 2012, Philipp Reisner wrote:
> Hi Jens,
> 
> This are the updates we have in the drbd-8.3 tree. They are intended
> for your "for-3.5/drivers" drivers branch.
> 
> These changes include one new feature:
>  * Allow detach from frozen backing devices with the new --force option;
>    configurable timeout for backing devices by the new disk-timeout option
> 
> And huge number of bug fixes:
>  * Fixed a write ordering problem on SyncTarget nodes for a write
>    to a block that gets resynced at the same time. The bug can
>    only be triggered with a device that has a firmware that
>    actually reorders writes to the same block
>  * Fixed a race between disconnect and receive_state, that could cause
>    a IO lockup
>  * Fixed resend/resubmit for requests with disk or network timeout
>  * Make sure that hard state changed do not disturb the connection
>    establishing process (I.e. detach due to an IO error). When the
>    bug was triggered it caused a retry in the connect process
>  * Postpone soft state changes to no disturb the connection
>    establishing process (I.e. becoming primary). When the bug
>    was triggered it could cause both nodes going into SyncSource state
>  * Fixed a refcount leak that could cause failures when trying to
>    unload a protocol family modules, that was used by DRBD
>  * Dedicated page pool for meta data IOs
>  * Deny normal detach (as opposed to --forced) if the user tries
>    to detach from the last UpToDate disk in the resource
>  * Fixed a possible protocol error that could be caused by
>    "unusual" BIOs.
>  * Enforce the disk-timeout option also on meta-data IO operations
>  * Implemented stable bitmap pages when we do a full write out of
>    the bitmap
>  * Fixed a rare compatibility issue with DRBD's older than 8.3.7
>    when negotiating the bio_size
>  * Fixed a rare race condition where an empty resync could stall with
>    if pause/unpause events happen in parallel
>  * Made the re-establishing of connections quicker, if it got a broken pipe
>    once. Previously there was a bug in the code caused it to waste the first
>    successful established connection after a broken pipe event.
> 
> PS: I am postponing the drbd-8.4 for mainline for one or two kernel
>     development cycles more (the ~400 patchets set).
> 
> Best regards,
>  Philipp
> 
> The following changes since commit 0b7877d4eea3f93e3dd941999522bbd8c538cb53:
> 
>   Merge tag 'v3.4-rc5' into for-3.5/core (2012-05-01 14:29:55 +0200)
> 
> are available in the git repository at:
> 
>   git@git.drbd.org:linux-drbd for-jens

Thanks, pulled in. Your git url confused me a bit, though, I pulled in
git://git.drbd.org/linux-drbd for-jens

Diffstat matches etc, so I'm jotting the above down to a typo in your
pull request script.

-- 
Jens Axboe

