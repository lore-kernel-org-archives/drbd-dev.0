Return-Path: <Lars.Ellenberg@linbit.com>
Date: Wed, 5 Oct 2005 10:56:05 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@linbit.com
Subject: Re: [Drbd-dev] 0.8 & GFS
Message-ID: <20051005085605.GA2581@barkeeper1.linbit>
References: <4enh25$1gctd83@mxip13a.cluster1.charter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4enh25$1gctd83@mxip13a.cluster1.charter.net>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

for those on the list: I let this post pass for "originality"

/ 2005-10-03 19:43:19 -0400
\ Joshua Mouch:
> I'd like to test the newest version of 0.8 that is in SVN with GFS 6.1 with
> the following storage failover setup:
> 
> _________        _________
> |   A   |        |   B   |
> |       |        |       |
> | DiskA |<-DRBD->| DiskB |
> ---------        ---------
> 
> 1) DiskA+DiskB should act as a networked stripped raid, which will be
> accomplished by DRBD syncing the data between DiskA and DiskB.

drbd does mirror. no striping.

> 2) Nodes A & B both provide an IMAP service (using Cyrus) with storage on
> DiskA+DiskB.

cyrus is evil.

> 3) GFS will ensure that locking occurs on DiskA+DiskB such that NodeA and
> NodeB cannot write to the same spot on disk simultaneously.
> 
> However, I can't quite figure out how to accomplish part 3 so that I can
> begin testing.  My first thought is export DiskA using GNBD and import it
> into Node B and do the same for DiskB to node A so that Node A & B can "see"
> both disks and therefore be able to perform locking.
> 
> _________        _________
> |   A   |        |   B   |
> |       |        |       |
> | DiskA |<-DRBD->| DiskB |
> |       |\      /|       |
> |       | \    / |       |
> | GnbdB |--\--/  |       |
> |       |   \    |       |
> |       |    \---| GnbdA |
> ---------        ---------
> 
> But that's where I get stuck.
> Is this the correct approach?

not at all.
nbd has nothing to do with it.
if you know how to setup gfs with shared disk, then you just substitute
the shared disk device nodes with the drbd device nodes.
both nodes "see" /dev/drbd0, and once initialized, it in fact has the
same data on both nodes, as if it where a shared disk.
how drbd does this? it's a mircale...

whether current svn in fact already works successfully in this way
is an other question.

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-0  :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
