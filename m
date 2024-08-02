Return-Path: <axboe@kernel.dk>
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com
	[209.85.166.177])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 633DD420639
	for <drbd-dev@lists.linbit.com>; Fri,  2 Aug 2024 21:37:41 +0200 (CEST)
Received: by mail-il1-f177.google.com with SMTP id
	e9e14a558f8ab-39aeccc64e8so3306575ab.2
	for <drbd-dev@lists.linbit.com>; Fri, 02 Aug 2024 12:37:41 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com, brauner@kernel.org,
	Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <20240802095147.2788218-1-yuehaibing@huawei.com>
References: <20240802095147.2788218-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] drbd: Remove unused extern declarations
Message-Id: <172262745942.170878.5478919565358638351.b4-ty@kernel.dk>
Date: Fri, 02 Aug 2024 13:37:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
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


On Fri, 02 Aug 2024 17:51:47 +0800, Yue Haibing wrote:
> Commit b411b3637fa7 ("The DRBD driver") declared but never implemented
> drbd_read_remote(), is_valid_ar_handle() and drbd_set_recv_tcq().
> And commit 668700b40a7c ("drbd: Create a dedicated workqueue for sending acks on the control connection")
> never implemented drbd_send_ping_wf().
> 
> Commit 2451fc3b2bd3 ("drbd: Removed the BIO_RW_BARRIER support form the receiver/epoch code")
> leave w_e_reissue() declaration unused.
> 
> [...]

Applied, thanks!

[1/1] drbd: Remove unused extern declarations
      commit: f48ada402d2f1e46fa241bcc6725bdde70725e15

Best regards,
-- 
Jens Axboe



