Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id BCE801013802
	for <drbd-dev@lists.linbit.com>; Thu, 13 Sep 2012 10:26:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id B65991B4487
	for <drbd-dev@lists.linbit.com>; Thu, 13 Sep 2012 10:26:19 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZPc1it37-E0i for <drbd-dev@lists.linbit.com>;
	Thu, 13 Sep 2012 10:26:19 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 981381B4458
	for <drbd-dev@lists.linbit.com>; Thu, 13 Sep 2012 10:26:19 +0200 (CEST)
Resent-Message-ID: <20120913082615.GD13815@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 46998103B4B4
	for <drbd-dev@lists.linbit.com>; Tue, 11 Sep 2012 16:41:09 +0200 (CEST)
Date: Tue, 11 Sep 2012 10:41:02 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Lars Ellenberg <lars.ellenberg@linbit.com>
Message-ID: <20120911144102.GE12039@redhat.com>
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
Cc: Jens Axboe <axboe@kernel.dk>, NeilBrown <neilb@suse.de>,
	Kent Overstreet <koverstreet@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] FLUSH/FUA documentation & code discrepancy
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Sep 11, 2012 at 10:25:01AM +0200, Lars Ellenberg wrote:

[..]
> "To enforce write-after-write dependencies, you *have* to drain the
> queue (do we have a generic interface available for that?),
> or at least wait for the completion of all the requests you
> (potentially) depend upon, before even submitting the dependent request.

I think you need to wait for all previous IOs (you are dependent on) to finish.

Thanks
Vivek
