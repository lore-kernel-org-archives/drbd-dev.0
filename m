Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
	[209.85.208.67])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6A89A4202B6
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 17:26:28 +0200 (CEST)
Received: by mail-ed1-f67.google.com with SMTP id p13so17404328edi.7
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 08:26:28 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	p3sm10698425edp.28.2020.10.12.08.26.26
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 12 Oct 2020 08:26:27 -0700 (PDT)
Resent-Message-ID: <20201012152625.GF2116@soda.linbit>
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net
	[83.223.78.233])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 182BD42022A
	for <drbd-dev@lists.linbit.com>; Sun, 11 Oct 2020 21:28:47 +0200 (CEST)
Date: Sun, 11 Oct 2020 21:20:12 +0200
From: Elimar Riesebieter <riesebie@lxtec.de>
To: Lukas Wunner <lukas@wunner.de>
Message-ID: <20201011192012.32nul25ez3adzb6q@toy.home.lxtec.de>
References: <1c700caab1ce71fa144116541471b3f7bb4629fa.1602432204.git.lukas@wunner.de>
	<20201011183930.veucf6z335njrkwe@toy.home.lxtec.de>
	<20201011185117.GA18543@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201011185117.GA18543@wunner.de>
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

* Lukas Wunner <lukas@wunner.de> [2020-10-11 20:51 +0200]:

[...]

> Be aware that with DKMS you have
> to patch the source code in /usr/src, then delete the copy in
> /var/lib/dkms such that it is recreated based on the patched
> source code.

This is what my Debian package does automagic ;-)

Elimar
--=20
  Do you smell something burning or is it me?

