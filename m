Return-Path: <axboe@kernel.dk>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
	[209.85.212.175]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A7561101E05A
	for <drbd-dev@lists.linbit.com>; Thu, 10 Jul 2014 22:11:21 +0200 (CEST)
Received: by mail-wi0-f175.google.com with SMTP id ho1so5214640wib.2
	for <drbd-dev@lists.linbit.com>; Thu, 10 Jul 2014 13:11:21 -0700 (PDT)
Message-ID: <53BEF367.6060703@kernel.dk>
Date: Thu, 10 Jul 2014 22:11:19 +0200
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org
References: <14195494.KgRksUidBS@fat-tyre> <1620384.qJGGe2kQsK@fat-tyre>
In-Reply-To: <1620384.qJGGe2kQsK@fat-tyre>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] DRBD updates for your for-3.17/drivers
	branch
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

On 2014-07-10 18:47, Philipp Reisner wrote:
> Hi Jens,
>
> shame on me. The previous pull request had a mistake in commit
> 7 'drbd: get rid of atomic update on disk bitmap works'.
> It missed the function drbd_bm_write_lazy() in drbd_bitmap.c.
> My test procedure only had a module build, but that does not
> unveil a completely missed function.
>
> Here is a branch with that mistake corrected.
>
> The following changes since commit 6a27b656fc0210e976db362e1368c56db05c8f08:
>
>    block: virtio-blk: support multi virt queues per virtio-blk device (2014-07-01 10:51:03 -0600)
>
> are available in the git repository at:
>
>    git://git.linbit.com/linux-drbd.git for-3.17v2
>
> for you to fetch changes up to bf0d6e4a1138e71cafdbbb99cde430eee50c4ff1:
>
>    drbd: silence underflow warning in read_in_block() (2014-07-10 18:35:23 +0200)

Pulled your updated variant, thanks.

-- 
Jens Axboe

