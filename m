Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 4D3242E083C4
	for <drbd-dev@lists.linbit.com>; Tue, 12 Aug 2008 10:49:46 +0200 (CEST)
Date: Tue, 12 Aug 2008 10:49:46 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] 8.2.6 Peer disk state handling issue when attaching
Message-ID: <20080812084946.GC19857@soda.linbit>
References: <DA0E7D869C862D4095C265233CD1D41EC30F85@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DA0E7D869C862D4095C265233CD1D41EC30F85@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Aug 11, 2008 at 11:52:30PM -0400, Graham, Simon wrote:
> I have noticed that with 8.2.6, if the role of a device is
> Secondary/Secondary and you detach and then re-attach a device, the peer
> disk state on the other node ends up as Consistent instead of UpToDate -
> it seems that in this case the code does not check if a resync is
> required and goes directly from DiskLess->Consistent on the side that is
> not doing the detach/attach.
> 
> Here is a sample extract from the messages file on the two systems:
> 
> First, on the system where you do the detach followed by attach
> (connection state is Connected when this starts, roles are
> Secondary/Secondary, disk UpToDate/UpToDate:
> 
> Aug  9 04:53:11 node0 kernel: drbd16: disk( UpToDate -> Diskless ) 
> 
> Aug  9 04:53:32 node0 kernel: drbd16: disk( Diskless -> Attaching ) 
> Aug  9 04:53:32 node0 kernel: drbd16: No usable activity log found.
> Aug  9 04:53:32 node0 kernel: drbd16: max_segment_size ( = BIO size ) =
> 32768
> Aug  9 04:53:32 node0 kernel: drbd16: reading of bitmap took 1 jiffies
> Aug  9 04:53:32 node0 kernel: drbd16: recounting of set bits took
> additional 0 jiffies
> Aug  9 04:53:32 node0 kernel: drbd16: 0 KB (0 bits) marked out-of-sync
> by on disk bit-map.
> Aug  9 04:53:32 node0 kernel: drbd16: disk( Attaching -> Negotiating ) 
> Aug  9 04:53:32 node0 kernel: drbd16: Writing meta data super block now.
> Aug  9 04:53:32 node0 kernel: drbd16: disk( Negotiating -> UpToDate )
> 
> On the other node (same starting state):
> 
> Aug  9 04:53:11 node1 kernel: drbd16: pdsk( UpToDate -> Diskless ) 
> 
> Aug  9 04:53:32 node1 kernel: drbd16: real peer disk state = Consistent
> Aug  9 04:53:32 node1 kernel: drbd16: pdsk( Diskless -> Consistent )
> 
> I can see why the second node does not go to the UpToDate state - there
> is a check in _drbd_set_state such that it only overwrites Consistent
> with UpToDate if the connection state is also changing which it does not
> in this case. HOWEVER, I'm not sure this is the right place to fix it -
> it seems to me that we should check for a resync even in this case since
> one or both of the disks could have been Primary and modified the disk
> at some point and then been downgraded to Secondary - so we really need
> to call drbd_sync_handshake even in this case, but we don't seem to...
> 
> I don't see any fixes post 8.2.6 that obviously address this but perhaps
> I missed something?

confirmed in current 8.2 git.

> If not, any thoughts on the right way to fix this?

I leave that question open for now.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
