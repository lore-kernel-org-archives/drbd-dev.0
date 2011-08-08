Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 81419105626D
	for <drbd-dev@lists.linbit.com>; Mon,  8 Aug 2011 15:57:57 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 8 Aug 2011 15:57:47 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201108081557.48504.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] request for review - DRBD multi volume support for 3.2
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a request for review of drbd-8.4. I intend to send a pull request 
to Jens early next week, for his for-3.2/drivers branch.

I want to point out the idr_for_each_entry() macro, added to
include/linux/idr.h.  Though we use this macro extensively in the new DRBD
code, it is not DRBD specific. I intend to leave it in this patch series, as
the following patches depend on it.

The most noticeable change is the support for multiple replicated volumes in
a single DRBD connection.  Write-ordering is obeyed among all writes in all
volumes in a single connection.  This feature is really important for users
who DRBD for mirroring over longer distances. (Protocol A).

The following changes since commit f963d270cb7bbb8eeb57901d02b22a493e664fd2:

  cciss: add transport mode attribute to sys (2011-08-08 11:40:17 +0200)

are available in the git repository at:
  git://git.drbd.org/linux-2.6-drbd.git for-jens
and the diffstat can be found below.

 drivers/block/drbd/Makefile        |    1 +
 drivers/block/drbd/drbd_actlog.c   |  702 ++++-----
 drivers/block/drbd/drbd_bitmap.c   |  296 +++-
 drivers/block/drbd/drbd_int.h      | 1250 ++++++--------
 drivers/block/drbd/drbd_interval.c |  177 ++
 drivers/block/drbd/drbd_interval.h |   40 +
 drivers/block/drbd/drbd_main.c     | 3372 ++++++++++++++---------------------
 drivers/block/drbd/drbd_nl.c       | 3332 +++++++++++++++++++++--------------
 drivers/block/drbd/drbd_nla.c      |   55 +
 drivers/block/drbd/drbd_nla.h      |    8 +
 drivers/block/drbd/drbd_proc.c     |   27 +-
 drivers/block/drbd/drbd_receiver.c | 3439 +++++++++++++++++++++---------------
 drivers/block/drbd/drbd_req.c      |  739 ++++-----
 drivers/block/drbd/drbd_req.h      |  185 +--
 drivers/block/drbd/drbd_state.c    | 1749 ++++++++++++++++++
 drivers/block/drbd/drbd_state.h    |  161 ++
 drivers/block/drbd/drbd_strings.c  |    1 +
 drivers/block/drbd/drbd_worker.c   |  974 ++++++-----
 drivers/block/drbd/drbd_wrappers.h |   10 +-
 include/linux/drbd.h               |   68 +-
 include/linux/drbd_genl.h          |  363 ++++
 include/linux/drbd_genl_api.h      |   55 +
 include/linux/drbd_limits.h        |   95 +-
 include/linux/drbd_nl.h            |  160 --
 include/linux/drbd_tag_magic.h     |   84 -
 include/linux/genl_magic_func.h    |  414 +++++
 include/linux/genl_magic_struct.h  |  277 +++
 include/linux/idr.h                |   11 +
 include/linux/lru_cache.h          |   67 +-
 lib/lru_cache.c                    |  357 +++--
 30 files changed, 10998 insertions(+), 7471 deletions(-)
 create mode 100644 drivers/block/drbd/drbd_interval.c
 create mode 100644 drivers/block/drbd/drbd_interval.h
 create mode 100644 drivers/block/drbd/drbd_nla.c
 create mode 100644 drivers/block/drbd/drbd_nla.h
 create mode 100644 drivers/block/drbd/drbd_state.c
 create mode 100644 drivers/block/drbd/drbd_state.h
 create mode 100644 include/linux/drbd_genl.h
 create mode 100644 include/linux/drbd_genl_api.h
 delete mode 100644 include/linux/drbd_nl.h
 delete mode 100644 include/linux/drbd_tag_magic.h
 create mode 100644 include/linux/genl_magic_func.h
 create mode 100644 include/linux/genl_magic_struct.h

Best,
 Phil
-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.
