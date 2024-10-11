Return-Path: <axboe@kernel.dk>
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com
	[209.85.166.47])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 82662420304
	for <drbd-dev@lists.linbit.com>; Fri, 11 Oct 2024 19:11:50 +0200 (CEST)
Received: by mail-io1-f47.google.com with SMTP id
	ca18e2360f4ac-8354851fcabso98637839f.2
	for <drbd-dev@lists.linbit.com>; Fri, 11 Oct 2024 10:11:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com, linux@treblig.org
In-Reply-To: <20241010204426.277535-1-linux@treblig.org>
References: <20241010204426.277535-1-linux@treblig.org>
Subject: Re: [PATCH] drbd: Remove unused conn_lowest_minor
Message-Id: <172866670811.255755.445033429638947954.b4-ty@kernel.dk>
Date: Fri, 11 Oct 2024 11:11:48 -0600
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


On Thu, 10 Oct 2024 21:44:26 +0100, linux@treblig.org wrote:
> conn_lowest_minor() last use was removed by 2011 commit
> 69a227731a37 ("drbd: Pass a peer device to a number of fuctions")
> 
> Remove it.
> 
> 

Applied, thanks!

[1/1] drbd: Remove unused conn_lowest_minor
      commit: 1e3fc2000035ffea0b1b7ec2423706715ab2e7f6

Best regards,
-- 
Jens Axboe



