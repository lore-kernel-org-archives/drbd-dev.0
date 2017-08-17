Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f179.google.com (mail-wr0-f179.google.com
	[209.85.128.179])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id AB7141058001
	for <drbd-dev@lists.linbit.com>; Thu, 17 Aug 2017 11:59:27 +0200 (CEST)
Received: by mail-wr0-f179.google.com with SMTP id z91so29582188wrc.4
	for <drbd-dev@lists.linbit.com>; Thu, 17 Aug 2017 02:59:27 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100])
	by smtp.gmail.com with ESMTPSA id p4sm2407611wrd.50.2017.08.17.02.59.26
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 17 Aug 2017 02:59:26 -0700 (PDT)
Date: Thu, 17 Aug 2017 11:59:25 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20170817095925.GD3587@soda.linbit>
References: <a1c1b596-8259-a2cf-3b1b-6461761bbca4@activecloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1c1b596-8259-a2cf-3b1b-6461761bbca4@activecloud.com>
Subject: Re: [Drbd-dev] [PATCH] drbdmeta: Fix drbdmeta to support old kernels
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

On Thu, Aug 17, 2017 at 04:57:12AM +0300, Artem Pogartsev wrote:
> Hello,
> 
> RedHat 6.9
> kernel-2.6.32-431.11.2
> drbd-utils-9.0.0
> drbd-8.4.10
> 
> Problem:
> 
> drbdmeta 0 v08 /dev/sda internal create-md
> initializing activity log
> initializing bitmap (30524 KB) to all zero
> ioctl(/dev/sda) failed: Invalid argument

Thanks for pointing this out.

I'm about to commit this instead:

    drbdmeta compat: fixup fallback path for BLKZEROOUT for older kernels
    
    Based on a suggestion on drbd-dev by
     From: Artem Pogartsev <artem.pogartsev@activecloud.com>
     Date: Thu, 17 Aug 2017 04:57:12 +0300
     To: drbd-dev@lists.linbit.com
     Subject: [PATCH] drbdmeta: Fix drbdmeta to support old kernels
     Message-ID: <a1c1b596-8259-a2cf-3b1b-6461761bbca4@activecloud.com>
    
    Though I chose to always execute the fallback code
    if the ioctl BLKZEROOUT fails, regardless of errno.
    
    As a side note,
    just because the define BLKZEROOUT is not in the (userland) headers
    (yet) does not necessarily mean the kernel does not know it.

diff --git a/user/shared/drbdmeta.c b/user/shared/drbdmeta.c
index 6ff877a..86f32ed 100644
--- a/user/shared/drbdmeta.c
+++ b/user/shared/drbdmeta.c
@@ -60,7 +60,12 @@
 
 #include "config.h"
 
-/* BLKZEROOUT, available on linux-3.6 and later. */
+/* BLKZEROOUT, available on linux-3.6 and later,
+ * and maybe backported to distribution kernels,
+ * even if they pretend to be older.
+ * Yes, we encountered a number of systems that already had it in their
+ * kernels, but not yet in the headers used to build userland stuff like this.
+ */
 #ifndef BLKZEROOUT
 # define BLKZEROOUT	_IO(0x12,127)
 #endif
@@ -1716,7 +1721,11 @@ static void zeroout_bitmap(struct format *cfg)
 	if (!err)
 		return;
 
-	if (errno == ENOTTY) {
+	PERROR("ioctl(%s, BLKZEROOUT, [%llu, %llu]) failed", cfg->md_device_name,
+			(unsigned long long)range[0], (unsigned long long)range[1]);
+	fprintf(stderr, "Using slow(er) fallback.\n");
+
+	{
 		/* need to sector-align this for O_DIRECT.
 		 * "sector" here means hard-sect size, which may be != 512.
 		 * Note that even though ALIGN does round up, for sector sizes
@@ -1744,9 +1753,6 @@ static void zeroout_bitmap(struct format *cfg)
 			}
 		}
 		fprintf(stderr,"\r100%%\n");
-	} else {
-		PERROR("ioctl(%s) failed", cfg->md_device_name);
-		exit(10);
 	}
 }
 
