Return-Path: <Lars.Ellenberg@linbit.com>
Received: from barkeeper1 (unknown [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 394CD2E051AF
	for <drbd-dev@lists.linbit.com>; Tue, 13 Mar 2007 23:59:56 +0100 (CET)
Date: Tue, 13 Mar 2007 23:59:56 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] make KDIR=... kernel-patch fails
Message-ID: <20070313225956.GB29914@barkeeper1.linbit>
References: <45F1DCB7.3020303@aj.net-lab.net>
	<20070310114246.GA26492@barkeeper1.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070310114246.GA26492@barkeeper1.linbit>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2007-03-10 12:42:46 +0100
\ Lars Ellenberg:
> / 2007-03-09 23:16:23 +0100
> \ Andreas John:

> > buildbox-etch:/usr/src/linux-vserver/linux-2.6.20.1/drbd-8.0.1# make
> > KDIR=/usr/src/linux-vserver/linux-2.6.20.1 kernel-patch

> > scripts/patch-kernel

> thanks for the report.
> sorry, but I "officially don't care" right now.
> though, we will do some effort later this year
> to try and get drbd into the kernel.org kernel.
> so when I have time, I'll have a look.

please try again with current svn.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
