Return-Path: <htejun@gmail.com>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4A4661013803
	for <drbd-dev@lists.linbit.com>; Thu, 13 Sep 2012 21:26:04 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so5379546pbb.27
	for <drbd-dev@lists.linbit.com>; Thu, 13 Sep 2012 12:26:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 13 Sep 2012 12:25:58 -0700
From: Tejun Heo <tj@kernel.org>
To: Joseph Glanville <joseph.glanville@orionvm.com.au>
Message-ID: <20120913192558.GK7677@google.com>
References: <20120910230654.GF7677@google.com>
	<20120910233159.GE19739@google.com>
	<20120911155820.74f1f918@notabene.brown>
	<20120911082501.GH7028@soda.linbit>
	<20120912185824.GS7677@google.com>
	<CAOzFzEjCf7ZPbheq-tfhts-E=Ep1kvn0muksaaTFqJ=cMm772w@mail.gmail.com>
	<20120912232019.GW7677@google.com>
	<CAOzFzEhfoCpGCy0n5cu60xz+tSbB26g1f2ztcD1DwZOY-6aTwQ@mail.gmail.com>
	<CAOzFzEhU6Y2hbRKU9qdFbtx_A-+wgs14E8Xza107G+z7uHzs_w@mail.gmail.com>
	<CAOzFzEg754UM_+Zzet2XB_gNOui3-hURskP2GAhr49J6-PBBHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOzFzEg754UM_+Zzet2XB_gNOui3-hURskP2GAhr49J6-PBBHA@mail.gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, NeilBrown <neilb@suse.de>,
	Kent Overstreet <koverstreet@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Vivek Goyal <vgoyal@redhat.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] FLUSH/FUA documentation & code discrepancy
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello, Joseph.

On Thu, Sep 13, 2012 at 01:10:13PM +1000, Joseph Glanville wrote:
> While reviewing some of the documentation in Documentation/block I
> found there is still out of date references to the old barrier code.
> Should this also be removed?
> I am not sufficiently confident of my understanding of the block layer
> to do a through review/update of the Documentation/block stuff but my
> untrained eye suggests maybe that such a undertaking is probably abit
> overdue.

Please be my guest.  I'll be happy to review it.

Thanks.

-- 
tejun
