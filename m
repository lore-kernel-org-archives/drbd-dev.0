Return-Path: <axboe@kernel.dk>
Received: from bombadil.infradead.org
	(173-166-109-252-newengland.hfc.comcastbusiness.net
	[173.166.109.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 86C07105643F
	for <drbd-dev@lists.linbit.com>; Thu, 28 Mar 2013 17:11:19 +0100 (CET)
Date: Thu, 28 Mar 2013 10:11:14 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <20130328161114.GD19488@kernel.dk>
References: <1364389729-17559-1-git-send-email-philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1364389729-17559-1-git-send-email-philipp.reisner@linbit.com>
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 00/17] RFC: Pile of DRBD fixes
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

On Wed, Mar 27 2013, Philipp Reisner wrote:
> The first patch improves the idr_for_each_entry() macro and its
> documentation, which is not specific to DRBD.
> 
> Each patch in this series addresses an independent issue, please refer
> to the individual commit messages for a description.

Applied to for-3.10/drivers, thanks.

-- 
Jens Axboe

