Return-Path: <BATV+29a21e8ca386e11a5a78+6294+infradead.org+hch@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6D45142080A
	for <drbd-dev@lists.linbit.com>; Mon, 16 Nov 2020 16:46:49 +0100 (CET)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Mon, 16 Nov 2020 15:57:49 +0100
Message-Id: <20201116145809.410558-59-hch@lst.de>
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-nvme@lists.infradead.org,
	Song Liu <song@kernel.org>, dm-devel@redhat.com,
	drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
	xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
	linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
	ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Subject: [Drbd-dev] [PATCH 58/78] init: cleanup match_dev_by_uuid and
	match_dev_by_label
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

Avoid a totally pointless goto label, and use the same style of
comparism for both helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/do_mounts.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index afa26a4028d25e..5879edf083b318 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -79,15 +79,10 @@ static int match_dev_by_uuid(struct device *dev, const void *data)
 	const struct uuidcmp *cmp = data;
 	struct hd_struct *part = dev_to_part(dev);
 
-	if (!part->info)
-		goto no_match;
-
-	if (strncasecmp(cmp->uuid, part->info->uuid, cmp->len))
-		goto no_match;
-
+	if (!part->info ||
+	    strncasecmp(cmp->uuid, part->info->uuid, cmp->len))
+		return 0;
 	return 1;
-no_match:
-	return 0;
 }
 
 /**
@@ -174,10 +169,9 @@ static int match_dev_by_label(struct device *dev, const void *data)
 	const char *label = data;
 	struct hd_struct *part = dev_to_part(dev);
 
-	if (part->info && !strcmp(label, part->info->volname))
-		return 1;
-
-	return 0;
+	if (!part->info || strcmp(label, part->info->volname))
+		return 0;
+	return 1;
 }
 
 static dev_t devt_from_partlabel(const char *label)
-- 
2.29.2

