Return-Path: <helmut@wollmersdorfer.at>
Received: from viefep15-int.chello.at (viefep15-int.chello.at [213.46.255.19])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id ABB2A14314
	for <drbd-dev@lists.linbit.com>; Thu, 21 Oct 2004 14:36:16 +0200 (CEST)
Received: from wollmersdorfer.at ([212.186.65.148]) by viefep15-int.chello.at
	(InterMail vM.6.01.03.04 201-2131-111-106-20040729) with ESMTP
	id <20041021123616.KKPN6911.viefep15-int.chello.at@wollmersdorfer.at>
	for <drbd-dev@lists.linbit.com>; Thu, 21 Oct 2004 14:36:16 +0200
Message-ID: <4177AD40.9070209@wollmersdorfer.at>
Date: Thu, 21 Oct 2004 14:36:16 +0200
From: Helmut Wollmersdorfer <helmut@wollmersdorfer.at>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] user interface test of drbd.conf
References: <41768F97.60206@wollmersdorfer.at>
	<PYb2hAVM47FNy9iVUnme8JY=lge@web.de>
In-Reply-To: <PYb2hAVM47FNy9iVUnme8JY=lge@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Lars Ellenberg wrote:
> / 2004-10-20 18:17:27 +0200
> \ Helmut Wollmersdorfer:

>>wfc-timeout
[...]
>>100000 valid passed

>>Problem description: Very high, maybe senseless values are accepted.

> should we limit it to three days?

Seems very high for a HA-System. On the other hand maybe someone wants 
the system to wait for a whole weekend.

3 days = 259200 seconds. I would like an easier to remember plain value 
like 100000, 200000 or 300000.

> I don't get the next sentence:

>>From my experience as tester I will not expect, that _any_ values will 
>>work correctly without "dry-run".

> hm?

Very easy explanation:
As we all know, usally numbers represented in text are converted to an 
easier to handle representation inside a program. This can be hex, 
decimal packed, floating etc. and mostly will be of fixed length. Even 
bignums will have an upper limit (e.g. 64Kdigits). If there is no check 
for a maximum value at input, funny things can happen in program logik 
afterwards: overruns, skip to negative values, truncated values, which 
possible could cause crazy program behaviour.

I do not aspect many of these errors, as the bug rate of drbd is very 
low (congratulations!) and at minor level.

> well, we have had a bugzilla, but we did not use it.
> and it would be very fast very heavily out of date.
> do you want to keep it up-to-date,
> and kick Phillip or me every now and then?

Yeah. But it needs a minimum of cooperation from developers. E.g. such 
messages like "solved, ready for retest", "won't solve", priorities etc.

Helmut Wollmersdorfer

