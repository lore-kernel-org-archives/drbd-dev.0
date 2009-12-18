Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 015B81072F03
	for <drbd-dev@lists.linbit.com>; Fri, 18 Dec 2009 15:34:07 +0100 (CET)
Resent-Message-ID: <20091218143407.GI26616@barkeeper1-xen.linbit>
From: "Kaloyan Kovachev" <kkovachev@varna.net>
To: drbd-user@lists.linbit.com
Date: Fri, 18 Dec 2009 14:04:17 +0200
Message-Id: <20091218104232.M76499@varna.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=windows-1251
Subject: [Drbd-dev] Concurrent writes
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello list,
 i have found an old tread about our problem back from April and the last
message from October (at the end of the email, so sorry for top posting) with
a hint to our setup.

 The setup:
 cluster with 2 nodes and 2 storages - Stor1 and Stor2 (part of the cluster =
4 nodes total)
 several LVM volumes replicated via DRBD (8.3.2) in active/active and exported
via IET as blockio then imported from all cluster members (including the
storages) from both storages at the same time and multipath used in multibus
mode from all.

 The problem:
 Not tested with other DRBD versions, but at least with different kernels the
results are the same.
 When cman is stopped on one/any of the storages i get in the logs for both of
them:
"block drbd0: istiod1[2739] Concurrent local write detected! [DISCARD L] new:
0s +1024; pending: 0s +1024"
 it is always for drbd0 (actively used from all active nodes) and always for
0s +1024

 My guess is that this is caused from multipath checking for the disk being
alive, but if so it should also happen when cman is running or for other
volumes too not?

P.S. please CC me as i am not subscribed to the list

------------ the last message in the tread --------------------------
Gennadiy,

I realize it's been a while since this issue was discussed last, but
we're still trying to hunt this down. I realize this is asking a lot,
but do you happen to still have the drbd.conf available from back in
April? It was unfortunately never posted in the thread.

Specifically, I'm curious as to whether you were using dual-Primary mode
at the time (allow-two-primaries).

Thanks!

Cheers,
Florian

On 2009-04-22 00:09, Gennadiy Nerubayev wrote:
> On Tue, Apr 21, 2009 at 5:39 PM, Roof, Morey R. <MRoof at admin.nmt.edu
> <mailto:MRoof at admin.nmt.edu>> wrote:
> 
>     The Initiators I use are: VMWare ESX 3.0.x, VMWare ESX 3.5.x, Micrsoft
>     iSCSI Initiator 2.08, and Linux (RHEL 5, SUSE 10).
> 
>     I gave SQLIO a run with your params and I'm not getting the concurrent
>     write issue.
> 
> 
> The bizarreness continues; downgrading DRBD is of no help either :( 
> Although, it is encouraging in a way suggesting that this might be
> finally isolated. I assume you're checking the logs of the primary node?
> 
>     The hardware I run DRBD is a pair of HP Proliant DL380 G4 servers with
>     12GB of RAM and P600 SAS controllers.  The machines are currently
>     replicating 1.8TB of data.  I run DRBD under SuSE 10SP2 and use IET
>     stock from SuSE but the DRBD is 8.0.16.
> 
> 
>  What is the kernel version on the target? Version of Windows on the
> initiator? Could you share the relevant portions of ietd.conf and drbd.conf?
> 
> Thanks,
> 
> -Gennadiy
