Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B3BD810735AE
	for <drbd-dev@lists.linbit.com>; Fri, 19 Jun 2009 17:55:51 +0200 (CEST)
Resent-Message-ID: <20090619155551.GF9526@soda.linbit>
Received: from master.grad.hr (master.grad.hr [161.53.50.3])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8E683104C146
	for <drbd-dev@lists.linbit.com>; Fri, 19 Jun 2009 17:25:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by master.grad.hr (Postfix) with ESMTP id 034AA4943C4
	for <drbd-dev@lists.linbit.com>; Fri, 19 Jun 2009 17:25:14 +0200 (CEST)
Received: from master.grad.hr ([127.0.0.1])
	by localhost (master.grad.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SUtIoibla4J7 for <drbd-dev@lists.linbit.com>;
	Fri, 19 Jun 2009 17:25:13 +0200 (CEST)
Received: from [192.168.78.136] (iskon217-215.duo.CARNet.hr [161.53.215.217])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by master.grad.hr (Postfix) with ESMTPSA id AB6AC494382
	for <drbd-dev@lists.linbit.com>; Fri, 19 Jun 2009 17:25:13 +0200 (CEST)
Message-ID: <4A3BADD8.8030206@grad.hr>
Date: Fri, 19 Jun 2009 17:25:12 +0200
From: =?UTF-8?B?QW50ZSBLYXJhbWF0acSH?= <ivoks@grad.hr>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: multipart/mixed; boundary="------------000306020407030103080200"
Subject: [Drbd-dev] Another compatibility issue
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.
--------------000306020407030103080200
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi again

Here's another issue I'm having. linux/drbd_config.h is right saying:

 /* 2.6.29 and up no longer have swabb.h */

But, then doesn't do anything about it. So, proposed diff is attached.

--------------000306020407030103080200
Content-Type: text/x-patch;
 name="swabb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="swabb.diff"

--- drbd8-8.3.2~/drbd/linux/drbd_config.h       2009-06-19 16:11:44.000000000 +0200
+++ drbd8-8.3.2/drbd/linux/drbd_config.h        2009-06-19 17:19:00.000000000 +0200
@@ -74,7 +74,11 @@
 #define HAVE_LINUX_SCATTERLIST_H

 /* 2.6.29 and up no longer have swabb.h */
+#include <linux/version.h>
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
 #define HAVE_LINUX_BYTEORDER_SWABB_H
+#endif
+

 /* Some vendor kernels < 2.6.7 might define msleep in one or
  * another way .. */

--------------000306020407030103080200--
