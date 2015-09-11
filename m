Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 995F4105570E
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 8F2AD2BEE36
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:16 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id eF4TKR1XASlN for <drbd-dev@lists.linbit.com>;
	Fri, 11 Sep 2015 15:20:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 467C82BEE40
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:16 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mtf0TOxtD79h for <drbd-dev@lists.linbit.com>;
	Fri, 11 Sep 2015 15:20:16 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 128BA2BEE36
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 15:20:16 +0200 (CEST)
Resent-Message-ID: <20150911132015.GT3436@soda.linbit>
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Hannes Reinecke <hare@suse.de>
Message-ID: <20150808090205.GA15061@kmo-pixel>
References: <CAF1ivSZbMDgyo_-wFGusSNSZ1fonSMWmNU9aVavGFaQsmEyYmQ@mail.gmail.com>
	<20150731213831.GA16464@redhat.com>
	<1438412290.26596.14.camel@hasee>
	<20150801163356.GA21478@redhat.com>
	<1438581502.26596.24.camel@hasee> <20150804113626.GA12682@lst.de>
	<1438754604.29731.31.camel@hasee> <20150807073001.GA17485@lst.de>
	<1438990806.24452.8.camel@ssi> <55C5C348.1070307@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55C5C348.1070307@suse.de>
Cc: Mike Snitzer <snitzer@redhat.com>, Ming Lei <ming.lei@canonical.com>,
	Neil@redhat.com, device-mapper development <dm-devel@redhat.com>,
	Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@infradead.org>, Nitin Gupta <ngupta@vflare.org>,
	Ming Lin <ming.l@ssi.samsung.com>, Al@redhat.com,
	Oleg Drokin <oleg.drokin@intel.com>,
	Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Andreas Dilger <andreas.dilger@intel.com>,
	Geoff Levand <geoff@infradead.org>, Jiri Kosina <jkosina@suse.cz>,
	lkml <linux-kernel@vger.kernel.org>, Jim Paris <jim@jtan.com>,
	Minchan Kim <minchan@kernel.org>, Dongsu Park <dpark@posteo.net>,
	drbd-user@lists.linbit.com
Subject: Re: [Drbd-dev] [dm-devel] [PATCH v5 01/11] block: make
 generic_make_request handle arbitrarily sized bios
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
Date: Fri, 11 Sep 2015 13:21:07 -0000

On Sat, Aug 08, 2015 at 10:52:24AM +0200, Hannes Reinecke wrote:
> Wouldn't it be easier to move both max_write_same_sectors and
> max_discard sectors to 64 bit (ie to type sector_t) and be done with the
> overflow?
> Seems to me this is far too much coding around self-imposed restrictions...

It's bio->bi_iter.bi_size that would have to be increased to 64 bits. Which I
suppose wouldn't actually increase the size of struct bio (when sector_t is 64
bits), since struct bvec_iter has padding right now...
