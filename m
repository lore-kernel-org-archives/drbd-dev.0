Return-Path: <axboe@kernel.dk>
Received: from mail-pb0-f44.google.com (mail-pb0-f44.google.com
	[209.85.160.44]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 482D1101AC78
	for <drbd-dev@lists.linbit.com>; Wed, 25 Jun 2014 18:01:24 +0200 (CEST)
Received: by mail-pb0-f44.google.com with SMTP id md12so1886268pbc.31
	for <drbd-dev@lists.linbit.com>; Wed, 25 Jun 2014 09:01:23 -0700 (PDT)
Message-ID: <53AAF128.1030800@kernel.dk>
Date: Wed, 25 Jun 2014 09:56:24 -0600
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org
References: <1403711558-27267-1-git-send-email-philipp.reisner@linbit.com>
	<1403711558-27267-2-git-send-email-philipp.reisner@linbit.com>
In-Reply-To: <1403711558-27267-2-git-send-email-philipp.reisner@linbit.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: fix NULL pointer deref in
	blk_add_request_payload
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

On 06/25/2014 09:52 AM, Philipp Reisner wrote:
> From: Lars Ellenberg <lars.ellenberg@linbit.com>
> 
> Discards don't have any payload.
> But the scsi layer still expects a bio_vec it can use internally,
> see sd_setup_discard_cmnd() and blk_add_request_payload().
> 
> Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
> Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>

Applied, thanks.

-- 
Jens Axboe

