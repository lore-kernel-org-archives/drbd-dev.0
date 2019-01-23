Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 6611E103B4AE
	for <drbd-dev@lists.linbit.com>; Thu, 24 Jan 2019 17:49:54 +0100 (CET)
Received: by mail-wr1-f66.google.com with SMTP id z5so7215347wrt.11
	for <drbd-dev@lists.linbit.com>; Thu, 24 Jan 2019 08:49:54 -0800 (PST)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	p139sm121383069wmd.31.2019.01.24.08.43.12
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 24 Jan 2019 08:43:12 -0800 (PST)
Resent-Message-ID: <20190124164311.GI13258@soda.linbit>
Received: from gateway32.websitewelcome.com (gateway32.websitewelcome.com
	[192.185.145.18])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 29DB2103B4B2
	for <drbd-dev@lists.linbit.com>; Wed, 23 Jan 2019 08:05:24 +0100 (CET)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
	by gateway32.websitewelcome.com (Postfix) with ESMTP id 764F69D7966
	for <drbd-dev@lists.linbit.com>;
	Wed, 23 Jan 2019 00:45:08 -0600 (CST)
Date: Wed, 23 Jan 2019 00:45:01 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>,
	Joshua Morris <josh.h.morris@us.ibm.com>,
	Philip Kelleher <pjk1939@linux.ibm.com>
Message-ID: <20190123064501.GA26147@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: linux-block@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH] block: Mark expected switch fall-throughs
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

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

This patch fixes the following warnings:

drivers/block/drbd/drbd_int.h:1774:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/block/drbd/drbd_int.h:1774:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/block/drbd/drbd_int.h:1774:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/block/drbd/drbd_int.h:1774:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/block/drbd/drbd_int.h:1774:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/block/drbd/drbd_receiver.c:3093:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/block/drbd/drbd_receiver.c:3120:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/block/drbd/drbd_req.c:856:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling
-Wimplicit-fallthrough

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/block/drbd/drbd_int.h      | 2 +-
 drivers/block/drbd/drbd_receiver.c | 4 ++--
 drivers/block/drbd/drbd_req.c      | 2 +-
 drivers/block/rsxx/core.c          | 1 +
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 000a2f4c0e92..f070f7200fc0 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1778,7 +1778,7 @@ static inline void __drbd_chk_io_error_(struct drbd_device *device,
 				_drbd_set_state(_NS(device, disk, D_INCONSISTENT), CS_HARD, NULL);
 			break;
 		}
-		/* NOTE fall through for DRBD_META_IO_ERROR or DRBD_FORCE_DETACH */
+		/* fall through - for DRBD_META_IO_ERROR or DRBD_FORCE_DETACH */
 	case EP_DETACH:
 	case EP_CALL_HELPER:
 		/* Remember whether we saw a READ or WRITE error.
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index c7ad88d91a09..74350663443f 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3094,7 +3094,7 @@ static int drbd_asb_recover_0p(struct drbd_peer_device *peer_device) __must_hold
 			rv =  1;
 			break;
 		}
-		/* Else fall through to one of the other strategies... */
+		/* Else fall through - to one of the other strategies... */
 	case ASB_DISCARD_OLDER_PRI:
 		if (self == 0 && peer == 1) {
 			rv = 1;
@@ -3119,7 +3119,7 @@ static int drbd_asb_recover_0p(struct drbd_peer_device *peer_device) __must_hold
 		}
 		if (after_sb_0p == ASB_DISCARD_ZERO_CHG)
 			break;
-		/* else: fall through */
+		/* else, fall through */
 	case ASB_DISCARD_LEAST_CHG:
 		if	(ch_self < ch_peer)
 			rv = -1;
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 643a04af213b..3809c7e6be8c 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -866,7 +866,7 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 			} /* else: FIXME can this happen? */
 			break;
 		}
-		/* else, fall through to BARRIER_ACKED */
+		/* else, fall through - to BARRIER_ACKED */
 
 	case BARRIER_ACKED:
 		/* barrier ack for READ requests does not make sense */
diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index 0cf4509d575c..898d522e8338 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -439,6 +439,7 @@ static void card_state_change(struct rsxx_cardinfo *card,
 		 * Fall through so the DMA devices can be attached and
 		 * the user can attempt to pull off their data.
 		 */
+		/* fall through */
 	case CARD_STATE_GOOD:
 		st = rsxx_get_card_size8(card, &card->size8);
 		if (st)
-- 
2.20.1

