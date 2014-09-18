Return-Path: <axboe@kernel.dk>
Received: from mail-pd0-f171.google.com (mail-pd0-f171.google.com
	[209.85.192.171]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 048E1101E067
	for <drbd-dev@lists.linbit.com>; Thu, 18 Sep 2014 17:07:47 +0200 (CEST)
Received: by mail-pd0-f171.google.com with SMTP id y13so554715pdi.16
	for <drbd-dev@lists.linbit.com>; Thu, 18 Sep 2014 08:07:45 -0700 (PDT)
Message-ID: <541AF3A8.3000900@kernel.dk>
Date: Thu, 18 Sep 2014 09:00:56 -0600
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org
References: <1411051782-23375-1-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1411051782-23375-1-git-send-email-philipp.reisner@linbit.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michel Lespinasse <walken@google.com>, Lai Jiangshan <laijs@cn.fujitsu.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 0/2] More for the 3.18 merge window
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

On 2014-09-18 08:49, Philipp Reisner wrote:
> Hi Jens,
>
> please put these two patches into your for-3.18/drivers branch.  They fix
> the safety code for concurrent overlapping write detection in a DRBD
> dual primary setup.
>
> The first of those two should also go to the stable kernels, I marked it
> with CC: stable@kernel.org

Applied, thanks.

-- 
Jens Axboe

