Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: linux-kernel@vger.kernel.org
Date: Mon,  6 Jul 2009 17:39:19 +0200
Message-Id: <1246894775-10855-1-git-send-email-philipp.reisner@linbit.com>
Cc: Bart Van Assche <bart.vanassche@gmail.com>,
	Kyle Moffett <kyle@moffetthome.net>, Christoph Hellwig <hch@infradead.org>,
	Neil Brown <neilb@suse.de>,
	Nikanth Karthikesan <knikanth@suse.de>, Greg KH <gregkh@suse.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Lars Marowsky-Bree <lmb@suse.de>, Jens Axboe <jens.axboe@oracle.com>,
	Dave Jones <davej@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 00/16] drbd: a block device for HA clusters
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

As the first bit of the DBRD patch already got upstream (see commit
10fc89d01a) it is time to get more of DRBD towards mainline.

Here is a post of drbd-8.3.2 for inclusion into linux-mm (or linux-next).

Patch set attached. Git tree available:
git pull git://git.drbd.org/linux-2.6-drbd.git drbd

In case you want to review the code, here is a note for you:

  Only the first patch (lru_cache) is self contained. The other patches are
  just split at file boundaries. Sorry, DRBD was developed as out-of-tree
  modules just for too long.

Short Description

  DRBD is a shared-nothing, replicated block device. It is designed to
  serve as a building block for high availability clusters and

  in this context, is a "drop-in" replacement for shared storage.
  Simplistically, you could see it as a network RAID 1.

  More information can be found at http://www.drbd.org

Changes since 2009-06-26

  * Cleanup: Added an entry to the MAINTAINERS file
  * DRBD:    Now at drbd-8.3.2:
  * DRBD:    Fixed a hard to trigger race condition. (kmap_atomic(..., KM_IRQ1) interruptible)

Changes since 2009-05-15

  * Cleanup: Moved lru_cache.c to /lib
  * Cleanup: all STATIC -> static
  * Cleanup: Removed drbd_config.h ; New Kconfig option: CONFIG_DRBD_FAULT_INJECTION
  * Cleanup: Removed drbd_buildtag.c
  * DRBD:    Following DRBD-upstream, now at 8.3.2-rc2. Relevant changes:
  * DRBD:    lru_cache: use pointer arrays and kmem_cache
  * DRBD:    Fixed for building on big endian architectures
  * DRBD:    Fixed nl stuff to work on architectures that does not do unaligned memory accesses
  * DRBD:    Deal with hash functions already ported to SHASH
  * DRBD:    GFP_KERNEL -> GFP_NOIO in various places

Changes since 2009-04-30

  * Cleanup: Removed typecasts, more documentation in lru_cache. Moved to /lib
  * Cleanup: replaced __attribute__((packed)) with __packed
  * Cleanup: remove quite a few 'inline's from .c files
  * Cleanup: renaming a few constants: _SECT -> _SECTOR_SIZE, _SIZE_B -> _SHIFT ...
  * Cleanup: rename inc_local -> get_ldev; inc_net -> get_net_conf; and corresponding dec_* -> put_*
  * Cleanup: rename mdev->bc to mdev->ldev (to match the recent change to get_ldev/put_ldev)
  * Cleanup: Made function comments kernel-doc compliant
  * Cleanup: vmalloc() only as a fall back for kmalloc()
  * DRBD:    Allow detach of a SyncTarget node. (Bugz 221)
  * DRBD:    Call drbd_rs_cancel_all() and reset rs_pending when aborting resync due to detach. (Bugz 223)
  * DRBD:    make drbd thread t_lock irqsave - lockdep complained, and lockdep is right (theoretically)

Changes since 2009-04-10

  * Cleanup: Removed all CamelCase
  * Cleanup: Replaced DRBD's own tracing stuff with regular tracepoints
  * Cleanup: Removed ERR/INFO/ALERT ... macros, using dev_err/dev_info/... now
  * Cleanup: Minor stuff, as suggested in feedback on LKML
  * DRBD:    Bitmap compression feature was finalised
  * DRBD:    new disable_sendpage parameter

Changes since the post on 2009-03-30, all triggered by reviews

  * Improvements to Makefile and Kconfig
  * Simplified definitions of bm_flags' bitnumbers
  * Removed debugging aid

Changes since the post on 2009-03-23, from drbd-mainline

  * Updated to the final drbd-8.3.1 code
  * Optionally run-length encode bitmap transfers

Changes since the post on 2009-03-23, triggered by reviews

  * Using the latest proc_create() now
  * Moved the allocation of md_io_tmpp to attach/detach out of drbd_md_sync_page_io()
  * Removing the mode selection comments for emacs
  * Removed DRBD_ratelimit()

cheers,
  Phil
