Return-Path: <philipp.reisner@linbit.com>
Received: from amd.localdomain (chello062178075200.26.11.tuwien.teleweb.at
	[62.178.75.200])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id D2FA414311
	for <drbd-dev@lists.linbit.com>; Fri,  8 Oct 2004 15:37:22 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] How Locking in GFS works...
Date: Fri, 8 Oct 2004 15:37:23 +0200
References: <200410041456.21841.philipp.reisner@linbit.com>
	<200410081432.09710.philipp.reisner@linbit.com>
	<20041008125544.GO8249@marowsky-bree.de>
In-Reply-To: <20041008125544.GO8249@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410081537.23086.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Freitag, 8. Oktober 2004 14:55 schrieb Lars Marowsky-Bree:
> On 2004-10-08T14:32:09, Philipp Reisner <philipp.reisner@linbit.com> wrote:
> >   3. Concurrent writes, high latency for data packets.
> >     The problem now is that N2 does can not detect that this was
> >     a concurrent write, since it got the ACK before the conflicting
> >     data packets comes in.
>
> Uhm. I don't see how this can be a problem.
>
> In this case, one write has logically happened before the other, and
> from they don't overlap - the second write will simply wipe out the
> first one, which seems fine?
>

Just look at it again. on the left figure you will find that N1 has
the blue data on its block and N2 has the green data on its disk. 

I do see here a problem.

> >   5. New write while processing a write from the peer.
>
> Sounds just like case 1.
>

In case 1 there is no concurrenct access at all ?!?

Hav you had a look at the pdf ?

-Philipp
