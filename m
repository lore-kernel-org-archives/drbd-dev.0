Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (unknown [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 7D6D92D9DFBA
	for <drbd-dev@lists.linbit.com>; Thu, 25 Jan 2007 22:32:08 +0100 (CET)
Date: Thu, 25 Jan 2007 22:32:10 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] oopses in 2.6.19.1
Message-ID: <20070125213210.GK7738@soda.linbit>
References: <20070110123116.GX15730@kwaak.net>
	<20070111171205.GC15730@kwaak.net>
	<20070111180322.GD15730@kwaak.net>
	<200701151806.20526.philipp.reisner@linbit.com>
	<20070116103749.GD9639@kwaak.net> <20070125174523.GD9639@kwaak.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070125174523.GD9639@kwaak.net>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


first, there is 2.6.19.2 already.
second, there is drbd 8.0.0 already.
though, there have not been any interesting changes in this area since revision 2695,
which you apparently use.

third, see below :)

/ 2007-01-25 18:45:23 +0100
\ Ard van Breemen:
> Hi,
> On Tue, Jan 16, 2007 at 11:37:49AM +0100, Ard van Breemen wrote:
> > I will try it.
> > It seems to happen if I do this:
> > - create a raidset at the primary, create a raidset at the
> > secondary.
> > - create the drbd device on top of that
> > - designate the primary primary.
> I've done this to create the following two kernel logs:
> Create a raidset at A, Create a raidset at B
> Wait for raidsync to complete
> Create the drbd device
> Start the connection (both inconsistent)
> make raidset A primary
> The stuff starts to sync.
> The sync speed at that moment is about 10MB/s.
> I reboot both systems (I just wanted to get a higher speed, and
> rebooting is an easy way to restore settings to something known).
> 
> The primary comes up ok, the secondary also.
> The secondary then trips.
> (At that moment both raidsets are OK).
> That's when I made the logs.
> 
> I reboot the secondary.
> The sync gains speed to >70MB/s
> 
> Just to let you know why I want to use drbd:
> I've got servers with >100M files. If one of the servers goes
> haywired, I've got to resync the 100M files. There is no normal
> application that can sync 1T/>100M files in a timely matter. Next
> to that, I have to bring a second server down, to be abel to do
> that. Using the raw power of drbd, I can do that with drbd in
> about 7 hours, and als be up to date after 7 hours of syncing.
> So: I only use it to sync. After that I disconnect the devices,
> and let them go on independently.
> (Resyncing from the backup takes 48 hours or so)
> Of course I can take the easy road and switch to 0.7 ;-)

thanks for reporting this.

> drbd: initialised. Version: 8.0rc1 (api:86/proto:85)
...

> drbd: initialised. Version: 8.0rc1 (api:86/proto:85)
> drbd: SVN Revision: 2695 build by ard@siddev, 2007-01-16 15:33:47

> drbd: registered as block device major 147
> drbd: minor_table @ 0xffff81007f017e80
> drbd0: disk( Diskless -> Attaching ) 
> drbd0: No usable activity log found.
> drbd0: max_segment_size ( = BIO size ) = 32768
> drbd0: Adjusting my ra_pages to backing device's (32 -> 96)
> drbd0: drbd_bm_resize called with capacity == 2318589904
> drbd0: resync bitmap: bits=289823738 words=4528496
> drbd0: size = 1105 GB (1159294952 KB)
> drbd0: reading of bitmap took 124 jiffies
> drbd0: recounting of set bits took additional 7 jiffies
> drbd0: 1105 GB marked out-of-sync by on disk bit-map.
> drbd0: disk( Attaching -> Inconsistent ) 
> drbd0: Writing meta data super block now.
> drbd0: conn( StandAlone -> Unconnected ) 
> drbd0: receiver (re)started
> drbd0: conn( Unconnected -> WFConnection ) 
> drbd0: conn( WFConnection -> WFReportParams ) 
> drbd0: Handshake successful: DRBD Network Protocol version 85
> drbd0: Peer authenticated using 20 bytes of 'sha1' HMAC
> drbd0: peer( Unknown -> Secondary ) conn( WFReportParams -> WFBitMapT ) pdsk( DUnknown -> UpToDate ) 
> drbd0: Writing meta data super block now.
> drbd0: conn( WFBitMapT -> WFSyncUUID ) 
> drbd0: conn( WFSyncUUID -> SyncTarget ) 
> drbd0: Began resync as SyncTarget (will sync 1158770664 KB [289692666 bits set]).
> drbd0: Writing meta data super block now.
> eth1: no IPv6 routers present
> eth0: no IPv6 routers present
> ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at ...ed/kernel/tyan-s2891/modules/drbd/drbd/lru_cache.c:312
> invalid opcode: 0000 [1] SMP 
> Call Trace:
>  [<ffffffff88077ecf>] :drbd:drbd_rs_complete_io+0xcf/0x130
>  [<ffffffff8806b94d>] :drbd:drbd_endio_write_sec+0x1bd/0x2d0

> RIP  [<ffffffff8807997f>] :drbd:lc_put+0x4f/0xc0
>  NMI Watchdog detected LOCKUP on CPU 0
> RIP: 0010:[<ffffffff8026b4ba>]  [<ffffffff8026b4ba>] _spin_lock_irqsave+0xa/0x20
> Call Trace:
>  [<ffffffff8807772b>] :drbd:__drbd_set_in_sync+0x1bb/0x2e0
>  [<ffffffff88071048>] :drbd:e_end_resync_block+0x68/0x100
>  [<ffffffff8806f50b>] :drbd:drbd_process_done_ee+0xdb/0x140
>  [<ffffffff88071688>] :drbd:drbd_asender+0xe8/0x580

we had some issues in that area lately,
but they where believed to be fixed.

we have to go through these call traces once again.

please upgrade to 8.0.0 anyways, so we won't turn your bug report down
accidentally just because you "only" use rc1...

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
