Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5D64342034B
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 17:27:30 +0200 (CEST)
Received: by mail-ed1-f66.google.com with SMTP id p13so17404471edi.7
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 08:27:30 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	r4sm10719453edv.16.2020.10.12.08.26.29
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 12 Oct 2020 08:26:29 -0700 (PDT)
Resent-Message-ID: <20201012152627.GG2116@soda.linbit>
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net
	[83.223.95.204])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 93E9642022A
	for <drbd-dev@lists.linbit.com>; Sun, 11 Oct 2020 21:38:44 +0200 (CEST)
Date: Sun, 11 Oct 2020 21:30:48 +0200
From: Elimar Riesebieter <riesebie@lxtec.de>
To: Lukas Wunner <lukas@wunner.de>
Message-ID: <20201011193048.rfe5qvuba2ovrwed@toy.home.lxtec.de>
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

> The patch worked for me with v5.3.

Did you build with brdb master? I used tag 9.0.25-1.

Elimar
--=20
  Never make anything simple and efficient when a way
  can be found to make it complex and wonderful ;-)

