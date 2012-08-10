Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CF7AC10561AB
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 889F91B435E
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:38 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J4DGdrPkQaDh for <drbd-dev@lists.linbit.com>;
	Fri, 10 Aug 2012 22:33:38 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 4EFF71B4206
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:38 +0200 (CEST)
Resent-Message-ID: <20120810203338.GO31190@soda.linbit>
Received: from mail-vc0-f182.google.com (mail-vc0-f182.google.com
	[209.85.220.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 951DF1013809
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 04:37:21 +0200 (CEST)
Received: by vcbgb22 with SMTP id gb22so1939485vcb.27
	for <drbd-dev@lists.linbit.com>; Thu, 09 Aug 2012 19:37:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120809070154.GG2845@dhcp-172-17-108-109.mtv.corp.google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-13-git-send-email-koverstreet@google.com>
	<Pine.LNX.4.64.1208061913500.21956@file.rdu.redhat.com>
	<20120808232804.GL6983@dhcp-172-17-108-109.mtv.corp.google.com>
	<CAFR8uedZiG0NWgWQQa03r+kKh8rT0jzpj+hwPzq+i7K6zhpT_A@mail.gmail.com>
	<20120809070154.GG2845@dhcp-172-17-108-109.mtv.corp.google.com>
Date: Thu, 9 Aug 2012 19:29:04 -0700
Message-ID: <CAFR8uedwrfv8TB==BkDTZAENYhDOY8S++aTqEoJ7xbn7Vo-6Ag@mail.gmail.com>
From: Muthu Kumar <muthu.lkml@gmail.com>
To: Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
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

Tejun,

On Thu, Aug 9, 2012 at 12:01 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On Wed, Aug 08, 2012 at 04:47:46PM -0700, Muthu Kumar wrote:
>> You are changing the meaning of __bio_clone() here. In old code, the
>> number of io_vecs, bi_idx, bi_vcnt are preserved. But in this modified
>> code, you are mapping bio_src's bi_iovec[bi_idx] to bio_dests
>> bi_iovec[0] and also restricting the number of allocated io_vecs of
>> the clone. It may be useful for cases were we would like a identical
>> copy of the original bio (may not be in current code base, but this
>> implementation is definitely not what one would expect from the name
>> "clone").
>
> Implementation details changed somewhat but the high-level semantics
> didn't change at all.  Any driver not messing with bio internals - and
> they shouldn't - shouldn't notice the change.

The reason for doing this change is because the code in question is
messing with bio internals.

No in-kernel drivers
> seem to be broken by the change.  If you ask me, this looks more like
> a bug fix to me where the bug is a silly behavior restricting
> usefulness of the interface.
>
>> May be, call this new implementation some thing else (and use it for bcache)?
>
> This doesn't only change __bio_clone() but all clone interface stacked
> on top of it, so, no way.

>This ain't windows.

ah... when you put it this way, it gets a different perspective :)

Anyway, my point is, we shouldn't make it non-obvious ("clone" should
be just "clone"). But, we can always add more comments i guess.

Regards,
Muthu


>
> Thanks.
>
> --
> tejun
