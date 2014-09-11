Return-Path: <axboe@kernel.dk>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
	[209.85.220.53]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 38A67101AC75
	for <drbd-dev@lists.linbit.com>; Thu, 11 Sep 2014 17:39:43 +0200 (CEST)
Received: by mail-pa0-f53.google.com with SMTP id rd3so9290802pab.26
	for <drbd-dev@lists.linbit.com>; Thu, 11 Sep 2014 08:39:41 -0700 (PDT)
Message-ID: <5411BBCA.5070905@kernel.dk>
Date: Thu, 11 Sep 2014 09:12:10 -0600
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org
References: <1410438553-30440-1-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1410438553-30440-1-git-send-email-philipp.reisner@linbit.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 0/9] DRBD updates for 3.18
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

On 2014-09-11 06:29, Philipp Reisner wrote:
> Hi Jens,
>
> please consider to put these patches into your (future) for-3.18/drivers
> branch. I have posted it for review on August 28. It consists mainly of
> minor cleanups, and an important performance improvement. With that
> DRBD was seen to write with 160k IOPS, on SSDs.

Applied, thanks Philipp.

-- 
Jens Axboe

