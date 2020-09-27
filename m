Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
	[209.85.218.66])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C00B942034B
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 17:29:23 +0200 (CEST)
Received: by mail-ej1-f66.google.com with SMTP id lw21so23772616ejb.6
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 08:29:23 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	w22sm10790014edu.15.2020.10.12.08.29.22
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 12 Oct 2020 08:29:23 -0700 (PDT)
Resent-Message-ID: <20201012152921.GL2116@soda.linbit>
Received: from mail3-relais-sop.national.inria.fr
	(mail3-relais-sop.national.inria.fr [192.134.164.104])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 09F85420385
	for <drbd-dev@lists.linbit.com>; Sun, 27 Sep 2020 22:04:18 +0200 (CEST)
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Philipp Reisner <philipp.reisner@linbit.com>
Date: Sun, 27 Sep 2020 21:12:28 +0200
Message-Id: <1601233948-11629-19-git-send-email-Julia.Lawall@inria.fr>
In-Reply-To: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
Cc: Jens Axboe <axboe@kernel.dk>,
	=?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Joe Perches <joe@perches.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 18/18] drbd: use semicolons rather than commas to
	separate statements
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

Replace commas with semicolons.  What is done is essentially described by
the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):

// <smpl>
@@ expression e1,e2; @@
e1
-,
+;
e2
... when any
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/block/drbd/drbd_receiver.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 422363daa618..87f732fb5456 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -111,8 +111,10 @@ static struct page *page_chain_tail(struct page *page, int *len)
 {
 	struct page *tmp;
 	int i = 1;
-	while ((tmp = page_chain_next(page)))
-		++i, page = tmp;
+	while ((tmp = page_chain_next(page))) {
+		++i;
+		page = tmp;
+	}
 	if (len)
 		*len = i;
 	return page;

