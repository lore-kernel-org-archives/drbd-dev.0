Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
	[209.85.218.47])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AD0A4422113
	for <drbd-dev@lists.linbit.com>; Fri, 13 Jan 2023 13:35:47 +0100 (CET)
Received: by mail-ej1-f47.google.com with SMTP id u19so51949304ejm.8
	for <drbd-dev@lists.linbit.com>; Fri, 13 Jan 2023 04:35:47 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Fri, 13 Jan 2023 13:35:36 +0100
Message-Id: <20230113123538.144276-7-christoph.boehmwalder@linbit.com>
In-Reply-To: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
References: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 6/8] MAINTAINERS: add drbd headers
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

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 595d59eec7ea..83b6f3a97cf6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6349,6 +6349,7 @@ T:	git git://git.linbit.com/linux-drbd.git
 T:	git git://git.linbit.com/drbd-8.4.git
 F:	Documentation/admin-guide/blockdev/
 F:	drivers/block/drbd/
+F:	include/linux/drbd*
 F:	lib/lru_cache.c
 
 DRIVER COMPONENT FRAMEWORK
-- 
2.38.1

