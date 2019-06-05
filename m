Return-Path: <dab21774@gmail.com>
Received: from mail-it1-f171.google.com (mail-it1-f171.google.com
	[209.85.166.171])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E50711028A61
	for <drbd-dev@lists.linbit.com>; Wed,  5 Jun 2019 18:07:55 +0200 (CEST)
Received: by mail-it1-f171.google.com with SMTP id i21so4301321ita.5
	for <drbd-dev@lists.linbit.com>; Wed, 05 Jun 2019 09:07:55 -0700 (PDT)
Received: from [192.168.1.9] (c-73-78-150-191.hsd1.co.comcast.net.
	[73.78.150.191]) by smtp.gmail.com with ESMTPSA id
	x78sm1349607ita.44.2019.06.05.09.07.52
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 09:07:54 -0700 (PDT)
To: drbd-dev@lists.linbit.com
From: David Butterfield <dab21774@gmail.com>
Message-ID: <456e2172-20fa-7b9d-47db-466f41123571@gmail.com>
Date: Wed, 5 Jun 2019 10:07:51 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [Drbd-dev] Avoid compiler warning about non-bool in logical
	expression
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

Avoid a compiler warning:
    drbd_receiver.c:1693:12: warning: logical ‘and’ applied to non-boolean constant [-Wlogical-op]

diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
@@ -1690,7 +1690,7 @@ next_bio:
                bio->bi_next = NULL;

                /* strip off REQ_UNPLUG unless it is the last bio */
-               if (bios && DRBD_REQ_UNPLUG)
+               if (bios && (DRBD_REQ_UNPLUG != 0))
                        bio->bi_opf &= ~DRBD_REQ_UNPLUG;
                drbd_generic_make_request(device, fault_type, bio);

