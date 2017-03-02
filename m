Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f177.google.com (mail-wr0-f177.google.com
	[209.85.128.177]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8C2651056484
	for <drbd-dev@lists.linbit.com>; Thu,  2 Mar 2017 22:33:14 +0100 (CET)
Received: by mail-wr0-f177.google.com with SMTP id g10so61748355wrg.2
	for <drbd-dev@lists.linbit.com>; Thu, 02 Mar 2017 13:33:14 -0800 (PST)
Received: from soda.linbit ([86.59.100.100])
	by smtp.gmail.com with ESMTPSA id 36sm12406404wrz.8.2017.03.02.13.33.13
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 02 Mar 2017 13:33:13 -0800 (PST)
Date: Thu, 2 Mar 2017 22:33:12 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20170302213312.GL10667@soda.linbit>
References: <alpine.LRH.2.11.1702281620050.16946@mail.ewheeler.net>
	<20170301130614.GH10667@soda.linbit>
	<alpine.LRH.2.11.1703011211010.6659@mail.ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LRH.2.11.1703011211010.6659@mail.ewheeler.net>
Subject: Re: [Drbd-dev] BUG: NULL pointer dereference triggered by drbdsetup
 events2
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

On Wed, Mar 01, 2017 at 01:36:55PM -0800, Eric Wheeler wrote:
> On Wed, 1 Mar 2017, Lars Ellenberg wrote:
> 
> > On Tue, Feb 28, 2017 at 04:28:46PM -0800, Eric Wheeler wrote:
> > > Hello all,
> > > 
> > > We found a relatively easy to reproduce bug that crashes the kernel. Start 
> > > with all of the resources down and only the DRBD module loaded and run the 
> > > following:
> > > 
> > > drbdadm up foo
> > > drbdsetup events2 foo | true
> > > drbdadm down foo; ls -d /sys/devices/virtual/bdi/147:7740
> > > drbdadm up foo
> > > 
> > > The backtrace is below. The ls above simply illustrates the problem. After 
> > > a down, the sysfs entry should not exist. The bug manifests because 
> > > add_disk attempts to create the same sysfs entry but it cannot and fails 
> > > up the stack. I have a feeling that the interface used by events2 is 
> > > holding open a reference count after down so the sysfs entry is never 
> > > removed.
> > > 
> > > We are piping into true because it fails quickly without reading any 
> > > stdio, so perhaps the kernel is blocked trying to flush a buffer into 
> > > userspace and never releases a resource count (speculation).
> > > 
> > > This was tested using the 4.10.1 kernel with userspace tools 
> > > drbd-utils-8.9.4. I suspect this could be worked around in userspace, but 
> > > it would be ideal if the kernel module could be fixed up to prevent a 
> > > crash.
> > > 
> > > Please let me know if you need additional information or if I can provide 
> > > any other testing.
> > > 
> > > Thank you for your help!
> > 
> > The "events2" part of drbd 8.4 was a "backport" from drbd 9.
> > I found this apparently relevant commit in our DRBD 9 repo.
> > 
> > In our out-of-tree 8.4 code, we later dropped the .done parts again,
> > for compat with RHEL 5, which is likely why this fix fell through.
> > 
> > I basically only re-diffed and compile-tested for current upstream kernel.
> > Does this help already, or do we need to dig deeper?
> 
> Hi Lars,
> 
> Thank you for responding so quickly!
> 
> The events2 feature is neat, it allows us to prevent polling and provide 
> better responsiveness in our infrastructure. We applied the patch and this 
> is what we found:
> 
> It no longer crashes the kernel with a null pointer dereference, but now 
> the drbdsetup calls never leave the kernel. The first time we ran the test 
> case it worked fine, but the second time 'drbdadm down foo' hung. I 
> checked the stack traces inside the kernel for each process that is hung 
> and have also included the output of this test:
> 
> 
> # This test succeeded
> ~]# drbdadm up foo
> ~]# drbdsetup events2 foo | true
> ~]# drbdadm down foo; ls -d /sys/devices/virtual/bdi/147:7740
> ls: cannot access /sys/devices/virtual/bdi/147:7740: No such file or directory
> ~]# drbdadm up foo

right.

> # This test failed
> ~]# drbdsetup events2 foo | true
> ~]# drbdadm down foo; ls -d /sys/devices/virtual/bdi/147:7740
> Command 'drbdsetup-84 down foo' did not terminate within 600 seconds
> /sys/devices/virtual/bdi/147:7740
> ~]# drbdadm up foo
> Command 'drbdsetup-84 new-resource foo --on-no-data-accessible=suspend-io' did not terminate within 5 seconds

There is something else going on here.

> The second test that failed left hung drbdsetup processes:
> 
> ~]# ps ax |grep drbdsetup-84
>  1579 pts/0    D      0:00 drbdsetup-84 down foo
>  1585 ?        D      0:00 drbdsetup-84 role 7740

Where is that "role" coming from?

>  1737 pts/0    D      0:00 drbdsetup-84 new-resource foo --on-no-data-accessible=suspend-io
> 
> These are the in-kernel stack traces for each pid:
> 
> ##### 1579 pts/0    D+     0:00 drbdsetup-84 down foo
> [root@hvtest2 ~]# cat /proc/1579/stack 
> [<ffffffff81102a8c>] wait_rcu_gp+0x5c/0x80
> [<ffffffff81106685>] synchronize_sched+0x45/0x60
> [<ffffffffa02a8ca2>] adm_del_resource+0xf2/0x110 [drbd]

Hm.
That's just doing a synchronize_rcu().

> [<ffffffffa02ab5f3>] drbd_adm_down+0x233/0x240 [drbd]
> [<ffffffff8161235d>] genl_family_rcv_msg+0x1cd/0x400
> [<ffffffff81612621>] genl_rcv_msg+0x91/0xd0
> [<ffffffff816113f1>] netlink_rcv_skb+0xc1/0xe0
> [<ffffffff81611adc>] genl_rcv+0x2c/0x40
> [<ffffffff81610a76>] netlink_unicast+0x106/0x210
> [<ffffffff81610fb4>] netlink_sendmsg+0x434/0x690

> ##### 1585 ?        D      0:00 drbdsetup-84 role 7740
> ~]# cat /proc/1585/stack
> [<ffffffff81612658>] genl_rcv_msg+0xc8/0xd0

This is likely waiting for the "genl_lock()".

> [<ffffffff816113f1>] netlink_rcv_skb+0xc1/0xe0
> [<ffffffff81611adc>] genl_rcv+0x2c/0x40
> [<ffffffff81610a76>] netlink_unicast+0x106/0x210
> [<ffffffff81610fb4>] netlink_sendmsg+0x434/0x690

> ##### 1737 pts/0    D      0:00 drbdsetup-84 new-resource foo --on-no-data-accessible=suspend-io
> ~]# cat /proc/1737/stack 
> [<ffffffff81612658>] genl_rcv_msg+0xc8/0xd0

The same.

> [<ffffffff816113f1>] netlink_rcv_skb+0xc1/0xe0
> [<ffffffff81611adc>] genl_rcv+0x2c/0x40
> [<ffffffff81610a76>] netlink_unicast+0x106/0x210
> [<ffffffff81610fb4>] netlink_sendmsg+0x434/0x690

The two drbdsetup waiting for genl_lock()
are maybe ugly, but expected in this,
as the drbdsetup down still holds it.

Question is: why does that down not make progress,
Why does the rcu grace period not make progress?

Anything suspicious in the logs before that?

> Please let me know if you would like any additional information.

Just as an additional data point,
can you try to reproduce with our out-of-tree DRBD 8.4 git?
(plus that .done() fix... I did not yet push it)


-- 
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD® and LINBIT® are registered trademarks of LINBIT
