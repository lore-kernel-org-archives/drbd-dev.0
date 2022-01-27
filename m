Return-Path: <konishi.ryusuke@gmail.com>
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
	[209.85.208.181])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 592324201E3
	for <drbd-dev@lists.linbit.com>; Thu, 27 Jan 2022 23:10:24 +0100 (CET)
Received: by mail-lj1-f181.google.com with SMTP id t14so6313648ljh.8
	for <drbd-dev@lists.linbit.com>; Thu, 27 Jan 2022 14:10:24 -0800 (PST)
MIME-Version: 1.0
References: <164325106958.29787.4865219843242892726.stgit@noble.brown>
	<164325158955.29787.4769373293473421057.stgit@noble.brown>
In-Reply-To: <164325158955.29787.4769373293473421057.stgit@noble.brown>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 28 Jan 2022 07:10:11 +0900
Message-ID: <CAKFNMom4Z76ti4fp69UeKYf0d4x635OR7Q_CjVnBj+vQSuhESg@mail.gmail.com>
To: NeilBrown <neilb@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: "Darrick J. Wong" <djwong@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux MM <linux-mm@kvack.org>, drbd-dev@lists.linbit.com,
	Paolo Valente <paolo.valente@linaro.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org,
	Chao Yu <chao@kernel.org>, linux-block@vger.kernel.org,
	linux-nilfs <linux-nilfs@vger.kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nfs@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [Drbd-dev] [PATCH 2/9] Remove bdi_congested() and
	wb_congested() and related functions
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

On Thu, Jan 27, 2022 at 11:47 AM NeilBrown <neilb@suse.de> wrote:
>
> These functions are no longer useful as the only bdis that report
> congestion are in ceph, fuse, and nfs.  None of those bdis can be the
> target of the calls in drbd, ext2, nilfs2, or xfs.
>
> Removing the test on bdi_write_contested() in current_may_throttle()
> could cause a small change in behaviour, but only when PF_LOCAL_THROTTLE
> is set.
>
> So replace the calls by 'false' and simplify the code - and remove the
> functions.
>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  drivers/block/drbd/drbd_int.h |    3 ---
>  drivers/block/drbd/drbd_req.c |    3 +--
>  fs/ext2/ialloc.c              |    2 --
>  fs/nilfs2/segbuf.c            |   11 -----------
>  fs/xfs/xfs_buf.c              |    3 ---
>  include/linux/backing-dev.h   |   26 --------------------------
>  mm/vmscan.c                   |    4 +---
>  7 files changed, 2 insertions(+), 50 deletions(-)

for nilfs2 bits,

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi
