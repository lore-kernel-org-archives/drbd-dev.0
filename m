Return-Path: <axboe@kernel.dk>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
	[209.85.220.52]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A3464101E064
	for <drbd-dev@lists.linbit.com>; Mon, 10 Nov 2014 18:08:50 +0100 (CET)
Received: by mail-pa0-f52.google.com with SMTP id fa1so8638992pad.11
	for <drbd-dev@lists.linbit.com>; Mon, 10 Nov 2014 09:08:48 -0800 (PST)
Message-ID: <5460EA16.1060908@kernel.dk>
Date: Mon, 10 Nov 2014 09:38:46 -0700
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org
References: <1415636475-7883-1-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1415636475-7883-1-git-send-email-philipp.reisner@linbit.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 0/7] DRBD updates for the 3.19 merge window
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

On 2014-11-10 09:21, Philipp Reisner wrote:
> Hi Jens,
>
> please take these patches for you for-3.19/drivers branch.
> They where posted for review on 2014-10-29.
>
> Some cleanups and 3 fixes. Two of them marked for stable:
> 0005-drbd-merge_bvec_fn-properly-remap-bvm-bi_bdev.patch and
> 0006-drbd-Fix-state-change-in-case-of-connection-timeout.patch
> (marked for stable)

Applied, thanks.

-- 
Jens Axboe

