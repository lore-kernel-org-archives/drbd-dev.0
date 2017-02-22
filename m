Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f173.google.com (mail-wr0-f173.google.com
	[209.85.128.173]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8ED5E1056320
	for <drbd-dev@lists.linbit.com>; Wed, 22 Feb 2017 09:18:44 +0100 (CET)
Received: by mail-wr0-f173.google.com with SMTP id z61so2746382wrc.1
	for <drbd-dev@lists.linbit.com>; Wed, 22 Feb 2017 00:18:44 -0800 (PST)
Received: from soda.linbit ([86.59.100.100])
	by smtp.gmail.com with ESMTPSA id l14sm744691wrc.3.2017.02.22.00.18.43
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 Feb 2017 00:18:43 -0800 (PST)
Date: Wed, 22 Feb 2017 09:18:42 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20170222081842.GP21236@soda.linbit>
References: <34e63ed3-e991-8a84-45c7-2d9682d5af86@digide.net>
	<20170220140715.GN21236@soda.linbit>
	<a56aa3ed-f241-e7aa-9778-2741695c1d7f@digide.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a56aa3ed-f241-e7aa-9778-2741695c1d7f@digide.net>
Subject: Re: [Drbd-dev] Avoid nested sleeping on TCP connect
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

On Mon, Feb 20, 2017 at 05:58:16PM +0100, Andreas Osterburg wrote:
> Thanks for your investigations.
> I didn't use a loop since the old behaviour was to leave the function returning -EAGAIN
> on timeout or interrupt. There is just one difference: When an event from the socket occures
> and no TCP-connection is established, the function leaves before the timeout elapses.

Exactly.
There may well be several incoming TCP connections,
and we want to wait for the right one.

> It makes no real difference to an interrupt, so I didn't handle it
> specially.

Usually there is no interrupt.
Interrupt would mean someone cancels the connection attemt,
tears down the connection before it is even established.
So yes, it could make a significant difference in some setups.

Anyways: right now, best to just leave it alone.
The inner mutex is supposed to have no real contention, the worst thing
that would happen if we should have to block for it, and the condition
is still not met, is one extra iteration in the outer wait_event loop,
which is harmless.

-- 
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD® and LINBIT® are registered trademarks of LINBIT
