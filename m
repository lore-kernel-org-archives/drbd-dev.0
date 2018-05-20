Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4364F1005404
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2018 15:40:31 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id j5-v6so9315595wme.5
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2018 06:40:31 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	j22-v6sm9928898edq.92.2018.05.23.06.40.29
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 23 May 2018 06:40:30 -0700 (PDT)
Resent-Message-ID: <20180523134028.GQ499@soda.linbit>
Received: from mail-lf0-f66.google.com (mail-lf0-f66.google.com
	[209.85.215.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5B115101AC56
	for <drbd-dev@lists.linbit.com>; Mon, 21 May 2018 01:18:24 +0200 (CEST)
Received: by mail-lf0-f66.google.com with SMTP id w202-v6so21231565lff.12
	for <drbd-dev@lists.linbit.com>; Sun, 20 May 2018 16:18:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87603i0vtx.fsf@notabene.neil.brown.name>
References: <20180520222558.7053-1-kent.overstreet@gmail.com>
	<87603i0vtx.fsf@notabene.neil.brown.name>
From: Kent Overstreet <kent.overstreet@gmail.com>
Date: Sun, 20 May 2018 19:11:48 -0400
Message-ID: <CAC7rs0vUCMuCvNez4Rr0M=OFEokKbL92e_R-M3nJ-gfoaLhgxw@mail.gmail.com>
To: NeilBrown <neilb@suse.com>
Content-Type: text/plain; charset="UTF-8"
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	"open list:SOFTWARE RAID \(Multiple Disks\) SUPPORT"
	<linux-raid@vger.kernel.org>, Mike Snitzer <snitzer@redhat.com>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Coly Li <colyli@suse.de>, linux-block <linux-block@vger.kernel.org>,
	Chris Mason <clm@fb.com>, bacik@fb.com,
	Shaohua Li <shli@kernel.org>, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 00/13] convert block layer to
	bioset_init()/mempool_init()
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

Thanks - sending it to him

On Sun, May 20, 2018 at 7:08 PM, NeilBrown <neilb@suse.com> wrote:
> On Sun, May 20 2018, Kent Overstreet wrote:
>
>> Jens - this series does the rest of the conversions that Christoph wanted, and
>> drops bioset_create().
>>
>> Only lightly tested, but the changes are pretty mechanical. Based on your
>> for-next tree.
>>
>> It's also in the for-jens branch at https://evilpiepirate.org/git/bcachefs.git
>>
>> Kent Overstreet (12):
>>   block: convert bounce, q->bio_split to bioset_init()/mempool_init()
>>   drbd: convert to bioset_init()/mempool_init()
>>   pktcdvd: convert to bioset_init()/mempool_init()
>>   lightnvm: convert to bioset_init()/mempool_init()
>>   bcache: convert to bioset_init()/mempool_init()
>>   md: convert to bioset_init()/mempool_init()
>
> Hi Kent,
>  this conversion looks really good, thanks for Ccing me on it.
>  However as Shaohua Li is now the maintainer of md, it probably should
>  have gone to him as well.
>
> Thanks,
> NeilBrown
