Return-Path: <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Disposition: inline
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Tue, 15 Sep 2009 16:45:13 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200909151645.14256.philipp.reisner@linbit.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [GIT PULL] DRBD for 2.6.32
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Linus,

Please pull
git://git.drbd.org/linux-2.6-drbd.git drbd

DRBD is a shared-nothing, replicated block device. It is designed to
serve as a building block for high availability clusters and
in this context, is a "drop-in" replacement for shared storage.

It has been discussed and reviewed on the list since March,
and Andrew has asked us to send a pull request for 2.6.32-rc1.

Stephen added us to linux-next in July, and our most recent 
build failure against Jens' 2.6.32-rc1 updates was ironed out this 
morning. So it should be in fairly good shape.

 Documentation/blockdev/drbd/DRBD-8.3-data-packets.svg          |  588 +
 Documentation/blockdev/drbd/DRBD-data-packets.svg              |  459 +
 Documentation/blockdev/drbd/README.txt                         |   16
 Documentation/blockdev/drbd/conn-states-8.dot                  |   18
 Documentation/blockdev/drbd/disk-states-8.dot                  |   16
 Documentation/blockdev/drbd/drbd-connection-state-overview.dot |   85
 Documentation/blockdev/drbd/node-states-8.dot                  |   14
 MAINTAINERS                                                    |   13
 drivers/block/Kconfig                                          |    2
 drivers/block/Makefile                                         |    1
 drivers/block/drbd/Kconfig                                     |   82
 drivers/block/drbd/Makefile                                    |    8
 drivers/block/drbd/drbd_actlog.c                               | 1484 +++
 drivers/block/drbd/drbd_bitmap.c                               | 1327 ++
 drivers/block/drbd/drbd_int.h                                  | 2258 +++++
 drivers/block/drbd/drbd_main.c                                 | 3735 ++++++++
 drivers/block/drbd/drbd_nl.c                                   | 2365 +++++
 drivers/block/drbd/drbd_proc.c                                 |  266
 drivers/block/drbd/drbd_receiver.c                             | 4456 ++++++++++
 drivers/block/drbd/drbd_req.c                                  | 1132 ++
 drivers/block/drbd/drbd_req.h                                  |  327
 drivers/block/drbd/drbd_strings.c                              |  113
 drivers/block/drbd/drbd_tracing.c                              |  753 +
 drivers/block/drbd/drbd_tracing.h                              |   87
 drivers/block/drbd/drbd_vli.h                                  |  351
 drivers/block/drbd/drbd_worker.c                               | 1529 +++
 drivers/block/drbd/drbd_wrappers.h                             |   91
 include/linux/drbd.h                                           |  349
 include/linux/drbd_limits.h                                    |  137
 include/linux/drbd_nl.h                                        |  137
 include/linux/drbd_tag_magic.h                                 |   83
 include/linux/lru_cache.h                                      |  294
 lib/Kconfig                                                    |    3
 lib/Makefile                                                   |    2
 lib/lru_cache.c                                                |  560 +
 35 files changed, 23141 insertions(+)

-phil
