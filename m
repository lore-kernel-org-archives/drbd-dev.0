Return-Path: <axboe@kernel.dk>
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
	[209.85.215.178])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1D585420064
	for <drbd-dev@lists.linbit.com>; Tue, 26 Jan 2021 21:11:48 +0100 (CET)
Received: by mail-pg1-f178.google.com with SMTP id b21so5341968pgk.7
	for <drbd-dev@lists.linbit.com>; Tue, 26 Jan 2021 12:11:48 -0800 (PST)
To: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
References: <20210121142150.12998-1-guoqing.jiang@cloud.ionos.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b3880d87-26b8-924d-f674-54c2a671f70f@kernel.dk>
Date: Tue, 26 Jan 2021 13:11:45 -0700
MIME-Version: 1.0
In-Reply-To: <20210121142150.12998-1-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH RESEND] drbd: remove unused argument from
 drbd_request_prepare and __drbd_make_request
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

On 1/21/21 7:21 AM, Guoqing Jiang wrote:
> We can remove start_jif since it is not used by drbd_request_prepare,
> then remove it from __drbd_make_request further.

Applied, thanks.

-- 
Jens Axboe

