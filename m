Return-Path: <karanja99erick@gmail.com>
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
	[209.85.128.42])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E5E18160907
	for <drbd-dev@lists.linbit.com>; Wed, 13 Aug 2025 09:18:51 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
	5b1f17b1804b1-459ddf8acf1so52552535e9.0
	for <drbd-dev@lists.linbit.com>; Wed, 13 Aug 2025 00:18:51 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] Docs: admin-guide: Correct spelling mistake
Date: Wed, 13 Aug 2025 10:18:36 +0300
Message-ID: <20250813071837.668613-1-karanja99erick@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, skhan@linuxfoundation.org,
	Erick Karanja <karanja99erick@gmail.com>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
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

Fix spelling mistake directoy to directory

Reported-by: codespell

Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
---
 Documentation/admin-guide/blockdev/zoned_loop.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/blockdev/zoned_loop.rst b/Documentation/admin-guide/blockdev/zoned_loop.rst
index 9c7aa3b482f3..64dcfde7450a 100644
--- a/Documentation/admin-guide/blockdev/zoned_loop.rst
+++ b/Documentation/admin-guide/blockdev/zoned_loop.rst
@@ -79,7 +79,7 @@ zone_capacity_mb   Device zone capacity (must always be equal to or lower than
                    the zone size. Default: zone size.
 conv_zones         Total number of conventioanl zones starting from sector 0.
                    Default: 8.
-base_dir           Path to the base directoy where to create the directory
+base_dir           Path to the base directory where to create the directory
                    containing the zone files of the device.
                    Default=/var/local/zloop.
                    The device directory containing the zone files is always
-- 
2.43.0

