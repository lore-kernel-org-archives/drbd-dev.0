Return-Path: <axboe@kernel.dk>
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
	[209.85.214.171])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 03FE3420FBE
	for <drbd-dev@lists.linbit.com>; Thu, 14 Jul 2022 18:28:40 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id w7so865087ply.12
	for <drbd-dev@lists.linbit.com>; Thu, 14 Jul 2022 09:28:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20220713055317.1888500-1-hch@lst.de>
References: <20220713055317.1888500-1-hch@lst.de>
Message-Id: <165781611803.623079.18294279066897804471.b4-ty@kernel.dk>
Date: Thu, 14 Jul 2022 10:28:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-raid@vger.kernel.org, tytso@mit.edu, song@kernel.org, mark@fasheh.com,
	linux-block@vger.kernel.org, adilger.kernel@dilger.ca,
	jlbec@evilplan.org, jack@suse.com, haris.iqbal@ionos.com,
	linux-ext4@vger.kernel.org, jinpu.wang@ionos.com,
	joseph.qi@linux.alibaba.com, ocfs2-devel@oss.oracle.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] remove bdevname
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

On Wed, 13 Jul 2022 07:53:08 +0200, Christoph Hellwig wrote:
> this series removes the final uses and the implementation of the bdevname()
> function.
> 
> Diffstat:
>  block/bdev.c                        |   10 ++---
>  block/blk-lib.c                     |    6 +--
>  block/genhd.c                       |   23 ------------
>  drivers/block/drbd/drbd_req.c       |    6 +--
>  drivers/block/pktcdvd.c             |   10 +----
>  drivers/block/rnbd/rnbd-srv-dev.c   |    1
>  drivers/block/rnbd/rnbd-srv-dev.h   |    1
>  drivers/block/rnbd/rnbd-srv-sysfs.c |    5 +-
>  drivers/block/rnbd/rnbd-srv.c       |    9 ++---
>  drivers/block/rnbd/rnbd-srv.h       |    3 -
>  drivers/md/md.c                     |    2 -
>  drivers/md/raid1.c                  |    2 -
>  drivers/md/raid10.c                 |    2 -
>  fs/ext4/mmp.c                       |    9 ++---
>  fs/jbd2/journal.c                   |    6 ++-
>  fs/ocfs2/cluster/heartbeat.c        |   64 ++++++++++++++++--------------------
>  include/linux/blkdev.h              |    1
>  kernel/trace/blktrace.c             |    4 +-
>  18 files changed, 62 insertions(+), 102 deletions(-)
> 
> [...]

Applied, thanks!

[1/9] block: stop using bdevname in bdev_write_inode
      commit: 5bf83e9a14ddae994d783dee96b91bf46f04839c
[2/9] block: stop using bdevname in __blkdev_issue_discard
      commit: 02ff3dd20f512cf811ae8028c44fdb212b5f2bf7
[3/9] drbd: stop using bdevname in drbd_report_io_error
      commit: 1b70ccecaed4c3c50239e8409156fb447f965554
[4/9] pktcdvd: stop using bdevname in pkt_seq_show
      commit: fa070a3b50a17506a230e72bd48dba89e7bb5fea
[5/9] pktcdvd: stop using bdevname in pkt_new_dev
      commit: beecf70ee84363e92f3bf783b74da5f26e765d8d
[6/9] rnbd-srv: remove the name field from struct rnbd_dev
      commit: 6e880cf59932a14bca128fc8e8faae0554932942
[7/9] ocfs2/cluster: remove the hr_dev_name field from struct o2hb_region
      commit: 4664954c9421ce326bb5c84f175902b03f17237e
[8/9] ext4: only initialize mmp_bdevname once
      commit: c5b045b9838972cc4c4985a32fa5d35ecf2ab15a
[9/9] block: remove bdevname
      commit: 900d156bac2bc474cf7c7bee4efbc6c83ec5ae58

Best regards,
-- 
Jens Axboe


