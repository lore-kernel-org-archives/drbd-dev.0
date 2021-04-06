Return-Path: <axboe@kernel.dk>
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
	[209.85.214.174])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C19274205D5
	for <drbd-dev@lists.linbit.com>; Tue,  6 Apr 2021 17:31:50 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id g10so7700030plt.8
	for <drbd-dev@lists.linbit.com>; Tue, 06 Apr 2021 08:31:50 -0700 (PDT)
To: Huang Guobin <huangguobin4@huawei.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
References: <1617710988-49205-1-git-send-email-huangguobin4@huawei.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <55e93aa0-cf16-51b0-ae0a-c561fc36a550@kernel.dk>
Date: Tue, 6 Apr 2021 09:31:50 -0600
MIME-Version: 1.0
In-Reply-To: <1617710988-49205-1-git-send-email-huangguobin4@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH -next] drbd: use DEFINE_SPINLOCK() for
	spinlock
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

On 4/6/21 6:09 AM, Huang Guobin wrote:
> From: Guobin Huang <huangguobin4@huawei.com>
> 
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().

Applied, thanks.

-- 
Jens Axboe

