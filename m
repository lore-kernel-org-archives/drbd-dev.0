Return-Path: <BATV+4e9b246676c62bade7ff+4980+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A5082105633D
	for <drbd-dev@lists.linbit.com>;
	Wed, 12 Apr 2017 10:48:16 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, target-devel@vger.kernel.org
Date: Wed, 12 Apr 2017 10:48:01 +0200
Message-Id: <20170412084809.8245-1-hch@lst.de>
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com,
	linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] remove REQ_OP_WRITE_SAME
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

Now that we are using REQ_OP_WRITE_ZEROES for all zeroing needs in the
kernel there is very little use left for REQ_OP_WRITE_SAME.  We only
have two callers left, and both just export optional protocol features
to remote systems: DRBD and the target code.

For the target code the only real use case was zeroing offload, which
is kept with this series, and for DRBD I suspect the same based on the
usage.

    git://git.infradead.org/users/hch/block.git delete-write-same

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/delete-write-same

Changes from RFC:
 - add zeroing offload for the SCSI target.

