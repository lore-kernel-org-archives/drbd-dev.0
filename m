Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A7D18100EC11
	for <drbd-dev@lists.linbit.com>; Thu,  6 Aug 2015 12:04:49 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: nwang@suse.com
Date: Thu,  6 Aug 2015 18:04:21 +0800
Message-Id: <1438855462-3757-1-git-send-email-nwang@suse.com>
In-Reply-To: <1950665.2mvfrclfR5@fat-tyre>
References: <1950665.2mvfrclfR5@fat-tyre>
Cc: linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH v3 0/1] Zeroout/discard devices instead of
	initial full sync
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

Patch set is based on drbd-8.4 3ae8af0b, may confilct with
branch rs-discard-granularity of new feature flag, have
already compiled/tested against SLES12.

Changes compare to v2:
1. two options for new-current-uuid --zeroout-devices and --discard-devices.
2. Create a new feature flag FF_DISCARD.
3. Mark optional for zeroout-devices and discard-devices.
4. Merge patch set into one patch.

Full sync for drbd initial usually take a long time, especically
when network become the bottleneck of the syncing. Simply skip
the full sync with "--clear-bitmap" may not the perfect solution
for all the cases, like using the bare device(no filesystem) to
work,etc database,vm... This patche set can be used to zero out
devices locally instead of a full sync to make the consistent
block device. This approach can be useful when lack of network
bandwidth to sync.

The patches add one new option "--zap-devices" to "new-current-uuid"
to zero out devices. It will start zeroing out devices of both
side.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org

Nick Wang (1):
  drbd: Support zeroout device instead of initial full sync

 drbd/drbd_int.h        |  15 +++++++
 drbd/drbd_main.c       |  60 +++++++++++++++++++++++++++-
 drbd/drbd_nl.c         |  41 +++++++++++++++++--
 drbd/drbd_protocol.h   |   2 +
 drbd/drbd_receiver.c   |  86 +++++++++++++++++++++++++++++++++++++++-
 drbd/drbd_worker.c     | 105 +++++++++++++++++++++++++++++++++++++++++++++++++
 drbd/linux/drbd_genl.h |   2 +
 7 files changed, 305 insertions(+), 6 deletions(-)

-- 
2.1.4

