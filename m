Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
	[209.85.218.44])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CE70742210F
	for <drbd-dev@lists.linbit.com>; Fri, 13 Jan 2023 13:35:44 +0100 (CET)
Received: by mail-ej1-f44.google.com with SMTP id u9so52054859ejo.0
	for <drbd-dev@lists.linbit.com>; Fri, 13 Jan 2023 04:35:44 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Fri, 13 Jan 2023 13:35:32 +0100
Message-Id: <20230113123538.144276-3-christoph.boehmwalder@linbit.com>
In-Reply-To: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
References: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 2/8] drbd: fix DRBD_VOLUME_MAX 65535 -> 65534
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

From: Robert Altnoeder <robert.altnoeder@linbit.com>

The protocol uses -1 as a reserved value for
'no specific volume', and since the protocol field
is a 16 bit unsigned value, -1 is converted to
65535. Therefore, limit the range of valid volume
numbers to [0, 65534].

Signed-off-by: Robert Altnoeder <robert.altnoeder@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 include/linux/drbd_limits.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/drbd_limits.h b/include/linux/drbd_limits.h
index d64271ccece4..058f7600f79c 100644
--- a/include/linux/drbd_limits.h
+++ b/include/linux/drbd_limits.h
@@ -21,7 +21,7 @@
 #define DRBD_MINOR_COUNT_DEF 32
 #define DRBD_MINOR_COUNT_SCALE '1'
 
-#define DRBD_VOLUME_MAX 65535
+#define DRBD_VOLUME_MAX 65534
 
 #define DRBD_DIALOG_REFRESH_MIN 0
 #define DRBD_DIALOG_REFRESH_MAX 600
-- 
2.38.1

