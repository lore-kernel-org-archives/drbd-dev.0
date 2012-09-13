Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 08FBE103B4CB
	for <drbd-dev@lists.linbit.com>; Thu, 13 Sep 2012 10:26:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id C45A11B4458
	for <drbd-dev@lists.linbit.com>; Thu, 13 Sep 2012 10:26:49 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cbhskbs-RO+W for <drbd-dev@lists.linbit.com>;
	Thu, 13 Sep 2012 10:26:49 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 6E4871B4499
	for <drbd-dev@lists.linbit.com>; Thu, 13 Sep 2012 10:26:49 +0200 (CEST)
Resent-Message-ID: <20120913082649.GH13815@soda.linbit>
Received: from mail-ob0-f182.google.com (mail-ob0-f182.google.com
	[209.85.214.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C57811013803
	for <drbd-dev@lists.linbit.com>; Thu, 13 Sep 2012 05:10:15 +0200 (CEST)
Received: by obbun3 with SMTP id un3so6523266obb.27
	for <drbd-dev@lists.linbit.com>; Wed, 12 Sep 2012 20:10:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOzFzEhU6Y2hbRKU9qdFbtx_A-+wgs14E8Xza107G+z7uHzs_w@mail.gmail.com>
References: <20120905100724.GA27527@soda.linbit>
	<20120906212952.GP29092@google.com>
	<20120907084221.GD7028@soda.linbit>
	<20120910225442.GE7677@google.com>
	<20120910230654.GF7677@google.com>
	<20120910233159.GE19739@google.com>
	<20120911155820.74f1f918@notabene.brown>
	<20120911082501.GH7028@soda.linbit>
	<20120912185824.GS7677@google.com>
	<CAOzFzEjCf7ZPbheq-tfhts-E=Ep1kvn0muksaaTFqJ=cMm772w@mail.gmail.com>
	<20120912232019.GW7677@google.com>
	<CAOzFzEhfoCpGCy0n5cu60xz+tSbB26g1f2ztcD1DwZOY-6aTwQ@mail.gmail.com>
	<CAOzFzEhU6Y2hbRKU9qdFbtx_A-+wgs14E8Xza107G+z7uHzs_w@mail.gmail.com>
Date: Thu, 13 Sep 2012 13:10:13 +1000
Message-ID: <CAOzFzEg754UM_+Zzet2XB_gNOui3-hURskP2GAhr49J6-PBBHA@mail.gmail.com>
From: Joseph Glanville <joseph.glanville@orionvm.com.au>
To: Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
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

Hi Tejun, list.

While reviewing some of the documentation in Documentation/block I
found there is still out of date references to the old barrier code.
Should this also be removed?
I am not sufficiently confident of my understanding of the block layer
to do a through review/update of the Documentation/block stuff but my
untrained eye suggests maybe that such a undertaking is probably abit
overdue.


-- 
CTO | Orion Virtualisation Solutions | www.orionvm.com.au
Phone: 1300 56 99 52 | Mobile: 0428 754 846
