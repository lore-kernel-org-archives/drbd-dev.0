Return-Path: <nwang@suse.com>
Received: from prv3-mh.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3DD7B10518B6
	for <drbd-dev@lists.linbit.com>; Mon, 13 Jul 2015 10:39:25 +0200 (CEST)
From: Nick Wang <nwang@suse.com>
To: nwang@suse.com
Date: Mon, 13 Jul 2015 16:38:54 +0800
Message-Id: <1436776744-3135-1-git-send-email-nwang@suse.com>
Cc: linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	philipp.reisner@linbit.com, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [Patch v2 00/10] Zero out devices instead of initial
	full sync
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

Patch set is based on drbd-8.4 859e34a9, have
already compiled/tested against SLES12.

If this feature can be merged into upstream, please
ignore v1, since v1 may caused pingACK timeout when
zeroing out large device.

Compare to v1, changes are as follow:
 1. Using drbd_device_post_work to zero out device as background
    task, so that it won't block pingACK when zeroing out
    large device.

 2. Fix bug of won't update peer node status if it finished
    zeroing out earier.

 3. Change some functions from file drbd_receive.c to
    drbd_worker.c and reorder the patch set.


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

Nick Wang (10):
  drbd: Fix the wrong logic of move history.
  drbd: Add options zap_devices to new-current-uuid
  drbd: Add a function to zero out drbd backing device.
  drbd: New packet P_ZERO_OUT.
  drbd: Functions to notify peer node to start
        zeroing out and zero out finished.
  drbd: Wapper for zeroing out device by worker.
  drbd: Add flag for drbd device work.
  drbd: Function to work with packet P_ZERO_OUT.
  drbd: Receive zero out command from peer node.
  drbd: Handle new-current-uuid --zap-devices.

Signed-off-by: Nick Wang <nwang@suse.com>
CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: Lars Ellenberg <lars.ellenberg@linbit.com>
CC: drbd-dev@lists.linbit.com
CC: linux-kernel@vger.kernel.org

 drbd/drbd_int.h        | 13 ++++++++
 drbd/drbd_main.c       | 51 ++++++++++++++++++++++++++--
 drbd/drbd_nl.c         | 21 +++++++++++-
 drbd/drbd_protocol.h   |  1 +
 drbd/drbd_receiver.c   | 69 ++++++++++++++++++++++++++++++++++++++
 drbd/drbd_worker.c     | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drbd/linux/drbd_genl.h |  1 +
 7 files changed, 243 insertions(+), 3 deletions(-)

-- 
1.8.4.5

