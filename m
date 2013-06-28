Return-Path: <axboe@kernel.dk>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9B7891057EC6
	for <drbd-dev@lists.linbit.com>; Fri, 28 Jun 2013 16:49:21 +0200 (CEST)
Date: Fri, 28 Jun 2013 16:05:24 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <20130628140524.GL24293@kernel.dk>
References: <1372171808-30515-1-git-send-email-philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1372171808-30515-1-git-send-email-philipp.reisner@linbit.com>
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 0/6] DRBD fixes and one functional enhancemet
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

On Tue, Jun 25 2013, Philipp Reisner wrote:
> Hi Jens,
> 
> Please consider to apply these patches to your for-3.11/drivers branch.
> 
> The first 4 patches are obvious fixes. The last patch adds
> the capability to change the activity log layout online.
> (al-stripes and al-stripe-size)
> 
> I posted these patches on the 14th for review.

Thanks, added for 3.11.

-- 
Jens Axboe

