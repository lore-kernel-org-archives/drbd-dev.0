Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
	[209.85.128.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id DC6AF4210D5
	for <drbd-dev@lists.linbit.com>; Fri,  9 Sep 2022 15:04:04 +0200 (CEST)
Received: by mail-wm1-f51.google.com with SMTP id
	bg5-20020a05600c3c8500b003a7b6ae4eb2so4397446wmb.4
	for <drbd-dev@lists.linbit.com>; Fri, 09 Sep 2022 06:04:04 -0700 (PDT)
Received: from grappa.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	ay3-20020a05600c1e0300b003b339438733sm670979wmb.19.2022.09.09.06.04.02
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 09 Sep 2022 06:04:03 -0700 (PDT)
Date: Fri, 9 Sep 2022 15:04:01 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <Yxs5wZZVMHNAVo4N@grappa.linbit>
References: <20220908211337.17090-1-veggiemike@sourceruckus.org>
	<20220908211337.17090-2-veggiemike@sourceruckus.org>
	<CAGNP_+VfjTkF57HJAk1-MEmJbGbcjVeUEX702awJo+mUE29uuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGNP_+VfjTkF57HJAk1-MEmJbGbcjVeUEX702awJo+mUE29uuw@mail.gmail.com>
Subject: Re: [Drbd-dev] [PATCH 1/3] drbd: remove WRITE_SAME support
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Sep 09, 2022 at 09:57:23AM +0200, Joel Colledge wrote:
> Hi Michael,
> 
> Thanks for the patch!
> 
> > This commit mimics upstream commit a34592ff6b78, which removes all the
> > WRITE_SAME code because "REQ_OP_WRITE_SAME was only ever submitted by
> > the legacy Linux zeroing code, which has switched to use
> > REQ_OP_WRITE_ZEROES long ago."  WRITE_SAME was then removed from Linux
> > 5.18.
> 
> This is an interesting case. If we remove all the write-same code like
> this, then we either need to add it back in via compat, or we lose a
> feature. I think it is OK to lose the feature on 5.18+ kernels, since
> the rest of the kernel does not use it any more. On older kernels this
> might break real use cases.
> 
> There is also the case where our peer is running an older kernel and
> we are running 5.18+. I think we should worry about that after
> deciding what to do with peers that run the same kernel.
> 
> I've added Lars to CC because he is more familiar with the historical
> changes in this area.
> 
> Note: If we do remove the feature entirely, we should stop advertising
> the feature flag DRBD_FF_WSAME so that the peer knows that we do not
> support it.

Problem with that is: I overloaded this "feature flag":
/* supports REQ_WRITE_SAME on the "wire" protocol.
 * Note: this flag is overloaded,
 * its presence also
 *   - indicates support for 128 MiB "batch bios",
 *     max discard size of 128 MiB
 *     instead of 4M before that.
 *   - indicates that we exchange additional settings in p_sizes
 *     drbd_send_sizes()/receive_sizes()
 */

I did that to avoid too much special casing with protocol version numbers,
we had 8.4 and 9 version ranges, and introduced the feature on both.

Takeaway: do not overload feature flags :-|

My original commit message:
    drbd: introduce WRITE_SAME support
    
    We will support WRITE_SAME, if
     * all peers support WRITE_SAME (both in kernel and DRBD version),
     * all peer devices support WRITE_SAME
     * logical_block_size is identical on all peers.
    
    We may at some point introduce a fallback on the receiving side
    for devices/kernels that do not support WRITE_SAME,
    by open-coding a submit loop. But not yet.

I don't think "open code a compat fallback" is useful,
the only "relevant" usage of WSAME was ZERO-OUT,
which got its own flag in upstream kernel (and then DRBD) in 2018.

I don't think "WSAME" compat accross 8.4 <-> 9 is something we need to worry
about, I'm fine with not supporting it or the other things it indicated when
connecting 8.4 <-> 9, which should only be done temporarily.
Most of the time a "stop everything; upgrade all nodes; start everything"
will be more effective and have shorter overall downtime than a rolling upgrade
one-by-one, moving services by stopping, then starting on an other node.

But actually we do not need to remove the DRBD_FF_WSAME flag, because WSAME
will not be used even if the feature flag is present, if we don't indicate
support for it in the p_sizes per "peer device" aka volume.
we now always report p->qlim->write_same_capable = 0.

==> I think the patch is okay as is.

If we want, we can just rename the flag,
%s/DRBD_FF_WSAME/DRBD_FF_EXTENDED_QLIM/g or something.

Should we want to drop the flag,
for 9 <-> 9, git log (below) says that we can use PRO_VERSION >= 111
to indicate "128 MiB batch bio size" and "extended p_sizes".

2021-07-30 95adb51a1 drbd: Allow reverting resync direction by usind the --discard-my-data flag        #define PRO_VERSION_MAX 121
2021-04-14 43a7362fa drbd: new option for "invalidate(-remote)" commands: "--reset-bitmap=no"          #define PRO_VERSION_MAX 120
2021-01-25 4f2682e38 drbd: Generalize when resync direction is based on disk states                    #define PRO_VERSION_MAX 119
2020-10-16 e595bfc63 drbd: Serialize connects and promotes properly                                    #define PRO_VERSION_MAX 118
2020-06-19 1f59029d7 drbd: Send config details, size, data UUIDs, and initial state before first 2pc   #define PRO_VERSION_MAX 117
2019-10-23 2f144892f drbd: Allow resync of a re-created peer from day0 UUID                            #define PRO_VERSION_MAX 116
2019-05-24 50124b2b9 drbd: introduce P_RS_CANCEL_AHEAD                                                 #define PRO_VERSION_MAX 115
2018-07-19 3d98754ed drbd: protocol 114: fix distributed deadlock on secondary activity log            #define PRO_VERSION_MAX 114
2018-04-11 6036fafcc drbd: introduce P_ZEROES (REQ_OP_WRITE_ZEROES on the "wire")
2018-03-13 d987c27a7 drbd: Automatically resolve split-brain in a specific case with quorum            #define PRO_VERSION_MAX 113
2016-08-29 6708bd087 drbd: two-phase resize                                                            #define PRO_VERSION_MAX 112
2016-01-28 399b81433 fixed resize for multiple nodes                                                   #define PRO_VERSION_MAX 111
2015-12-04 aeee107ec drbd: introduce WRITE_SAME support
2012-01-24 6a4b0c000 drbd: Implement cluster-wide state changes using two-phase commit                 #define PRO_VERSION_MAX 110

