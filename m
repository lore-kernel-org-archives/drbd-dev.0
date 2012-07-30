Return-Path: <axboe@kernel.dk>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B9FD31017A2C
	for <drbd-dev@lists.linbit.com>; Mon, 30 Jul 2012 09:41:47 +0200 (CEST)
Message-ID: <501631D3.7080309@kernel.dk>
Date: Mon, 30 Jul 2012 09:03:47 +0200
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: Philipp Reisner <philipp.reisner@linbit.com>
References: <6356994.vJFLSmzzfE@fat-tyre>
In-Reply-To: <6356994.vJFLSmzzfE@fat-tyre>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd-8.3 fixes
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 07/24/2012 04:24 PM, Philipp Reisner wrote:
> Hi Jens,
> 
> Please consider to pull these changes for the 3.6 merge window.
> I did not found a for-3.6/drivers branch, so I based the patches
> on the 3.5 release.
> 
> Best,
>  Phil
> 
> 
> The following changes since commit 28a33cbc24e4256c143dce96c7d93bf423229f92:
> 
>   Linux 3.5 (2012-07-21 13:58:29 -0700)
> 
> are available in the git repository at:
> 
>   git://git.drbd.org/linux-drbd.git for-jens
> 
> for you to fetch changes up to a73ff3231df59a4b92ccd0dd4e73897c5822489b:
> 
>   drbd: announce FLUSH/FUA capability to upper layers (2012-07-24 15:14:28 +0200)
> 
> ----------------------------------------------------------------
> Lars Ellenberg (10):
>       drbd: cleanup, remove two unused global flags
>       drbd: differentiate between normal and forced detach
>       drbd: report congestion if we are waiting for some userland callback
>       drbd: reset congestion information before reporting it in /proc/drbd
>       drbd: do not reset rs_pending_cnt too early
>       drbd: call local-io-error handler early
>       drbd: fix potential access after free
>       drbd: flush drbd work queue before invalidate/invalidate remote                                 
>       drbd: fix max_bio_size to be unsigned                                                           
>       drbd: announce FLUSH/FUA capability to upper layers
> 
>  drivers/block/drbd/drbd_actlog.c   |    8 +++--
>  drivers/block/drbd/drbd_bitmap.c   |    4 +--
>  drivers/block/drbd/drbd_int.h      |   44 ++++++++++++++++--------
>  drivers/block/drbd/drbd_main.c     |   65 +++++++++++++++++++++++++++---------
>  drivers/block/drbd/drbd_nl.c       |   36 +++++++++++++++-----
>  drivers/block/drbd/drbd_proc.c     |    3 ++
>  drivers/block/drbd/drbd_receiver.c |   38 +++++++++++++++------
>  drivers/block/drbd/drbd_req.c      |    9 +++--
>  drivers/block/drbd/drbd_worker.c   |   12 ++-----
>  9 files changed, 153 insertions(+), 66 deletions(-)

Pulled, thanks.

-- 
Jens Axboe

