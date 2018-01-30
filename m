Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 6CCF71056F9F
	for <drbd-dev@lists.linbit.com>; Tue, 30 Jan 2018 10:47:43 +0100 (CET)
Received: by mail-wm0-f41.google.com with SMTP id r78so39105696wme.0
	for <drbd-dev@lists.linbit.com>; Tue, 30 Jan 2018 01:47:43 -0800 (PST)
Date: Tue, 30 Jan 2018 10:47:41 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Eric Wheeler <drbd-dev@lists.ewheeler.net>
Message-ID: <20180130094741.GA9072@soda.linbit>
References: <alpine.LRH.2.11.1801292023200.10022@mail.ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.11.1801292023200.10022@mail.ewheeler.net>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD in Linux v4.14.15 deadlock during disconnect
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Jan 29, 2018 at 08:33:24PM +0000, Eric Wheeler wrote:
> Hello all,
> 
> We noticed one of our DRBDs went into a NetworkFailure status. We issued a 
> drbdadm disconnect and now I cannot get it out of the 'Disconnecting' 
> state.
> 
> Here are the details on the host that is stuck:
> 
>   PID                  STARTED CMD                         STAT
>  6842 Tue Jan 23 16:41:52 2018 [drbd_r_acd.]               D
> 11504 Sun Jan 28 11:06:38 2018 [drbd_a_acd.]               D
> 21252 Mon Jan 29 12:10:06 2018 drbdsetup-84 disconnect ipv D
> 
> 
> These are the contents of /proc/[pid]/stack
> 
> === 6842 ===
> [<ffffffff8b0cd0d2>] io_schedule+0x12/0x40
> [<ffffffffc0ac042e>] _drbd_wait_ee_list_empty+0x8e/0xd0 [drbd]
> [<ffffffffc0ac08fb>] conn_wait_active_ee_empty+0x5b/0xc0 [drbd]
> [<ffffffffc0ac9b04>] receive_Barrier+0x74/0x580 [drbd]
> [<ffffffffc0acb189>] drbd_receiver+0x139/0x330 [drbd]
> [<ffffffffc0ad3860>] drbd_thread_setup+0xa0/0x1c0 [drbd]
> [<ffffffff8b0bfe9c>] kthread+0xfc/0x130
> [<ffffffff8b800365>] ret_from_fork+0x35/0x40
> [<ffffffffffffffff>] 0xffffffffffffffff
> 
> === 11504 ===
> [<ffffffffc0ad0629>] wait_until_done_or_force_detached+0xa9/0x210 [drbd]
> [<ffffffffc0ad09a1>] drbd_md_sync_page_io+0x211/0x430 [drbd]
> [<ffffffffc0ad9d99>] drbd_md_write+0x1a9/0x310 [drbd]
> [<ffffffffc0ad9f5d>] drbd_md_sync+0x5d/0x190 [drbd]
> [<ffffffffc0ada0d5>] conn_md_sync+0x45/0xa0 [drbd]
> [<ffffffffc0acb67a>] drbd_ack_receiver+0x2fa/0x540 [drbd]
> [<ffffffffc0ad3860>] drbd_thread_setup+0xa0/0x1c0 [drbd]
> [<ffffffff8b0bfe9c>] kthread+0xfc/0x130
> [<ffffffff8b800365>] ret_from_fork+0x35/0x40
> [<ffffffffffffffff>] 0xffffffffffffffff
> 
> === 21252 ===
> [<ffffffffc0adc1eb>] conn_try_disconnect+0x4b/0x100 [drbd]
> [<ffffffffc0ae0908>] drbd_adm_disconnect+0xd8/0x150 [drbd]
> [<ffffffff8b66912f>] genl_family_rcv_msg+0x1ef/0x3a0
> [<ffffffff8b669327>] genl_rcv_msg+0x47/0x90
> [<ffffffff8b668502>] netlink_rcv_skb+0xe2/0x110
> [<ffffffff8b668d34>] genl_rcv+0x24/0x40
> [<ffffffff8b667c6e>] netlink_unicast+0x17e/0x250
> [<ffffffff8b66800d>] netlink_sendmsg+0x2cd/0x3c0
> [<ffffffff8b60cd80>] sock_sendmsg+0x30/0x40
> [<ffffffff8b60ce17>] sock_write_iter+0x87/0x100
> [<ffffffff8b24e466>] __vfs_write+0xf6/0x150
> [<ffffffff8b24e65d>] vfs_write+0xad/0x1a0
> [<ffffffff8b24e8a2>] SyS_write+0x52/0xc0
> [<ffffffff8b003831>] do_syscall_64+0x61/0x1a0
> [<ffffffff8b80012c>] entry_SYSCALL64_slow_path+0x25/0x25
> [<ffffffffffffffff>] 0xffffffffffffffff
> 
> 
> [501568.817936] drbd acd.: meta connection shut down by peer.
> [501568.824466] drbd acd.: peer( Primary -> Unknown ) conn( Connected -> NetworkFailure ) pdsk( UpToDate -> DUnknown ) 
> 

The kernel threads should, but won't, die.
The drbd_ack_receiver is waiting for an already submitted write to the
IO backend (wait_until_done_or_force_detached()),
which blocks it from processing the "ee" (epoch entry) lists.
And the drbd_receiver in turn waits for those lists to become empty.

> This is where I issued a disconnect and drbdsetup hung:
> 
> [502141.512122] drbd acd.: conn( NetworkFailure -> Disconnecting ) 

Which also just tickles the state handling and then waits for the kernel
threads to die. Which they won't, because they are already stuck.

> 7737: cs:Disconnecting ro:Secondary/Unknown ds:UpToDate/DUnknown B r---b-
>     ns:0 nr:20999640 dw:20999624 dr:17532 al:0 bm:0 lo:6 pe:0 ua:0 ap:0 ep:1 wo:f oos:0

DRBD thinks that it has some requests against the local backend open
(lo:6), but has not seen the completion events yet.

Possibly some strange side effect of one of the more recent kernel changes
that resulted in bios submitted via generic make request not to be
actually submitted to the backend but starving on some list,
because we are doing something wrong^W The Old Way, still?

Do you have an "easy" reproducer,
or would be able to do a "bisect",
or manual probing of some relevant kernel versions?

Also, because sometimes during the process of upstreaming some blunder
happens, again the question: in-tree DRBD of the mentioned kernel version?
or out-of-tree DRBD? which git hash?

> [1122622.430869] drbd acd.: peer( Secondary -> Unknown ) conn( Connected -> Timeout ) pdsk( UpToDate -> DUnknown ) 
> [1122622.433721] block drbd7737: new current UUID DCD2BADDEC63176F:8DA7D6114056CFE9:BD3B26ED28251CA1:BD3A26ED28251CA1
> [1122622.435434] drbd acd.: ack_receiver terminated
> [1122622.437149] drbd acd.: Terminating drbd7737_a_acd.
> [1122622.467753] drbd acd.: Connection closed
> [1122622.473915] drbd acd.: conn( Timeout -> Unconnected ) 
> [1122622.479376] drbd acd.: receiver terminated
> [1122622.484620] drbd acd.: Restarting receiver thread
> [1122622.489570] drbd acd.: receiver (re)started
> [1122622.494739] drbd acd.: conn( Unconnected -> WFConnection ) 

> Is there any way I can get it out of this state?

We do have a "force-detach", which should get you out here.
It will leak some objects (those that DRBD thinks are waiting on the
backend IO completion).

> Would you like any additional information to troubleshoot if this is a bug 
> that needs to be fixed?

Yes, please, that sure needs fixing.

"Reproducer would be nice" ;-)

Thanks,

    Lars

