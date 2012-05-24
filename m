Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0B73E1005420
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:15:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 04B441B4268
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:15:47 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wtmwx4Z8uYpV for <drbd-dev@lists.linbit.com>;
	Thu, 24 May 2012 18:15:46 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id DA68D1B4262
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:15:46 +0200 (CEST)
Resent-Message-ID: <20120524161546.GS5734@soda.linbit>
Received: from tyo201.gate.nec.co.jp (TYO201.gate.nec.co.jp [202.32.8.193])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BDBD11013802
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 03:16:48 +0200 (CEST)
Message-ID: <4FBD8BD9.8070708@ce.jp.nec.com>
Date: Thu, 24 May 2012 10:16:09 +0900
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
MIME-Version: 1.0
To: Kent Overstreet <koverstreet@google.com>
References: <1337817771-25038-1-git-send-email-koverstreet@google.com>
	<1337817771-25038-3-git-send-email-koverstreet@google.com>
	<4FBD7E80.4020005@ce.jp.nec.com>
	<20120524003915.GA27443@google.com>
In-Reply-To: <20120524003915.GA27443@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: axboe@kernel.dk, device-mapper development <dm-devel@redhat.com>,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, mpatocka@redhat.com,
	agk@redhat.com, bharrosh@panasas.com,
	linux-fsdevel@vger.kernel.org, yehuda@hq.newdream.net,
	drbd-dev@lists.linbit.com, vgoyal@redhat.com, sage@newdream.net
Subject: Re: [Drbd-dev] [dm-devel] [PATCH v2 02/14] dm: kill
	dm_rq_bio_destructor
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 05/24/12 09:39, Kent Overstreet wrote:
> On Thu, May 24, 2012 at 09:19:12AM +0900, Jun'ichi Nomura wrote:
>> The destructor may also be called from blk_rq_unprep_clone(),
>> which just puts bio.
>> So this patch will introduce a memory leak.
> 
> Well, keeping around bi_destructor solely for that reason would be
> pretty lousy. Can you come up with a better solution?

I don't have good one but here are some ideas:
  a) Do bio_endio() rather than bio_put() in blk_rq_unprep_clone()
     and let bi_end_io reap additional data.
     It looks ugly.
  b) Separate the constructor from blk_rq_prep_clone().
     dm has to do rq_for_each_bio loop again for constructor.
     Possible performance impact.
  c) Open code blk_rq_prep/unprep_clone() in dm.
     It exposes unnecessary block-internals to dm.
  d) Pass destructor function to blk_rq_prep/unprep_clone()
     for them to callback.

Umm, is "d)" better?
-- 
Jun'ichi Nomura, NEC Corporation
