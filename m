Return-Path: <axboe@kernel.dk>
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com
	[209.85.166.175])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8F78A4205D4
	for <drbd-dev@lists.linbit.com>; Wed,  6 Mar 2024 16:35:31 +0100 (CET)
Received: by mail-il1-f175.google.com with SMTP id
	e9e14a558f8ab-35d374bebe3so5646475ab.1
	for <drbd-dev@lists.linbit.com>; Wed, 06 Mar 2024 07:35:31 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>
In-Reply-To: <20240306140332.623759-1-philipp.reisner@linbit.com>
References: <20240305134041.137006-1-hch@lst.de>
	<20240306140332.623759-1-philipp.reisner@linbit.com>
Subject: Re: [PATCH 0/7] drbd atomic queue limits conversion
Message-Id: <170973932937.23995.12080568570430339256.b4-ty@kernel.dk>
Date: Wed, 06 Mar 2024 08:35:29 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	drbd-dev@lists.linbit.com
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


On Wed, 06 Mar 2024 15:03:25 +0100, Philipp Reisner wrote:
> Here, with the Reviewed-by and Tested-by trailers.
> 
> Christoph Hellwig (7):
>   drbd: pass the max_hw_sectors limit to blk_alloc_disk
>   drbd: refactor drbd_reconsider_queue_parameters
>   drbd: refactor the backing dev max_segments calculation
>   drbd: merge drbd_setup_queue_param into
>     drbd_reconsider_queue_parameters
>   drbd: don't set max_write_zeroes_sectors in decide_on_discard_support
>   drbd: split out a drbd_discard_supported helper
>   drbd: atomically update queue limits in
>     drbd_reconsider_queue_parameters
> 
> [...]

Applied, thanks!

[1/7] drbd: pass the max_hw_sectors limit to blk_alloc_disk
      commit: aa067325c05dc3a3aac588f40cacf8418f916cee
[2/7] drbd: refactor drbd_reconsider_queue_parameters
      commit: 342d81fde24152adf9747e6e126c8c3179d1a54c
[3/7] drbd: refactor the backing dev max_segments calculation
      commit: 2828908d5cc8396e7c91d04d67e03ed834234bcd
[4/7] drbd: merge drbd_setup_queue_param into drbd_reconsider_queue_parameters
      commit: e16344e506314e35b1a5a8ccd7b88f4b1844ebb0
[5/7] drbd: don't set max_write_zeroes_sectors in decide_on_discard_support
      commit: e3992e02c970f6eb803b98b9f733cad40f190161
[6/7] drbd: split out a drbd_discard_supported helper
      commit: 5eaee6e9c8f9940ecee93678972774fb8dd450d5
[7/7] drbd: atomically update queue limits in drbd_reconsider_queue_parameters
      commit: e6dfe748f09e37f77437bd337f891f5b57d5d5a2

Best regards,
-- 
Jens Axboe



