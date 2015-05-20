Return-Path: <dietmar@proxmox.com>
Received: from proxmox.maurer-it.com (proxmox.maurer-it.com [94.136.31.133])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E7EE81051881
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 14:25:43 +0200 (CEST)
Date: Wed, 20 May 2015 14:25:41 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: Roland Kammerer <roland.kammerer@linbit.com>, drbd-dev@lists.linbit.com
Message-ID: <1529837518.111.1432124741450.JavaMail.open-xchange@ronja.mits.lan>
In-Reply-To: <20150520120147.GV1968@rck.sh>
References: <1335158101.57.1432118468143.JavaMail.open-xchange@ronja.mits.lan>
	<20150520120147.GV1968@rck.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] howto enable auto-promote
Reply-To: Dietmar Maurer <dietmar@proxmox.com>
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


> Auto-promote is enabled. As you can see it failed, and it can only fail
> if it was enabled... Your problem is the "multiple primaries" thingy.
> Please tell us which drbdmanage commands you executed. 

What commands? The idea is that 'auto-promote' works without any commands.
So I just start the kvm VM on the second node, which tries to open the device.

So I tried to enable allow-two-primaries somehow. Adding it 
to /etc/drbd.d/global_common.conf did not help. Then I tried:

# drbdadm net-options --allow-two-primaries=yes vm-100-disk-1

on each node, and it seems to work now.

So where is the right place to set allow-two-primaries for 
volumes managed by drbdmanage? 

And why is that disabled by default? 

