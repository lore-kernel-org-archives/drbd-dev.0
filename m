Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (unknown [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 0DA5F2E07872
	for <drbd-dev@lists.linbit.com>; Tue, 20 Feb 2007 12:42:25 +0100 (CET)
Resent-Message-ID: <20070220114226.GB7742@soda.linbit>
Received: from RMnet.it (slack.rmnet.it [82.145.99.24])
	by garbage.rmnet.it (8.13.6/8.12.8) with SMTP id l1K5ewwf026562
	for <drbd-dev@lists.linbit.com>; Tue, 20 Feb 2007 06:40:58 +0100
From: Matteo <matteo@RMnet.it>
Message-ID: <1498.151.41.195.37.1171950058.squirrel@webmail.rmnet.it>
Date: Tue, 20 Feb 2007 06:40:58 +0100 (CET)
To: <drbd-dev@lists.linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Drbd-dev] Drbd v7 / v8 problem with Iscsi_target 0.4.14
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi guys,

I'm running test lab with 2 Nas (1Tbyte raid5)serving iscsi vmware esx over
gigabit ethernet w/ jumbos.
Appliance is Openfiler 2.2 plus iscsi modification. Kernel is 2.6.19-3.0.1
(rpath) arch is 32bit.

The problem is that iscsi_target seems to have a problem livin on top of a
drbd block device.

At this time, iscsi_target has good IO performance (up to 60Mb/sec) only
with drbd shutted. if we start drbd on the remote node, the performance of
iscsi_target drammatically drops down to around 1Mb/sec

We tried Drbd version 7.2 and version 8.0 Protocol C (also tried use-bmbv,
or low sync-rate)
We tried iscsi_target revision 58 trough 98 patched with reserve/release.

We tried both fileio and blockio operations without performance differences.
Blockio however helps not use linux cache (iowait processor around 0%)

in addition, vpd manipulation introduces Esx Servers resignaturing problems.
(it's amazing on how dangerous is that)

At this time i've got no idea of how to solve that.

Can anyone comment out?

Any suggestions?
--
so long and thank for all the fish
--matteo



