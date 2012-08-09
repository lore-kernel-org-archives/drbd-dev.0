Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7445E10561AA
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 677C51B435E
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:34 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bFoIk8j-7YwO for <drbd-dev@lists.linbit.com>;
	Fri, 10 Aug 2012 22:33:34 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 4064A1B4206
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:33:34 +0200 (CEST)
Resent-Message-ID: <20120810203334.GH31190@soda.linbit>
Received: from mail-yx0-f182.google.com (mail-yx0-f182.google.com
	[209.85.213.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 289041045C2E
	for <drbd-dev@lists.linbit.com>; Thu,  9 Aug 2012 05:25:05 +0200 (CEST)
Received: by yenl7 with SMTP id l7so2352052yen.27
	for <drbd-dev@lists.linbit.com>; Wed, 08 Aug 2012 20:25:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120809031936.GM7262@moria.home.lan>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-13-git-send-email-koverstreet@google.com>
	<Pine.LNX.4.64.1208061913500.21956@file.rdu.redhat.com>
	<20120808232804.GL6983@dhcp-172-17-108-109.mtv.corp.google.com>
	<CAFR8uedZiG0NWgWQQa03r+kKh8rT0jzpj+hwPzq+i7K6zhpT_A@mail.gmail.com>
	<20120809031936.GM7262@moria.home.lan>
Date: Wed, 8 Aug 2012 20:25:03 -0700
Message-ID: <CAH+dOxKr=BcWO5qmYZkrc2px+ckx=_+viWQ9M2hE7RMA3DaXNg@mail.gmail.com>
From: Kent Overstreet <koverstreet@google.com>
To: Muthu Kumar <muthu.lkml@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: axboe@kernel.dk, linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	device-mapper development <dm-devel@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, agk@redhat.com,
	sage@newdream.net, Tejun Heo <tj@kernel.org>,
	yehuda@hq.newdream.net, vgoyal@redhat.com, drbd-dev@lists.linbit.com
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

On Wed, Aug 8, 2012 at 8:19 PM, Kent Overstreet <koverstreet@google.com> wrote:
> In particular, if this change breaks anything then the new bio_split()
> _will_ break things.
>
> We need to be clear about our interfaces; in this case bi_idx and
> bi_vcnt, in particular. Either this is a safe change, or it's not. If
> no one knows... that's a bigger problem, and not just for this patch...
>
> Fortunately this code actually has been tested quite a bit (and the bio
> splitting code for even longer), and (somewhat to my surprise) I haven't
> run into any bugs caused by it.

Oh, it's worse than that - remember how bio_kmalloc() works for up to
1024 pages, but bio_alloc_bioset() only up to 256?

We can already have situations where bios are allocated that are
impossible to clone (or if we don't, it's only because of
queue_limits. That's not sketchy at all.)
