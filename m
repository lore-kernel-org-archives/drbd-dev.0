Return-Path: <BATV+a4de8e1a1e27f13a2878+8264+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 89442160870
	for <drbd-dev@lists.linbit.com>; Thu,  9 Apr 2026 08:40:43 +0200 (CEST)
Date: Wed, 8 Apr 2026 23:40:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 00/20] DRBD 9 rework
Message-ID: <addJ6uTc8Zo4GKpW@infradead.org>
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
	<ecf00b4b-c3f8-4161-a97d-3d23b423cabf@kernel.dk>
	<adXk_m3SbRcWTOIC@infradead.org>
	<c92d5318-8c8e-434f-835e-61cf1fae4edf@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c92d5318-8c8e-434f-835e-61cf1fae4edf@kernel.dk>
Cc: linux-block@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
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

First an apology, I thought it was in your tree, but it looks like
the drbd branch just has minor fixes.  So a lot less urgency.

On Wed, Apr 08, 2026 at 06:58:58AM -0600, Jens Axboe wrote:
> See the previous discussion,

Do you have a pointer to that discussion?  I can't remember one.

> the goal is to sync the two drbd code
> bases. It's followed the "usual" pattern of the in-kernel driver being
> neglected and development and users pushed to the out-of-tree one,
> which is highly annoying.

I don't think that's a a usual pattern.  Also the new version looks
like a complete rewrite and not something incremental:

 45 files changed, 45891 insertions(+), 16264 deletions(-)

For a code base that is "29482 total".

I think reviewing it would be easier by just adding an new drbd9 driver
and then steering people toward it carefully, as that is actually
reviewable compared to non-bisectable patches changing large chunks
of code in a non-atomic way.

