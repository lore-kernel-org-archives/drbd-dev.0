Return-Path: <michael.d.labriola@gmail.com>
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com
	[209.85.166.174])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 680404202B2
	for <drbd-dev@lists.linbit.com>; Sun, 13 Dec 2020 06:59:07 +0100 (CET)
Received: by mail-il1-f174.google.com with SMTP id c18so12764143iln.10
	for <drbd-dev@lists.linbit.com>; Sat, 12 Dec 2020 21:59:07 -0800 (PST)
From: Michael D Labriola <michael.d.labriola@gmail.com>
To: drbd-dev@lists.linbit.com
Date: Sun, 13 Dec 2020 00:58:51 -0500
Message-Id: <20201213055859.3305-1-michael.d.labriola@gmail.com>
Subject: [Drbd-dev] Get drbd-9.0 branch building with Linux 5.9 and 5.10
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

Hey, everyone! I had the chance to try building the latest drbd-9.0
code against the 5.9 and 5.10 kernels this afternoon. Things almost
built, but not quite.  I made a series of commits to get things
compiling.  Most of it is trivial compat test changes and following
along w/ what's already been done in the mainline drbd8 module to get
it ready for 5.10.

I did not create a compat test for the switch from
sched_setscheduler() to sched_set_fifo_low() yet.  Mostly, because
I've never done that and have to wrap my head around how to add
another test. ;-)

I tried submitting a pull request via github, but got the auto-close
message.  So, here's take two.


