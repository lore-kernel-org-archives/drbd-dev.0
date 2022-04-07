Return-Path: <martin.petersen@oracle.com>
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
	[205.220.177.32])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C7EB5421019
	for <drbd-dev@lists.linbit.com>; Thu,  7 Apr 2022 08:23:45 +0200 (CEST)
To: Christoph Hellwig via Ocfs2-devel <ocfs2-devel@oss.oracle.com>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Message-ID: <yq1tub5h92g.fsf@ca-mkp.ca.oracle.com>
References: <20220406060516.409838-1-hch@lst.de>
	<20220406060516.409838-21-hch@lst.de>
Date: Wed, 06 Apr 2022 23:22:13 -0400
In-Reply-To: <20220406060516.409838-21-hch@lst.de> (Christoph Hellwig via
	Ocfs2-devel's message of "Wed, 6 Apr 2022 08:05:09 +0200")
Content-Type: text/plain
MIME-Version: 1.0
Cc: jfs-discussion@lists.sourceforge.net, linux-nvme@lists.infradead.org,
	virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
	dm-devel@redhat.com, target-devel@vger.kernel.org,
	linux-mtd@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	drbd-dev@lists.linbit.com, linux-s390@vger.kernel.org,
	linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org,
	cluster-devel@redhat.com, xen-devel@lists.xenproject.org,
	linux-ext4@vger.kernel.org, linux-um@lists.infradead.org,
	nbd@other.debian.org, linux-raid@vger.kernel.org,
	linux-bcache@vger.kernel.org, ceph-devel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	ntfs3@lists.linux.dev, linux-btrfs@vger.kernel.org
Subject: Re: [Drbd-dev] [Ocfs2-devel] [PATCH 20/27] block: use
 bdev_discard_alignment in part_discard_alignment_show
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


Christoph,

> Use the bdev based alignment helper instead of open coding it.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
