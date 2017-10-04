Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4A8F3105803B
	for <drbd-dev@lists.linbit.com>; Wed,  4 Oct 2017 14:56:35 +0200 (CEST)
Received: by mail-wm0-f46.google.com with SMTP id q132so22981955wmd.2
	for <drbd-dev@lists.linbit.com>; Wed, 04 Oct 2017 05:56:35 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	q24sm12287552edb.49.2017.10.04.05.56.34
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 04 Oct 2017 05:56:34 -0700 (PDT)
Resent-Message-ID: <20171004125634.GH8989@soda.linbit>
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 61455105801B
	for <drbd-dev@lists.linbit.com>; Wed,  4 Oct 2017 03:54:43 +0200 (CEST)
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com
From: Jia-Ju Bai <baijiaju1990@163.com>
Message-ID: <95166e02-4670-624a-ebbc-d1fbf55560e5@163.com>
Date: Wed, 4 Oct 2017 09:39:24 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [BUG] drbd/block: A sleep-in-atomic bug in notify_helper
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

The driver may sleep under a RCU lock, and the function call path is:
drbd_sync_handshake (acquire the RCU lock)
   drbd_asb_recover_1p
     drbd_khelper
       notify_helper
         mutex_lock --> may sleep

I hope to fix it, but I do not find a proper way at present ...
This bug is found by my static analysis tool and my code review.


Thanks,
Jia-Ju Bai


