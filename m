Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3B504100EC11
	for <drbd-dev@lists.linbit.com>; Mon, 11 May 2015 09:49:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 2FA2B305694
	for <drbd-dev@lists.linbit.com>; Mon, 11 May 2015 09:49:01 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id XbPNw2zi-Tlz for <drbd-dev@lists.linbit.com>;
	Mon, 11 May 2015 09:49:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 14AD230CB1C
	for <drbd-dev@lists.linbit.com>; Mon, 11 May 2015 09:49:01 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Dm0YzLTa8qxY for <drbd-dev@lists.linbit.com>;
	Mon, 11 May 2015 09:49:01 +0200 (CEST)
Received: from localhost (chello213047144126.1.15.vie.surfer.at
	[213.47.144.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id E1C33305694
	for <drbd-dev@lists.linbit.com>; Mon, 11 May 2015 09:49:00 +0200 (CEST)
Date: Mon, 11 May 2015 09:49:00 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20150511074859.GU1968@rck.sh>
References: <1676265523.49.1431326660324.JavaMail.open-xchange@ronja.mits.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1676265523.49.1431326660324.JavaMail.open-xchange@ronja.mits.lan>
Subject: Re: [Drbd-dev] drbdmanage package name
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

On Mon, May 11, 2015 at 08:44:20AM +0200, Dietmar Maurer wrote:
> I just saw that you name the package 'python-drbdmanage'.
> 
> > Package: python-drbdmanage
> 
> Why don't you simply call it 'drbdmanage'?
> 
> IMHO, adding 'python' would be OK for a python library, but not 
> for a binary package?

AFAIK the initial Debian packaging came from a Debian upstream guy and I
adopted his initial naming convention.

The Debian python packaging guide states:
"Binary packages with public modules should follow python-modulename
naming schema[...].[1]

Currently, it is a "frankenstein-package" anyways, because it contains
the server, the modules which could be used for example to write your
own client, and the client itself...

I will keep it in mind and think about renaming/splitting.

Regards, rck

[1] https://wiki.debian.org/Python/Packaging
