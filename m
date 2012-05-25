Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1C4E81005415
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:04:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 141001B4262
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:04:10 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CxQRxBAjSLZJ for <drbd-dev@lists.linbit.com>;
	Fri, 25 May 2012 09:04:10 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id EDDFD1B4206
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 09:04:09 +0200 (CEST)
Resent-Message-ID: <20120525070409.GR12726@soda.linbit>
Received: from natasha.panasas.com (natasha.panasas.com [67.152.220.90])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 14B6F1019A78
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 08:43:44 +0200 (CEST)
Message-ID: <4FBF29F7.6030808@panasas.com>
Date: Fri, 25 May 2012 09:43:03 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
To: Vivek Goyal <vgoyal@redhat.com>
References: <1337817771-25038-1-git-send-email-koverstreet@google.com>
	<1337817771-25038-9-git-send-email-koverstreet@google.com>
	<20120524195202.GG27550@redhat.com>
In-Reply-To: <20120524195202.GG27550@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	Kent Overstreet <koverstreet@google.com>,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, mpatocka@redhat.com,
	yehuda@hq.newdream.net, linux-fsdevel@vger.kernel.org,
	sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 08/14] block: Kill bi_destructor
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 05/24/2012 10:52 PM, Vivek Goyal wrote:

> In fact I am not even sure that for one driver we should introduce
> bio_reset() in generic block layer. So to me we should get rid of bio_reset()
> and let all the gory details remain in driver.
> 


I disagree. The kind of trick we do where up to BIO_RESET_BYTES
the struct is memset **must** stay at header, very close to the
structure.

I would though make bio_reset() inline at header, it's a single
memset. Even the memset is inlined by the compiler.

> Thanks
> Vivek


Thanks
Boaz
