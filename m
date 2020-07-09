Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 4C6E14203F5
	for <drbd-dev@lists.linbit.com>; Thu,  9 Jul 2020 16:01:47 +0200 (CEST)
Date: Thu, 9 Jul 2020 16:01:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Message-ID: <20200709140145.GA3068@lst.de>
References: <20200701090622.3354860-1-hch@lst.de>
	<b5d6df17-68af-d535-79e4-f95e16dd5632@kernel.dk>
	<20200709053233.GA3243@lst.de>
	<82e2785d-2091-1986-0014-3b7cea7cd0d8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82e2785d-2091-1986-0014-3b7cea7cd0d8@kernel.dk>
Cc: linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, dm-devel@redhat.com,
	Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] remove dead bdi congestion leftovers
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

On Thu, Jul 09, 2020 at 07:58:58AM -0600, Jens Axboe wrote:
> On 7/8/20 11:32 PM, Christoph Hellwig wrote:
> > On Wed, Jul 08, 2020 at 05:14:29PM -0600, Jens Axboe wrote:
> >> On 7/1/20 3:06 AM, Christoph Hellwig wrote:
> >>> Hi Jens,
> >>>
> >>> we have a lot of bdi congestion related code that is left around without
> >>> any use.  This series removes it in preparation of sorting out the bdi
> >>> lifetime rules properly.
> >>
> >> Please run series like this through a full compilation, for both this one
> >> and the previous series I had to fix up issues like this:
> >>
> >> drivers/md/bcache/request.c: In function ‘bch_cached_dev_request_init’:
> >> drivers/md/bcache/request.c:1233:18: warning: unused variable ‘g’ [-Wunused-variable]
> >>  1233 |  struct gendisk *g = dc->disk.disk;
> >>       |                  ^
> >> drivers/md/bcache/request.c: In function ‘bch_flash_dev_request_init’:
> >> drivers/md/bcache/request.c:1320:18: warning: unused variable ‘g’ [-Wunused-variable]
> >>  1320 |  struct gendisk *g = d->disk;
> >>       |                  ^
> >>
> >> Did the same here, applied it.
> > 
> > And just like the previous one I did, and the compiler did not complain.
> > There must be something about certain gcc versions not warning about
> > variables that are initialized but not otherwise used.
> 
> Are you using gcc-10? It sucks for that. gcc-9 seems to reliably hit
> these cases for me, not sure why gcc-10 doesn't. And the ones quoted
> above are about as trivial as they can get.

gcc-9.3 from Debian -testing.  And yes, I'm really surprised it didn't
find those.
