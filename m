Return-Path: <drbd-dev@lists.ewheeler.net>
Received: from mail.ewheeler.net (mx.ewheeler.net [66.155.3.69])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CE4041056F9D
	for <drbd-dev@lists.linbit.com>; Mon, 29 Jan 2018 21:33:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail.ewheeler.net (Postfix) with ESMTP id 3B973A0674
	for <drbd-dev@lists.linbit.com>; Mon, 29 Jan 2018 20:33:27 +0000 (UTC)
Received: from mail.ewheeler.net ([127.0.0.1])
	by localhost (mail.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SOinKlVuBw8y for <drbd-dev@lists.linbit.com>;
	Mon, 29 Jan 2018 20:33:26 +0000 (UTC)
Received: from mx.ewheeler.net (mx.ewheeler.net [66.155.3.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ewheeler.net (Postfix) with ESMTPSA id 8BA6AA066F
	for <drbd-dev@lists.linbit.com>; Mon, 29 Jan 2018 20:33:26 +0000 (UTC)
Date: Mon, 29 Jan 2018 20:33:24 +0000 (UTC)
From: Eric Wheeler <drbd-dev@lists.ewheeler.net>
To: drbd-dev@lists.linbit.com
Message-ID: <alpine.LRH.2.11.1801292023200.10022@mail.ewheeler.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Drbd-dev] DRBD in Linux v4.14.15 deadlock during disconnect
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

Hello all,

We noticed one of our DRBDs went into a NetworkFailure status. We issued a 
drbdadm disconnect and now I cannot get it out of the 'Disconnecting' 
state.

Here are the details on the host that is stuck:

  PID                  STARTED CMD                         STAT
 6842 Tue Jan 23 16:41:52 2018 [drbd_r_acd.]               D
11504 Sun Jan 28 11:06:38 2018 [drbd_a_acd.]               D
21252 Mon Jan 29 12:10:06 2018 drbdsetup-84 disconnect ipv D


These are the contents of /proc/[pid]/stack

=== 6842 ===
[<ffffffff8b0cd0d2>] io_schedule+0x12/0x40
[<ffffffffc0ac042e>] _drbd_wait_ee_list_empty+0x8e/0xd0 [drbd]
[<ffffffffc0ac08fb>] conn_wait_active_ee_empty+0x5b/0xc0 [drbd]
[<ffffffffc0ac9b04>] receive_Barrier+0x74/0x580 [drbd]
[<ffffffffc0acb189>] drbd_receiver+0x139/0x330 [drbd]
[<ffffffffc0ad3860>] drbd_thread_setup+0xa0/0x1c0 [drbd]
[<ffffffff8b0bfe9c>] kthread+0xfc/0x130
[<ffffffff8b800365>] ret_from_fork+0x35/0x40
[<ffffffffffffffff>] 0xffffffffffffffff

=== 11504 ===
[<ffffffffc0ad0629>] wait_until_done_or_force_detached+0xa9/0x210 [drbd]
[<ffffffffc0ad09a1>] drbd_md_sync_page_io+0x211/0x430 [drbd]
[<ffffffffc0ad9d99>] drbd_md_write+0x1a9/0x310 [drbd]
[<ffffffffc0ad9f5d>] drbd_md_sync+0x5d/0x190 [drbd]
[<ffffffffc0ada0d5>] conn_md_sync+0x45/0xa0 [drbd]
[<ffffffffc0acb67a>] drbd_ack_receiver+0x2fa/0x540 [drbd]
[<ffffffffc0ad3860>] drbd_thread_setup+0xa0/0x1c0 [drbd]
[<ffffffff8b0bfe9c>] kthread+0xfc/0x130
[<ffffffff8b800365>] ret_from_fork+0x35/0x40
[<ffffffffffffffff>] 0xffffffffffffffff

=== 21252 ===
[<ffffffffc0adc1eb>] conn_try_disconnect+0x4b/0x100 [drbd]
[<ffffffffc0ae0908>] drbd_adm_disconnect+0xd8/0x150 [drbd]
[<ffffffff8b66912f>] genl_family_rcv_msg+0x1ef/0x3a0
[<ffffffff8b669327>] genl_rcv_msg+0x47/0x90
[<ffffffff8b668502>] netlink_rcv_skb+0xe2/0x110
[<ffffffff8b668d34>] genl_rcv+0x24/0x40
[<ffffffff8b667c6e>] netlink_unicast+0x17e/0x250
[<ffffffff8b66800d>] netlink_sendmsg+0x2cd/0x3c0
[<ffffffff8b60cd80>] sock_sendmsg+0x30/0x40
[<ffffffff8b60ce17>] sock_write_iter+0x87/0x100
[<ffffffff8b24e466>] __vfs_write+0xf6/0x150
[<ffffffff8b24e65d>] vfs_write+0xad/0x1a0
[<ffffffff8b24e8a2>] SyS_write+0x52/0xc0
[<ffffffff8b003831>] do_syscall_64+0x61/0x1a0
[<ffffffff8b80012c>] entry_SYSCALL64_slow_path+0x25/0x25
[<ffffffffffffffff>] 0xffffffffffffffff


[501568.817936] drbd acd.: meta connection shut down by peer.
[501568.824466] drbd acd.: peer( Primary -> Unknown ) conn( Connected -> NetworkFailure ) pdsk( UpToDate -> DUnknown ) 


This is where I issued a disconnect and drbdsetup hung:

[502141.512122] drbd acd.: conn( NetworkFailure -> Disconnecting ) 


7737: cs:Disconnecting ro:Secondary/Unknown ds:UpToDate/DUnknown B r---b-
    ns:0 nr:20999640 dw:20999624 dr:17532 al:0 bm:0 lo:6 pe:0 ua:0 ap:0 ep:1 wo:f oos:0

================

On the peer node that is not stuck, these are its details:

7737: cs:StandAlone ro:Primary/Unknown ds:UpToDate/DUnknown   r-----
    ns:36287872 nr:189036 dw:36573040 dr:41806048 al:661 bm:0 lo:0 pe:0 ua:0 ap:0 ep:1 wo:f oos:74888


[1122622.430869] drbd acd.: peer( Secondary -> Unknown ) conn( Connected -> Timeout ) pdsk( UpToDate -> DUnknown ) 
[1122622.433721] block drbd7737: new current UUID DCD2BADDEC63176F:8DA7D6114056CFE9:BD3B26ED28251CA1:BD3A26ED28251CA1
[1122622.435434] drbd acd.: ack_receiver terminated
[1122622.437149] drbd acd.: Terminating drbd7737_a_acd.
[1122622.467753] drbd acd.: Connection closed
[1122622.473915] drbd acd.: conn( Timeout -> Unconnected ) 
[1122622.479376] drbd acd.: receiver terminated
[1122622.484620] drbd acd.: Restarting receiver thread
[1122622.489570] drbd acd.: receiver (re)started
[1122622.494739] drbd acd.: conn( Unconnected -> WFConnection ) 


This is where we disconnected on the peer node that is not stuck:

[1123338.139536] drbd acd.: conn( WFConnection -> Disconnecting ) 
[1123338.139544] drbd acd.: Discarding network configuration.
[1123338.167479] drbd acd.: Connection closed
[1123338.171652] drbd acd.: conn( Disconnecting -> StandAlone ) 
[1123338.175511] drbd acd.: receiver terminated
[1123338.179242] drbd acd.: Terminating drbd7737_r_acd.



Is there any way I can get it out of this state?

Would you like any additional information to troubleshoot if this is a bug 
that needs to be fixed?

-Eric

--
Eric Wheeler
