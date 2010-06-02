Return-Path: <axboe@kernel.dk>
Date: Wed, 2 Jun 2010 08:19:07 +0200
From: Jens Axboe <jaxboe@fusionio.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20100602061907.GI3564@kernel.dk>
References: <20100602140322.7e374a2e.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100602140322.7e374a2e.sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
	linux-next@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
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

On Wed, Jun 02 2010, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the drbd tree got a conflict in
> fs/fs-writeback.c between commit f17625b318d9b151e7bd41e31223e9d89b2aaa77
> ("Revert "writeback: ensure that WB_SYNC_NONE writeback with sb pinned is
> sync"") from the block tree and commits
> 5c92877730b509fefc445bbba6b3bc441c2c272a ("writeback: fix early free of
> work struct") and dff38fd3d1d0914ac0715445bbe21fbce9abed15 ("writeback:
> fix non-integrity write-back") from the drbd tree.
> 
> I suspect this is caused because the drbd tree id based on a different
> version of the block tree to what is in the block tree for-next branch.
> I just used the version of this file from the block tree.

Yeah, I had to yank a few patches since they didn't quite work out in
Christophs testing. The for-next version in the block tree has it all,
so that approach works.

-- 
Jens Axboe

