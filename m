Return-Path: <akiyks@gmail.com>
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
	[209.85.216.50])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5DD32420204
	for <drbd-dev@lists.linbit.com>; Wed, 17 Nov 2021 10:38:19 +0100 (CET)
Received: by mail-pj1-f50.google.com with SMTP id
	j5-20020a17090a318500b001a6c749e697so4039470pjb.1
	for <drbd-dev@lists.linbit.com>; Wed, 17 Nov 2021 01:38:19 -0800 (PST)
To: Jonathan Corbet <corbet@lwn.net>
From: Akira Yokosawa <akiyks@gmail.com>
Message-ID: <3cbff170-582b-b6cf-0988-e0d0c9b47505@gmail.com>
Date: Wed, 17 Nov 2021 18:38:14 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-doc@vger.kernel.org
Subject: [Drbd-dev] [PATCH] docs: admin-guide/blockdev: Use subgraphs in
 node-states-8.dot
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

While node-states-8.dot has two digraphs, dot(1) command can not
properly handle multiple graphs in a DOT file.

Use subgraphs and merge them into a single graph.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
---
Hi Jon,

I happened to spot a broken DOT script at the bottom of

    https://www.kernel.org/doc/html/latest/admin-guide/blockdev/drbd/figures.html

and managed to fix it.

DRBD DRIVER maintainers,
If I'm missing something here, please let me know.

        Thanks, Akira
--
 .../blockdev/drbd/node-states-8.dot           | 25 +++++++++++--------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/drbd/node-states-8.dot b/Documentation/admin-guide/blockdev/drbd/node-states-8.dot
index bfa54e1f8016..993f0c152ead 100644
--- a/Documentation/admin-guide/blockdev/drbd/node-states-8.dot
+++ b/Documentation/admin-guide/blockdev/drbd/node-states-8.dot
@@ -1,13 +1,16 @@
-digraph node_states {
-	Secondary -> Primary           [ label = "ioctl_set_state()" ]
-	Primary   -> Secondary 	       [ label = "ioctl_set_state()" ]
-}
+digraph G {
+	compound=true;
+	subgraph node_states {
+		Secondary -> Primary           [ label = "ioctl_set_state()" ]
+		Primary   -> Secondary 	       [ label = "ioctl_set_state()" ]
+	}
 
-digraph peer_states {
-	Secondary -> Primary           [ label = "recv state packet" ]
-	Primary   -> Secondary 	       [ label = "recv state packet" ]
-	Primary   -> Unknown 	       [ label = "connection lost" ]
-	Secondary  -> Unknown  	       [ label = "connection lost" ]
-	Unknown   -> Primary           [ label = "connected" ]
-	Unknown   -> Secondary         [ label = "connected" ]
+	subgraph peer_states {
+		Secondary -> Primary           [ label = "recv state packet" ]
+		Primary   -> Secondary 	       [ label = "recv state packet" ]
+		Primary   -> Unknown 	       [ label = "connection lost" ]
+		Secondary  -> Unknown  	       [ label = "connection lost" ]
+		Unknown   -> Primary           [ label = "connected" ]
+		Unknown   -> Secondary         [ label = "connected" ]
+	}
 }

base-commit: 53b606fa29e321352a105978726b975b42b292a4
-- 
2.17.1

