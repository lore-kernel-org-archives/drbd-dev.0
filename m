Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
	[209.85.218.68])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7B67B420385
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 17:27:37 +0200 (CEST)
Received: by mail-ej1-f68.google.com with SMTP id lw21so23759581ejb.6
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 08:27:37 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	u24sm1282996edo.92.2020.10.12.08.26.36
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 12 Oct 2020 08:26:36 -0700 (PDT)
Resent-Message-ID: <20201012152634.GJ2116@soda.linbit>
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net
	[83.223.95.204])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 18DF54202E2
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 13:14:40 +0200 (CEST)
Date: Mon, 12 Oct 2020 13:14:39 +0200
From: Elimar Riesebieter <riesebie@lxtec.de>
To: Lukas Wunner <lukas@wunner.de>
Message-ID: <20201012111439.jyewfvopfsjeyvp3@toy.home.lxtec.de>
References: <1c700caab1ce71fa144116541471b3f7bb4629fa.1602432204.git.lukas@wunner.de>
	<20201011183930.veucf6z335njrkwe@toy.home.lxtec.de>
	<20201011185117.GA18543@wunner.de>
	<20201011193048.rfe5qvuba2ovrwed@toy.home.lxtec.de>
	<20201012005410.GA28362@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201012005410.GA28362@wunner.de>
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

Hi Lukas,

* Lukas Wunner <lukas@wunner.de> [2020-10-12 02:54 +0200]:

[...]=20
> If you're unsuccessful debugging the build failure on your own,
> maybe you can upload your drbd build directory somewhere so I
> can take a look.

https://lxtec.de/drbd/drbd_dkms_buildir_hsh_201012.tar.xz

BTW without your patch the module was build successful with 4.19 and
5.7 though.

Thanks for cooperation
Elimar
--=20
  Never make anything simple and efficient when a way
  can be found to make it complex and wonderful ;-)

