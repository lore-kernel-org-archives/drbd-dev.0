Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 6A5B91483762
	for <drbd-dev@lists.linbit.com>; Tue,  1 Jun 2010 14:07:06 +0200 (CEST)
Resent-Message-ID: <20100601120706.GC26706@soda.linbit>
Date: Tue, 1 Jun 2010 10:22:47 +0200
From: Jens Axboe <jaxboe@fusionio.com>
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <20100601082246.GA3564@kernel.dk>
References: <20100601141324.edf41f7f.sfr@canb.auug.org.au>
	<20100601081823.GA29991@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100601081823.GA29991@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	Julia Lawall <julia@diku.dk>, Al Viro <viro@zeniv.linux.org.uk>,
	drbd-dev@lists.linbit.com
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

On Tue, Jun 01 2010, Christoph Hellwig wrote:
> On Tue, Jun 01, 2010 at 02:13:24PM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the drbd tree got a conflict in fs/pipe.c
> > between commit cc967be54710d97c05229b2e5ba2d00df84ddd64 ("fs: Add missing
> > mutex_unlock") from Linus' tree and commits
> > 0191f8697bbdfefcd36e7b8dc3eeddfe82893e4b ("pipe: F_SETPIPE_SZ should
> > return -EPERM for non-root") and b9598db3401282bb27b4aef77e3eee12015f7f29
> > ("pipe: make F_{GET,SET}PIPE_SZ deal with byte sizes") from the drbd tree.
> > 
> > I fixed it up (see below) and can carry the fix for a while.
> 
> Why is the drbd tree touching fs/pipe.c anyway?

A quick guess would be that it's based off for-linus in the block tree,
which has a patch or two in that area. Why it would conflict and simply
not note that it's the same change, perhaps a rebase or something? Not
sure.

-- 
Jens Axboe

