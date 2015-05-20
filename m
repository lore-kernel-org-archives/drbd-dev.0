Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 13C131045C28
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 14:48:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 05E4644CA95
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 14:48:38 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Ib3ESt35g6OH for <drbd-dev@lists.linbit.com>;
	Wed, 20 May 2015 14:48:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B79DC44CFEB
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 14:48:37 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id as5Rm8_KBn8E for <drbd-dev@lists.linbit.com>;
	Wed, 20 May 2015 14:48:37 +0200 (CEST)
Received: from localhost (chello213047144126.1.15.vie.surfer.at
	[213.47.144.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id 8C73D44CA95
	for <drbd-dev@lists.linbit.com>; Wed, 20 May 2015 14:48:37 +0200 (CEST)
Date: Wed, 20 May 2015 14:48:36 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20150520124836.GX1968@rck.sh>
References: <1335158101.57.1432118468143.JavaMail.open-xchange@ronja.mits.lan>
	<20150520120147.GV1968@rck.sh>
	<1529837518.111.1432124741450.JavaMail.open-xchange@ronja.mits.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529837518.111.1432124741450.JavaMail.open-xchange@ronja.mits.lan>
Subject: Re: [Drbd-dev] howto enable auto-promote
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

On Wed, May 20, 2015 at 02:25:41PM +0200, Dietmar Maurer wrote:
> 
> > Auto-promote is enabled. As you can see it failed, and it can only fail
> > if it was enabled... Your problem is the "multiple primaries" thingy.
> > Please tell us which drbdmanage commands you executed. 
> 
> What commands? The idea is that 'auto-promote' works without any commands.
> So I just start the kvm VM on the second node, which tries to open the device.
> 
> So I tried to enable allow-two-primaries somehow. Adding it 
> to /etc/drbd.d/global_common.conf did not help. 

You probably forgot to "drbdadm adjust"...

> Then I tried:
> 
> # drbdadm net-options --allow-two-primaries=yes vm-100-disk-1
> 
> on each node, and it seems to work now.
> 
> So where is the right place to set allow-two-primaries for 
> volumes managed by drbdmanage? 

Passing these "generic drbd options" to drbdmanage is work in progress.
I expect it to be finished for the next release. 

> And why is that disabled by default? 
> 

Oh, because you really really have to know if two primiaries are a good
idea. Allowing multiple primaries is definitely nothing that should be
enabled by default.

Regards, rck

Again: Please no TO/CC, and please ask such questions on drbd-user.
