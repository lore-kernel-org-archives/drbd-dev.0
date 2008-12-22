Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 5E2D92E03762
	for <drbd-dev@lists.linbit.com>; Mon, 22 Dec 2008 13:46:06 +0100 (CET)
Date: Mon, 22 Dec 2008 13:46:06 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD gets stuck in BrokenPipe state
Message-ID: <20081222124606.GC7914@barkeeper1-xen.linbit>
References: <494E8946.5020105@dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <494E8946.5020105@dev.rtsoft.ru>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sun, Dec 21, 2008 at 09:21:58PM +0300, Yuri Frolov wrote:
> Hello,
>
> I'm pretty new with DRBD, so forgive me, If I ask something simple or  
> well-known.
> I've faced with the problem that drbd moves to "BrokenPipe" state and  
> never gets out of it.
> I've searched the web and found out, that the problem looks to be known,  
> but I haven't found a proper solution for 0.7.x series,
> have I been missing something, that really exists?

as recently also posted on drbd-user:
drbd 0.7 is seriously end-of-life.
we won't even bother to track down issues in the 0.7 code base.

unless you are a well paying existing customer ;)
and even then we'd persuade you to upgrade.

> The exact version of code is
>
> # cat /proc/drbd version: 0.7.21 (api:79/proto:74)
>
> Here the logs
>
> ncs_pseudo_drbd.out log:
> 	Tue Mar 18 16:47:03 UTC 2008 In script: get_cs r1 BrokenPipe
> 	Tue Mar 18 16:47:13 UTC 2008 In script: get_cs r1 BrokenPipe
> 	Tue Mar 18 16:47:13 UTC 2008 In script: get_cs Broken pipe after multiple retries
>
> syslog:
> 	Mar 18 16:31:06 F101-SLOT-2 kernel: drbd1: Secondary/Secondary --> Primary/Secondary
> 	Mar 18 16:45:39 F101-SLOT-2 kernel: drbd1: meta connection shut down by peer.
> 	Mar 18 16:45:39 F101-SLOT-2 kernel: drbd1: sock was shut down by peer
> 	Mar 18 16:45:39 F101-SLOT-2 kernel: drbd1: sock_sendmsg returned -32
> 	Mar 18 16:45:39 F101-SLOT-2 kernel: drbd1: drbd1_asender [4902]: cstate Connected --> NetworkFailure
> 	Mar 18 16:45:39 F101-SLOT-2 kernel: drbd1: asender terminated
> 	Mar 18 16:45:39 F101-SLOT-2 kernel: drbd1: drbd1_receiver [4751]: cstate NetworkFailure --> BrokenPipe
> 	Mar 18 16:45:39 F101-SLOT-2 kernel: drbd1: short read expecting header on sock: r=0
> 	Mar 18 16:45:39 F101-SLOT-2 kernel: drbd1: drbd1_worker [4725]: cstate BrokenPipe --> BrokenPipe
> 	Mar 18 16:45:39 F101-SLOT-2 kernel: drbd1: short sent UnplugRemote size=8 sent=0
> 	Mar 18 16:45:40 F101-SLOT-2 kernel: TIPC: Lost link <1.1.239:bond0-1.1.31:bond0> on network plane A
> 	Mar 18 16:45:40 F101-SLOT-2 kernel: TIPC: Lost contact with <1.1.31>
> 	Mar 18 16:47:13 F101-SLOT-2 ncs_scap: NCS_AvSv: Card going for reboot -safComp=ScbRepl,safSu=WibbScb1_SU,safNode=SC_2_14 faulted due to 1 -rcvr=6
> 		--- Here pdrbd daemon reboot the system because drbd got stuck in BrokenPipe state (as shown in ncs_pseudo_drbd.out logs)
>
> So, is the problem known and the fix exists or it's something new? Could  
> you suggest the best place to look at in the sources?

sorry, no. drbd 0.7 is dead.
you may try using the latest 0.7, but there are probably a number of
bugs and race conditions left in the 0.7 code base, that will become
more and more likely exposed on newer hardware.

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
