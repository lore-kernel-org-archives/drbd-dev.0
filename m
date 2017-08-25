Return-Path: <axboe@kernel.dk>
Received: from mail-io0-f169.google.com (mail-io0-f169.google.com
	[209.85.223.169])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 78CEC1057FE8
	for <drbd-dev@lists.linbit.com>; Fri, 25 Aug 2017 19:33:30 +0200 (CEST)
Received: by mail-io0-f169.google.com with SMTP id c18so1629744ioj.1
	for <drbd-dev@lists.linbit.com>; Fri, 25 Aug 2017 10:33:30 -0700 (PDT)
To: Philipp Reisner <philipp.reisner@linbit.com>, linux-kernel@vger.kernel.org
References: <1503609794-13233-1-git-send-email-philipp.reisner@linbit.com>
	<1503609794-13233-2-git-send-email-philipp.reisner@linbit.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <eabff286-68f9-b3b1-9fe9-5f68f26b9bad@kernel.dk>
Date: Fri, 25 Aug 2017 11:26:20 -0600
MIME-Version: 1.0
In-Reply-To: <1503609794-13233-2-git-send-email-philipp.reisner@linbit.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: drbd-dev@lists.linbit.com
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

On 08/24/2017 03:22 PM, Philipp Reisner wrote:
> +#ifndef blk_queue_plugged
> +struct drbd_plug_cb {
> +	struct blk_plug_cb cb;
> +	struct drbd_request *most_recent_req;
> +	/* do we need more? */
> +};

What is this blk_queue_plugged ifdef?

-- 
Jens Axboe

