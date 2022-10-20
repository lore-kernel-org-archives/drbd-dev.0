Return-Path: <axboe@kernel.dk>
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
	[209.85.216.44])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6BDDF4206CF
	for <drbd-dev@lists.linbit.com>; Thu, 20 Oct 2022 14:47:31 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
	a6-20020a17090abe0600b0020d7c0c6650so3405616pjs.0
	for <drbd-dev@lists.linbit.com>; Thu, 20 Oct 2022 05:47:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
In-Reply-To: <20221020085205.129090-1-christoph.boehmwalder@linbit.com>
References: <20221020085205.129090-1-christoph.boehmwalder@linbit.com>
Message-Id: <166627004940.161439.4764263813482729420.b4-ty@kernel.dk>
Date: Thu, 20 Oct 2022 05:47:29 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2] drbd: only clone bio if we have a backing
	device
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

On Thu, 20 Oct 2022 10:52:05 +0200, Christoph Böhmwalder wrote:
> Commit c347a787e34cb (drbd: set ->bi_bdev in drbd_req_new) moved a
> bio_set_dev call (which has since been removed) to "earlier", from
> drbd_request_prepare to drbd_req_new.
> 
> The problem is that this accesses device->ldev->backing_bdev, which is
> not NULL-checked at this point. When we don't have an ldev (i.e. when
> the DRBD device is diskless), this leads to a null pointer deref.
> 
> [...]

Applied, thanks!

[1/1] drbd: only clone bio if we have a backing device
      commit: 6d42ddf7f27b6723549ee6d4c8b1b418b59bf6b5

Best regards,
-- 
Jens Axboe


