Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 852E214301
	for <drbd-dev@lists.linbit.com>; Mon,  4 Oct 2004 14:55:43 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Mon, 4 Oct 2004 14:56:21 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200410041456.21841.philipp.reisner@linbit.com>
Subject: [Drbd-dev] How Locking in GFS works...
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Finally I found a Text describing usefully how the on disk 
layout of GFS (actually openGFS) looks like and how the locking
works.
[I was not able to find anything about Sistina's ahm. RedHat's
 GFS. ]

Find everything at http://opengfs.sourceforge.net/docs.php

The interesting part from the document on Locking:

2.  Lock name

  lm_lockname_t    gl_name   -- Unique "name" (but not a string!) for lock

  The lockname structure has two components:

    uint64         ln_number -- lock number
    unsigned int   ln_type   -- type of protected entity

  For most locks, the lock number is the block number (within the filesystem's
  64-bit linear block space, which can span many storage devices) of the
  protected entity, left shifted to be equivalent to a 512-byte sector.
  Details are in src/fs/glock.c, ogfs_blk2lockname().

  As an example, if we wanted to protect an inode at block 0x100, and we
  are using 4-kByte blocks, the lock number would be 0x0800 (0x100 << 3).

  I believe the block-to-sector conversion is for support of hardware-based
  DMEP protocols, which address the DMEP storage space in terms of 512-byte
  sectors.  This could turn out to be problematic in *very large* 64-bit
  filesystems, if they want to use the upper 3 bits of the 64-bit block
  number.

  There is a special lock for the disk-based superblock, defined in
  src/fs/ogfs_ondisk.h.  Note that this lock is not based on the block
  number (the superblock is *not* stored in block 0):

    OGFS_SB_LOCK      (0) -- protects superblock read accesses from fs 
upgrades

  In addition to the block-based number assignments, OpenGFS uses some
  special, non-disk lock numbers.  They are defined in src/fs/ogfs_ondisk.h
  (even though they don't show up on disk!):
[...]

This is intended as food for thought on how we should design our
support for shared disk file systems.

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
