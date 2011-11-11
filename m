Return-Path: <florian@hastexo.com>
Received: from mail-bw0-f54.google.com (mail-bw0-f54.google.com
	[209.85.214.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8EBBA1055705
	for <drbd-dev@lists.linbit.com>; Fri, 11 Nov 2011 16:15:06 +0100 (CET)
Received: by bkbzs8 with SMTP id zs8so6290754bkb.27
	for <drbd-dev@lists.linbit.com>; Fri, 11 Nov 2011 07:15:06 -0800 (PST)
Message-ID: <4EBD3BF7.9020406@hastexo.com>
Date: Fri, 11 Nov 2011 16:15:03 +0100
From: Florian Haas <florian@hastexo.com>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] User's Guide fix for variable-rate sync;
	missing doc in man pages
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Phil/Lars,

please consider pulling the following small change since commit
41d5ae8d7f9855387f202603d612a3cfbd23f505:

  Merge remote-tracking branch 'fghaas/master' (2011-09-02 12:45:49 +0200)

from the git repository at:

  git://github.com/fghaas/drbd-documentation master

Florian Haas (1):
      Fix incorrect configuration syntax for c-plan-ahead and friends

 users-guide/administration.txt |    2 +-
 users-guide/recent-changes.txt |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Error pointed out by Andrea Spadaccini (spadaccio) in #drbd on freenode.

Andrea also helpfully mentioned that apply-al is missing from the
drbdmeta man page, which reports having been last updated for 8.3.2. You
may want to fix that too.

Andrea, regarding your other comment about disk-options: that one _is_
documented, in the drbdsetup man page.

Cheers,
Florian

-- 
Need help with High Availability?
http://www.hastexo.com/now
