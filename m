Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 228B510556AF
	for <drbd-dev@lists.linbit.com>; Thu, 10 Nov 2011 15:02:28 +0100 (CET)
Date: Thu, 10 Nov 2011 15:02:25 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20111110140225.GU15431@barkeeper1-xen.linbit>
References: <CAKicB3iKjDuhvv=Ngyo8U0WhO01qVysHSsg9z3VO3er4V0goSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKicB3iKjDuhvv=Ngyo8U0WhO01qVysHSsg9z3VO3er4V0goSw@mail.gmail.com>
Subject: Re: [Drbd-dev] drbdadm bug in dual-primary/corosync/ocfs cluster
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Nov 10, 2011 at 12:53:52AM -0600, Matthew Christ wrote:
> Hello:
> 
> I'm testing a dual-primary DRBD cluster with corosync and OCFS and I
> get the following bugcheck when a node is fenced, loses power, or
> loses network connectivity. The kernel bugcheck shows up on the
> surviving node: drbd-8.3.10.tar.gz
> 
> Nov  9 23:55:10 vmhost0 external/ipmi[28054]: debug: ipmitool output:
> Chassis Power Control: Reset
> Nov  9 23:55:11 vmhost0 kernel: [ 2391.883321] bnx2 0000:08:00.0:
> eth0: NIC Copper Link is Down
> Nov  9 23:55:11 vmhost0 kernel: [ 2391.902305] br1: port 1(eth0) entering forwarding state
> ...a bunch of crm fencing/resource migration crud.
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.029531] block drbd0: conn( Unconnected -> WFConnection )
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030015] BUG: unable to handle kernel NULL pointer dereference at 0000000000000030
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030019] IP: [<ffffffff8143c48b>] sock_ioctl+0x1f/0x201
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030027] PGD 215908067 PUD 21cda7067 PMD 0
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030031] Oops: 0000 [#2] SMP
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030033] last sysfs file: /sys/fs/ocfs2/loaded_cluster_plugins
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030036] CPU 2
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030037] Modules linked in: ocfs2 ocfs2_nodemanager ocfs2_stack_user ocfs2_stackglue dlm drbd lru_cache ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack ipt_REJECT iptable_mangle iptable_filter ip_tables bnx2
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030049]
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030052] Pid: 28141, comm: drbdadm Tainted: G      D     2.6.38-gentoo-r6STI #4 Dell Inc. PowerEdge 1950/0NK937
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030057] RIP: 0010:[<ffffffff8143c48b>]  [<ffffffff8143c48b>] sock_ioctl+0x1f/0x201
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030061] RSP: 0018:ffff88021ce27e68  EFLAGS: 00010282
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030063] RAX: 0000000000000000 RBX: 0000000000005401 RCX: 00007fff27903490
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030065] RDX: 00007fff27903490 RSI: 0000000000005401 RDI: ffff88021ce69300
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030067] RBP: ffff88021ce27e98 R08: 00007fff279034d0 R09: 00007ff44488ee60
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030070] R10: 00007fff279032b0 R11: 0000000000000202 R12: 00000000ffffffe7
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030072] R13: 00007fff27903490 R14: ffff88021e404840 R15: 0000000000000000
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030075] FS: 00007ff444a91700(0000) GS:ffff8800cf900000(0000) knlGS:0000000000000000
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030077] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030080] CR2: 0000000000000030 CR3: 000000021afa6000 CR4: 00000000000006e0
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030082] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030084] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030087] Process drbdadm (pid: 28141, threadinfo ffff88021ce26000, task ffff8802139fadc0)
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030088] Stack:
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030090]  ffff88021ce27e78 0000000000000246 ffff88021ce69300 00000000ffffffe7
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030094]  00007fff27903490 00007fff27903490 ffff88021ce27f28 ffffffff811286f4
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030098]  ffff88021ce27f78 ffffffff8151309f 0000000000000000 0000000000000000
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030101] Call Trace:
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030108]  [<ffffffff811286f4>] do_vfs_ioctl+0x484/0x4c5
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030113]  [<ffffffff8151309f>] page_fault+0x1f/0x30
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030116]  [<ffffffff81128786>] sys_ioctl+0x51/0x77
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030121]  [<ffffffff8102f93b>] system_call_fastpath+0x16/0x1b
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030123] Code: 00 5b 41 5c 41 5d 41 5e 41 5f c9 c3 55 48 89 e5 41 56 41 55 49 89 d5 41 54 53 89 f3 48 83 ec 10 4c 8b b7 a0 00 00 00 49 8b 46 20 <4c> 8b 60 30 8d 83 10 76 ff ff 83 f8 0f 77 0d 4c 89 e7 e8 4e 3e
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030143] RIP [<ffffffff8143c48b>] sock_ioctl+0x1f/0x201
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030146]  RSP <ffff88021ce27e68>
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.030148] CR2: 0000000000000030
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.033648] ---[ end trace 16ec925abb8aa89d ]---
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.033727] block drbd0: helper command: /sbin/drbdadm fence-peer minor-0 exit code 0 (0x9)
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.033730] block drbd0: fence-peer helper broken, returned 0
> Nov  9 23:55:14 vmhost0 kernel: [ 2394.250451] bnx2 0000:08:00.0: eth0: NIC Copper Link is Up, 1000 Mbps full duplex, receive & transmit
> flow control ON
> 
> * The bug only occurs when fencing 'resource-only' or
> 'resource-and-stonith' is used.
> * Bug occurs in Ubuntu 11.10 and Gentoo, using the stable versions of
> DRBD provided by their respective repositories.
> * Bug occurs with kernel versions 3.1, 3.0, 2.6.39, 2.6.38.
> * Bug occurs when using the provided-by-package 'fence-peer' handler,
> and with the newest 'fence-peer' handler from your git repo.
>
> 
> Everything seems to work fine when I've turn off DRBD's fencing. I
> don't exactly need it with corosync to handle stonith.
> Let me know if you need additional information.

Quoting
http://www.gossamer-threads.com/lists/drbd/users/22218#22218


  >> If you need a workaround for this panic, the best I can offer is to
  >> remove the “altname” specifications from the cluster configuration,
  >> set <totem rrp_mode=”none”> and <dlm protocol=”tcp”>, so that
  >> corosync uses TCP sockets instead of SCTP sockets.

  I am CC David and cluster-devel.
  David maintains DLM in kernel and userland.

  A few quick notes about using RRP/altname in a more general fashion.

  RRP/altname is expected to be Technology Preview state starting from
  RHEL6.2 (the technology will be there for users to test/try but not
  officially supported for production yet). We have not done a lot of
  intensive testing on the overall RHCS stack yet (except corosync, that
  btw does not use DLM) so there might be (== there are) bugs that we will
  have to address. Packages in RHEL6.2/Centos6.2 will have reasonable
  defaults and they are expected to work better (but far from being bug
  free) vs RHEL6.0/Centos6.0.

  It will take sometime before all the stack will be fully
  tested/supported in such environment but it is a work in progress.

  This report is extremely useful and surely will speed up things a lot.

  Thanks
  Fabio

And Dave had to say:

 Re: DLM + SCTP bug (was Re: kernel panic with DRBD: solved)

  ...

  > >> When node A starts back up, the SCTP protocol notices this (as it?s
  > >> supposed to), and delivers an SCTP_ASSOC_CHANGE / SCTP_RESTART
  > >> notification to the SCTP socket, telling the socket owner (the
  > >> dlm_recv thread) that the other node has restarted.
  > >> DLM responds by telling SCTP to create a clone of the master
  > >> socket, for use in communicating with the newly restarted node.
  > >> (This is an SCTP_SOCKOPT_PEELOFF request.)
  > >> And this is where things go wrong:
  > >> the SCTP_SOCKOPT_PEELOFF request is designed to be called from user
  > >> space, not from a kernel thread, and so it /does/ allocate a file
  > >> descriptor for the new socket.
  > >> Since DLM is calling it from a kernel thread, the kernel thread
  > >> now has an open file descriptor (#0) to that socket.
  > >> And since kernel threads share the same file descriptor, every
  > >> kernel thread on the system has this open descriptor.
  > >> So defect #1 is that DLM is calling an SCTP user-space interface
  > >> from a kernel thread, which results in pollution of the kernel
  > >> thread file descriptor table.

  Thanks for that analysis. As you point out, SCTP is only ever really
  used or tested from user space, not from the kernel like the dlm does.
  So I'm not surprised to hear about problems like this.  I don't know
  how difficult it might be to fix that.
  
  I'd also expect to find other problems like it with dlm+sctp.
  
  Some experienced time and attention is probably needed to move the
  dlm's sctp support beyond experimental.

  Dave


Conclusion:
Bug in DLM / corosync SCTP mode
--> don't use SCTP mode.

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
