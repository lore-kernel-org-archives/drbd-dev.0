Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id F0CAC105059F
	for <drbd-dev@lists.linbit.com>; Wed, 10 Jun 2015 09:49:05 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com
Date: Wed, 10 Jun 2015 15:48:19 +0800
Message-Id: <1433922509-10280-1-git-send-email-nwang@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Drbd-dev] [PATCH 00/10] Zero out devices instead of initial full
	sync
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

Full sync for drbd initial usually take a long time, especically
when network become the bottleneck the syncing. Simply skip the
full sync with "--clear-bitmap" may not the perfect solution
for all the cases. So this patches can be used to zero out 
devices locally instead of a full sync,two make consistent block 
device. This approach can be useful when lack of network bandwidth 
to sync.

The patches add one new option "--zap-devices" to "new-current-uuid" 
to zero out devices. Besides the change of drbd, also need to modify 
drbd-utils for the flag.

All patches are compiled/tested against SLES12.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org

 drbd/drbd_int.h        |  9 +++++
 drbd/drbd_main.c       | 42 ++++++++++++++++++++-
 drbd/drbd_nl.c         | 42 ++++++++++++++++++++-
 drbd/drbd_protocol.h   |  1 +
 drbd/drbd_receiver.c   | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drbd/linux/drbd_genl.h |  1 +
 6 files changed, 191 insertions(+), 3 deletions(-)

-- 
1.8.4.5

