Return-Path: <lars.ellenberg@linbit.com>
Date: Wed, 23 Sep 2009 09:11:52 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20090923071152.GA8000@barkeeper1-xen.linbit>
References: <20090923145100.1917fdd8.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20090923145100.1917fdd8.sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-next@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] linux-next: block tree build failure
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Sep 23, 2009 at 02:51:00PM +1000, Stephen Rothwell wrote:
> Hi Jens,
> 
> Today's linux-next build (x86_64 allmodconfig) failed like this:
> 
> drivers/block/drbd/drbd_tracing.c:29:26: error: linux/marker.h: No such file or directory
> 
> Caused by commit 95eaef1cbc63f73df4ff8559dd66b1d29b462535 ("Replaced our
> own tracing stuff with Linux's tracepoints") from the block/drbd trees
> interacting with commit fc5377668c3d808e1d53c4aee152c836f55c3490
> ("tracing: Remove markers") from Linus' tree.
> 
> I have no idea what the correct thing to do is here, so I have reverted
> the merge of the drbd tree into the block tree and will have to drop the
> drbd tree for today.

We'll have a look.
A quick fix should be to just disable CONFIG_DRBD_TRACE.

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
