Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D6EE6105632B
	for <drbd-dev@lists.linbit.com>; Fri,  1 Apr 2016 10:57:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C2231403D2F
	for <drbd-dev@lists.linbit.com>; Fri,  1 Apr 2016 10:57:58 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id cb0AjArFutEs for <drbd-dev@lists.linbit.com>;
	Fri,  1 Apr 2016 10:57:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 91070403D31
	for <drbd-dev@lists.linbit.com>; Fri,  1 Apr 2016 10:57:58 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0YnUoepdbici for <drbd-dev@lists.linbit.com>;
	Fri,  1 Apr 2016 10:57:58 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 60E45403D2F
	for <drbd-dev@lists.linbit.com>; Fri,  1 Apr 2016 10:57:58 +0200 (CEST)
Resent-Message-ID: <20160401085757.GB3078@soda.linbit>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 769451056312
	for <drbd-dev@lists.linbit.com>; Fri,  1 Apr 2016 02:31:08 +0200 (CEST)
Received: from mail-yw0-f177.google.com ([209.85.161.177])
	by youngberry.canonical.com with esmtpsa
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <ming.lei@canonical.com>) id 1almzT-0004qe-OV
	for drbd-dev@lists.linbit.com; Fri, 01 Apr 2016 00:31:07 +0000
Received: by mail-yw0-f177.google.com with SMTP id h65so123279446ywe.0
	for <drbd-dev@lists.linbit.com>; Thu, 31 Mar 2016 17:31:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160331075228.GA2491@infradead.org>
References: <1459354637-17415-1-git-send-email-ming.lei@canonical.com>
	<1459354637-17415-3-git-send-email-ming.lei@canonical.com>
	<20160330171927.GA13320@infradead.org>
	<CACVXFVNtphY8bWrdMKcR7jYn5hD=H5H6jXrY111K0kZ8jJQHWw@mail.gmail.com>
	<20160331075228.GA2491@infradead.org>
Date: Fri, 1 Apr 2016 08:31:06 +0800
Message-ID: <CACVXFVPOiH4pEW7J0-Nimoj6thoUtY_A+A9PaaisLwibKP1DHg@mail.gmail.com>
From: Ming Lei <ming.lei@canonical.com>
To: Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset=UTF-8
Cc: Boaz Harrosh <boaz@plexistor.com>, Jens Axboe <axboe@fb.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	xfs@oss.sgi.com, linux-block@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Anton Altaparmakov <anton@tuxera.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v1 2/8] block: make 'struct bvec_iter' not
	depend on CONFIG_BLOCK
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

On Thu, Mar 31, 2016 at 3:52 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Mar 31, 2016 at 09:02:59AM +0800, Ming Lei wrote:
>> That way may cause trouble to blk_type.h because it needs bvec_iter,
>> then looks not good to always include bvec_iter.h into blk_type.h.
>
> I'd expect bvec.h to be always included in blk_types.h, and replace

That should be fine, but blk_types.h will become more fat.

> the inclusion of blk_types.h in fs.h eventually.

I guess it can't be done because fs.h need 'struct bio'.

thanks,
Ming
