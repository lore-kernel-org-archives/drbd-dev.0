Return-Path: <BATV+4d4f7abe5776451c4d8a+8263+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8B011160876
	for <drbd-dev@lists.linbit.com>; Wed,  8 Apr 2026 07:17:51 +0200 (CEST)
Date: Tue, 7 Apr 2026 22:17:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 00/20] DRBD 9 rework
Message-ID: <adXk_m3SbRcWTOIC@infradead.org>
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
	<ecf00b4b-c3f8-4161-a97d-3d23b423cabf@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ecf00b4b-c3f8-4161-a97d-3d23b423cabf@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
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

On Thu, Apr 02, 2026 at 07:30:35PM -0600, Jens Axboe wrote:
> On 3/27/26 4:38 PM, Christoph Böhmwalder wrote:
> > As discussed (context: [0]), here is the first version of our DRBD 9
> > rework series, intended for for-next via for-7.1/drbd.
> 
> Will you fixup the kerneldoc (nits) and the assigned-but-not-read
> issues and send out a new version? Also looks this series doesn't
> actually apply to for-7.1/block, patch 12 fails.

Looks like all this went in without any review?  Since when have we
started these grand replacements anyway, as they are known to cause
bugs and regressions?

