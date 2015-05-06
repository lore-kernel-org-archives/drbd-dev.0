Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A5D9A10556D9
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 9FF84449119
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:43 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id j7MK8CigOL5G for <drbd-dev@lists.linbit.com>;
	Thu,  7 May 2015 11:35:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 8161544A5E5
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:43 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id g4wJuRTe2i0C for <drbd-dev@lists.linbit.com>;
	Thu,  7 May 2015 11:35:43 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 576A5449119
	for <drbd-dev@lists.linbit.com>; Thu,  7 May 2015 11:35:43 +0200 (CEST)
Resent-Message-ID: <20150507093543.GX18767@soda.linbit>
MIME-Version: 1.0
In-Reply-To: <20150506064849.GB5181@infradead.org>
References: <1430203717-13307-1-git-send-email-mlin@kernel.org>
	<1430203717-13307-2-git-send-email-mlin@kernel.org>
	<20150428114320.GA9790@lst.de> <5549AFD4.5020803@kernel.org>
	<20150506064849.GB5181@infradead.org>
Date: Wed, 6 May 2015 00:13:14 -0700
Message-ID: <CAF1ivSZKSEfvXg_EUWkxkigLPVZNxQ0uEY7kns8CfE=nfLrCoQ@mail.gmail.com>
From: Ming Lin <mlin@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset=UTF-8
Cc: Mike Snitzer <snitzer@redhat.com>, Neil Brown <neilb@suse.de>,
	Ming Lei <ming.lei@canonical.com>,
	Keith Busch <keith.busch@intel.com>, dm-devel@redhat.com,
	Joshua Morris <josh.h.morris@us.ibm.com>, Alasdair Kergon <agk@redhat.com>,
	Lars Ellenberg <drbd-dev@lists.linbit.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Nitin Gupta <ngupta@vflare.org>, Oleg Drokin <oleg.drokin@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Ming Lin <mlin@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Andreas Dilger <andreas.dilger@intel.com>,
	Geoff Levand <geoff@infradead.org>, Jiri Kosina <jkosina@suse.cz>,
	lkml <linux-kernel@vger.kernel.org>, Jim Paris <jim@jtan.com>,
	Minchan Kim <minchan@kernel.org>, Christoph Hellwig <hch@lst.de>,
	drbd-user@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 01/10] block: make generic_make_request
 handle arbitrarily sized bios
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

On Tue, May 5, 2015 at 11:48 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, May 05, 2015 at 11:08:20PM -0700, Ming Lin wrote:
>> How about below incremental patch?
>
>> -
>> -             /*
>> -              * If the queue doesn't support SG gaps and adding this
>> -              * offset would create a gap, disallow it.
>> -              */
>> -             if (q->queue_flags & (1 << QUEUE_FLAG_SG_GAPS) &&
>> -                 bvec_gap_to_prev(prev, offset))
>> -                     return 0;
>
> You need to keep the explicit checks for the BLOCK_PC case, as we can't
> split those.

I'll keep it. Thanks.

>
> Otherwise it looks fine.
