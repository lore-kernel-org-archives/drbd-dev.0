Return-Path: <m@sys4.de>
Received: from mail.sys4.de (mail.sys4.de [194.126.158.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C8AF31051881
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 13:32:11 +0100 (CET)
Received: from localhost (echo.sys4.de [127.0.0.1])
	by mail.sys4.de (Postfix) with ESMTP id 3qTsXB4dB8z1JRk
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 13:32:10 +0100 (CET)
Received: from localhost (tmo-113-80.customers.d1-online.com [80.187.113.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.sys4.de (Postfix) with ESMTPSA id 3qTsX96tw8z1JRf
	for <drbd-dev@lists.linbit.com>; Tue, 22 Mar 2016 13:32:09 +0100 (CET)
Date: Tue, 22 Mar 2016 13:32:07 +0100
From: Marc Schiffbauer <m@sys4.de>
To: drbd-dev@lists.linbit.com
Message-ID: <20160322123207.GJ30157@schiffbauer.net>
References: <20160321231817.GI30157@schiffbauer.net>
	<20160322102517.GG4437@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160322102517.GG4437@soda.linbit>
Subject: Re: [Drbd-dev] integer signedness mixup problem in drbd_main.c
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

* Lars Ellenberg schrieb am 22.03.16 um 11:25 Uhr:
> On Tue, Mar 22, 2016 at 12:18:17AM +0100, Marc Schiffbauer wrote:
> > hi all,
> > 
> > using a kernel hardened with grsecurity/PaX we discovered a problem 
> > where PaX detects a size overflow after a quite large uptime:
> > 
> > PAX: size overflow detected in function drbd_send_dblock 
> > drivers/block/drbd/drbd_main.c:1625 cicus.964_133 max, count: 1
> > 
> > this was in kernel 3.14.19, but 4.4.5 still seems to have that problem.  
> > The line triggering this is:
> > 
> > p->seq_num = cpu_to_be32(atomic_inc_return_unchecked(&mdev->packet_seq));
> 
> Boring.
> seq_num should give it away: it is a sequence number.
> it wraps. that's what sequence numbers do, eventually.
> 
> haven't we been here before?

We had another case that had been fixed.

Thanks Lars for the Feedback.

-Marc

-- 
[*] sys4 AG

http://sys4.de, +49 (89) 30 90 46 64
Franziskanerstraße 15, 81669 München

Sitz der Gesellschaft: München, Amtsgericht München: HRB 199263
Vorstand: Patrick Ben Koetter, Marc Schiffbauer
Aufsichtsratsvorsitzender: Florian Kirstein
