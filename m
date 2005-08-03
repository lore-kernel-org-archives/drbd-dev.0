Return-Path: <acalando@free.fr>
Received: from postfix4-1.free.fr (postfix4-1.free.fr [213.228.0.62])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 0B93D14E73
	for <drbd-dev@lists.linbit.com>; Wed,  3 Aug 2005 14:05:29 +0200 (CEST)
Received: from computone.varlin (nor75-14-81-57-126-177.fbx.proxad.net
	[81.57.126.177])
	by postfix4-1.free.fr (Postfix) with ESMTP id A4964319E78
	for <drbd-dev@lists.linbit.com>; Wed,  3 Aug 2005 14:05:24 +0200 (CEST)
Date: Wed, 3 Aug 2005 14:15:30 +0200
From: Antoine Calando <acalando@free.fr>
To: drbd-dev@lists.linbit.com
Message-ID: <20050803141530.52037016@computone.varlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] GFS over DRBD: It looks promising!
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


Hello,

I've done some test with the last version of DRBD (rev 1912, 0.8-pre1)
and Red Hat GFS, and I got some interesting results.

I set up a primary/primary DRBD link on two nodes. I created a GFS
partition with gulm lock on /dev/drbd0, I mounted it on both nodes
and I tried some basic tests: it worked! I can copy and create files
(I tried with a few megas), and they appear on the other node without
any problem.

I tried then to run a bonnie++ bench on one node, but I had a kernel
freeze :v( (without any interesting log on the crashed node)

I do some other tests with bonnie++, GFS and DRBD, to find where the 
problem is:

- GFS in local/single mode with bonnie++: it works
- GFS in local/gulm lock mode (2 mounts) with bonnie++: it works (by
the way, it is quite fast)

- ext3 on DRBD (rev 1912) in primary/secondary with bonnie++: it works.

- GFS with gulm lock on DRBD (1912) primary/secondary, with bd_claim 
disabled. GFS is mounted r/w on primary node, and ro on secondary node.
It freezes when I launch bonnie++.

- GFS with no lock on DRBD (1912) primary/secondary (GFS only mounted
on primary): it reboots after a few seconds with bonnie++.

- Same test with DRBD 0.7.11: same result, with a delay of a few minutes.


It seems that DRBD can not manage heavy I/O with GFS, but I don't know why.


Here are some detailed instructions if somebody else want to try without
spending hours and hours with poor documentation ;):

I get GFS from here http://sourceware.org/cluster/
I had much problems with packages, so the best is to use cvs code. I used
STABLE branch.
# cvs -d :pserver:cvs@sources.redhat.com:/cvs/cluster checkout -r STABLE cluster

There was some errors during the make. I had to do some make/"make install"
several times in order to install completely GFS.

(following instructions may be inacurate, I don't have gfs on the machine
I'm using now, it's just what I remember since yesterday)

To create a gfs partition in nolock mode (pointless, just for tests):
# gfs_mkfs -p lock_nolock -t cluster_name:fs_name -j 1 /dev/disk_device

To mount it:
# mount -t gfs /dev/disk_device /mnt/gfs0


To create a gfs partiton for 2 nodes with gulm lock on primary DRBD device: 
# gfs_mkfs -p lock_gulm -t cluster_name:fs_name -j 2 /dev/drbd_device

Gulm lock server must be started before mounting partition on both nodes:
node1# lock_gulm -n cluster_name -s node1 -v All  (node1 is gulm server)
node2# lock_gulm -n cluster_name -s node1 -v All

GFS over DRBD can then be mounted on each node.


Happy testing and thanks to the DRBD team for this great piece of software!

Antoine





