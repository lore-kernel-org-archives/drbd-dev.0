Return-Path: <jmartin@longphone.fr>
Received: from hermes.longphone.fr (hermes.longphone.fr [193.41.238.17])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 9B8D82E4CA79
	for <drbd-dev@lists.linbit.com>; Thu, 14 Aug 2008 10:27:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by hermes.longphone.fr (Postfix) with ESMTP id 4F94421C00A
	for <drbd-dev@lists.linbit.com>; Thu, 14 Aug 2008 09:55:09 +0200 (CEST)
Subject: [Drbd-dev] too small timeout in drbdsetup
From: Jerome Martin <jmartin@longphone.fr>
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Aug 2008 09:57:33 +0200
Message-Id: <1218700653.5281.26.camel@jaguar.home.zzz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello,

I use drbd in a HA cluster environement, with at times several
drbdadm/drbdsetup commands running in parallel (notably for monitoring
drbd resources status, but also during cluster startup, nodes reboots,
etc..).

I have a drbd minor counts on each node that ranges from 2 to 10, and on
all nodes with more than 3 drbd ressources, I am experiencing very
annoying issues with that timeout.

Please note that it took me some time to realize that the fault was not
coming from my resource agents or some other faults, and I expect it to
be the same for many other users after me if this does not get changed
and/or documented on the drbd upstream packages. I of course now have to
maintain a custom drbd package in my local repository only to get the
trivial patch below in.

Philip, Lars, please consider this request seriously and give it some
thinking. I really think this is an issue that needs to be addressed
because :

1/ I concerns a usecase that is really on your target users base (HA /
clustering)
2/ It is an issue that can stay dormant for a very long time until a
user decides to add more drbds to his setup,and then bite him really
bad, even though it is now reported and trivial to fix (even though I
believe one should always perform tests before production with a bigger
scale than one's actual initial need)
3/ when being addressed by a learning cluster-admin who at the same time
needs to deal with many other different issues, even though it seems
trivial, it can be very hard to debug what's wrong when it gets
triggered
4/ It adds robustness to drbd in many usage scenarios, and I believe
this is what drbd is about: being robust. I'd be disapointed not to see
drbd go for the "safer and most robust" choices, as I guess a large
member of the users community would be.

I know you might feel I am over-emphasing this tiny little detail, but
after many talks around this on linux-ha IRC channels, plus several
support sessions given to users/developers of my own clustering OSS
project, not to mention reports I had from different people in different
usage scenarios unrelated to the above, I really feel this might have a
larger impact than one could initially imagine when looking at it
coldly. And I also fear some of the impacted people are not reporting
their experience because they lack understanding of what actually
happens, and might turn their back on a drbd-based solution for the
wrong reasons ("never got it to run stable, so dumped it" type of
story).

Note: the actual timeout value that I feel is required to solve 99.9% of
the occurences of the issue at hand is 1s, but I feel that for coherency
reasons it should be set to NL_TIME and be made configurable. But YMMV
and I see no reasons to stay on the safe side with this one.

Thanks for your most valuable time,
Jerome

diff -Naurd drbd8-8.0.12~/user/drbdsetup.c drbd8-8.0.12/user/drbdsetup.c
--- drbd8-8.0.12~/user/drbdsetup.c	2008-04-08 21:05:56.000000000 +0200
+++ drbd8-8.0.12/user/drbdsetup.c	2008-08-04 16:11:11.000000000 +0200
@@ -1839,8 +1839,8 @@
 	tl->drbd_p_header->drbd_minor = 0;
 	tl->drbd_p_header->flags = 0;
 
-	rr = call_drbd(sk_nl, tl, (struct nlmsghdr*)buffer, 4096, 500);
-	/* Might print: (after 500ms)
+	rr = call_drbd(sk_nl, tl, (struct nlmsghdr*)buffer, 4096, NL_TIME);
+	/* Might print: (after NL_TIME)
 	   No response from the DRBD driver! Is the module loaded? */
 	close_cn(sk_nl);
 	if (rr == -2) exit(20);

Best Regards,
-- 
Jérôme Martin | LongPhone
Responsable Architecture Réseau
122, rue la Boetie | 75008 Paris
Tel :  +33 (0)1 56 26 28 44
Fax : +33 (0)1 56 26 28 45
Mail : jmartin@longphone.fr
Web : www.longphone.com <http://www.longphone.com>

