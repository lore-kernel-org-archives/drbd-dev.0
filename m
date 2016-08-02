Return-Path: <mmazur@axeos.com>
Received: from srv.axeos.nl (srv.axeos.nl [185.67.224.54])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 5EDB51056446
	for <drbd-dev@lists.linbit.com>; Tue,  2 Aug 2016 16:15:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by localhost.srv.axeos.nl (Postfix) with ESMTP id 366421414F
	for <drbd-dev@lists.linbit.com>; Tue,  2 Aug 2016 16:10:00 +0200 (CEST)
Received: from srv.axeos.nl ([127.0.0.1])
	by localhost (srv.axeos.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jKe_iyTQOo4P for <drbd-dev@lists.linbit.com>;
	Tue,  2 Aug 2016 16:09:53 +0200 (CEST)
Received: from mmaszyna.axeos.nl (mmazur.int.axeos.nl [10.28.45.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by srv.axeos.nl (Postfix) with ESMTPSA
	for <drbd-dev@lists.linbit.com>; Tue,  2 Aug 2016 16:09:53 +0200 (CEST)
From: mmazur@axeos.com
To: drbd-dev@lists.linbit.com
Date: Tue,  2 Aug 2016 16:09:52 +0200
Message-Id: <20160802140952.27683-1-mmazur@axeos.com>
Subject: [Drbd-dev] [PATCH] Fix systemd service file
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

From: Mariusz Mazur <mmazur@axeos.com>

Previous commit introduced an issue by putting PrivateTmp in the
[Install] section.
---
 conf/drbdmanaged.service | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/conf/drbdmanaged.service b/conf/drbdmanaged.service
index af2b141..ae03c37 100644
--- a/conf/drbdmanaged.service
+++ b/conf/drbdmanaged.service
@@ -6,8 +6,7 @@ Requires=dbus.service
 [Service]
 ExecStart=/usr/bin/dbus-drbdmanaged-service
 User=root
+PrivateTmp=yes
 
 [Install]
 WantedBy=multi-user.target
-
-PrivateTmp=yes
-- 
2.9.2

