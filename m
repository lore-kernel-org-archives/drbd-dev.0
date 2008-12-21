Return-Path: <yfrolov@dev.rtsoft.ru>
Message-ID: <494E8946.5020105@dev.rtsoft.ru>
Date: Sun, 21 Dec 2008 21:21:58 +0300
From: Yuri Frolov <yfrolov@dev.rtsoft.ru>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] DRBD gets stuck in BrokenPipe state
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello,

I'm pretty new with DRBD, so forgive me, If I ask something simple or 
well-known.
I've faced with the problem that drbd moves to "BrokenPipe" state and 
never gets out of it.
I've searched the web and found out, that the problem looks to be known, 
but I haven't found a proper solution for 0.7.x series,
have I been missing something, that really exists?
The exact version of code is

# cat /proc/drbd 
version: 0.7.21 (api:79/proto:74)

Here the logs

ncs_pseudo_drbd.out log:
	Tue Mar 18 16:47:03 UTC 2008 In script: get_cs r1 BrokenPipe
	Tue Mar 18 16:47:13 UTC 2008 In script: get_cs r1 BrokenPipe
	Tue Mar 18 16:47:13 UTC 2008 In script: get_cs Broken pipe after multiple retries

syslog:
	Mar 18 16:31:06 F101-SLOT-2 kernel: drbd1: Secondary/Secondary --> Primary/Secondary
	Mar 18 16:45:39 F101-SLOT-2 kernel: drbd1: meta connection shut down by peer.
	Mar 18 16:45:39 F101-SLOT-2 kernel: drbd1: sock was shut down by peer
	Mar 18 16:45:39 F101-SLOT-2 kernel: drbd1: sock_sendmsg returned -32
	Mar 18 16:45:39 F101-SLOT-2 kernel: drbd1: drbd1_asender [4902]: cstate Connected --> NetworkFailure
	Mar 18 16:45:39 F101-SLOT-2 kernel: drbd1: asender terminated
	Mar 18 16:45:39 F101-SLOT-2 kernel: drbd1: drbd1_receiver [4751]: cstate NetworkFailure --> BrokenPipe
	Mar 18 16:45:39 F101-SLOT-2 kernel: drbd1: short read expecting header on sock: r=0
	Mar 18 16:45:39 F101-SLOT-2 kernel: drbd1: drbd1_worker [4725]: cstate BrokenPipe --> BrokenPipe
	Mar 18 16:45:39 F101-SLOT-2 kernel: drbd1: short sent UnplugRemote size=8 sent=0
	Mar 18 16:45:40 F101-SLOT-2 kernel: TIPC: Lost link <1.1.239:bond0-1.1.31:bond0> on network plane A
	Mar 18 16:45:40 F101-SLOT-2 kernel: TIPC: Lost contact with <1.1.31>
	Mar 18 16:47:13 F101-SLOT-2 ncs_scap: NCS_AvSv: Card going for reboot -safComp=ScbRepl,safSu=WibbScb1_SU,safNode=SC_2_14 faulted due to 1 -rcvr=6
		--- Here pdrbd daemon reboot the system because drbd got stuck in BrokenPipe state (as shown in ncs_pseudo_drbd.out logs)

So, is the problem known and the fix exists or it's something new? Could 
you suggest the best place to look at in the sources?

Thank you,
Yuri

