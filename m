Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
	[209.85.208.47])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id DAD0E42096D
	for <drbd-dev@lists.linbit.com>; Fri,  9 Dec 2022 15:53:35 +0100 (CET)
Received: by mail-ed1-f47.google.com with SMTP id v8so3417308edi.3
	for <drbd-dev@lists.linbit.com>; Fri, 09 Dec 2022 06:53:35 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Fri,  9 Dec 2022 15:53:23 +0100
Message-Id: <20221209145327.2272271-5-christoph.boehmwalder@linbit.com>
In-Reply-To: <20221209145327.2272271-1-christoph.boehmwalder@linbit.com>
References: <20221209145327.2272271-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 4/8] drbd: remove unnecessary assignment in
	vli_encode_bits
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
 drivers/block/drbd/drbd_vli.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_vli.h b/drivers/block/drbd/drbd_vli.h
index 1ee81e3c2152..941c511cc4da 100644
--- a/drivers/block/drbd/drbd_vli.h
+++ b/drivers/block/drbd/drbd_vli.h
@@ -327,7 +327,7 @@ static inline int bitstream_get_bits(struct bitstream *bs, u64 *out, int bits)
  */
 static inline int vli_encode_bits(struct bitstream *bs, u64 in)
 {
-	u64 code = code;
+	u64 code;
 	int bits = __vli_encode_bits(&code, in);
 
 	if (bits <= 0)
-- 
2.38.1

