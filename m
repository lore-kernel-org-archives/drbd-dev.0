Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
	[209.85.208.45])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 73E2A42018E
	for <drbd-dev@lists.linbit.com>; Wed,  6 Sep 2023 15:31:11 +0200 (CEST)
Received: by mail-ed1-f45.google.com with SMTP id
	4fb4d7f45d1cf-52e828ad46bso2206192a12.1
	for <drbd-dev@lists.linbit.com>; Wed, 06 Sep 2023 06:31:11 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
	<christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  6 Sep 2023 15:30:34 +0200
Message-ID: <20230906133034.948817-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: David Howells <dhowells@redhat.com>,
	Serguei Ivantsov <manowar@gsc-game.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Linux regression tracking <regressions@leemhuis.info>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] drbd: swap bvec_set_page len and offset
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

bvec_set_page has the following signature:

static inline void bvec_set_page(struct bio_vec *bv, struct page *page,
		unsigned int len, unsigned int offset)

However, the usage in DRBD swaps the len and offset parameters. This
leads to a bvec with length=0 instead of the intended length=4096, which
causes sock_sendmsg to return -EIO.

This leaves DRBD unable to transmit any pages and thus completely
broken.

Swapping the parameters fixes the regression.

Fixes: eeac7405c735 ("drbd: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage()")
Reported-by: Serguei Ivantsov <manowar@gsc-game.com>
Link: https://lore.kernel.org/regressions/CAKH+VT3YLmAn0Y8=q37UTDShqxDLsqPcQ4hBMzY7HPn7zNx+RQ@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 79ab532aabaf..6bc86106c7b2 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1557,7 +1557,7 @@ static int _drbd_send_page(struct drbd_peer_device *peer_device, struct page *pa
 	do {
 		int sent;
 
-		bvec_set_page(&bvec, page, offset, len);
+		bvec_set_page(&bvec, page, len, offset);
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
 
 		sent = sock_sendmsg(socket, &msg);
-- 
2.41.0

