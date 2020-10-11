Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
	[209.85.218.66])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C8A494202B6
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 17:27:25 +0200 (CEST)
Received: by mail-ej1-f66.google.com with SMTP id dt13so23761020ejb.12
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 08:27:25 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	p15sm5145557eji.40.2020.10.12.08.26.24
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 12 Oct 2020 08:26:25 -0700 (PDT)
Resent-Message-ID: <20201012152623.GE2116@soda.linbit>
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net
	[83.223.95.100])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D9ACD42022A
	for <drbd-dev@lists.linbit.com>; Sun, 11 Oct 2020 21:03:44 +0200 (CEST)
Date: Sun, 11 Oct 2020 20:55:45 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Elimar Riesebieter <riesebie@lxtec.de>
Message-ID: <20201011185545.GB18543@wunner.de>
References: <1c700caab1ce71fa144116541471b3f7bb4629fa.1602432204.git.lukas@wunner.de>
	<20201011183930.veucf6z335njrkwe@toy.home.lxtec.de>
	<20201011184741.c766frixh5v7xgyb@toy.home.lxtec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201011184741.c766frixh5v7xgyb@toy.home.lxtec.de>
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

On Sun, Oct 11, 2020 at 08:47:41PM +0200, Elimar Riesebieter wrote:
> * Elimar Riesebieter <riesebie@lxtec.de> [2020-10-11 20:39 +0200]:
> > /var/lib/dkms/drbd/9.0.25-1hsh2/build/src/drbd/drbd_bitmap.c: In function "bm_realloc_pages":
> > /var/lib/dkms/drbd/9.0.25-1hsh2/build/src/drbd/drbd_bitmap.c:368:15: error: too few arguments to function "__vmalloc"
> 
> This was on 4.19. I think the changes must depend on KVERS as the
> modules should build from 4.19 upwards. Will try your patch against
> 5.8 tomorrow.

The patch tests whether __vmalloc() expects 2 arguments and applies
the coccinelle patch if not.  The coccinelle patch adds the third
argument to the __vmalloc() invocation.  This works independently
of the specific kernel version.

Thanks,

Lukas
