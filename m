Return-Path: <dab21774@gmail.com>
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com
	[209.85.166.41])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 305F01028A61
	for <drbd-dev@lists.linbit.com>; Wed,  5 Jun 2019 18:04:05 +0200 (CEST)
Received: by mail-io1-f41.google.com with SMTP id e3so20609841ioc.12
	for <drbd-dev@lists.linbit.com>; Wed, 05 Jun 2019 09:04:05 -0700 (PDT)
Received: from [192.168.1.9] (c-73-78-150-191.hsd1.co.comcast.net.
	[73.78.150.191])
	by smtp.gmail.com with ESMTPSA id 67sm4996415ith.16.2019.06.05.09.04.04
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 09:04:04 -0700 (PDT)
To: drbd-dev@lists.linbit.com
From: David Butterfield <dab21774@gmail.com>
Message-ID: <8e49689e-4fff-fbf1-eb58-7147be7c7ce7@gmail.com>
Date: Wed, 5 Jun 2019 10:03:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] comment "centi seconds" should be "deci seconds"
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

Comment in drbd_limits.h refers to "centi seconds" but they appear to be units of 1/10 (deci)
rather than 1/100 (centi).  (I assume this is a bug in the comment rather than the definition)

52 /* net { */
53   /* timeout, unit centi seconds
54    *    (XXX They actually seem to be deci-seconds)
55    * more than one minute timeout is not useful */
56 #define DRBD_TIMEOUT_MIN 1
57 #define DRBD_TIMEOUT_MAX 600
58 #define DRBD_TIMEOUT_DEF 60       /* 6 seconds */
59 #define DRBD_TIMEOUT_SCALE '1'
