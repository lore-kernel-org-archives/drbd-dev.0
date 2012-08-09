Return-Path: <htejun@gmail.com>
Received: from mail-yx0-f182.google.com (mail-yx0-f182.google.com
	[209.85.213.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 61A37103B4C6
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 09:08:18 +0200 (CEST)
Received: by yenl7 with SMTP id l7so175823yen.27
	for <drbd-dev@lists.linbit.com>; Thu, 09 Aug 2012 00:08:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 9 Aug 2012 00:01:54 -0700
From: Tejun Heo <tj@kernel.org>
To: Muthu Kumar <muthu.lkml@gmail.com>
Message-ID: <20120809070154.GG2845@dhcp-172-17-108-109.mtv.corp.google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-13-git-send-email-koverstreet@google.com>
	<Pine.LNX.4.64.1208061913500.21956@file.rdu.redhat.com>
	<20120808232804.GL6983@dhcp-172-17-108-109.mtv.corp.google.com>
	<CAFR8uedZiG0NWgWQQa03r+kKh8rT0jzpj+hwPzq+i7K6zhpT_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFR8uedZiG0NWgWQQa03r+kKh8rT0jzpj+hwPzq+i7K6zhpT_A@mail.gmail.com>
Cc: axboe@kernel.dk, Kent Overstreet <koverstreet@google.com>,
	linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	device-mapper development <dm-devel@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, agk@redhat.com,
	sage@newdream.net, yehuda@hq.newdream.net, vgoyal@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [dm-devel] [PATCH v5 12/12] block: Only clone bio
 vecs that are in use
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello,

On Wed, Aug 08, 2012 at 04:47:46PM -0700, Muthu Kumar wrote:
> You are changing the meaning of __bio_clone() here. In old code, the
> number of io_vecs, bi_idx, bi_vcnt are preserved. But in this modified
> code, you are mapping bio_src's bi_iovec[bi_idx] to bio_dests
> bi_iovec[0] and also restricting the number of allocated io_vecs of
> the clone. It may be useful for cases were we would like a identical
> copy of the original bio (may not be in current code base, but this
> implementation is definitely not what one would expect from the name
> "clone").

Implementation details changed somewhat but the high-level semantics
didn't change at all.  Any driver not messing with bio internals - and
they shouldn't - shouldn't notice the change.  No in-kernel drivers
seem to be broken by the change.  If you ask me, this looks more like
a bug fix to me where the bug is a silly behavior restricting
usefulness of the interface.

> May be, call this new implementation some thing else (and use it for bcache)?

This doesn't only change __bio_clone() but all clone interface stacked
on top of it, so, no way.  This ain't windows.

Thanks.

-- 
tejun
