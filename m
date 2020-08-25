Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0212.hostedemail.com
	[216.40.44.212])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 09D7142092A
	for <drbd-dev@lists.linbit.com>; Tue, 25 Aug 2020 07:03:19 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
	[10.5.19.251])
	by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 218E718019F28
	for <drbd-dev@lists.linbit.com>; Tue, 25 Aug 2020 04:57:24 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: Jiri Kosina <trivial@kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Mon, 24 Aug 2020 21:56:03 -0700
Message-Id: <1c8081264d82101d7837220c5ee221c307da5d91.1598331148.git.joe@perches.com>
In-Reply-To: <cover.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 06/29] drbd: Avoid comma separated statements
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

Use semicolons and braces.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/block/drbd/drbd_receiver.c | 6 ++++--
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
-- 
2.26.0

