Return-Path: <bart.vanassche@gmail.com>
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
	[209.85.215.176])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 417FA4205C4
	for <drbd-dev@lists.linbit.com>; Tue,  6 Apr 2021 23:00:36 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id w10so5814098pgh.5
	for <drbd-dev@lists.linbit.com>; Tue, 06 Apr 2021 14:00:36 -0700 (PDT)
To: Lee Jones <lee.jones@linaro.org>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
	<20210312105530.2219008-3-lee.jones@linaro.org>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <ed6f1b85-ba63-52fd-16f2-cd8777c3fdd0@acm.org>
Date: Tue, 6 Apr 2021 14:00:34 -0700
MIME-Version: 1.0
In-Reply-To: <20210312105530.2219008-3-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 02/11] block: drbd: drbd_interval: Demote
 some kernel-doc abuses and fix another header
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

On 3/12/21 2:55 AM, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> [ ... ]

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
