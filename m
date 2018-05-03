Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9A28B1056F9D
	for <drbd-dev@lists.linbit.com>; Thu,  3 May 2018 16:33:23 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id w194so6690609wmf.2
	for <drbd-dev@lists.linbit.com>; Thu, 03 May 2018 07:33:23 -0700 (PDT)
Date: Thu, 3 May 2018 16:33:21 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Sarah Newman <srn@prgmr.com>
Message-ID: <20180503143321.GW10032@soda.linbit>
References: <1525051158-18696-1-git-send-email-srn@prgmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1525051158-18696-1-git-send-email-srn@prgmr.com>
Cc: philipp.reisner@linbit.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: avoid use-after-free in
	drbd_request_endio
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

On Sun, Apr 29, 2018 at 06:19:18PM -0700, Sarah Newman wrote:
> It appears that bio_put(req->private_bio) may put the bio being
> passed in, after which point accessing bio will no longer be
> valid. Make a local copy of bio->bi_error before then.
> 
> Without this patch, with CONFIG_DEBUG_PAGEALLOC the debug message
> 
> "role( Secondary -> Primary )"
> 
> is followed by
> 
> "BUG: unable to handle kernel paging request"
> 
> This applies to versions before 4e4cbee93d561, first released
> in v4.13. v4.13+ appears to have a similar bug.
> 
> Signed-off-by: Sarah Newman <srn@prgmr.com>

Acked-by: Lars Ellenberg <lars.ellenberg@linbit.com>

The original (out-of-tree) code
is just like the result of your patch,
though obfuscated by compatibility macros.
This was apparently an "upstreaming mishap"
when removing that obfuscation :-(

I think minimal in-tree change would have been:
   req->private_bio = ERR_PTR(bio->bi_error);
   bio_put(bio);

-- 
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD® and LINBIT® are registered trademarks of LINBIT
