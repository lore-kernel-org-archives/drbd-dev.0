Return-Path: <iustin@google.com>
Received: from localhost (artichoke.zrh.corp.google.com [172.30.13.34])
	by mail2.zrh.corp.google.com with ESMTP id l099blBQ017282
	for <drbd-dev@lists.linbit.com>; Tue, 9 Jan 2007 01:37:47 -0800
Date: Tue, 9 Jan 2007 10:37:47 +0100
To: drbd-dev@lists.linbit.com
Message-ID: <20070109093747.GC1756@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
From: iustin@google.com (Iustin Pop)
Subject: [Drbd-dev] Another small patch for guess_dev_name in
	user/drbdsetup.c (0.7 branch)
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

guess_dev_name can exit early if the major/minor pair passed in is 0,0
as this is not a real device so we won't find it in /dev. This skips
recursing over /dev and stat-ing every file.

Attached patch fixes this.

Regards,
Iustin Pop

--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="null-device.patch"

Index: user/drbdsetup.c
===================================================================
--- user/drbdsetup.c	(revision 2659)
+++ user/drbdsetup.c	(working copy)
@@ -1220,6 +1220,9 @@
   struct stat sb;
   static char dev_name[50];
 
+  if(major==0 && minor==0)
+    return NULL;
+
   device_dir=opendir(dir);
 
   if(!device_dir) goto err_out;

--Y7xTucakfITjPcLV--
