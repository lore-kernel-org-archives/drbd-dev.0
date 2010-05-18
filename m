Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 18 May 2010 13:45:21 +0200
References: <20100518152031.9a244971.sfr@canb.auug.org.au>
In-Reply-To: <20100518152031.9a244971.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201005181345.22986.philipp.reisner@linbit.com>
Cc: Jens Axboe <jens.axboe@oracle.com>,
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

Hi Stephen,

FYI:
I use 
git://git.drbd.org/linux-2.6-drbd.git for-jens
as path of my patches to Jens.

I switched that tree to Jens' 
git://git.kernel.dk/linux-2.6-block.git for-2.6.35
and provided the DRBD patches on top of that.

Not that I am not willing to help, I have the feeling that this
merge conflict has nothing to do with DRBD.

Best,
 Phil

> Hi all,
> 
> Today's linux-next merge of the drbd tree got a conflict in
> mm/page-writeback.c between commit
> 42bd225c0ba7c95af39293d39a950c48e7e5cb23 (""laptop-mode: Make flushes
> per-device" fix") from the block tree and commit
> e913fc825dc685a444cb4c1d0f9d32f372f59861 ("writeback: fix WB_SYNC_NONE
> writeback from umount") from the drbd tree (via its merge of the block
> tree).
> 
> I used the next-20100517 version of the block tree today (because the
> above conflict was not resolved correctly in the block tree and caused a
> build failure), so I will also use the next-20100517 version of the drbd
> tree for today.
> 
-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.
