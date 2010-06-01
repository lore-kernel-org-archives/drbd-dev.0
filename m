Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 78179148377B
	for <drbd-dev@lists.linbit.com>; Tue,  1 Jun 2010 14:07:12 +0200 (CEST)
Resent-Message-ID: <20100601120712.GD26706@soda.linbit>
Date: Tue, 1 Jun 2010 10:31:26 +0200
From: Jens Axboe <jaxboe@fusionio.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20100601083126.GB3564@kernel.dk>
References: <20100601141324.edf41f7f.sfr@canb.auug.org.au>
	<20100601081823.GA29991@infradead.org>
	<20100601182213.479a777e.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100601182213.479a777e.sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	linux-next@vger.kernel.org, Julia Lawall <julia@diku.dk>,
	Al Viro <viro@zeniv.linux.org.uk>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] linux-next: manual merge of the drbd tree with
	Linus' tree
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Jun 01 2010, Stephen Rothwell wrote:
> [Replacing Jens' Oracle address ...]
> 
> Hi Christoph,
> 
> On Tue, 1 Jun 2010 04:18:23 -0400 Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, Jun 01, 2010 at 02:13:24PM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Today's linux-next merge of the drbd tree got a conflict in fs/pipe.c
> > > between commit cc967be54710d97c05229b2e5ba2d00df84ddd64 ("fs: Add missing
> > > mutex_unlock") from Linus' tree and commits
> > > 0191f8697bbdfefcd36e7b8dc3eeddfe82893e4b ("pipe: F_SETPIPE_SZ should
> > > return -EPERM for non-root") and b9598db3401282bb27b4aef77e3eee12015f7f29
> > > ("pipe: make F_{GET,SET}PIPE_SZ deal with byte sizes") from the drbd tree.
> > > 
> > > I fixed it up (see below) and can carry the fix for a while.
> > 
> > Why is the drbd tree touching fs/pipe.c anyway?
> 
> It is based on the block tree.  I assume that it is currently based on a
> version of the block tree that Jens has not yet pushed into
> linux-next.  :-(

Just checked, and it is indeed for-next that is behind... Will update
it.

-- 
Jens Axboe

