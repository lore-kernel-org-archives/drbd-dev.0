Return-Path: <ard@kwaak.net>
Received: from mail.kwaak.net (gw-cistron.kwaak.net [62.216.22.210])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id D53A72D9DFA1
	for <drbd-dev@lists.linbit.com>; Sun, 28 Jan 2007 12:09:12 +0100 (CET)
Received: from ard by mail.kwaak.net with local (Exim 4.50) id 1HB7l4-0005UX-1B
	for drbd-dev@lists.linbit.com; Sun, 28 Jan 2007 11:59:38 +0100
Date: Sun, 28 Jan 2007 11:59:38 +0100
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] oopses in 2.6.19.1
Message-ID: <20070128105938.GH9639@kwaak.net>
References: <20070110123116.GX15730@kwaak.net>
	<20070111171205.GC15730@kwaak.net>
	<20070111180322.GD15730@kwaak.net>
	<200701151806.20526.philipp.reisner@linbit.com>
	<20070116103749.GD9639@kwaak.net> <20070125174523.GD9639@kwaak.net>
	<20070125213210.GK7738@soda.linbit>
	<20070125222630.GC8857@soda.linbit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070125222630.GC8857@soda.linbit>
From: Ard van Breemen <ard@kwaak.net>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,
On Thu, Jan 25, 2007 at 11:26:30PM +0100, Lars Ellenberg wrote:
> (not dared to commit this, in case this all was nonsense...
> I feel too tired now)
Thanks to this patch the machines don't crash anymore.
But:
Primary:
SVN Revision: 2713 build by ard@siddev, 2007-01-26 15:41:35
 0: cs:Connected st:Primary/Secondary ds:UpToDate/UpToDate C r---
    ns:1159294952 nr:0 dw:0 dr:1159294952 al:0 bm:70758 lo:0 pe:0 ua:0 ap:0
        resync: used:0/31 hits:72385178 misses:70758 starving:0 dirty:0 changed:70758
        act_log: used:0/127 hits:0 misses:0 starving:0 dirty:0 changed:0

Secondary:
SVN Revision: 2713 build by ard@siddev, 2007-01-26 15:41:35
 0: cs:SyncTarget st:Secondary/Primary ds:Inconsistent/UpToDate C r---
    ns:0 nr:1159294952 dw:1159294952 dr:0 al:0 bm:70758 lo:0 pe:0 ua:0 ap:0
        [===================>] sync'ed:100.0% (0/1132123)M
        stalled
        resync: used:28/31 hits:72385178 misses:70758 starving:0 dirty:0 changed:70758
        act_log: used:0/127 hits:0 misses:0 starving:0 dirty:0 changed:0

The dmesg on the secondary:
Jan 27 19:19:52 localhost kernel: drbd0: Began resync as SyncTarget (will sync 1159294952 KB [289823738 bits s
Jan 27 19:19:52 localhost kernel: drbd0: Writing meta data super block now.
Jan 27 19:30:37 localhost kernel: drbd0: drbd_rs_complete_io(,85553088 [=2610]) called, but refcnt is 0!?
Jan 27 19:35:11 localhost kernel: drbd0: drbd_rs_complete_io(,122285888 [=3731]) called, but refcnt is 0!?
<snip>
Jan 27 23:26:15 localhost kernel: drbd0: drbd_rs_complete_io(,1931640128 [=58948]) called, but refcnt is 0!?
Jan 27 23:33:21 localhost kernel: drbd0: drbd_rs_complete_io(,1982954432 [=60514]) called, but refcnt is 0!?
Jan 27 23:33:52 localhost kernel: drbd0: drbd_rs_complete_io(,1986625472 [=60626]) called, but refcnt is 0!?
Jan 27 23:37:53 localhost kernel: drbd0: drbd_rs_complete_io(,2014511040 [=61477]) called, but refcnt is 0!?
Jan 28 00:29:53 localhost kernel: drbd0: Retrying drbd_rs_del_all() later. refcnt=1
Jan 28 00:30:24 localhost last message repeated 294 times
Jan 28 00:31:25 localhost last message repeated 584 times

From that point on that message is repeated over and over...

Regards,
Ard van Breemen
