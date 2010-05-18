Return-Path: <iustin@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.35])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C4BB9103B4A4
	for <drbd-dev@lists.linbit.com>; Tue, 18 May 2010 10:52:17 +0200 (CEST)
Received: from kpbe18.cbf.corp.google.com (kpbe18.cbf.corp.google.com
	[172.25.105.82]) by smtp-out.google.com with ESMTP id o4I8qDck010490
	for <drbd-dev@lists.linbit.com>; Tue, 18 May 2010 01:52:14 -0700
Received: from bwz15 (bwz15.prod.google.com [10.188.26.15])
	by kpbe18.cbf.corp.google.com with ESMTP id o4I8qBjp004732
	for <drbd-dev@lists.linbit.com>; Tue, 18 May 2010 01:52:12 -0700
Received: by bwz15 with SMTP id 15so16015bwz.24
	for <drbd-dev@lists.linbit.com>; Tue, 18 May 2010 01:52:10 -0700 (PDT)
Date: Tue, 18 May 2010 10:52:07 +0200
From: Iustin Pop <iustin@google.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <20100518085207.GB19087@google.com>
References: <cover.1274099535.git.iustin@google.com>
	<201005172344.40802.philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201005172344.40802.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 0/3] Implement
	{begin|after}-resync-source	handlers
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, May 17, 2010 at 11:44:40PM +0200, Philipp Reisner wrote:
> Am Montag 17 Mai 2010 14:37:57 schrieb Iustin Pop:
> > These small patches duplicate the resync-target handlers for the other
> > end of the connection.
> >
> 
> Hi Iustin,
> 
> The patches look okay so far, I am considering to apply them
> to our tree.
> 
> * Have you ever considered to use the "drbdsetup events" 
>   interface instead?

Yep, I thought about it, and might use it if the handler method is not
good enough (for whatever reason). But I'd rather like to use the
handlers, since they allow reaction before the actual sync starts, and
thus they eliminate a window of "uncontrolled" syncs (see below why we
want to control them).

> * Are you going to use them in your organisation? 

That too, but better said we're going to use them in Ganeti (opensource,
cluster-based virtualization manager). Background: Ganeti uses only the
low-level drbdsetup interface, and not the drbdadm one, since we manage
the minor numbers assignments dynamically. This dynamic part hits us,
because we cannot make easy 'resync-after' rules (especially as on
bigger Ganeti clusters, like 20-40 nodes, you could get easily into
circular dependencies if you're not careful.

So the plan is to write a custom usermode_helper (right now Ganeti
documentations says to use /bin/true :), so we're not losing any
functionality by moving to a custom helper), that will simply restrict
DRBD to a single sync (either incoming or outgoing) per machine, in
order to not overload any machine's I/O resources. When a begin-sync
request comes in, either source or target, the helper will look if any
other minors are undergoing syncs, and if so will drbdsetup pause-sync
the minor - I hope that this is safe to do from the callback, my few
tests show it so. And when a after-resync-* requests comes, we look if
there are any paused syncs (on our end), and if so then we'll unpause
one.

Now, if drbd (the kernel driver) would have a setting like 'max_syncs',
then we wouldn't have to implement anything in Ganeti, but that is
probably more work in the kernel - which is harder, compared with a
simple userspace shell script.

Hope my explanation makes sense…
iustin
