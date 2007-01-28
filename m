Return-Path: <ard@kwaak.net>
Received: from mail.kwaak.net (gw-cistron.kwaak.net [62.216.22.210])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 175582D9DFA1
	for <drbd-dev@lists.linbit.com>; Sun, 28 Jan 2007 12:39:00 +0100 (CET)
Received: from ard by mail.kwaak.net with local (Exim 4.50) id 1HB8N5-0005F6-9N
	for drbd-dev@lists.linbit.com; Sun, 28 Jan 2007 12:38:55 +0100
Date: Sun, 28 Jan 2007 12:38:55 +0100
From: Ard van Breemen <ard@kwaak.net>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] oopses in 2.6.19.1
Message-ID: <20070128113855.GI9639@kwaak.net>
References: <20070110123116.GX15730@kwaak.net>
	<20070111171205.GC15730@kwaak.net>
	<20070111180322.GD15730@kwaak.net>
	<200701151806.20526.philipp.reisner@linbit.com>
	<20070116103749.GD9639@kwaak.net> <20070125174523.GD9639@kwaak.net>
	<20070125213210.GK7738@soda.linbit>
	<20070125222630.GC8857@soda.linbit>
	<20070128105938.GH9639@kwaak.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070128105938.GH9639@kwaak.net>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,
On Sun, Jan 28, 2007 at 11:59:38AM +0100, Ard van Breemen wrote:
From that point on that message is repeated over and over...
What makes it even more interesting:
siep:~# drbdadm down all
Child process does not terminate!
Exiting.
siep:~# No response from the DRBD driver! Is the module loaded?
No response from the DRBD driver! Is the module loaded?
State change failed: (0)unknown error.
cat /proc/drbd 
version: 8.0.0 (api:86/proto:86)
SVN Revision: 2713 build by ard@siddev, 2007-01-26 15:41:35
 0: cs:SyncTarget st:Secondary/Primary ds:Inconsistent/UpToDate C r---
    ns:0 nr:1297904392 dw:1297901288 dr:0 al:0 bm:79217 lo:97 pe:3444 ua:97 ap:0
        [==>.................] sync'ed: 12.0% (996766/1132123)M
        finish: 3:34:10 speed: 79,384 (71,408) K/sec
        resync: used:11/31 hits:81043148 misses:79225 starving:0 dirty:0 changed:79225
        act_log: used:0/127 hits:0 misses:0 starving:0 dirty:0 changed:0

(siep in this case is the slave)

So: on drbdadm down all, the system starts to sync again...

We've got a dmesg for that:
Jan 28 06:47:02 localhost kernel: drbd0: Retrying drbd_rs_del_all() later. refcnt=1
Jan 28 06:47:33 localhost last message repeated 295 times
<snip>
Jan 28 11:59:54 localhost last message repeated 501 times
Jan 28 11:59:54 localhost kernel: drbd0: peer( Primary -> Unknown ) conn( SyncTarget -> Disconnecting ) pdsk( 
Jan 28 11:59:54 localhost kernel: drbd0: short read expecting header on sock: r=-512
Jan 28 11:59:54 localhost kernel: drbd0: asender terminated
Jan 28 11:59:54 localhost kernel: drbd0: Retrying drbd_rs_del_all() later. refcnt=1
Jan 28 11:59:54 localhost kernel: drbd0: Resync done (total 60002 sec; paused 0 sec; 0 K/sec)
Jan 28 11:59:54 localhost kernel: drbd0: conn( Disconnecting -> Connected ) disk( Inconsistent -> UpToDate ) p
Jan 28 11:59:54 localhost kernel: drbd0: Writing meta data super block now.
Jan 28 11:59:54 localhost kernel: drbd0: tl_clear()
Jan 28 11:59:54 localhost kernel: drbd0: Connection closed
Jan 28 11:59:54 localhost kernel: drbd0: conn( Connected -> Unconnected ) pdsk( UpToDate -> DUnknown ) 
Jan 28 11:59:54 localhost kernel: drbd0: drbdd_init: (mdev->receiver.t_state != Restarting) in /usr/src/shared
Jan 28 11:59:54 localhost kernel: drbd0: receiver terminated
Jan 28 11:59:54 localhost kernel: drbd0: receiver (re)started
Jan 28 11:59:54 localhost kernel: drbd0: conn( Unconnected -> WFConnection ) 
Jan 28 11:59:54 localhost kernel: drbd0: conn( WFConnection -> WFReportParams ) 
Jan 28 11:59:54 localhost kernel: drbd0: Handshake successful: DRBD Network Protocol version 86
Jan 28 11:59:54 localhost kernel: drbd0: Peer authenticated using 20 bytes of 'sha1' HMAC
Jan 28 11:59:54 localhost kernel: drbd0: Writing meta data super block now.
Jan 28 11:59:55 localhost kernel: drbd0: writing of bitmap took 93 jiffies
Jan 28 11:59:55 localhost kernel: drbd0: 1105 GB marked out-of-sync by on disk bit-map.
Jan 28 11:59:55 localhost kernel: drbd0: 1159294952 KB now marked out-of-sync by on disk bit-map.
Jan 28 11:59:55 localhost kernel: drbd0: Writing meta data super block now.
Jan 28 11:59:55 localhost kernel: drbd0: peer( Unknown -> Primary ) conn( WFReportParams -> WFBitMapT ) pdsk( 
Jan 28 11:59:55 localhost kernel: drbd0: Writing meta data super block now.
Jan 28 11:59:56 localhost kernel: drbd0: conn( WFBitMapT -> WFSyncUUID ) 
Jan 28 11:59:56 localhost kernel: drbd0: conn( WFSyncUUID -> SyncTarget ) disk( UpToDate -> Inconsistent ) 
Jan 28 11:59:56 localhost kernel: drbd0: Began resync as SyncTarget (will sync 1159294952 KB [289823738 bits s
Jan 28 11:59:56 localhost kernel: drbd0: Writing meta data super block now.
Jan 28 12:07:46 localhost kernel: drbd0: drbd_rs_complete_io(,67857280 [=2070]) called, but refcnt is 0!?
Jan 28 12:12:24 localhost kernel: drbd0: drbd_rs_complete_io(,107445120 [=3278]) called, but refcnt is 0!?

So the patch of Lars makes the system not crash :-).
If anyone can hint where I have to infest the code with some printk's and
hopefully some explanation of what to look for, I might be able to track it
down. Unfortunately I only have about 10% resources left in my head to look at
it :-(.
