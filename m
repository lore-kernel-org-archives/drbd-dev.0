Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (0122700014.0.fullrate.dk [95.166.99.235])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 39B0910BB09E
	for <drbd-dev@lists.linbit.com>; Tue, 18 May 2010 15:05:47 +0200 (CEST)
Date: Tue, 18 May 2010 15:05:46 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <20100518130545.GZ25951@kernel.dk>
References: <20100518152031.9a244971.sfr@canb.auug.org.au>
	<201005181345.22986.philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201005181345.22986.philipp.reisner@linbit.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] linux-next: manual merge of the drbd tree with the
	block tree
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, May 18 2010, Philipp Reisner wrote:
> Hi Stephen,
> 
> FYI:
> I use 
> git://git.drbd.org/linux-2.6-drbd.git for-jens
> as path of my patches to Jens.
> 
> I switched that tree to Jens' 
> git://git.kernel.dk/linux-2.6-block.git for-2.6.35
> and provided the DRBD patches on top of that.
> 
> Not that I am not willing to help, I have the feeling that this
> merge conflict has nothing to do with DRBD.

I suspect that the merge will go smoothly with the updated branches when
Stephen runs his scripts tomorrow.

-- 
Jens Axboe

