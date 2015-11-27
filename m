Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DECA71055F58
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id D6E882AE5F4
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:11 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id LTBXX6v-sR4f for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id A91802AE8C3
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:11 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EpCajEu7R94v for <drbd-dev@lists.linbit.com>;
	Mon, 30 Nov 2015 20:30:11 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 720EC2AE5F4
	for <drbd-dev@lists.linbit.com>; Mon, 30 Nov 2015 20:30:11 +0100 (CET)
Resent-Message-ID: <20151130193011.GL22693@soda.linbit>
Received: from mailrelay119.isp.belgacom.be (mailrelay119.isp.belgacom.be
	[195.238.20.146])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 92AAA10518AC
	for <drbd-dev@lists.linbit.com>; Fri, 27 Nov 2015 22:27:31 +0100 (CET)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Date: Fri, 27 Nov 2015 22:26:09 +0100
Message-Id: <1448659575-13485-5-git-send-email-fabf@skynet.be>
In-Reply-To: <1448659575-13485-1-git-send-email-fabf@skynet.be>
References: <1448659575-13485-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 04/21] drbd: include linux/uaccess.h instead of
	asm/uaccess.h
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

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/block/drbd/drbd_main.c     | 2 +-
 drivers/block/drbd/drbd_proc.c     | 2 +-
 drivers/block/drbd/drbd_receiver.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 5b43dfb..be08885 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -31,7 +31,7 @@
 #include <linux/module.h>
 #include <linux/jiffies.h>
 #include <linux/drbd.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/types.h>
 #include <net/sock.h>
 #include <linux/ctype.h>
diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
index 233a710..be2b93f 100644
--- a/drivers/block/drbd/drbd_proc.c
+++ b/drivers/block/drbd/drbd_proc.c
@@ -25,7 +25,7 @@
 
 #include <linux/module.h>
 
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/proc_fs.h>
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 1957fe8..1c72991 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -25,7 +25,7 @@
 
 #include <linux/module.h>
 
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <net/sock.h>
 
 #include <linux/drbd.h>
-- 
2.1.4

