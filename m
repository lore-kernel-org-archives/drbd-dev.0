Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
	[209.85.128.47])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 167FF1011BFC
	for <drbd-dev@lists.linbit.com>; Wed, 12 Jun 2019 16:10:24 +0200 (CEST)
Received: by mail-wm1-f47.google.com with SMTP id z23so6703686wma.4
	for <drbd-dev@lists.linbit.com>; Wed, 12 Jun 2019 07:10:24 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219])
	by smtp.gmail.com with ESMTPSA id r131sm146453wmf.4.2019.06.12.07.10.22
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 12 Jun 2019 07:10:22 -0700 (PDT)
Date: Wed, 12 Jun 2019 16:10:21 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20190612141021.GZ5803@soda.linbit>
References: <456e2172-20fa-7b9d-47db-466f41123571@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <456e2172-20fa-7b9d-47db-466f41123571@gmail.com>
Subject: Re: [Drbd-dev] Avoid compiler warning about non-bool in logical
 expression
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

On Wed, Jun 05, 2019 at 10:07:51AM -0600, David Butterfield wrote:
> Avoid a compiler warning:
>     drbd_receiver.c:1693:12: warning: logical ‘and’ applied to non-boolean constant [-Wlogical-op]

I don't care.

> diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
> @@ -1690,7 +1690,7 @@ next_bio:
>                 bio->bi_next = NULL;
> 
>                 /* strip off REQ_UNPLUG unless it is the last bio */
> -               if (bios && DRBD_REQ_UNPLUG)
> +               if (bios && (DRBD_REQ_UNPLUG != 0))
>                         bio->bi_opf &= ~DRBD_REQ_UNPLUG;
>                 drbd_generic_make_request(device, fault_type, bio);
