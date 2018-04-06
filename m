Return-Path: <drbd-dev@lists.ewheeler.net>
Received: from mail.ewheeler.net (mx.ewheeler.net [66.155.3.69])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5754D1057315
	for <drbd-dev@lists.linbit.com>; Sat,  7 Apr 2018 01:13:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.ewheeler.net (Postfix) with ESMTP id D4D4CA0414
	for <drbd-dev@lists.linbit.com>; Fri,  6 Apr 2018 23:07:49 +0000 (UTC)
Received: from mail.ewheeler.net ([127.0.0.1])
	by localhost (mail.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id nThxMyLxHWci for <drbd-dev@lists.linbit.com>;
	Fri,  6 Apr 2018 23:07:49 +0000 (UTC)
Received: from mx.ewheeler.net (mx.ewheeler.net [66.155.3.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ewheeler.net (Postfix) with ESMTPSA id 512AEA03B0
	for <drbd-dev@lists.linbit.com>; Fri,  6 Apr 2018 23:07:49 +0000 (UTC)
Date: Fri, 6 Apr 2018 23:07:44 +0000 (UTC)
From: Eric Wheeler <drbd-dev@lists.ewheeler.net>
To: drbd-dev@lists.linbit.com
Message-ID: <alpine.LRH.2.11.1804062306340.7784@mail.ewheeler.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Drbd-dev] [PATCH] drbd-utils: Add disable-write-same as a
	drbd.conf option
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


Author: Eric Wheeler <drbd@linux.ewheeler.net>
Date:   Fri Apr 6 16:04:26 2018 -0700

    drbd-utils: Add disable-write-same as a drbd.conf option
    
    This patch updates the grammar parser so that disable-write-same can be
    used in drbd.conf
    
    Signed-off-by: Eric Wheeler <drbd@linux.ewheeler.net>

diff --git a/user/v84/drbdadm_scanner.fl b/user/v84/drbdadm_scanner.fl
index 633b1bc..541e754 100644
--- a/user/v84/drbdadm_scanner.fl
+++ b/user/v84/drbdadm_scanner.fl
@@ -145,6 +145,7 @@ csums-after-crash-only  { DP; CP; return TK_NET_FLAG; }
 al-extents		{ DP; CP; RC(AL_EXTENTS); return TK_SYNCER_OLD_OPT | TK_DISK_OPTION;}
 al-updates		{ DP; CP; return TK_DISK_FLAG; 	}
 discard-zeroes-if-aligned { DP; CP; return TK_DISK_FLAG; 	}
+disable-write-same { DP; CP; return TK_DISK_FLAG; 	}
 cpu-mask		{ DP; CP; return TK_SYNCER_OLD_OPT | TK_RES_OPTION;	}
 use-rle			{ DP; CP; return TK_SYNCER_OLD_OPT | TK_NET_FLAG;	}
 delay-probe-volume	{ DP; CP; return TK_DEPRECATED_OPTION;  }
