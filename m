Return-Path: <axboe@kernel.dk>
Date: Mon, 5 Oct 2009 08:31:38 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20091005063138.GO26573@kernel.dk>
References: <20091005143552.977a2d4d.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091005143552.977a2d4d.sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [Drbd-dev] linux-next: block/drbd tree build failure
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Oct 05 2009, Stephen Rothwell wrote:
> Hi Jens,
> 
> Today's linux-next build (x86_64 allmodconfig) failed like this:
> 
> drivers/block/drbd/drbd_req.c: In function '_drbd_start_io_acct':
> drivers/block/drbd/drbd_req.c:43: error: subscripted value is neither array nor pointer
> drivers/block/drbd/drbd_req.c: In function '_drbd_end_io_acct':
> drivers/block/drbd/drbd_req.c:56: error: subscripted value is neither array nor pointer
> 
> I reported a similar error against the dbd tree, which was fixed, but now
> the commit that caused that error has been reverted and thus we get
> this :-(
> 
> I have reverted the drbd commits from the block tree for today.

That's probably my fault, not drbd. I moved it to a new branch since it
isn't going into 2.6.32, and perhaps dropped that fix along the way.
I'll look into it.

-- 
Jens Axboe

