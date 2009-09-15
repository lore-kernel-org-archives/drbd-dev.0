Return-Path: <axboe@kernel.dk>
Date: Tue, 15 Sep 2009 08:23:06 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20090915062306.GP14984@kernel.dk>
References: <20090915160739.86e85ab3.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090915160739.86e85ab3.sfr@canb.auug.org.au>
Cc: Nikanth Karthikesan <knikanth@suse.de>, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] linux-next: drbd tree build failure
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Sep 15 2009, Stephen Rothwell wrote:
> Hi Philipp,
> 
> Today's linux-next build (x86_64 allmodconfig) failed like this:
> 
> drivers/block/drbd/drbd_req.c: In function '_drbd_start_io_acct':
> drivers/block/drbd/drbd_req.c:45: error: lvalue required as increment operand
> drivers/block/drbd/drbd_req.c: In function '_drbd_end_io_acct':
> drivers/block/drbd/drbd_req.c:58: error: lvalue required as decrement operand
> 
> Caused by commit 954749162c98ca45c42cbc00c9ed6d5d6c0b8bb7 ("DRBD:
> request") from the drbd tree interacting with commit
> a9327cac440be4d8333bba975cbbf76045096275 ("Seperate read and write
> statistics of in_flight requests") from the block tree.
> 
> I have applied the following merge fix for today, but there may be a
> better fix.

Fix looks correct.

-- 
Jens Axboe

