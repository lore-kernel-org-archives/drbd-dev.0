Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A5392105647C
	for <drbd-dev@lists.linbit.com>; Thu, 10 Nov 2016 15:14:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B918E2BA75B
	for <drbd-dev@lists.linbit.com>; Thu, 10 Nov 2016 15:14:35 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Wb4-PcafgFlw for <drbd-dev@lists.linbit.com>;
	Thu, 10 Nov 2016 15:14:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 98BAB2BAA16
	for <drbd-dev@lists.linbit.com>; Thu, 10 Nov 2016 15:14:35 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oz-B0iHPcJg7 for <drbd-dev@lists.linbit.com>;
	Thu, 10 Nov 2016 15:14:35 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 6FD6E2BA75B
	for <drbd-dev@lists.linbit.com>; Thu, 10 Nov 2016 15:14:35 +0100 (CET)
Resent-Message-ID: <20161110141435.GR1382@soda.linbit>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BB2461056478
	for <drbd-dev@lists.linbit.com>; Thu, 10 Nov 2016 00:41:35 +0100 (CET)
Date: Wed, 9 Nov 2016 23:41:28 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Lars Ellenberg <lars.ellenberg@linbit.com>
Message-ID: <20161109234127.GI19539@ZenIV.linux.org.uk>
References: <60514f9b-6f1c-8b7e-429a-490cdaae14d8@kernel.dk>
	<1478728378-22289-1-git-send-email-lars.ellenberg@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1478728378-22289-1-git-send-email-lars.ellenberg@linbit.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>, wolfgang.glas@iteg.at,
	Richard Weinberger <richard@nod.at>,
	christoph.lechleitner@iteg.at, philipp.reisner@linbit.com,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2] drbd: Fix kernel_sendmsg() usage -
 potential NULL deref
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

On Wed, Nov 09, 2016 at 10:52:58PM +0100, Lars Ellenberg wrote:

> This should go into 4.9,
> and into all stable branches since and including v4.0,
> which is the first to contain the exposing change.
> 
> It is correct for all stable branches older than that as well
> (which contain the DRBD driver; which is 2.6.33 and up).
> 
> It requires a small "conflict" resolution for v4.4 and earlier, with v4.5
> we dropped the comment block immediately preceding the kernel_sendmsg().

ACK.  I'll rebase commit 7a4992299554 ([drbd] use sock_sendmsg()) on top
of that as soon as it hits the mainline.  For conspiracy theorists out
there (hi, Brad) - that commit (killing the modifications of iovec and
reinitializing msg->iov_iter; just set it once and let sendmsg() update
it in normal fashion) had been sitting around since late 2014.  It happened
to fix the bug in question, without a single line refering to that in commit
message.  Reason: I had completely missed the problem; intent of that
loop had been obvious and replacement had obviously done what was intended
there.  What I had failed to spot was that the code in there did *not*
match that intent.  Replacement does.  And unlike the minimal fix (either
version) it doesn't belong in -stable.
