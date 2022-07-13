Return-Path: <BATV+c1a09d14d477e25aee4e+6898+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id ED4CC420647
	for <drbd-dev@lists.linbit.com>; Wed, 13 Jul 2022 08:08:55 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 13 Jul 2022 07:53:12 +0200
Message-Id: <20220713055317.1888500-5-hch@lst.de>
In-Reply-To: <20220713055317.1888500-1-hch@lst.de>
References: <20220713055317.1888500-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Song Liu <song@kernel.org>, Mark Fasheh <mark@fasheh.com>,
	linux-raid@vger.kernel.org, Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Joel Becker <jlbec@evilplan.org>, Jan Kara <jack@suse.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	linux-ext4@vger.kernel.org, Jack Wang <jinpu.wang@ionos.com>,
	ocfs2-devel@oss.oracle.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 4/9] pktcdvd: stop using bdevname in pkt_seq_show
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

Just use the %pg format specifier instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/pktcdvd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 653d242314830..a7016ffce9a43 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2460,11 +2460,9 @@ static int pkt_seq_show(struct seq_file *m, void *p)
 {
 	struct pktcdvd_device *pd = m->private;
 	char *msg;
-	char bdev_buf[BDEVNAME_SIZE];
 	int states[PACKET_NUM_STATES];
 
-	seq_printf(m, "Writer %s mapped to %s:\n", pd->name,
-		   bdevname(pd->bdev, bdev_buf));
+	seq_printf(m, "Writer %s mapped to %pg:\n", pd->name, pd->bdev);
 
 	seq_printf(m, "\nSettings:\n");
 	seq_printf(m, "\tpacket size:\t\t%dkB\n", pd->settings.size / 2);
-- 
2.30.2

