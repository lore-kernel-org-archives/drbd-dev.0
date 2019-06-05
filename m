Return-Path: <dab21774@gmail.com>
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com
	[209.85.166.42])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 6CD781028A61
	for <drbd-dev@lists.linbit.com>; Wed,  5 Jun 2019 18:14:28 +0200 (CEST)
Received: by mail-io1-f42.google.com with SMTP id u19so4740624ior.9
	for <drbd-dev@lists.linbit.com>; Wed, 05 Jun 2019 09:14:27 -0700 (PDT)
Received: from [192.168.1.9] (c-73-78-150-191.hsd1.co.comcast.net.
	[73.78.150.191]) by smtp.gmail.com with ESMTPSA id
	k203sm9070618itk.41.2019.06.05.09.14.25
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 09:14:26 -0700 (PDT)
To: drbd-dev@lists.linbit.com
From: David Butterfield <dab21774@gmail.com>
Message-ID: <e9d5ec6e-30e9-9af1-06c3-bcf8b1d92068@gmail.com>
Date: Wed, 5 Jun 2019 10:14:19 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] avoid use of errno as a function parameter name
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

Avoid use of errno as an argument name because it is allowed to be a macro such as
    # define errno (*__errno_location ())

diff --git a/drbd_wrappers.h b/drbd_wrappers.h
-static inline blk_status_t errno_to_blk_status(int errno)
+static inline blk_status_t errno_to_blk_status(int _errno)
 {
        blk_status_t status =
-               errno == 0 ? BLK_STS_OK :
-               errno == -ENOMEM ? BLK_STS_RESOURCE :
-               errno == -EOPNOTSUPP ? BLK_STS_NOTSUPP :
+               _errno == 0 ? BLK_STS_OK :
+               _errno == -ENOMEM ? BLK_STS_RESOURCE :
+               _errno == -EOPNOTSUPP ? BLK_STS_NOTSUPP :
                BLK_STS_IOERR;
