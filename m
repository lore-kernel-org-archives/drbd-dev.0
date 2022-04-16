Return-Path: <chao@kernel.org>
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 74C0C420FAC
	for <drbd-dev@lists.linbit.com>; Sat, 16 Apr 2022 04:39:20 +0200 (CEST)
Message-ID: <ffa14a07-b8f9-828e-97bc-cf7a2099bab5@kernel.org>
Date: Sat, 16 Apr 2022 10:28:49 +0800
MIME-Version: 1.0
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20220415045258.199825-1-hch@lst.de>
	<20220415045258.199825-27-hch@lst.de>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220415045258.199825-27-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: jfs-discussion@lists.sourceforge.net, linux-nvme@lists.infradead.org,
	virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
	dm-devel@redhat.com, target-devel@vger.kernel.org,
	linux-mtd@lists.infradead.org, drbd-dev@lists.linbit.com,
	linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
	linux-scsi@vger.kernel.org, cluster-devel@redhat.com,
	xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org,
	linux-um@lists.infradead.org, Coly Li <colyli@suse.de>,
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
	David Sterba <dsterba@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org,
	nbd@other.debian.org, Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-raid@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-mmc@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev,
	ocfs2-devel@oss.oracle.com
Subject: Re: [Drbd-dev] [f2fs-dev] [PATCH 26/27] block: decouple
 REQ_OP_SECURE_ERASE from REQ_OP_DISCARD
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

On 2022/4/15 12:52, Christoph Hellwig wrote:
> Secure erase is a very different operation from discard in that it is
> a data integrity operation vs hint.  Fully split the limits and helper
> infrastructure to make the separation more clear.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com> [drbd]
> Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com> [nifs2]
> Acked-by: Jaegeuk Kim <jaegeuk@kernel.org> [f2fs]
> Acked-by: Coly Li <colyli@suse.de> [bcache]
> Acked-by: David Sterba <dsterba@suse.com> [btrfs]

For f2fs part,

Acked-by: Chao Yu <chao@kernel.org>

Thanks,
