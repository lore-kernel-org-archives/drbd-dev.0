Return-Path: <mrtops03@gmail.com>
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com
	[209.85.166.54])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 915654205F5
	for <drbd-dev@lists.linbit.com>; Tue,  8 Feb 2022 00:54:46 +0100 (CET)
Received: by mail-io1-f54.google.com with SMTP id d188so19089834iof.7
	for <drbd-dev@lists.linbit.com>; Mon, 07 Feb 2022 15:54:46 -0800 (PST)
From: Ethan Dye <mrtops03@gmail.com>
To: 
Date: Mon,  7 Feb 2022 16:54:42 -0700
Message-Id: <20220207235442.95090-1-mrtops03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com, Nitin Gupta <ngupta@vflare.org>,
	Ethan Dye <mrtops03@gmail.com>
Subject: [Drbd-dev] [PATCH] block/zram: Fix wording in optional feature docs
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

This fixes some simple grammar errors in the documentation for zram,
specifically errors in the optional featue section of the zram
documentation.

Signed-off-by: Ethan Dye <mrtops03@gmail.com>
---
 Documentation/admin-guide/blockdev/zram.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 3e11926a4df9..54fe63745ed8 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -315,8 +315,8 @@ To use the feature, admin should set up backing device via::
 
 	echo /dev/sda5 > /sys/block/zramX/backing_dev
 
-before disksize setting. It supports only partition at this moment.
-If admin wants to use incompressible page writeback, they could do via::
+before disksize setting. It supports only partitions at this moment.
+If admin wants to use incompressible page writeback, they could do it via::
 
 	echo huge > /sys/block/zramX/writeback
 
@@ -341,9 +341,9 @@ Admin can request writeback of those idle pages at right timing via::
 
 	echo idle > /sys/block/zramX/writeback
 
-With the command, zram writeback idle pages from memory to the storage.
+With the command, zram will writeback idle pages from memory to the storage.
 
-If admin want to write a specific page in zram device to backing device,
+If an admin wants to write a specific page in zram device to the backing device,
 they could write a page index into the interface.
 
 	echo "page_index=1251" > /sys/block/zramX/writeback
@@ -354,7 +354,7 @@ to guarantee storage health for entire product life.
 
 To overcome the concern, zram supports "writeback_limit" feature.
 The "writeback_limit_enable"'s default value is 0 so that it doesn't limit
-any writeback. IOW, if admin wants to apply writeback budget, he should
+any writeback. IOW, if admin wants to apply writeback budget, they should
 enable writeback_limit_enable via::
 
 	$ echo 1 > /sys/block/zramX/writeback_limit_enable
@@ -365,7 +365,7 @@ until admin sets the budget via /sys/block/zramX/writeback_limit.
 (If admin doesn't enable writeback_limit_enable, writeback_limit's value
 assigned via /sys/block/zramX/writeback_limit is meaningless.)
 
-If admin want to limit writeback as per-day 400M, he could do it
+If admin wants to limit writeback as per-day 400M, they could do it
 like below::
 
 	$ MB_SHIFT=20
@@ -375,16 +375,16 @@ like below::
 	$ echo 1 > /sys/block/zram0/writeback_limit_enable
 
 If admins want to allow further write again once the budget is exhausted,
-he could do it like below::
+they could do it like below::
 
 	$ echo $((400<<MB_SHIFT>>4K_SHIFT)) > \
 		/sys/block/zram0/writeback_limit
 
-If admin wants to see remaining writeback budget since last set::
+If an admin wants to see the remaining writeback budget since last set::
 
 	$ cat /sys/block/zramX/writeback_limit
 
-If admin want to disable writeback limit, he could do::
+If an admin wants to disable writeback limit, they could do::
 
 	$ echo 0 > /sys/block/zramX/writeback_limit_enable
 
@@ -393,7 +393,7 @@ system reboot, echo 1 > /sys/block/zramX/reset) so keeping how many of
 writeback happened until you reset the zram to allocate extra writeback
 budget in next setting is user's job.
 
-If admin wants to measure writeback count in a certain period, he could
+If admin wants to measure writeback count in a certain period, they could
 know it via /sys/block/zram0/bd_stat's 3rd column.
 
 memory tracking
-- 
2.32.0 (Apple Git-132)

