Return-Path: <axboe@kernel.dk>
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
	[209.85.222.195])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C72AD4203E2
	for <drbd-dev@lists.linbit.com>; Thu, 12 Mar 2020 15:13:50 +0100 (CET)
Received: by mail-qk1-f195.google.com with SMTP id c145so6336494qke.12
	for <drbd-dev@lists.linbit.com>; Thu, 12 Mar 2020 07:13:50 -0700 (PDT)
To: Jackie Liu <liuyun01@tj.kylinos.cn>
References: <20200307023925.20789-1-liuyun01@tj.kylinos.cn>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <116082a5-7942-3215-c81f-50253376a6fd@kernel.dk>
Date: Thu, 12 Mar 2020 07:49:20 -0600
MIME-Version: 1.0
In-Reply-To: <20200307023925.20789-1-liuyun01@tj.kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] block/drbd: delete invalid function
	drbd_md_mark_dirty_
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

On 3/6/20 7:39 PM, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> We deleted last_md_mark_dirty long ago, this function no longer needs to
> exist, delete it, otherwise a compilation error will occur when DEBUG is
> opened.

Applied, thanks.

-- 
Jens Axboe

