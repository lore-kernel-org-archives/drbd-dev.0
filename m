Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 34E271055F5F
	for <drbd-dev@lists.linbit.com>; Wed, 27 May 2015 10:58:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 30D902A0E92
	for <drbd-dev@lists.linbit.com>; Wed, 27 May 2015 10:58:08 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id sjRyJWr6n2tS for <drbd-dev@lists.linbit.com>;
	Wed, 27 May 2015 10:58:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 107173D84CB
	for <drbd-dev@lists.linbit.com>; Wed, 27 May 2015 10:58:08 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gbL6EXYi41l6 for <drbd-dev@lists.linbit.com>;
	Wed, 27 May 2015 10:58:07 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id DB0152A0E92
	for <drbd-dev@lists.linbit.com>; Wed, 27 May 2015 10:58:07 +0200 (CEST)
Resent-Message-ID: <20150527085807.GE18767@soda.linbit>
MIME-Version: 1.0
In-Reply-To: <20150525150827.GA27012@lst.de>
References: <1432318723-18829-1-git-send-email-mlin@kernel.org>
	<1432318723-18829-9-git-send-email-mlin@kernel.org>
	<20150525140413.GA26065@lst.de>
	<CAOi1vP8vNEXw2e1eWa4LqKD14SA7XtSQ_C8+4d_sz20t4nfEng@mail.gmail.com>
	<20150525150827.GA27012@lst.de>
Date: Mon, 25 May 2015 18:19:33 +0300
Message-ID: <CAOi1vP81kGRXjKEgu8+hkvWBZyXP5Q46U2KwPbdiVJsgU70Ocg@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Cc: Jens Axboe <axboe@kernel.dk>, Alex Elder <elder@kernel.org>,
	Sage Weil <sage@inktank.com>, Mike Snitzer <snitzer@redhat.com>,
	Neil Brown <neilb@suse.de>, Jiri Kosina <jkosina@suse.cz>,
	Alex Elder <elder@linaro.org>,
	Ceph Development <ceph-devel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Yehuda Sadeh <yehuda@inktank.com>, linux-raid@vger.kernel.org,
	dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
	Dongsu Park <dpark@posteo.net>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Ming Lin <mlin@kernel.org>, Kent Overstreet <kent.overstreet@gmail.com>,
	drbd-user@lists.linbit.com, Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH v4 08/11] block: kill merge_bvec_fn()
	completely
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

On Mon, May 25, 2015 at 6:08 PM, Christoph Hellwig <hch@lst.de> wrote:
> On Mon, May 25, 2015 at 06:02:30PM +0300, Ilya Dryomov wrote:
>> I'm not Alex, but yeah, we have all the clone/split machinery and so we
>> can handle a spanning case just fine.  I think rbd_merge_bvec() exists
>> to make sure we don't have to do that unless it's really necessary -
>> like when a single page gets submitted at an inconvenient offset.
>>
>> I have a patch that adds a blk_queue_chunk_sectors(object_size) call to
>> rbd_init_disk() but I haven't had a chance to play with it yet.  In any
>> case, we should be fine with getting rid of rbd_merge_bvec().  If this
>> ends up a per-driver patchset, I can make rbd_merge_bvec() ->
>> blk_queue_chunk_sectors() a single patch and push it through
>> ceph-client.git.
>
> Hmm, looks like the new blk_queue_split_bio ignore the chunk_sectors
> value, another thing that needs updating.  I forgot how many weird
> merging hacks we had to add for nvme..
>
> While I'd like to see per-driver patches we'd still need to merge
> them together through the block tree.  Note that with this series
> there won't be any benefit of using blk_queue_chunk_sectors over just
> doing the split in rbd.  Maybe we can even remove it again and do
> that work in the drivers in the future.

OK, I'll drop it, especially if it's potentially on its way out.  With
the fancy striping support, which I'll hopefully get to sometime, the
striping pattern will become much more complicated anyway, so relying
on rbd doing bio splitting is right in the long run as well.

Thanks,

                Ilya
