Return-Path: <axboe@kernel.dk>
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
	[209.85.216.53])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 770454205D7
	for <drbd-dev@lists.linbit.com>; Wed,  9 Jun 2021 17:42:31 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id k7so1566134pjf.5
	for <drbd-dev@lists.linbit.com>; Wed, 09 Jun 2021 08:42:31 -0700 (PDT)
To: Zhen Lei <thunder.leizhen@huawei.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev <drbd-dev@lists.linbit.com>,
	linux-block <linux-block@vger.kernel.org>
References: <20210609121426.13936-1-thunder.leizhen@huawei.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <aefad024-73b0-26b2-f02c-fe534df16bbb@kernel.dk>
Date: Wed, 9 Jun 2021 09:42:27 -0600
MIME-Version: 1.0
In-Reply-To: <20210609121426.13936-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] [PATCH 1/1] drbd: remove unnecessary oom message
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

On 6/9/21 6:14 AM, Zhen Lei wrote:
> Fixes scripts/checkpatch.pl warning:
> WARNING: Possible unnecessary 'out of memory' message
> 
> Remove it can help us save a bit of memory.

Applied, thanks.

-- 
Jens Axboe

