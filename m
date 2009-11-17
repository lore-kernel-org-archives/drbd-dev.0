Return-Path: <lars.ellenberg@linbit.com>
Date: Tue, 17 Nov 2009 10:42:10 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-user@lists.linbit.com, drbd-dev@lists.linbit.com
Message-ID: <20091117094210.GI12722@barkeeper1-xen.linbit>
References: <561dc3260911142208o6fee58a3t7f0e582df470e792@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <561dc3260911142208o6fee58a3t7f0e582df470e792@mail.gmail.com>
Subject: Re: [Drbd-dev] [DRBD-user] 3-node active/active/active config?
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sun, Nov 15, 2009 at 01:08:30AM -0500, Jiann-Ming Su wrote:
> Don't know if this has been discussed before, but it seems like with
> 8.3's dual primary support, it's possible to set up a 3-node, all
> active drbd cluster.
> 
> Each node would be dual primary with each other node.  Node A would
> form drbd0 with node B and drbd1 with node C.  Node B would have drbd0
> with A and drbd2 with C.  And, C would have drbd1 with A and drbd2
> with B.
> 
> Then you can use software raid to create md0 on each node with its
> respective drbd devices.
> 
> Noce A:  md0 (drbd0, drbd1)
> Node B:  md0 (drbd0, drbd2)
> Node C:  md0 (drbd1, drbd2)
> 
> Then format md0 on each node with a cluster filesystem like ocfs2 with
> each node as a member of the cluster.
> 
> Do the drbd experts here have any thoughts on how this idea would go
> horribly wrong?  Thanks for any input and feedback.


 A-MD(A-DRBD0(A-sdx), A-DRBD1(A-sdy))
 B-MD(B-DRBD0(B-sdx),                 B-DRBD2(B-sdy))
 C-MD(                C-DRBD1(C-sdx), C-DRBD2(C-sdy))


So you write block N on A-MD.
It will hit A-DRBD0, and A-DRBD1,
  which will hit local disks A-sdx, A-sdy,
  and via DRBD replication B-sdx, and C-sdx.

Still with me?
Great.

Now, you want to read that block N on B,
which decides in its read balancing path to fetch
block N from B-sdy.

It will surely get _some_ data from there,
but certainly not the data you just wrote on A-MD.

To summ it up in one word:
DON'T.

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
__
please don't Cc me, but send to list   --   I'm subscribed
