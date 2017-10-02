Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A2D58105800D
	for <drbd-dev@lists.linbit.com>; Mon,  2 Oct 2017 15:20:13 +0200 (CEST)
Received: by mail-wm0-f49.google.com with SMTP id e195so6791776wma.5
	for <drbd-dev@lists.linbit.com>; Mon, 02 Oct 2017 06:20:13 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	s196sm8498150wmb.26.2017.10.02.06.13.44
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 02 Oct 2017 06:13:44 -0700 (PDT)
Date: Mon, 2 Oct 2017 15:13:36 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20171002131336.GA8989@soda.linbit>
References: <1506897256-14072-1-git-send-email-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506897256-14072-1-git-send-email-me@tobin.cc>
Subject: Re: [Drbd-dev] [PATCH 00/17] lru_cache: checkpatch clean ups
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

On Mon, Oct 02, 2017 at 09:33:59AM +1100, Tobin C. Harding wrote:
> Checkpatch clean ups for lib/lru_cache.c
> 
> This patch set is intended to test the waters as to whether DRBD
> wants/accepts checkpatch clean ups. I know that many maintainers
> consider such patches as code churn.

I'd consider them such.
Probably nothing wrong with those patches, really,
though I did not look very closely.

I'd maybe do this kind of cleanup IF I was to touch the code anyways.

> I am taking a look at the DRBD code after bumping into Brian at OSSNA in LA.
> 
> If you do want/like checkpatch fixes I am happy to do so for drivers/block/drbd/* while I look
> around the code base.
> 
> I don't know which tree you guys are working off.
> This series applies on top of Linus' development
> tree, commit:
> 
> a8c964eacb21288b2dbfa9d80cee5968a3b8fb21

Our "upstream" is out-of-tree still,
and tries to be compatible with a wide range of kernel.org tree versions.
We recently move the public master to github.com/LINBIT/drbd-8.4/
and it looks in some parts quite different from the in kernel code,
for compatilibity reasons.

But for this kind of cleanup stuff,
kernel.org master is the right reference, yes.

As I said, I don't care much for "no-op" commits, and even if I'd take
them, I'd fold them all into one "fixes for checkpatch complaints".

But don't let that keep you from "looking around the code base",
maybe you still spot things that actually need fixing
or can otherwise be improved.  It's not that we don't like contributors,
it's just that contributing "white-space only changes" to C code won't
earn you much points in my book ;-)

Thanks,

    Lars

