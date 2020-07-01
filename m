Return-Path: <BATV+501e1de201b53739768b+6156+infradead.org+hch@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 46FF14203F3
	for <drbd-dev@lists.linbit.com>; Wed,  1 Jul 2020 11:24:02 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  1 Jul 2020 11:06:19 +0200
Message-Id: <20200701090622.3354860-2-hch@lst.de>
In-Reply-To: <20200701090622.3354860-1-hch@lst.de>
References: <20200701090622.3354860-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, dm-devel@redhat.com,
	Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
	linux-btrfs@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 1/4] drbd: remove a bogus bdi_rw_congested call
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

bdi_rw_congested returns congestion state, so calling it without
looking at the return value doesn't make much sense.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_proc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
index 1c41cd9982a257..3c0193de249830 100644
--- a/drivers/block/drbd/drbd_proc.c
+++ b/drivers/block/drbd/drbd_proc.c
@@ -265,7 +265,6 @@ int drbd_seq_show(struct seq_file *seq, void *v)
 			seq_printf(seq, "%2d: cs:Unconfigured\n", i);
 		} else {
 			/* reset device->congestion_reason */
-			bdi_rw_congested(device->rq_queue->backing_dev_info);
 
 			nc = rcu_dereference(first_peer_device(device)->connection->net_conf);
 			wp = nc ? nc->wire_protocol - DRBD_PROT_A + 'A' : ' ';
-- 
2.26.2

