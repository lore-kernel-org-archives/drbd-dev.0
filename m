Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 73CB110556C8
	for <drbd-dev@lists.linbit.com>; Mon, 29 Aug 2011 16:19:34 +0200 (CEST)
Resent-Message-ID: <20110829141934.GD3435@barkeeper1-xen.linbit>
Received: from mail-iy0-f182.google.com (mail-iy0-f182.google.com
	[209.85.210.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C471210003F7
	for <drbd-dev@lists.linbit.com>; Mon, 29 Aug 2011 15:55:50 +0200 (CEST)
Received: by iadx2 with SMTP id x2so818147iad.27
	for <drbd-dev@lists.linbit.com>; Mon, 29 Aug 2011 06:55:49 -0700 (PDT)
MIME-Version: 1.0
Sender: penberg@gmail.com
In-Reply-To: <201108291351.06092.philipp.reisner@linbit.com>
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
	<20110826135402.GS14479@barkeeper1-xen.linbit>
	<CAGZ=bqJojmtfVjQdbx3j2vZyrz01dZZs7wVqBxNbqreejZu4JQ@mail.gmail.com>
	<201108291351.06092.philipp.reisner@linbit.com>
Date: Mon, 29 Aug 2011 15:52:56 +0300
Message-ID: <CAOJsxLHQFhHaASj9eSJeQ9H_VyS59ztu=caOoUipYEneiB1vAA@mail.gmail.com>
From: Pekka Enberg <penberg@kernel.org>
To: Philipp Reisner <philipp.reisner@linbit.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jens Axboe <axboe@kernel.dk>, Kyle Moffett <kyle@moffetthome.net>,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RFC 000/118] drbd: part 1 of adding multiple volume
 support to drbd
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Aug 29, 2011 at 2:51 PM, Philipp Reisner
<philipp.reisner@linbit.com> wrote:
> The new feature set, might be partially broken, but introducing
> the new features is the whole point of this patch series.

If that new feature can, for example, corrupt your data while you're
doing "git bisect" on non-DRBD regression, that's no good. Can that
happen?

                        Pekka
