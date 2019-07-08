Return-Path: <dab21774@gmail.com>
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com
	[209.85.166.52])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2A3A41011BF7
	for <drbd-dev@lists.linbit.com>; Mon,  8 Jul 2019 19:50:54 +0200 (CEST)
Received: by mail-io1-f52.google.com with SMTP id q22so15415245iog.4
	for <drbd-dev@lists.linbit.com>; Mon, 08 Jul 2019 10:50:54 -0700 (PDT)
Received: from [192.168.1.20] (c-73-78-150-191.hsd1.co.comcast.net.
	[73.78.150.191]) by smtp.gmail.com with ESMTPSA id
	k5sm22441946ioj.47.2019.07.08.10.50.51
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Jul 2019 10:50:52 -0700 (PDT)
To: drbd-dev@lists.linbit.com
From: David Butterfield <dab21774@gmail.com>
Message-ID: <bd96aeb1-ac7c-1da4-bebf-e4f28d0e0313@gmail.com>
Date: Mon, 8 Jul 2019 11:50:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] rcu_dereference() called when not under rcu_read_lock().
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

It seems that in general rcu_dereference() is expected to be called under rcu_read_lock().

I've observed that it is sometimes called without rcu_read_lock() -- for example the two call
stacks below that traverse the idr list.  Is something else protecting such that the
rcu_read_lock() is unnecessary in some cases?

idr_get_next() calls rcu_dereference(), but is called not under rcu_read_lock()
 [02]   0x5e9eeb  rwlock_assert_readlocked usermode_lib.h:1016 (discriminator 5)
 [03]   0x5fa816  idr_get_next idr.c:602
 [04]   0x5684b7  adm_new_connection drbd_nl.c:3774
 [05]   0x569643  drbd_adm_new_peer drbd_nl.c:4070

idr_find() calls rcu_dereference(), but is called not under rcu_read_lock()
 [02]   0x5e9eeb  rwlock_assert_readlocked usermode_lib.h:1016 (discriminator 5)
 [03]   0x5fa582  idr_find idr.c:507
 [04]   0x536970  minor_to_device drbd_int.h:1418
 [05]   0x546625  drbd_create_device drbd_main.c:3709
 [06]   0x570b85  drbd_adm_new_minor drbd_nl.c:5858
