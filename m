Return-Path: <florian@hastexo.com>
Received: from mail-we0-f182.google.com (mail-we0-f182.google.com
	[74.125.82.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7AFDF106DCC8
	for <drbd-dev@lists.linbit.com>; Thu, 22 Mar 2012 13:36:28 +0100 (CET)
Received: by wern13 with SMTP id n13so2996318wer.27
	for <drbd-dev@lists.linbit.com>; Thu, 22 Mar 2012 05:36:28 -0700 (PDT)
From: Florian Haas <florian@hastexo.com>
To: drbd-dev@lists.linbit.com
Date: Thu, 22 Mar 2012 13:30:16 +0100
Message-Id: <1332419419-29091-1-git-send-email-florian@hastexo.com>
Subject: [Drbd-dev] Trivial User's Guide fixes
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Lars,

here are the patches from the User's Guide patchset from last
November, minus those that Phil and I agreed to drop by offlist
email. Martin's and my primary blog locations have changed since
November, so I've tacked the new URLs on as well.  Feel free to take
or drop whatever you consider appropriate. This supersedes my pull
request from Nov 28
(http://lists.linbit.com/pipermail/drbd-dev/2011-November/002004.html).

These patches are against the current state of the tree at
git.drbd.org.

In summary, the following changes since commit
5c4c8eb62387f64ab1ce503323cea55011159c82:

  User's Guide: Added proper op monitor intervals for both Master and Slave roles. (2011-11-14 11:03:52 +0100)

are available in the git repository at:
  git://github.com/fghaas/drbd-documentation master

Florian Haas (3):
      User's Guide: Fix incorrect configuration syntax for c-plan-ahead and friends
      User's Guide: update blog links in "more info" section
      User's Guide: correct blog locations for Florian and Martin

 users-guide/administration.txt |    2 +-
 users-guide/more-info.txt      |    9 ++++-----
 users-guide/recent-changes.txt |    2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

Hope this is useful.

Cheers,
Florian
