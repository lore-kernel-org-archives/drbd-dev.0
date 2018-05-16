Return-Path: <BATV+8c5add14d4fec8f33fc9+5379+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1C04E105788F
	for <drbd-dev@lists.linbit.com>; Wed, 16 May 2018 12:06:50 +0200 (CEST)
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Date: Wed, 16 May 2018 11:43:20 +0200
Message-Id: <20180516094346.20506-17-hch@lst.de>
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
Subject: [Drbd-dev] [PATCH 16/42] net: move seq_file_single_net to
	<linux/seq_file_net.h>
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

This helper deals with single_{open,release}_net internals and thus
belongs here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/seq_file_net.h | 13 +++++++++++++
 include/net/ip_vs.h          | 12 ------------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/linux/seq_file_net.h b/include/linux/seq_file_net.h
index 43ccd84127b6..ed20faa99e05 100644
--- a/include/linux/seq_file_net.h
+++ b/include/linux/seq_file_net.h
@@ -28,4 +28,17 @@ static inline struct net *seq_file_net(struct seq_file *seq)
 #endif
 }
 
+/*
+ * This one is needed for single_open_net since net is stored directly in
+ * private not as a struct i.e. seq_file_net can't be used.
+ */
+static inline struct net *seq_file_single_net(struct seq_file *seq)
+{
+#ifdef CONFIG_NET_NS
+	return (struct net *)seq->private;
+#else
+	return &init_net;
+#endif
+}
+
 #endif
diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index eb0bec043c96..aea7a124e66b 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -41,18 +41,6 @@ static inline struct netns_ipvs *net_ipvs(struct net* net)
 	return net->ipvs;
 }
 
-/* This one needed for single_open_net since net is stored directly in
- * private not as a struct i.e. seq_file_net can't be used.
- */
-static inline struct net *seq_file_single_net(struct seq_file *seq)
-{
-#ifdef CONFIG_NET_NS
-	return (struct net *)seq->private;
-#else
-	return &init_net;
-#endif
-}
-
 /* Connections' size value needed by ip_vs_ctl.c */
 extern int ip_vs_conn_tab_size;
 
-- 
2.17.0

