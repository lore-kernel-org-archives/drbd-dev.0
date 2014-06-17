Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C60EA101AC79
	for <drbd-dev@lists.linbit.com>; Tue, 17 Jun 2014 12:45:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B957D2A161D
	for <drbd-dev@lists.linbit.com>; Tue, 17 Jun 2014 12:45:23 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id d8azxNloRq75 for <drbd-dev@lists.linbit.com>;
	Tue, 17 Jun 2014 12:45:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 9D4D62A703A
	for <drbd-dev@lists.linbit.com>; Tue, 17 Jun 2014 12:45:23 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZZQZCiRZBJD3 for <drbd-dev@lists.linbit.com>;
	Tue, 17 Jun 2014 12:45:23 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 834FF2A161D
	for <drbd-dev@lists.linbit.com>; Tue, 17 Jun 2014 12:45:23 +0200 (CEST)
Resent-Message-ID: <20140617104523.GG28884@soda.linbit>
From: Martin Kepplinger <martink@posteo.de>
To: rientjes@google.com
Date: Tue, 17 Jun 2014 08:54:07 +0200
Message-Id: <1402988047-16364-1-git-send-email-martink@posteo.de>
In-Reply-To: <alpine.DEB.2.02.1406160225510.30205@chino.kir.corp.google.com>
References: <alpine.DEB.2.02.1406160225510.30205@chino.kir.corp.google.com>
Cc: Martin Kepplinger <martink@posteo.de>, linux-kernel@vger.kernel.org,
	drbd-user@lists.linbit.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v2] drbd: change one-bit bitfield to be an
	unsigned int
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

The one-bit bitfields are assigned true (1) or false (0) and checked
for them respectively. While it should work either way and -1 is true
as well it is more clear to see what's going on when using an unsigned int
because 1 doesn't silently become -1 behind the label true.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
Thanks for looking at it. This is more of a question: Does this make sense
to you now? I can be mistaken. It just wasn't totally clear to me at first
sight and even though it should be, why not try to improve it.

sparse called it 'dubious' before the change.

(built but untested)

 drivers/block/drbd/drbd_interval.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_interval.h b/drivers/block/drbd/drbd_interval.h
index f38fcb0..8d670e6 100644
--- a/drivers/block/drbd/drbd_interval.h
+++ b/drivers/block/drbd/drbd_interval.h
@@ -9,8 +9,8 @@ struct drbd_interval {
 	sector_t sector;	/* start sector of the interval */
 	unsigned int size;	/* size in bytes */
 	sector_t end;		/* highest interval end in subtree */
-	int local:1		/* local or remote request? */;
-	int waiting:1;
+	unsigned int local:1;	/* local or remote request? */
+	unsigned int waiting:1;
 };
 
 static inline void drbd_clear_interval(struct drbd_interval *i)
-- 
1.7.10.4

