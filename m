Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8A7641057FF0
	for <drbd-dev@lists.linbit.com>; Thu, 10 Aug 2017 14:21:05 +0200 (CEST)
Received: by mail-wm0-f54.google.com with SMTP id t201so18327022wmt.1
	for <drbd-dev@lists.linbit.com>; Thu, 10 Aug 2017 05:21:05 -0700 (PDT)
Date: Thu, 10 Aug 2017 14:21:01 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: Nick Wang <nwang@suse.com>
Message-ID: <20170810122100.GC15992@rck.sh>
References: <20170810081957.18681-1-nwang@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170810081957.18681-1-nwang@suse.com>
Cc: jfehlig@suse.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] block-drbd: Update block-drbd script to
 support modern Xen
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

On Thu, Aug 10, 2017 at 04:19:57PM +0800, Nick Wang wrote:
> The xm/xend toolstack has long been removed from Xen and replaced
> with xl/libxl. The legacy xmdomain.cfg(5) configuration format is
> still supported for backward compatibility, but xl.cfg(5) format
> is preferred. Update the script documenation to reflect this.
> 
> When the legacy format is used, libxl places the entire target
> string in $XENBUS_PATH/params, e.g. 'drbd:myresource'. To ensure
> the script continues to work with the legacy configuration format,
> strip any 'drbd:' prefix from the resource identifier read from
> xenstore.

Merged.

Thanks, rck
