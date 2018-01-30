Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
	[209.85.128.196])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E6E091057311
	for <drbd-dev@lists.linbit.com>; Tue, 30 Jan 2018 10:54:33 +0100 (CET)
Received: by mail-wr0-f196.google.com with SMTP id 16so10379745wry.12
	for <drbd-dev@lists.linbit.com>; Tue, 30 Jan 2018 01:54:33 -0800 (PST)
Date: Tue, 30 Jan 2018 10:54:31 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Eric Wheeler <drbd-dev@lists.ewheeler.net>, drbd-dev@lists.linbit.com
Message-ID: <20180130095431.GB9072@soda.linbit>
References: <alpine.LRH.2.11.1801292023200.10022@mail.ewheeler.net>
	<20180130094741.GA9072@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130094741.GA9072@soda.linbit>
Subject: Re: [Drbd-dev] DRBD in Linux v4.14.15 deadlock during disconnect
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

On Tue, Jan 30, 2018 at 10:47:41AM +0100, Lars Ellenberg wrote:
> > Would you like any additional information to troubleshoot if this is a bug 
> > that needs to be fixed?
> 
> Yes, please, that sure needs fixing.
> 
> "Reproducer would be nice" ;-)

Also, you could attach a
grep -r ^ /sys/kernel/debug/drbd 
*before* you force-detach.

There may be something interesting in there, who knows.

    Lars

