Return-Path: <szymon.madej@nask.pl>
Received: from [195.187.243.214] (twister.nask.waw.pl [195.187.243.214])
	by boromir.nask.net.pl  with ESMTP id jBKEnBFv029496
	for <drbd-dev@lists.linbit.com>; Tue, 20 Dec 2005 15:49:11 +0100 (CET)
Message-ID: <43A819F6.3000505@nask.pl>
Date: Tue, 20 Dec 2005 15:49:26 +0100
From: Szymon Madej <szymon.madej@nask.pl>
MIME-Version: 1.0
To: drbd-dev@linbit.com
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] Problem with DRBD0.7 on Debian Sarge.
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello!

I've strange situation at work today. I was doing reboot of secondary
node in HA HeartBeat cluster, which use DRBD to distributed data, after
recompilation of it's kernel. Old kernel lacks of High Memory Support.
I've recompilled it, installed, recompilled the DRBD module for this
kernel and installed it. Then I've executed lilo to write new bootsector
and rebooted it. Before reboot primary node has consistent data on both
DRBD devices that I'm using: drbd0 and drbd1. After reboot using my new
kernel, (secondary) when DRBD was loaded and connected to primary node
I've received such kernel mesasges (cutted out timestamp and machine name):

kernel: drbd: initialised. Version: 0.7.10 (api:77/proto:74)
kernel: drbd: SVN Revision: 1743 build by root@XXXXXXXX, 2005-09-07 15:31:27
kernel: drbd: registered as block device major 147
kernel: e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
kernel: e1000: eth1: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
kernel: drbd0: resync bitmap: bits=2979411 words=93108
kernel: drbd0: size = 11 GB (11917644 KB)
kernel: drbd0: 0 KB marked out-of-sync by on disk bit-map.
kernel: drbd0: Found 3 transactions (5 active extents) in activity log.
kernel: drbd0: drbdsetup [668]: cstate Unconfigured --> StandAlone
kernel: drbd1: resync bitmap: bits=3180224 words=99382
kernel: drbd1: size = 12 GB (12720896 KB)
kernel: drbd1: 0 KB marked out-of-sync by on disk bit-map.
kernel: drbd1: Found 4 transactions (157 active extents) in activity log.
kernel: drbd1: drbdsetup [672]: cstate Unconfigured --> StandAlone
kernel: drbd0: drbdsetup [690]: cstate StandAlone --> Unconnected
kernel: drbd0: drbd0_receiver [691]: cstate Unconnected --> WFConnection
kernel: drbd1: drbdsetup [698]: cstate StandAlone --> Unconnected
kernel: drbd1: drbd1_receiver [699]: cstate Unconnected --> WFConnection
kernel: drbd0: drbd0_receiver [691]: cstate WFConnection --> WFReportParams
kernel: drbd0: Handshake successful: DRBD Network Protocol version 74
kernel: drbd0: Connection established.
kernel: drbd0: I am(S): 1:00000002:00000001:0000000c:00000001:01
kernel: drbd0: Peer(P): 1:00000002:00000001:0000000d:00000001:10
kernel: drbd0: drbd0_receiver [691]: cstate WFReportParams --> WFBitMapT
kernel: drbd0: Secondary/Unknown --> Secondary/Primary
kernel: drbd1: drbd1_receiver [699]: cstate WFConnection --> WFReportParams
kernel: drbd1: Handshake successful: DRBD Network Protocol version 74
kernel: drbd1: Connection established.
kernel: drbd1: I am(S): 1:00000002:00000001:0000000d:00000002:01
kernel: drbd1: Peer(P): 1:00000002:00000001:0000000e:00000002:10
kernel: drbd1: drbd1_receiver [699]: cstate WFReportParams --> WFBitMapT
kernel: drbd1: Secondary/Unknown --> Secondary/Primary
kernel: drbd1: drbd1_receiver [699]: cstate WFBitMapT --> SyncTarget
kernel: drbd1: Resync started as SyncTarget (need to sync 5268 KB [1317
bits set]).
kernel: drbd0: drbd0_receiver [691]: cstate WFBitMapT --> SyncTarget
kernel: drbd0: Resync started as SyncTarget (need to sync 0 KB [0 bits
set]).
kernel: drbd0: Resync done (total 1 sec; paused 0 sec; 0 K/sec)
kernel: drbd1: sock_recvmsg returned -14
kernel: drbd1: drbd1_receiver [699]: cstate SyncTarget --> BrokenPipe
kernel: drbd1: short read receiving data block: read -14 expected 4096
kernel: drbd1: error receiving RSDataReply, l: 4112!
kernel: drbd1: ASSERT( mdev->resync_work.cb == w_resync_inactive ) in
/usr/src/modules/drbd/drbd/drbd_receiver.c:1773
kernel: drbd1: worker terminated
kernel: drbd1: asender terminated
kernel: drbd0: drbd0_receiver [691]: cstate SyncTarget --> Connected
kernel: drbd1: drbd1_receiver [699]: cstate BrokenPipe --> Unconnected
kernel: drbd1: Connection lost.


On primary node at this moment the logs contains:


kernel: e1000: eth1: e1000_watchdog: NIC Link is Down
kernel: e1000: eth1: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
kernel: drbd0: drbd0_receiver [884]: cstate WFConnection --> WFReportParams
kernel: drbd0: Handshake successful: DRBD Network Protocol version 74
kernel: drbd0: Connection established.
kernel: drbd0: I am(P): 1:00000002:00000001:0000000d:00000001:10
kernel: drbd0: Peer(S): 1:00000002:00000001:0000000c:00000001:01
kernel: drbd0: drbd0_receiver [884]: cstate WFReportParams --> WFBitMapS
kernel: drbd1: drbd1_receiver [892]: cstate WFConnection --> WFReportParams
kernel: drbd0: Primary/Unknown --> Primary/Secondary
kernel: drbd1: Handshake successful: DRBD Network Protocol version 74
kernel: drbd1: Connection established.
kernel: drbd1: I am(P): 1:00000002:00000001:0000000e:00000002:10
kernel: drbd1: Peer(S): 1:00000002:00000001:0000000d:00000002:01
kernel: drbd1: drbd1_receiver [892]: cstate WFReportParams --> WFBitMapS
kernel: drbd1: Primary/Unknown --> Primary/Secondary
kernel: drbd0: drbd0_receiver [884]: cstate WFBitMapS --> SyncSource
kernel: drbd0: Resync started as SyncSource (need to sync 0 KB [0 bits
set]).
kernel: drbd0: Resync done (total 1 sec; paused 0 sec; 0 K/sec)
kernel: drbd0: drbd0_receiver [884]: cstate SyncSource --> Connected
kernel: drbd1: drbd1_receiver [892]: cstate WFBitMapS --> SyncSource
kernel: drbd1: Resync started as SyncSource (need to sync 5268 KB [1317
bits set]).
kernel: drbd1: meta connection shut down by peer.
kernel: drbd1: drbd1_asender [29409]: cstate SyncSource --> NetworkFailure
kernel: drbd1: asender terminated
kernel: drbd1: drbd1_receiver [892]: cstate NetworkFailure --> BrokenPipe
kernel: drbd1: _drbd_send_page: size=4096 len=2640 sent=-104
kernel: drbd1: drbd_send_block() failed
kernel: drbd1: short read expecting header on sock: r=-512
kernel: drbd1: worker terminated
kernel: drbd1: drbd1_receiver [892]: cstate BrokenPipe --> Unconnected
kernel: drbd1: Connection lost.


And then DRBD on both nodes went into infinite loop, trying to be synced.
Both nodes are identical machines, running Debian Sarge with 2.6.8
kernel. DRBD module is compiled and installed from Debian source package
version 0.7.10. The eth0 is primary network device, eth1 is connected to
each other with crossed cable - and used only for DRBD synchronization
and HeartBeat. Both eth0 and eth1 are Intel gigabit cards - using driver
e1000. The only change I've done in kernel is to turn on the High Memory
Support.

Any ideas, what currently has happened? I'm afraid of consistency of my
data - because this cluster contains very important data for the company.

Thanks in advance
Szymon Madej

