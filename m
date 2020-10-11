Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
	[209.85.208.68])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 833F1420323
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 17:26:23 +0200 (CEST)
Received: by mail-ed1-f68.google.com with SMTP id t21so17399203eds.6
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 08:26:23 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	q27sm10916076ejd.74.2020.10.12.08.26.22
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 12 Oct 2020 08:26:22 -0700 (PDT)
Resent-Message-ID: <20201012152620.GD2116@soda.linbit>
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net
	[83.223.78.240])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C3B5342022A
	for <drbd-dev@lists.linbit.com>; Sun, 11 Oct 2020 20:58:38 +0200 (CEST)
Date: Sun, 11 Oct 2020 20:51:17 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Elimar Riesebieter <riesebie@lxtec.de>
Message-ID: <20201011185117.GA18543@wunner.de>
References: <1c700caab1ce71fa144116541471b3f7bb4629fa.1602432204.git.lukas@wunner.de>
	<20201011183930.veucf6z335njrkwe@toy.home.lxtec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201011183930.veucf6z335njrkwe@toy.home.lxtec.de>
Cc: Michael Hierweck <michael.hierweck@hostsharing.net>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH drbd-9.0] compat: __vmalloc() pgprot argument
 was removed in v5.8
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

On Sun, Oct 11, 2020 at 08:39:30PM +0200, Elimar Riesebieter wrote:
> Applied that patch to tag 9.0.25-1. Building the module via dkms
> gives:
> 
> /var/lib/dkms/drbd/9.0.25-1hsh2/build/src/drbd/drbd_bitmap.c: In function ???bm_realloc_pages???:
> /var/lib/dkms/drbd/9.0.25-1hsh2/build/src/drbd/drbd_bitmap.c:368:15: error: too few arguments to function ???__vmalloc???
>    new_pages = __vmalloc(bytes,
>                ^~~~~~~~~
> In file included from /var/lib/dkms/drbd/9.0.25-1hsh2/build/src/drbd/drbd_bitmap.c:16:
> /usr/src/linux-headers-4.19.0-9-common/include/linux/vmalloc.h:80:14: note: declared here
>  extern void *__vmalloc(unsigned long size, gfp_t gfp_mask, pgprot_t prot);
>               ^~~~~~~~~

The patch worked for me with v5.3.  Be aware that with DKMS you have
to patch the source code in /usr/src, then delete the copy in
/var/lib/dkms such that it is recreated based on the patched
source code.

Thanks,

Lukas
