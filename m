Return-Path: <BATV+f1fc5bea56d51e2fc981+4960+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id B05C31058000
	for <drbd-dev@lists.linbit.com>; Thu, 23 Mar 2017 16:01:14 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
	snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Date: Thu, 23 Mar 2017 10:33:18 -0400
Message-Id: <20170323143341.31549-1-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	dm-devel@redhat.com, linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] RFC: always use REQ_OP_WRITE_ZEROES for zeroing offload
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

I've done testing with ATA, SCSI and NVMe setups, but there are
a few things that will need more attention:

 - what is dm-kcopyd doing with the current WRITE SAME usage
   that gets multiple biovecs?  Can we fix it up in any way.
 - what are we going to do with discards through parity raid?
   I suspect we should either just disable it for now entirely
   or modify raid5.c to issue REQ_OP_WRITE_ZEROES to the underlying
   devices.  But I need someone with such a setup to test it.
 - The DRBD code in this area was very odd, and will need an
   audit from the maintainers.

Note that this series needs to be applied on top of the
"support ranges TRIM for libata" series.

A git tree is also avaiable at:

    git://git.infradead.org/users/hch/block.git discard-rework

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/discard-rework
