Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 340652E30331
	for <drbd-dev@lists.linbit.com>; Mon, 14 Jan 2008 10:07:49 +0100 (CET)
Date: Mon, 14 Jan 2008 10:07:48 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [DRBD-8.0 PATCH] Fix deadlock between transfer log and
	resync
Message-ID: <20080114090748.GI5715@barkeeper1.linbit>
References: <342BAC0A5467384983B586A6B0B3767107C5AF6A@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B3767107C5AF6A@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Jan 11, 2008 at 10:29:57AM -0500, Graham, Simon wrote:
> The attached patches fix some deadlocks between the transfer log and
> resync - when the TL is in use (previously only protocols A and B but
> now all protocols), if there is a request on the TL that conflicts with
> a resync region, the code would deadlock with the resync processing
> waiting for the AL area to be clean and new requests that might lead to
> a barrier that would clear out the TL blocked by the resync.
> 
> The attached patches include the following:
> 
> 1. Non-TCQ DRBD Barrier implementation on target now flushes 
>    disk to force cached data to disk.

this is correct, we should do that.

> 2. A deadlock between resync and requests sitting in the TL
>    is fixed - if a resync request is started that conflicts
>    with entries in the TL, a DRBD barrier is initiated - this
>    will clear up the TL when the barrier ack is received and
>    allow the resync to procede.
> 3. When changing role from Primary, it is necessary to clear out
>    transfer log - do this by initiating barrier
> 4. When SyncTarget is also Primary, it is possible for
> drbd_try_rs_begin_io
>    to never make progress due to entries in tl that will not be flushed.
>    Change code to initiate barrier IF conflict with AL is found.

these will be handled differently and more generically,
as recently discussed in the "Crash in lru_cache.c" thread.


-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
