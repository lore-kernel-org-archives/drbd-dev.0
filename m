Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
	[209.85.218.66])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 174F0420383
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 17:27:33 +0200 (CEST)
Received: by mail-ej1-f66.google.com with SMTP id h24so23742443ejg.9
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 08:27:33 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	j24sm10354185edq.29.2020.10.12.08.26.32
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 12 Oct 2020 08:26:32 -0700 (PDT)
Resent-Message-ID: <20201012152630.GH2116@soda.linbit>
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net
	[83.223.95.100])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1354F4202AD
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 02:54:10 +0200 (CEST)
Date: Mon, 12 Oct 2020 02:54:10 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Elimar Riesebieter <riesebie@lxtec.de>
Message-ID: <20201012005410.GA28362@wunner.de>
References: <1c700caab1ce71fa144116541471b3f7bb4629fa.1602432204.git.lukas@wunner.de>
	<20201011183930.veucf6z335njrkwe@toy.home.lxtec.de>
	<20201011185117.GA18543@wunner.de>
	<20201011193048.rfe5qvuba2ovrwed@toy.home.lxtec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201011193048.rfe5qvuba2ovrwed@toy.home.lxtec.de>
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

On Sun, Oct 11, 2020 at 09:30:48PM +0200, Elimar Riesebieter wrote:
> * Lukas Wunner <lukas@wunner.de> [2020-10-11 20:51 +0200]:
> > The patch worked for me with v5.3.
> 
> Did you build with brdb master? I used tag 9.0.25-1.

The patch is meant to be applied to the drbd-9.0 branch where all
development seems to happen.  It also applies cleanly to the
drbd-9.0.25-1 tag.

I'm afraid I cannot reproduce the issue you're seeing with your
DKMS package on v4.19.  Using tag drbd-9.0.25-1 and v4.19.95,
the call to __vmalloc() is correctly patched in drbd_bitmap.c
but the build fails for a different reason (conflicting types
for blkdev_issue_zeroout()).  Doesn't look like 4.19 is well
supported.

If you're unsuccessful debugging the build failure on your own,
maybe you can upload your drbd build directory somewhere so I
can take a look.

Thanks,

Lukas
