Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 818101011BE7
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:15:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 7AE851B4262
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:15:38 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9uei61IKJBOv for <drbd-dev@lists.linbit.com>;
	Thu, 24 May 2012 18:15:38 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 573B71B40FA
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 18:15:38 +0200 (CEST)
Resent-Message-ID: <20120524161538.GQ5734@soda.linbit>
Received: from tyo200.gate.nec.co.jp (TYO200.gate.nec.co.jp [202.32.8.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id F1C2E106DCE1
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 02:28:07 +0200 (CEST)
Received: from tyo202.gate.nec.co.jp ([10.7.69.202])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q4O0S0ws027959
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2012 09:28:01 +0900 (JST)
Message-ID: <4FBD7E80.4020005@ce.jp.nec.com>
Date: Thu, 24 May 2012 09:19:12 +0900
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
MIME-Version: 1.0
To: Kent Overstreet <koverstreet@google.com>
References: <1337817771-25038-1-git-send-email-koverstreet@google.com>
	<1337817771-25038-3-git-send-email-koverstreet@google.com>
In-Reply-To: <1337817771-25038-3-git-send-email-koverstreet@google.com>
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

Hi,

On 05/24/12 09:02, Kent Overstreet wrote:
> @@ -1438,15 +1439,6 @@ void dm_dispatch_request(struct request *rq)
>  }
>  EXPORT_SYMBOL_GPL(dm_dispatch_request);
>  
> -static void dm_rq_bio_destructor(struct bio *bio)
> -{
> -	struct dm_rq_clone_bio_info *info = bio->bi_private;
> -	struct mapped_device *md = info->tio->md;
> -
> -	free_bio_info(info);
> -	bio_free(bio, md->bs);
> -}
> -
>  static int dm_rq_bio_constructor(struct bio *bio, struct bio *bio_orig,
>  				 void *data)
>  {
> @@ -1461,7 +1453,6 @@ static int dm_rq_bio_constructor(struct bio *bio, struct bio *bio_orig,
>  	info->tio = tio;
>  	bio->bi_end_io = end_clone_bio;
>  	bio->bi_private = info;
> -	bio->bi_destructor = dm_rq_bio_destructor;

The destructor may also be called from blk_rq_unprep_clone(),
which just puts bio.
So this patch will introduce a memory leak.

Please check this comment as well:
https://www.redhat.com/archives/dm-devel/2012-May/msg00216.html

Thanks,
-- 
Jun'ichi Nomura, NEC Corporation
