Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BC1DC1056471
	for <drbd-dev@lists.linbit.com>; Tue,  8 Nov 2016 15:21:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 8F0EB416368
	for <drbd-dev@lists.linbit.com>; Tue,  8 Nov 2016 15:21:31 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id jIaWGKr7q5HL for <drbd-dev@lists.linbit.com>;
	Tue,  8 Nov 2016 15:21:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 3DB92416373
	for <drbd-dev@lists.linbit.com>; Tue,  8 Nov 2016 15:21:31 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sgNr3hTrEwhP for <drbd-dev@lists.linbit.com>;
	Tue,  8 Nov 2016 15:21:31 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 1B918416368
	for <drbd-dev@lists.linbit.com>; Tue,  8 Nov 2016 15:21:31 +0100 (CET)
Resent-Message-ID: <20161108142130.GH1382@soda.linbit>
Received: from radon.swed.at (b.ns.miles-group.at [95.130.255.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 52DDF1056480
	for <drbd-dev@lists.linbit.com>; Tue,  8 Nov 2016 14:55:32 +0100 (CET)
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, drbd-dev@lists.linbit.com,
	philipp.reisner@linbit.com, viro@zeniv.linux.org.uk,
	christoph.lechleitner@iteg.at, wolfgang.glas@iteg.at
References: <1478601789-15060-1-git-send-email-richard@nod.at>
	<1478601789-15060-1-git-send-email-richard@nod.at>
From: Richard Weinberger <richard@nod.at>
Message-ID: <497abc52-093f-17ea-5fb5-645030a23a01@nod.at>
Date: Tue, 8 Nov 2016 14:55:29 +0100
MIME-Version: 1.0
In-Reply-To: <1478601789-15060-1-git-send-email-richard@nod.at>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] [PATCH] drbd: Fix kernel_sendmsg() usage
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

Lars,

On 08.11.2016 14:43, Lars Ellenberg wrote:
> From 3a5859e696178e31a25e65de58c461046fc52beb Mon Sep 17 00:00:00 2001
> From: Richard Weinberger <richard@nod.at>
> Date: Tue, 8 Nov 2016 11:43:09 +0100
> Subject: [PATCH] drbd: Fix kernel_sendmsg() usage - potential NULL deref
> drbd: Fix kernel_sendmsg() usage - potential NULL deref
> 
> Don't pass a size larger than iov_len to kernel_sendmsg().
> Otherwise it will cause a NULL pointer deref when kernel_sendmsg()
> returns with rv < size.
> 
> DRBD as external module has been around in the kernel 2.4 days already.
> We used to be compatible to 2.4 and very early 2.6 kernels,
> we used to use
>  rv = sock_sendmsg(sock, &msg, iov.iov_len);
> then later changed to
>  rv = kernel_sendmsg(sock, &msg, &iov, 1, size);
> when we should have used
>  rv = kernel_sendmsg(sock, &msg, &iov, 1, iov.iov_len);
> 
> tcp_sendmsg() used to totally ignore the size parameter.
>  57be5bd ip: convert tcp_sendmsg() to iov_iter primitives
> changes that, and exposes our long standing error.
> 
> Even with this error exposed, to trigger the bug, we would need to have
> an environment (config or otherwise) causing us to not use sendpage()
> for larger transfers, a flaky connection, and have it fail "just at the
> right time".  Apparently that was unlikely enough for most, so this went
> unnoticed for years.
> 
> Still, it is known to trigger at least some of these,
> and suspected for the others:
> [0] http://lists.linbit.com/pipermail/drbd-user/2016-July/023112.html
> [1] http://lists.linbit.com/pipermail/drbd-dev/2016-March/003362.html
> [2] https://forums.grsecurity.net/viewtopic.php?f=3&t=4546
> [3] https://ubuntuforums.org/showthread.php?t=2336150
> [4] http://e2.howsolveproblem.com/i/1175162/
> 
> This should go into 4.9,
> and into all stable branches since and including v4.0,
> which is the first to contain the exposing change.
> 
> It is correct for all stable branches older than that as well
> (which contain the DRBD driver; which is 2.6.33 and up).
> 
> It requires a small "conflict" resolution for v4.4 and earlier, with v4.5
> we dropped the comment block immediately preceding the kernel_sendmsg().
> 
> Cc: stable@vger.kernel.org
> Cc: viro@zeniv.linux.org.uk
> Cc: christoph.lechleitner@iteg.at
> Cc: wolfgang.glas@iteg.at
> Reported-by: Christoph Lechleitner <christoph.lechleitner@iteg.at>
> Tested-by: Christoph Lechleitner <christoph.lechleitner@iteg.at>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>

Changing my patch is perfectly fine, but please clearly state it.
I.e. by adding something like that before your S-o-b.
[Lars: Massaged patch to match my personal taste...]

Thanks,
//richard
