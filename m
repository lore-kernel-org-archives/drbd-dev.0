Return-Path: <michael.weiss@aisec.fraunhofer.de>
Received: from mail-edgeMUC218.fraunhofer.de (mail-edgemuc218.fraunhofer.de
	[192.102.154.218])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 05B05162267
	for <drbd-dev@lists.linbit.com>; Tue, 21 Oct 2025 15:36:02 +0200 (CEST)
From: =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To: <michael.weiss@aisec.fraunhofer.de>
Subject: [PATCH] docs: nbd: update default value for ndb max_part to '16'
Date: Tue, 21 Oct 2025 15:28:48 +0200
Message-ID: <20251021132848.371792-1-michael.weiss@aisec.fraunhofer.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Cc: gyroidos@aisec.fraunhofer.de, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, nbd@other.debian.org,
	drbd-dev@lists.linbit.com
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

Syncronize the documentation with actual code state of the default
value for nbd max_part.

Commit 7a8362a0b5919 ("nbd: change the default nbd partitions")
changed the default value of max_part from '0' to '16'. The admin
guide still stated '0' until now.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 Documentation/admin-guide/blockdev/nbd.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/blockdev/nbd.rst b/Documentation/admin-guide/blockdev/nbd.rst
index faf2ac4b15099..6d631ea53e8a2 100644
--- a/Documentation/admin-guide/blockdev/nbd.rst
+++ b/Documentation/admin-guide/blockdev/nbd.rst
@@ -25,7 +25,7 @@ A) NBD parameters
 -----------------
 
 max_part
-	Number of partitions per device (default: 0).
+	Number of partitions per device (default: 16).
 
 nbds_max
 	Number of block devices that should be initialized (default: 16).
-- 
2.47.3

