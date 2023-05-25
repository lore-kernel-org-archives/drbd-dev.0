Return-Path: <kvapss@gmail.com>
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
	[209.85.221.47])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8C8AD4202D0
	for <drbd-dev@lists.linbit.com>; Thu, 25 May 2023 16:49:31 +0200 (CEST)
Received: by mail-wr1-f47.google.com with SMTP id
	ffacd0b85a97d-3078a3f3b5fso2189988f8f.0
	for <drbd-dev@lists.linbit.com>; Thu, 25 May 2023 07:49:31 -0700 (PDT)
From: Andrei Kvapil <kvapss@gmail.com>
To: drbd-dev@lists.linbit.com
Date: Thu, 25 May 2023 16:49:15 +0200
Message-Id: <20230525144915.9031-1-kvapss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Vasily Oleynikov <vasily.oleynikov@flant.com>
Subject: [Drbd-dev] [PATCH] containers: add commands to correct SELinux
	context
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

When running the entry.sh script with RAM-based module loading method, the
generated modules acquire the 'var_lib_t' context by default on certain systems.

This patch adds commands to correct the context to 'modules_object_t'
to allow seamless module loading on SELinux-enabled systems.

Co-developed-by: Vasily Oleynikov <vasily.oleynikov@flant.com>
---
 docker/entry.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/docker/entry.sh b/docker/entry.sh
index 2c91734e6..978df6431 100644
--- a/docker/entry.sh
+++ b/docker/entry.sh
@@ -217,6 +217,10 @@ load_from_ram() {
 		find . -name "*.ko" -print0 | xargs -0 -n1 "/lib/modules/$(uname -r)/build/scripts/sign-file" "$CONFIG_MODULE_SIG_HASH" "${LB_SIGN}/signing_key.pem" "${LB_SIGN}/signing_key.x509" 
 	fi
 
+ 	chcon -t modules_object_t ./drbd.ko || true
+ 	chcon -t modules_object_t ./drbd_transport_tcp.ko || true
+ 	chcon -t modules_object_t ./drbd_transport_rdma.ko || true
+
 	insmod ./drbd.ko usermode_helper=disabled
 	insmod ./drbd_transport_tcp.ko
 	insmod ./drbd_transport_rdma.ko 2>/dev/null || true
-- 
2.32.0 (Apple Git-132)

