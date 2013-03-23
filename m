Return-Path: <axboe@kernel.dk>
Received: from bombadil.infradead.org
	(173-166-109-252-newengland.hfc.comcastbusiness.net
	[173.166.109.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9A45C1056308
	for <drbd-dev@lists.linbit.com>; Sat, 23 Mar 2013 02:21:07 +0100 (CET)
Date: Fri, 22 Mar 2013 18:15:42 -0600
From: Jens Axboe <axboe@kernel.dk>
To: lars.ellenberg@linbit.com
Message-ID: <20130323001542.GN1628@kernel.dk>
References: <1363713419-17803-1-git-send-email-philipp.reisner@linbit.com>
	<1363713419-17803-11-git-send-email-philipp.reisner@linbit.com>
	<20130322202224.GJ5231@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130322202224.GJ5231@soda.linbit>
Cc: drbd-dev@lists.linbit.com, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [Drbd-dev] [PATCH 10/18,
 update] drbd: prepare to queue write requests on a submit worker
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

On Fri, Mar 22 2013, lars.ellenberg@linbit.com wrote:
> From: Lars Ellenberg <lars.ellenberg@linbit.com>
> 
> Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
> Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
> ---
>  drivers/block/drbd/drbd_int.h  |   13 +++++++++++++
>  drivers/block/drbd/drbd_main.c |   26 +++++++++++++++++++++++++-
>  drivers/block/drbd/drbd_nl.c   |    1 +
>  drivers/block/drbd/drbd_req.c  |   29 +++++++++++++++++++++++++++++
>  4 files changed, 68 insertions(+), 1 deletion(-)
> 
> Updated
> =======
> to apply against current upstream,
> because of 56de210 drbd: convert to idr_alloc()
> affected the context of the last chunk of drbd_main.c; now last two
> chunks: needed to re-add the out_idr_remove_vol cleanup goto.

That's better - updated series and pushed out for testing.

-- 
Jens Axboe

