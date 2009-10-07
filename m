Return-Path: <axboe@kernel.dk>
Date: Wed, 7 Oct 2009 08:33:54 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20091007063354.GG5216@kernel.dk>
References: <20091007135505.df1f058c.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091007135505.df1f058c.sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org, Alasdair G Kergon <agk@redhat.com>,
	Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [Drbd-dev] linux-next: block tree build failure
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Oct 07 2009, Stephen Rothwell wrote:
> Hi Jens,
> 
> Today's linux-next build (x86_64 allmodconfig) failed like this:
> 
> drivers/block/drbd/drbd_req.c: In function '_drbd_start_io_acct':
> drivers/block/drbd/drbd_req.c:43: error: lvalue required as increment operand
> drivers/block/drbd/drbd_req.c: In function '_drbd_end_io_acct':
> drivers/block/drbd/drbd_req.c:56: error: lvalue required as decrement operand
> 
> This is back again :-(
> 
> I have used the block tree from next-20091006 for today.  I also had to
> use the device-mapper tree from next-20091006 since that is based on the
> block tree.

Irk darn, I fixed this up. Sorry about that, Stephen. It was due to the
in_flight counter being reverted for -rc3 and now back functional in my
upstream branch.

-- 
Jens Axboe

