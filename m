Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 861B34203F0
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:56:28 +0200 (CEST)
Received: by mail-wr1-f65.google.com with SMTP id x13so12285576wrv.4
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:56:28 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	c16sm14188023wrx.4.2020.06.13.02.56.27
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:56:27 -0700 (PDT)
Resent-Message-ID: <20200613095625.GG4222@soda.linbit>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E5D0C4203E8
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2020 23:47:36 +0200 (CEST)
From: Colin King <colin.king@canonical.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
Message-Id: <20200507214735.66114-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Drbd-dev] [PATCH] block/drbd: remove redundant initialization to
	variable rv
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
Date: Sat, 13 Jun 2020 09:58:15 -0000

From: Colin Ian King <colin.king@canonical.com>

The variable rv is being initialized with a value that is never read
and it is being updated later with a new value.  The initialization is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/block/drbd/drbd_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index c094c3c2c5d4..22dfaa91a89d 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3522,7 +3522,7 @@ void drbd_uuid_set_bm(struct drbd_device *device, u64 val) __must_hold(local)
  */
 int drbd_bmio_set_n_write(struct drbd_device *device) __must_hold(local)
 {
-	int rv = -EIO;
+	int rv;
 
 	drbd_md_set_flag(device, MDF_FULL_SYNC);
 	drbd_md_sync(device);
-- 
2.25.1

