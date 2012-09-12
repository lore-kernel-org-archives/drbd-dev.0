Return-Path: <htejun@gmail.com>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 30DD21013809
	for <drbd-dev@lists.linbit.com>; Wed, 12 Sep 2012 20:58:31 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so3310352pbb.27
	for <drbd-dev@lists.linbit.com>; Wed, 12 Sep 2012 11:58:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 12 Sep 2012 11:58:24 -0700
From: Tejun Heo <tj@kernel.org>
To: NeilBrown <neilb@suse.de>, Kent Overstreet <koverstreet@google.com>,
	Jens Axboe <axboe@kernel.dk>, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Vivek Goyal <vgoyal@redhat.com>, drbd-dev@lists.linbit.com
Message-ID: <20120912185824.GS7677@google.com>
References: <3029802.oqG0dEY71l@fat-tyre>
	<20120905084915.GF3195@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120905100724.GA27527@soda.linbit>
	<20120906212952.GP29092@google.com>
	<20120907084221.GD7028@soda.linbit>
	<20120910225442.GE7677@google.com>
	<20120910230654.GF7677@google.com>
	<20120910233159.GE19739@google.com>
	<20120911155820.74f1f918@notabene.brown>
	<20120911082501.GH7028@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120911082501.GH7028@soda.linbit>
Subject: Re: [Drbd-dev] FLUSH/FUA documentation & code discrepancy
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello,

On Tue, Sep 11, 2012 at 10:25:01AM +0200, Lars Ellenberg wrote:
> Or do we have a better place to document write ordering requirements?
> 
> "To enforce write-after-write dependencies, you *have* to drain the
> queue (do we have a generic interface available for that?),
> or at least wait for the completion of all the requests you
> (potentially) depend upon, before even submitting the dependent request.
> 
> Additionally, to avoid integrity issues due to volatile caches,
> you need to use FLUSH/FUA as appropriate."

I think it would be best to note the lack of any ordering guarantee in
the comment of bio_submit()?  Any one interested in submitting a
patch?

Thanks.

-- 
tejun
