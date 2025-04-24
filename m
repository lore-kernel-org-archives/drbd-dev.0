Return-Path: <splc.regional.east@gmail.com>
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com
	[209.85.219.170])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BEE4E16091D
	for <drbd-dev@lists.linbit.com>; Thu, 24 Apr 2025 17:23:04 +0200 (CEST)
Received: by mail-yb1-f170.google.com with SMTP id
	3f1490d57ef6-e455bf1f4d3so945138276.2
	for <drbd-dev@lists.linbit.com>; Thu, 24 Apr 2025 08:23:04 -0700 (PDT)
MIME-Version: 1.0
From: Reginald Cirque <splc.regional.east@gmail.com>
Date: Thu, 24 Apr 2025 11:22:52 -0400
Message-ID: <CANA-72DMWg-UwGBVbM9y-p9zUJu_4LqZk3V9qOEZCM0nSHzq=Q@mail.gmail.com>
Subject: Possible memory leak in DRBD 8.4.11
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="UTF-8"
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Good day,
I was syncing a 300 GB LVM volume from a DRBD primary to a newly-built
secondary, and noticed that the sending host (primary) had 300G of
"untracked", used, memory (not visible in slab, cached, or associated
with any application(s), simply shown as "kernel dynamic memory" in
"smem -twk" output) for long (many hours) after the sync had
completed, suggesting that DRBD buffers/page-pool were not reclaimed.

When I ran "drbdsetup down" to disconnect the secondary, I observed a
kernel log message:
"block drbd3: net_ee not empty, killed 291226 entries", which further
suggests to me that DRBD buffers are not being properly reclaimed.

The memory was returned back to the system ~instantly after
disconnecting the secondary.

I am running Linux kernel 6.1.128-1.el8.x86_64 and patching-in the
8.4.11 DRBD module in-tree.
