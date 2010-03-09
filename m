Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1E1811065002
	for <drbd-dev@lists.linbit.com>; Tue,  9 Mar 2010 15:32:47 +0100 (CET)
Resent-Message-ID: <20100309143247.GI4199@soda.linbit>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D486E1065005
	for <drbd-dev@lists.linbit.com>; Tue,  9 Mar 2010 15:23:32 +0100 (CET)
Received: from guests.acceleratorcentre.net ([209.222.173.41]
	helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <rpjday@crashcourse.ca>)
	id 1NoypD-0002Vg-JI
	for drbd-dev@lists.linbit.com; Tue, 09 Mar 2010 07:46:16 -0500
Date: Tue, 9 Mar 2010 07:44:36 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: drbd-dev@lists.linbit.com
Message-ID: <alpine.LFD.2.00.1003090743100.22662@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Drbd-dev] [PATCH] DRBD:  Delete superfluous defn of "ARRY_SIZE".
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  given that the macro is misspelled, no one appears to use it, and
there already is an ARRAY_SIZE() macro defined in kernel.h for general
use, there's really no reason for this to be here.

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index ab871e0..36508ea 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -156,8 +156,6 @@ static const struct block_device_operations drbd_ops = {
 	.release = drbd_release,
 };

-#define ARRY_SIZE(A) (sizeof(A)/sizeof(A[0]))
-
 #ifdef __CHECKER__
 /* When checking with sparse, and this is an inline function, sparse will
    give tons of false positives. When this is a real functions sparse works.

rday
--

========================================================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

            Linux Consulting, Training and Kernel Pedantry.

Web page:                                          http://crashcourse.ca
Twitter:                                       http://twitter.com/rpjday
========================================================================
