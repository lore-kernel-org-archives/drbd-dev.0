Return-Path: <akpm@linux-foundation.org>
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5884B4201E3
	for <drbd-dev@lists.linbit.com>; Thu, 27 Jan 2022 23:51:06 +0100 (CET)
Date: Thu, 27 Jan 2022 14:42:29 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: NeilBrown <neilb@suse.de>
Message-Id: <20220127144229.a7109a508521db5e8ddda09c@linux-foundation.org>
In-Reply-To: <164325106958.29787.4865219843242892726.stgit@noble.brown>
References: <164325106958.29787.4865219843242892726.stgit@noble.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, drbd-dev@lists.linbit.com,
	linux-nilfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org,
	Philipp, Chao Yu <chao@kernel.org>, linux-block@vger.kernel.org,
	Paolo Valente <paolo.valente@linaro.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Axboe <axboe@kernel.dk>, linux-nfs@vger.kernel.org, Jens,
	Jeff Layton <jlayton@kernel.org>, Reisner <philipp.reisner@linbit.com>,
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [Drbd-dev] [PATCH 0/9] Remove remaining parts of congestions
 tracking code.
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, 27 Jan 2022 13:46:29 +1100 NeilBrown <neilb@suse.de> wrote:

> Congestion hasn't been reliably tracked for quite some time.
> Most MM uses of it for guiding writeback decisions were removed in 5.16.
> Some other uses were removed in 17-rc1.
> 
> This series removes the remaining places that test for congestion, and
> the few places which still set it.
> 
> The second patch touches a few filesystems.  I didn't think there was
> much value in splitting this out by filesystems, but if maintainers
> would rather I did that, I will.
> 
> The f2fs, cephfs, fuse, NFS, and block patches can go through the
> respective trees proving the final patch doesn't land until after they
> all do - so maybe it should be held for 5.18-rc2 if all the rest lands
> by 5.18-rc1.

Plan B: I'll just take everything.  While collecting tested-bys and
acked-bys from filesystem maintainers (please).

