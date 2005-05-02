Return-Path: <paul.clements@steeleye.com>
Message-ID: <42766EF6.4090707@steeleye.com>
Date: Mon, 02 May 2005 14:18:30 -0400
From: Paul Clements <paul.clements@steeleye.com>
MIME-Version: 1.0
To: drbd-dev@linbit.com, drbd-user@linbit.com
References: <4F6A5F5D1AA48F4584FF34E6F57D0518018A85@steelpo1.steeleye.com>
	<42765DEB.6040109@steeleye.com>
In-Reply-To: <42765DEB.6040109@steeleye.com>
Content-Type: multipart/mixed; boundary="------------020001010600000706030604"
Subject: [Drbd-dev] BUG: DRBD on Power PC 64-bit with RedHat EL 3 (2.4.21
 kernel) does not work
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.
--------------020001010600000706030604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

We've recently been trying to certify DRBD (we've tried both 0.7.5 and 
0.7.10 with the same results) on ppc64 with RHEL3.

Unfortunately, we have run into two fairly serious issues:

1) we had to hack up the source just to get it to build:

The basic problem is that the adjust_drbd_config_h.sh script is not 
doing the right thing for RHEL3 on ppc64. RHEL3 has a find_next_bit() 
function, and on most architectures it's an inline function. However, on 
ppc64 it's not inline and it's not exported, which means drbd (being a 
module) can't use it. So we have to actually disable the 
HAVE_FIND_NEXT_BIT setting in drbd_config.h. Also, there is no 
arch-specific find_next_bit function for ppc64 in drbd_compat_types.h, 
so we have to use the generic find_next_bit function that's in that file 
(by defining USE_GENERIC_FIND_NEXT_BIT in drbd_config.h). Of course, 
when this function is defined, it conflicts with the previous 
find_next_bit function declaration from the kernel headers 
(asm-ppc64/bitops.h). So, we had to rename the generic function to 
generic_find_next_bit and change all calls in the drbd source (just one 
in drbd_bitmap.c) to use generic_find_next_bit instead of find_next_bit.


2) additionally, the driver appears to start up fine on both machines, 
but when the resync begins, it quickly stalls and never makes any progress


Included are the DRBD config and other system information. Please let me 
know if you need any further information.

Thanks,
Paul


--------
After starting drbd on the source system (already running on the 
target), this happens:

[root@trumpkin root]# cat /proc/drbd
version: 0.7.5 (api:76/proto:74)
SVN Revision: 1578 build by root@tumnus, 2005-04-29 10:13:28
  0: cs:SyncSource st:Secondary/Secondary ld:Consistent
     ns:128 nr:0 dw:0 dr:128 al:0 bm:0 lo:0 pe:0 ua:0 ap:0
         [>...................] sync'ed:  0.9% (978816/978944)K
         finish: 2:43:08 speed: 32 (32) K/sec

[root@trumpkin root]# cat /proc/drbd
version: 0.7.5 (api:76/proto:74)
SVN Revision: 1578 build by root@tumnus, 2005-04-29 10:13:28
  0: cs:SyncSource st:Secondary/Secondary ld:Consistent
     ns:128 nr:0 dw:0 dr:128 al:0 bm:0 lo:0 pe:0 ua:0 ap:0
         [>...................] sync'ed:  0.9% (978816/978944)K
         finish: 7:28:37 speed: 8 (8) K/sec

[root@trumpkin root]# cat /proc/drbd
version: 0.7.5 (api:76/proto:74)
SVN Revision: 1578 build by root@tumnus, 2005-04-29 10:13:28
  0: cs:SyncSource st:Secondary/Secondary ld:Consistent
     ns:128 nr:0 dw:0 dr:128 al:0 bm:0 lo:0 pe:0 ua:0 ap:0
         [>...................] sync'ed:  0.9% (978816/978944)K
         finish: 8:09:24 speed: 8 (8) K/sec

[root@trumpkin root]# uname -a
Linux trumpkin 2.4.21-27.EL #1 SMP Wed Dec 1 21:53:20 EST 2004 ppc64 
ppc64 ppc64
  GNU/Linux


--------
On the target, this is reported:

[root@tumnus root]# cat /proc/drbd
version: 0.7.5 (api:76/proto:74)
SVN Revision: 1578 build by root@tumnus, 2005-04-29 10:13:28
  0: cs:SyncTarget st:Secondary/Secondary ld:Inconsistent
     ns:0 nr:128 dw:128 dr:0 al:0 bm:0 lo:0 pe:0 ua:0 ap:0
         [>...................] sync'ed:  0.9% (978816/978944)K
         finish: 106:02:18 speed: 0 (0) K/sec

[root@tumnus root]# cat /proc/drbd
version: 0.7.5 (api:76/proto:74)
SVN Revision: 1578 build by root@tumnus, 2005-04-29 10:13:28
  0: cs:SyncTarget st:Secondary/Secondary ld:Inconsistent
     ns:0 nr:128 dw:128 dr:0 al:0 bm:0 lo:0 pe:0 ua:0 ap:0
         [>...................] sync'ed:  0.9% (978816/978944)K
         finish: 117:35:37 speed: 0 (0) K/sec

[root@tumnus root]# cat /proc/drbd
version: 0.7.5 (api:76/proto:74)
SVN Revision: 1578 build by root@tumnus, 2005-04-29 10:13:28
  0: cs:SyncTarget st:Secondary/Secondary ld:Inconsistent
     ns:0 nr:128 dw:128 dr:0 al:0 bm:0 lo:0 pe:0 ua:0 ap:0
         [>...................] sync'ed:  0.9% (978816/978944)K
         finish: 118:16:24 speed: 0 (0) K/sec

[root@tumnus root]# uname -a
Linux tumnus 2.4.21-27.EL #1 SMP Wed Dec 1 21:53:20 EST 2004 ppc64 ppc64 
ppc64 GNU/Linux


--------------020001010600000706030604
Content-Type: text/plain;
 name="drbd.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="drbd.conf"

#
# drbd.conf example
#

resource RHEL0 {

  # transfer protocol to use.
  # C: write IO is reported as completed, if we know it has
  #    reached _both_ local and remote DISK.
  #    * for critical transactional data.
  # B: write IO is reported as completed, if it has reached
  #    local DISK and remote buffer cache.
  #    * for most cases.
  # A: write IO is reported as completed, if it has reached
  #    local DISK and local tcp send buffer. (see also sndbuf-size)
  #    * for high latency networks
  #
  #**********
  # uhm, benchmarks have shown that C is actually better than B.
  # this note shall disappear, when we are convinced that B is
  # the right choice "for most cases".
  # Until then, always use C unless you have a reason not to.
  #	--lge
  #**********
  #
  protocol C;

  # what should be done in case the cluster starts up in
  # degraded mode, but knows it has inconsistent data.
#  incon-degr-cmd "echo '!DRBD! pri on incon-degr' | wall ; sleep 60 ; halt -f";

  startup {
    # Wait for connection timeout. 
    # The init script blocks the boot process until the resources
    # are connected. This is so when the cluster manager starts later,
    # it does not see a resource with internal split-brain.
    # In case you want to limit the wait time, do it here.
    # Default is 0, which means unlimited. Unit is seconds.
    #
     wfc-timeout  30;

    # Wait for connection timeout if this node was a degraded cluster.
    # In case a degraded cluster (= cluster with only one node left)
    # is rebooted, this timeout value is used. 
    #
    degr-wfc-timeout 120;    # 2 minutes.
  }

  syncer {
    # Limit the bandwith used by the resynchronisation process.
    # default unit is KB/sec; optional suffixes K,M,G are allowed
    #
    rate 100M;

  }

  on trumpkin {
    device     /dev/drbd0;
    disk       /dev/sdb2;
    address    172.17.100.211:60003;
    meta-disk  /dev/sdb7[0];

    # meta-disk is either 'internal' or '/dev/ice/name [idx]'
    #
    # You can use a single block device to store meta-data
    # of multiple DRBD's.
    # E.g. use meta-disk /dev/hde6[0]; and meta-disk /dev/hde6[1];
    # for two different resources. In this case the meta-disk
    # would need to be at least 256 MB in size.
    #
    # 'internal' means, that the last 128 MB of the lower device
    # are used to store the meta-data.
    # You must not give an index with 'internal'.
  }

  on tumnus {
    device    /dev/drbd0;
    disk      /dev/sdb2;
    address   172.17.100.210:60003;
    meta-disk /dev/sdb7[0];
  }
}


--------------020001010600000706030604--
