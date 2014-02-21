Return-Path: <axboe@kernel.dk>
Received: from mail-pb0-f43.google.com (mail-pb0-f43.google.com
	[209.85.160.43]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4F160101AC79
	for <drbd-dev@lists.linbit.com>; Sat, 22 Feb 2014 01:07:57 +0100 (CET)
Received: by mail-pb0-f43.google.com with SMTP id ma3so1484223pbc.30
	for <drbd-dev@lists.linbit.com>; Fri, 21 Feb 2014 16:07:55 -0800 (PST)
Date: Fri, 21 Feb 2014 15:42:53 -0800
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <20140221234253.GD29129@kernel.dk>
References: <20140218202054.GD25515@kernel.dk>
	<1392803347-6075-1-git-send-email-philipp.reisner@linbit.com>
	<1392803347-6075-2-git-send-email-philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392803347-6075-2-git-send-email-philipp.reisner@linbit.com>
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: Fix future possible NULL pointer
	dereference
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

On Wed, Feb 19 2014, Philipp Reisner wrote:
> From: Andreas Gruenbacher <agruen@linbit.com>
> 
> Right now every resource has exactly one connection. But we are preparing
> for dynamic connections. I.e. in the future thre can be resources without
> connections.
> 
> However smatch points this out as 'variable dereferenced before check',
> which is correct.
> 
> This issue was introduced in
> drbd: get_one_status(): Iterate over resource->devices instead of connection->peer_devices

Applied, thanks.

-- 
Jens Axboe

