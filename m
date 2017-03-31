Return-Path: <BATV+2133f6211fed31f2c605+4968+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7BA35105647D
	for <drbd-dev@lists.linbit.com>;
	Fri, 31 Mar 2017 18:33:23 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
	snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Date: Fri, 31 Mar 2017 18:32:48 +0200
Message-Id: <20170331163313.31821-1-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	dm-devel@redhat.com, linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] always use REQ_OP_WRITE_ZEROES for zeroing offload
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This series makes REQ_OP_WRITE_ZEROES the only zeroing offload
supported by the block layer, and switches existing implementations
of REQ_OP_DISCARD that correctly set discard_zeroes_data to it,
removes incorrect discard_zeroes_data, and also switches WRITE SAME
based zeroing in SCSI to this new method.

The series is against the block for-next tree.

A git tree is also avaiable at:

    git://git.infradead.org/users/hch/block.git discard-rework

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/discard-rework
