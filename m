Return-Path: <lmb@suse.de>
Date: Mon, 21 Feb 2005 17:01:46 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@lists.linbit.com
Message-ID: <20050221160146.GH7016@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3Pql8miugIZX0722"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Drbd-dev] Compile fix for 0.8
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


--3Pql8miugIZX0722
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The attached patch fixes a minor problem when compiling drbd-0.8:

linux/fs.h pulls in linux/wait.h via some nested includes, in which
P_ALL etc are #defines. Later, we try to include sys/wait.h, in which
P_ALL etc are enum names, and gcc doesn't like numeric enums.

Fix: simply include correct header.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business


--3Pql8miugIZX0722
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=drbd-08

Index: user/drbdmeta.c
===================================================================
--- user/drbdmeta.c	(revision 1763)
+++ user/drbdmeta.c	(working copy)
@@ -40,7 +40,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 
-#include <linux/fs.h>		/* for BLKGETSIZE64 */
+#include <sys/mount.h>		/* for BLKGETSIZE64 */
 #include <linux/drbd.h>		/* only use DRBD_MAGIC from here! */
 
 #include "drbdtool_common.h"

--3Pql8miugIZX0722--
