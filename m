Return-Path: <mliebherr99@googlemail.com>
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com
	[209.85.218.49]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DC0281056482
	for <drbd-dev@lists.linbit.com>; Tue, 27 Sep 2016 08:51:02 +0200 (CEST)
Received: by mail-oi0-f49.google.com with SMTP id a62so5173075oib.1
	for <drbd-dev@lists.linbit.com>; Mon, 26 Sep 2016 23:51:02 -0700 (PDT)
MIME-Version: 1.0
From: Ml Ml <mliebherr99@googlemail.com>
Date: Tue, 27 Sep 2016 08:44:40 +0200
Message-ID: <CANFxOjC_xdJae=61cnyrsj1OefE_z69dgNA2-3VgQ55iHhZNrw@mail.gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=UTF-8
Subject: [Drbd-dev] DRBD9 - ASSERTION FAILED: pp_in_use
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

Hello List,

i am writing to this Dev-Mailing list because i dont seem to get help
or an answer on the drbd-users mailing list or the proxmox support
team.

We run a 3 Node (Proxmox) Cluster with drbd, and each time we add the
3rd node we run into this error after a while:

(...)
[Mon Sep 26 19:39:57 2016] drbd vm-105-disk-1 node07: ASSERTION
FAILED: pp_in_use: -29 < 0
[Mon Sep 26 19:40:00 2016] drbd vm-105-disk-1 node07: ASSERTION
FAILED: pp_in_use: -1 < 0
[Mon Sep 26 19:40:00 2016] drbd vm-105-disk-1 node07: ASSERTION
FAILED: pp_in_use: -5 < 0
[Mon Sep 26 19:40:00 2016] drbd vm-105-disk-1 node07: ASSERTION
FAILED: pp_in_use: -13 < 0
[Mon Sep 26 19:40:00 2016] drbd vm-105-disk-1 node07: ASSERTION
FAILED: pp_in_use: -29 < 0
(...)

This error spams my logs and after a while the system gets unseable
slow until you have to hard reset it.

root@node06:~# dpkg -l |grep drbd
ii  drbd-utils                     8.9.8-1
amd64        RAID 1 over TCP/IP for Linux (user utilities)
ii  drbdmanage                     0.97.3-1
amd64        Distributed configuration management for DRBD

root@node06:~# uname -r
4.4.19-1-pve


I was told on the irc freenode channel:
- to use the latest github drbd source
- to no use drbd9 yet

I also asked the drbd users in april:
  http://lists.linbit.com/pipermail/drbd-user/2016-April/022893.html

Is this a bug or a wrong setup? I really love drbd but with this
problem we might have to move to ceph if we cant solve it.... :-(

I would be glad for any hint.
( i dont even understand what that error means )

Thanks.
