Return-Path: <Lars.Ellenberg@linbit.com>
Received: from barkeeper1 (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 54E1114FEE
	for <drbd-dev@lists.linbit.com>; Tue,  4 Oct 2005 11:04:34 +0200 (CEST)
Resent-Message-ID: <20051004090434.GB8623@barkeeper1.linbit>
Received: from mxip13a.cluster1.charter.net (mxip13a.cluster1.charter.net
	[209.225.28.143])
	by mxsf36.cluster1.charter.net (8.12.11/8.12.11) with ESMTP id
	j93NhV7Q015925
	for <drbd-dev@lists.linbit.com>; Mon, 3 Oct 2005 19:43:31 -0400
Message-Id: <4enh25$1gctd83@mxip13a.cluster1.charter.net>
From: "Joshua Mouch" <joshua@emailscout.net>
To: <drbd-dev@linbit.com>
Date: Mon, 3 Oct 2005 19:43:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] 0.8 & GFS
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

I'd like to test the newest version of 0.8 that is in SVN with GFS 6.1 with
the following storage failover setup:

_________        _________
|   A   |        |   B   |
|       |        |       |
| DiskA |<-DRBD->| DiskB |
---------        ---------

1) DiskA+DiskB should act as a networked stripped raid, which will be
accomplished by DRBD syncing the data between DiskA and DiskB.

2) Nodes A & B both provide an IMAP service (using Cyrus) with storage on
DiskA+DiskB.

3) GFS will ensure that locking occurs on DiskA+DiskB such that NodeA and
NodeB cannot write to the same spot on disk simultaneously.

However, I can't quite figure out how to accomplish part 3 so that I can
begin testing.  My first thought is export DiskA using GNBD and import it
into Node B and do the same for DiskB to node A so that Node A & B can "see"
both disks and therefore be able to perform locking.

_________        _________
|   A   |        |   B   |
|       |        |       |
| DiskA |<-DRBD->| DiskB |
|       |\      /|       |
|       | \    / |       |
| GnbdB |--\--/  |       |
|       |   \    |       |
|       |    \---| GnbdA |
---------        ---------

But that's where I get stuck.  Is this the correct approach?

Joshua Mouch
