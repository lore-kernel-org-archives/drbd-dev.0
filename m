Return-Path: <akiyks@gmail.com>
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
	[209.85.216.53])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B088B420206
	for <drbd-dev@lists.linbit.com>; Fri, 26 Nov 2021 05:11:22 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id
	np6-20020a17090b4c4600b001a90b011e06so7084342pjb.5
	for <drbd-dev@lists.linbit.com>; Thu, 25 Nov 2021 20:11:22 -0800 (PST)
To: Jonathan Corbet <corbet@lwn.net>, Joel Colledge <joel.colledge@linbit.com>
From: Akira Yokosawa <akiyks@gmail.com>
Message-ID: <7df04f45-8746-e666-1a9d-a998f1ab1f91@gmail.com>
Date: Fri, 26 Nov 2021 13:11:17 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	linux-doc@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v2] docs: admin-guide/blockdev: Remove digraph of
	node-states
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

While node-states-8.dot has two digraphs, the dot(1) command can
not properly handle multiple graphs in a DOT file and the
kernel-doc page at

    https://www.kernel.org/doc/html/latest/admin-guide/blockdev/drbd/figures.html

fails to render the graphs.

It turned out that the digraph of node_states can be removed.

Quote from Joel's reflection:

    On reflection, the digraph node_states can be removed entirely.
    It is too basic to contain any useful information. In addition
    it references "ioctl_set_state". The ioctl configuration
    interface for DRBD has long been removed. In fact, it was never
    in the upstream version of DRBD.

Remove node_states and rename the DOT file peer_states-8.dot.

Suggested-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
---
Changes in v1 [1] -> v2

 - As suggested by Joel, remove the digraph of node_states.
 - Rename the DOT file peers-states-8.dot.
 - Update the change log and the patch title.
 - Add Joel's Suggested-by.

[1]: https://lkml.kernel.org/r/3cbff170-582b-b6cf-0988-e0d0c9b47505@gmail.com

Joel, are you OK with this change going through the -doc tree?

        Thanks, Akira
--
 Documentation/admin-guide/blockdev/drbd/figures.rst          | 4 ++--
 .../blockdev/drbd/{node-states-8.dot => peer-states-8.dot}   | 5 -----
 2 files changed, 2 insertions(+), 7 deletions(-)
 rename Documentation/admin-guide/blockdev/drbd/{node-states-8.dot => peer-states-8.dot} (71%)

diff --git a/Documentation/admin-guide/blockdev/drbd/figures.rst b/Documentation/admin-guide/blockdev/drbd/figures.rst
index bd9a4901fe46..9f73253ea353 100644
--- a/Documentation/admin-guide/blockdev/drbd/figures.rst
+++ b/Documentation/admin-guide/blockdev/drbd/figures.rst
@@ -25,6 +25,6 @@ Sub graphs of DRBD's state transitions
     :alt:   disk-states-8.dot
     :align: center
 
-.. kernel-figure:: node-states-8.dot
-    :alt:   node-states-8.dot
+.. kernel-figure:: peer-states-8.dot
+    :alt:   peer-states-8.dot
     :align: center
diff --git a/Documentation/admin-guide/blockdev/drbd/node-states-8.dot b/Documentation/admin-guide/blockdev/drbd/peer-states-8.dot
similarity index 71%
rename from Documentation/admin-guide/blockdev/drbd/node-states-8.dot
rename to Documentation/admin-guide/blockdev/drbd/peer-states-8.dot
index bfa54e1f8016..6dc3954954d6 100644
--- a/Documentation/admin-guide/blockdev/drbd/node-states-8.dot
+++ b/Documentation/admin-guide/blockdev/drbd/peer-states-8.dot
@@ -1,8 +1,3 @@
-digraph node_states {
-	Secondary -> Primary           [ label = "ioctl_set_state()" ]
-	Primary   -> Secondary 	       [ label = "ioctl_set_state()" ]
-}
-
 digraph peer_states {
 	Secondary -> Primary           [ label = "recv state packet" ]
 	Primary   -> Secondary 	       [ label = "recv state packet" ]

base-commit: b96ff02ab2be1791248237b1bf318aaf62e8b701
-- 
2.17.1

