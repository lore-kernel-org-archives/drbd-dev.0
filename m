Return-Path: <sarvesh20123@gmail.com>
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
	[209.85.214.178])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0A935420302
	for <drbd-dev@lists.linbit.com>; Mon, 25 Nov 2024 17:51:58 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
	d9443c01a7336-21270d64faeso33104675ad.1
	for <drbd-dev@lists.linbit.com>; Mon, 25 Nov 2024 08:51:58 -0800 (PST)
From: Saru2003 <sarvesh20123@gmail.com>
To: minchan@kernel.org,
	senozhatsky@chromium.org
Subject: [PATCH v2] Documentation: zram: fix dictionary spelling
Date: Mon, 25 Nov 2024 22:21:22 +0530
Message-Id: <20241125165122.17521-1-sarvesh20123@gmail.com>
In-Reply-To: <20241125024927.GA440697@google.com>
References: <20241125024927.GA440697@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, philipp.reisner@linbit.com,
	linux-kernel@vger.kernel.org, terrelln@fb.com,
	Saru2003 <sarvesh20123@gmail.com>, lars.ellenberg@linbit.com,
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

Fixes a typo in the ZRAM documentation where 'dictioary' was
misspelled. Corrected it to 'dictionary' in the example usage
of 'algorithm_params'.

Signed-off-by: Sarveshwaar SS <sarvesh20123@gmail.com>
---
 Documentation/admin-guide/blockdev/zram.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 678d70d6e1c3..dbf2b4f47ec3 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -119,14 +119,14 @@ compression algorithm to use external pre-trained dictionary, pass full
 path to the `dict` along with other parameters::
 
 	#pass path to pre-trained zstd dictionary
-	echo "algo=zstd dict=/etc/dictioary" > /sys/block/zram0/algorithm_params
+	echo "algo=zstd dict=/etc/dictionary" > /sys/block/zram0/algorithm_params
 
 	#same, but using algorithm priority
-	echo "priority=1 dict=/etc/dictioary" > \
+	echo "priority=1 dict=/etc/dictionary" > \
 		/sys/block/zram0/algorithm_params
 
 	#pass path to pre-trained zstd dictionary and compression level
-	echo "algo=zstd level=8 dict=/etc/dictioary" > \
+	echo "algo=zstd level=8 dict=/etc/dictionary" > \
 		/sys/block/zram0/algorithm_params
 
 Parameters are algorithm specific: not all algorithms support pre-trained
-- 
2.34.1

