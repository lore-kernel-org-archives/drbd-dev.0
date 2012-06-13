Return-Path: <axboe@kernel.dk>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 395CD1019A68
	for <drbd-dev@lists.linbit.com>; Wed, 13 Jun 2012 22:29:04 +0200 (CEST)
Date: Wed, 13 Jun 2012 21:20:00 +0200
From: Jens Axboe <jaxboe@fusionio.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <20120613192000.GE8230@kernel.dk>
References: <1788738.mNsnrf6o6T@fat-tyre>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1788738.mNsnrf6o6T@fat-tyre>
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] drbd fixes
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Jun 12 2012, Philipp Reisner wrote:
> Hi Jens,
> 
> In the last 4 weeks three bugs were reported and fixed. Please consider
> to pass these 3 commits on to Linus.
> 
> The following changes since commit 4fd1ffaa122cf66bfb710ced43679413df4f3605:
> 
>   Merge branch 'for-jens' of git://git.drbd.org/linux-drbd into for-3.5/drivers (2012-05-18 16:20:06 +0200)
> 
> are available in the git repository at:
> 
> 
>   git://git.drbd.org/linux-drbd.git for-jens
> 
> for you to fetch changes up to 0d5934e3c258fc5decc4103600c597086fd95a52:
> 
>   drbd: fix null pointer dereference with on-congestion policy when diskless (2012-06-12 14:35:19 +0200)

Pulled, thanks.

-- 
Jens Axboe

