Return-Path: <dietmar@proxmox.com>
Received: from proxmox.maurer-it.com (proxmox.maurer-it.com [94.136.31.133])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D8761100EBF0
	for <drbd-dev@lists.linbit.com>; Mon, 11 May 2015 10:43:44 +0200 (CEST)
Date: Mon, 11 May 2015 10:43:38 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: Roland Kammerer <roland.kammerer@linbit.com>, drbd-dev@lists.linbit.com
Message-ID: <1348675331.157.1431333818922.JavaMail.open-xchange@ronja.mits.lan>
In-Reply-To: <20150511074859.GU1968@rck.sh>
References: <1676265523.49.1431326660324.JavaMail.open-xchange@ronja.mits.lan>
	<20150511074859.GU1968@rck.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] drbdmanage package name
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

> Currently, it is a "frankenstein-package" anyways, because it contains
> the server, the modules which could be used for example to write your
> own client, and the client itself...
> 
> I will keep it in mind and think about renaming/splitting.

Yes, I guess you should split the package if it contains a library.
But the package with the binary toolkit should be called 'drbdmanage',
an sections should be 'admin' instead of 'python'.

I also noticed that you do not apply the quilt patches, which is good because 
the included patches are out of date. I suggest to remove patch
0001-var-lib-drbdd.patch from debian/patches/series to avoid confusion.

 

