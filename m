Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8F0CA10003DC
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 88BEB1B435D
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:03 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cXzaZvzVgov9 for <drbd-dev@lists.linbit.com>;
	Wed, 30 May 2012 10:41:03 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 6CAA61B435C
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:41:03 +0200 (CEST)
Resent-Message-ID: <20120530084103.GM4141@soda.linbit>
Received: from tyo202.gate.nec.co.jp (TYO202.gate.nec.co.jp [202.32.8.206])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 39DA21019A68
	for <drbd-dev@lists.linbit.com>; Mon, 28 May 2012 13:42:16 +0200 (CEST)
Message-ID: <4FC3645E.8040901@ce.jp.nec.com>
Date: Mon, 28 May 2012 20:41:18 +0900
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
MIME-Version: 1.0
To: Kent Overstreet <koverstreet@google.com>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
	<1337977539-16977-3-git-send-email-koverstreet@google.com>
	<4FC2CD93.1080009@ce.jp.nec.com>
In-Reply-To: <4FC2CD93.1080009@ce.jp.nec.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: axboe@kernel.dk, linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	device-mapper development <dm-devel@redhat.com>,
	mpatocka@redhat.com, vgoyal@redhat.com, sage@newdream.net,
	bharrosh@panasas.com, tj@kernel.org, yehuda@hq.newdream.net,
	agk@redhat.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [dm-devel] [PATCH v3 02/16] dm: Use bioset's
	front_pad for dm_rq_clone_bio_info
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 05/28/12 09:57, Jun'ichi Nomura wrote:
> On 05/26/12 05:25, Kent Overstreet wrote:
>> -	pools->bs = bioset_create(pool_size, 0);
>> +	pools->bs = bioset_create(pool_size,
>> +				  offsetof(struct dm_rq_clone_bio_info, orig));
>>  	if (!pools->bs)
>>  		goto free_tio_pool_and_out;
> 
> Did you mean offset of *clone*?
> "offsetof(struct dm_rq_clone_bio_info, orig)" is zero.

Additional comment:
frontpad is not necessary if type is DM_TYPE_BIO_BASED.
Please check conditional switches done in the same function for
pools->tio_pool.

-- 
Jun'ichi Nomura, NEC Corporation
