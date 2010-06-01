Return-Path: <BATV+7118efa77cc3b6051839+2473+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 1 Jun 2010 04:18:23 -0400
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20100601081823.GA29991@infradead.org>
References: <20100601141324.edf41f7f.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100601141324.edf41f7f.sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-next@vger.kernel.org, Julia Lawall <julia@diku.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <jens.axboe@oracle.com>, drbd-dev@lists.linbit.com
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

On Tue, Jun 01, 2010 at 02:13:24PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the drbd tree got a conflict in fs/pipe.c
> between commit cc967be54710d97c05229b2e5ba2d00df84ddd64 ("fs: Add missing
> mutex_unlock") from Linus' tree and commits
> 0191f8697bbdfefcd36e7b8dc3eeddfe82893e4b ("pipe: F_SETPIPE_SZ should
> return -EPERM for non-root") and b9598db3401282bb27b4aef77e3eee12015f7f29
> ("pipe: make F_{GET,SET}PIPE_SZ deal with byte sizes") from the drbd tree.
> 
> I fixed it up (see below) and can carry the fix for a while.

Why is the drbd tree touching fs/pipe.c anyway?

