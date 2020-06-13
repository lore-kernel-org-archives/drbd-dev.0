Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8D4DB420425
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 11:58:40 +0200 (CEST)
Received: by mail-wr1-f65.google.com with SMTP id j10so12280800wrw.8
	for <drbd-dev@lists.linbit.com>; Sat, 13 Jun 2020 02:58:40 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	m129sm13899319wmf.2.2020.06.13.02.58.39
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Jun 2020 02:58:39 -0700 (PDT)
Resent-Message-ID: <20200613095838.GV4222@soda.linbit>
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net
	[5.45.199.163])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1E6574202C3
	for <drbd-dev@lists.linbit.com>; Mon, 25 May 2020 14:34:24 +0200 (CEST)
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20200525113014.345997-1-hch@lst.de>
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <81f4057b-124a-d0e7-94af-15a198d48d50@yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <20200525113014.345997-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Cc: linux-nvdimm@lists.01.org, linux-bcache@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Minchan Kim <minchan@kernel.org>, dm-devel@redhat.com,
	Nitin Gupta <ngupta@vflare.org>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] block I/O accounting improvements
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>
Date: Sat, 13 Jun 2020 10:18:48 -0000

On 25/05/2020 14.29, Christoph Hellwig wrote:
> Hi Jens,
> 
> they series contains various improvement for block I/O accounting.  The
> first bunch of patches switch the bio based drivers to better accounting
> helpers compared to the current mess.  The end contains a fix and various
> performanc improvements.  Most of this comes from a series Konstantin
> sent a few weeks ago, rebased on changes that landed in your tree since
> and my change to always use the percpu version of the disk stats.
> 

Thanks for picking this up.

One note about possible further improvement in reply to first patch.

Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
