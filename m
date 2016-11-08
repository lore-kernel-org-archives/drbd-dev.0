Return-Path: <axboe@kernel.dk>
Received: from mail-yw0-f173.google.com (mail-yw0-f173.google.com
	[209.85.161.173]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 90B5D1056482
	for <drbd-dev@lists.linbit.com>; Tue,  8 Nov 2016 17:58:47 +0100 (CET)
Received: by mail-yw0-f173.google.com with SMTP id l124so182374870ywb.3
	for <drbd-dev@lists.linbit.com>; Tue, 08 Nov 2016 08:58:47 -0800 (PST)
Date: Tue, 8 Nov 2016 09:52:04 -0700
From: Jens Axboe <axboe@kernel.dk>
To: Richard Weinberger <richard@nod.at>
Message-ID: <20161108165204.GC2834@kernel.dk>
References: <1478601789-15060-1-git-send-email-richard@nod.at>
	<1478601789-15060-1-git-send-email-richard@nod.at>
	<497abc52-093f-17ea-5fb5-645030a23a01@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <497abc52-093f-17ea-5fb5-645030a23a01@nod.at>
Cc: wolfgang.glas@iteg.at, christoph.lechleitner@iteg.at,
	philipp.reisner@linbit.com, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	drbd-dev@lists.linbit.com
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

On Tue, Nov 08 2016, Richard Weinberger wrote:
> On 08.11.2016 14:43, Lars Ellenberg wrote:
> > From 3a5859e696178e31a25e65de58c461046fc52beb Mon Sep 17 00:00:00 2001
> > From: Richard Weinberger <richard@nod.at>
> > Date: Tue, 8 Nov 2016 11:43:09 +0100
> > Subject: [PATCH] drbd: Fix kernel_sendmsg() usage - potential NULL deref
> > drbd: Fix kernel_sendmsg() usage - potential NULL deref
> > 
> > Don't pass a size larger than iov_len to kernel_sendmsg().
> > Otherwise it will cause a NULL pointer deref when kernel_sendmsg()
> > returns with rv < size.
> > 
> > DRBD as external module has been around in the kernel 2.4 days already.
> > We used to be compatible to 2.4 and very early 2.6 kernels,
> > we used to use
> >  rv = sock_sendmsg(sock, &msg, iov.iov_len);
> > then later changed to
> >  rv = kernel_sendmsg(sock, &msg, &iov, 1, size);
> > when we should have used
> >  rv = kernel_sendmsg(sock, &msg, &iov, 1, iov.iov_len);
> > 
> > tcp_sendmsg() used to totally ignore the size parameter.
> >  57be5bd ip: convert tcp_sendmsg() to iov_iter primitives
> > changes that, and exposes our long standing error.
> > 
> > Even with this error exposed, to trigger the bug, we would need to have
> > an environment (config or otherwise) causing us to not use sendpage()
> > for larger transfers, a flaky connection, and have it fail "just at the
> > right time".  Apparently that was unlikely enough for most, so this went
> > unnoticed for years.
> > 
> > Still, it is known to trigger at least some of these,
> > and suspected for the others:
> > [0] http://lists.linbit.com/pipermail/drbd-user/2016-July/023112.html
> > [1] http://lists.linbit.com/pipermail/drbd-dev/2016-March/003362.html
> > [2] https://forums.grsecurity.net/viewtopic.php?f=3&t=4546
> > [3] https://ubuntuforums.org/showthread.php?t=2336150
> > [4] http://e2.howsolveproblem.com/i/1175162/
> > 
> > This should go into 4.9,
> > and into all stable branches since and including v4.0,
> > which is the first to contain the exposing change.
> > 
> > It is correct for all stable branches older than that as well
> > (which contain the DRBD driver; which is 2.6.33 and up).
> > 
> > It requires a small "conflict" resolution for v4.4 and earlier, with v4.5
> > we dropped the comment block immediately preceding the kernel_sendmsg().
> > 
> > Cc: stable@vger.kernel.org
> > Cc: viro@zeniv.linux.org.uk
> > Cc: christoph.lechleitner@iteg.at
> > Cc: wolfgang.glas@iteg.at
> > Reported-by: Christoph Lechleitner <christoph.lechleitner@iteg.at>
> > Tested-by: Christoph Lechleitner <christoph.lechleitner@iteg.at>
> > Signed-off-by: Richard Weinberger <richard@nod.at>
> > Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
> 
> Changing my patch is perfectly fine, but please clearly state it.
> I.e. by adding something like that before your S-o-b.
> [Lars: Massaged patch to match my personal taste...]

Lars, are you sending a new one? If you do, add the stable tag as well.

-- 
Jens Axboe

