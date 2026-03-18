Return-Path: <arnd@kernel.org>
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C474616225B
	for <drbd-dev@lists.linbit.com>; Wed, 18 Mar 2026 11:56:06 +0100 (CET)
From: Arnd Bergmann <arnd@kernel.org>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 2/2] drbd: select CONFIG_NET_HANDSHAKE
Date: Wed, 18 Mar 2026 11:48:50 +0100
Message-Id: <20260318104858.1868731-2-arnd@kernel.org>
In-Reply-To: <20260318104858.1868731-1-arnd@kernel.org>
References: <20260318104858.1868731-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@google.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Simon Horman <horms@kernel.org>,
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

From: Arnd Bergmann <arnd@arndb.de>

The TLS handshake code is optional and has to be enabled for DRBD:

ERROR: modpost: "tls_handshake_cancel" [drivers/block/drbd/drbd_transport_tcp.ko] undefined!
ERROR: modpost: "tls_server_hello_x509" [drivers/block/drbd/drbd_transport_tcp.ko] undefined!
ERROR: modpost: "tls_client_hello_x509" [drivers/block/drbd/drbd_transport_tcp.ko] undefined!
ERROR: modpost: "tls_get_record_type" [drivers/block/drbd/drbd_transport_tcp.ko] undefined!
ERROR: modpost: "tls_alert_recv" [drivers/block/drbd/drbd_transport_tcp.ko] undefined!

Select the option whenever DRBD is eanbled and rework the dependency in
the symbol so it can be selected more easily.

Fixes: fa8ef6960ebd ("drbd: add TCP transport implementation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/drbd/Kconfig | 1 +
 net/Kconfig                | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
index 29ec6ed84251..de9e232d6479 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -11,6 +11,7 @@ config BLK_DEV_DRBD
 	depends on PROC_FS && INET
 	select LRU_CACHE
 	select CRC32
+	select NET_HANDSHAKE
 	help
 
 	  NOTE: In order to authenticate connections you have to select
diff --git a/net/Kconfig b/net/Kconfig
index 62266eaf0e95..769880113740 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -92,9 +92,7 @@ source "drivers/dibs/Kconfig"
 source "net/xdp/Kconfig"
 
 config NET_HANDSHAKE
-	bool
-	depends on SUNRPC || NVME_TARGET_TCP || NVME_TCP
-	default y
+	def_bool SUNRPC || NVME_TARGET_TCP || NVME_TCP
 
 config NET_HANDSHAKE_KUNIT_TEST
 	tristate "KUnit tests for the handshake upcall mechanism" if !KUNIT_ALL_TESTS
-- 
2.39.5

