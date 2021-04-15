Return-Path: <tolimit1019@gmail.com>
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
	[209.85.214.174])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2F8914202B2
	for <drbd-dev@lists.linbit.com>; Thu, 15 Apr 2021 08:36:56 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id y2so11498221plg.5
	for <drbd-dev@lists.linbit.com>; Wed, 14 Apr 2021 23:36:56 -0700 (PDT)
From: Ming Li <tolimit1019@gmail.com>
To: drbd-dev@lists.linbit.com
Date: Thu, 15 Apr 2021 14:36:46 +0800
Message-Id: <20210415063646.5298-1-mingli199x@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Ming Li <tolimit1019@gmail.com>
Subject: [Drbd-dev] [PATCH] check head in page_chain_del for every loop
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

From: Ming Li <tolimit1019@gmail.com>

there will be crash when we get a NULL head in loop.

Signed-off-by: Ming Li <tolimit1019@gmail.com>
---
 drbd/drbd_receiver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index f127a235..28fb2e06 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -280,12 +280,12 @@ static struct page *page_chain_del(struct page **head, int count)
 	BUG_ON(!head);
 
 	page = READ_ONCE(*head);
-	if (!page)
-		return NULL;
 
 	do {
 		n = count;
 		rv_head = page;
+		if (!page)
+			return NULL;
 		while (true) {
 			tmp = page_chain_next(page);
 			if (--n == 0)
-- 
2.24.3 (Apple Git-128)

