Return-Path: <philipp.reisner@linbit.com>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 6EEDE1057FE8
	for <drbd-dev@lists.linbit.com>; Mon, 28 Aug 2017 15:35:47 +0200 (CEST)
Received: by mail-wm0-f44.google.com with SMTP id t201so3738993wmt.1
	for <drbd-dev@lists.linbit.com>; Mon, 28 Aug 2017 06:35:47 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Mon, 28 Aug 2017 15:35:44 +0200
Message-ID: <5783324.F96FteIkt8@fat-tyre>
In-Reply-To: <eabff286-68f9-b3b1-9fe9-5f68f26b9bad@kernel.dk>
References: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
	<1503609794-13233-2-git-send-email-philipp.reisner@linbit.com>
	<eabff286-68f9-b3b1-9fe9-5f68f26b9bad@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 01/17] drbd: introduce
	drbd_recv_header_maybe_unplug
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

Am Freitag, 25. August 2017, 19:26:20 CEST schrieb Jens Axboe:
> On 08/24/2017 03:22 PM, Philipp Reisner wrote:
> > +#ifndef blk_queue_plugged
> > +struct drbd_plug_cb {
> > +	struct blk_plug_cb cb;
> > +	struct drbd_request *most_recent_req;
> > +	/* do we need more? */
> > +};
> 
> What is this blk_queue_plugged ifdef?

Facepalm. That escaped from out out-of-tree code. It has compat code
so that it can be compiled with older (distro) kernels. I will resend
it without that.

