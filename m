Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D559E103B4D5
	for <drbd-dev@lists.linbit.com>; Thu, 16 Aug 2012 20:17:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id CE6911B4361
	for <drbd-dev@lists.linbit.com>; Thu, 16 Aug 2012 20:17:08 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kPsxL3vFg0Dk for <drbd-dev@lists.linbit.com>;
	Thu, 16 Aug 2012 20:17:08 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id B438C1B435E
	for <drbd-dev@lists.linbit.com>; Thu, 16 Aug 2012 20:17:08 +0200 (CEST)
Resent-Message-ID: <20120816181708.GG8189@soda.linbit>
Received: from tyo200.gate.nec.co.jp (TYO200.gate.nec.co.jp [202.32.8.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 67E5D1013804
	for <drbd-dev@lists.linbit.com>; Tue, 14 Aug 2012 07:48:03 +0200 (CEST)
Received: from tyo202.gate.nec.co.jp ([10.7.69.202])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7E5m0U3014016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <drbd-dev@lists.linbit.com>; Tue, 14 Aug 2012 14:48:00 +0900 (JST)
Message-ID: <5029E320.3050603@ce.jp.nec.com>
Date: Tue, 14 Aug 2012 14:33:20 +0900
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
MIME-Version: 1.0
To: Kent Overstreet <koverstreet@google.com>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-3-git-send-email-koverstreet@google.com>
In-Reply-To: <1344290921-25154-3-git-send-email-koverstreet@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: axboe@kernel.dk, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	tj@kernel.org, sage@newdream.net, agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 02/12] dm: Use bioset's front_pad for
	dm_rq_clone_bio_info
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 08/07/12 07:08, Kent Overstreet wrote:
>  struct dm_rq_clone_bio_info {
>  	struct bio *orig;
>  	struct dm_rq_target_io *tio;
> +	struct bio clone;
>  };
...
> -	pools->bs = bioset_create(pool_size, 0);
> +	pools->bs = bioset_create(pool_size,
> +				  offsetof(struct dm_rq_clone_bio_info, orig));
>  	if (!pools->bs)
>  		goto free_tio_pool_and_out;

Shouldn't this be offsetof(struct dm_rq_clone_bio_info, clone)?

-- 
Jun'ichi Nomura, NEC Corporation
