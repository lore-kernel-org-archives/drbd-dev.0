Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org
Date: Mon,  6 Jul 2009 17:39:20 +0200
Message-Id: <1246894775-10855-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1246894775-10855-1-git-send-email-philipp.reisner@linbit.com>
References: <1246894775-10855-1-git-send-email-philipp.reisner@linbit.com>
Cc: Bart Van Assche <bart.vanassche@gmail.com>,
	Kyle Moffett <kyle@moffetthome.net>, Christoph Hellwig <hch@infradead.org>,
	Neil Brown <neilb@suse.de>,
	Nikanth Karthikesan <knikanth@suse.de>, Greg KH <gregkh@suse.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Lars Marowsky-Bree <lmb@suse.de>, Jens Axboe <jens.axboe@oracle.com>,
	Dave Jones <davej@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 01/16] drbd: Entry in the MAINTAINERS file for
	DRBD
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>

---
diff --git a/MAINTAINERS b/MAINTAINERS
index fa2a16d..a351378 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1939,6 +1939,19 @@ S:	Maintained
 F:	drivers/scsi/dpt*
 F:	drivers/scsi/dpt/
 
+DRBD DRIVER
+P:     Philipp Reisner
+P:     Lars Ellenberg
+M:     drbd-dev@lists.linbit.com
+L:     drbd-user@lists.linbit.com
+W:     http://www.drbd.org
+T:     git git://git.drbd.org/linux-2.6-drbd.git drbd
+T:     git git://git.drbd.org/drbd-8.3.git
+S:     Supported
+F:     drivers/block/drbd/
+F:     lib/lru_cache.c
+F:     Documentation/blockdev/drbd/
+
 DRIVER CORE, KOBJECTS, AND SYSFS
 P:	Greg Kroah-Hartman
 M:	gregkh@suse.de
