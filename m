Return-Path: <BATV+8c5add14d4fec8f33fc9+5379+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id F3B131057315
	for <drbd-dev@lists.linbit.com>; Wed, 16 May 2018 11:44:24 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Date: Wed, 16 May 2018 11:43:05 +0200
Message-Id: <20180516094346.20506-2-hch@lst.de>
In-Reply-To: <20180516094346.20506-1-hch@lst.de>
References: <20180516094346.20506-1-hch@lst.de>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-afs@lists.infradead.org, linux-acpi@vger.kernel.org,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	Jiri Slaby <jslaby@suse.com>, linux-ext4@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>,
	megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 01/42] net/can: single_open_net needs to be
	paired with single_release_net
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

Otherwise we will leak a reference to the network namespace.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/can/bcm.c  | 2 +-
 net/can/proc.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index ac5e5e34fee3..8073fa14e143 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -249,7 +249,7 @@ static const struct file_operations bcm_proc_fops = {
 	.open		= bcm_proc_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= single_release,
+	.release	= single_release_net,
 };
 #endif /* CONFIG_PROC_FS */
 
diff --git a/net/can/proc.c b/net/can/proc.c
index fdf704e9bb8c..fde2fd55b826 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -279,7 +279,7 @@ static const struct file_operations can_stats_proc_fops = {
 	.open		= can_stats_proc_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= single_release,
+	.release	= single_release_net,
 };
 
 static int can_reset_stats_proc_show(struct seq_file *m, void *v)
@@ -449,7 +449,7 @@ static const struct file_operations can_rcvlist_sff_proc_fops = {
 	.open		= can_rcvlist_sff_proc_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= single_release,
+	.release	= single_release_net,
 };
 
 
@@ -492,7 +492,7 @@ static const struct file_operations can_rcvlist_eff_proc_fops = {
 	.open		= can_rcvlist_eff_proc_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= single_release,
+	.release	= single_release_net,
 };
 
 /*
-- 
2.17.0

