Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8CEF61018D73
	for <drbd-dev@lists.linbit.com>; Mon, 17 Sep 2018 10:56:25 +0200 (CEST)
Received: by mail-wr1-f65.google.com with SMTP id g33-v6so16413805wrd.1
	for <drbd-dev@lists.linbit.com>; Mon, 17 Sep 2018 01:56:25 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	n5-v6sm5356763wmh.1.2018.09.17.01.56.23
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 17 Sep 2018 01:56:24 -0700 (PDT)
Resent-Message-ID: <20180917085623.GB24385@soda.linbit>
Received: from mail-qt0-f194.google.com (mail-qt0-f194.google.com
	[209.85.216.194])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id F0B8F101AC67
	for <drbd-dev@lists.linbit.com>; Wed, 12 Sep 2018 12:29:57 +0200 (CEST)
Received: by mail-qt0-f194.google.com with SMTP id m13-v6so1279030qth.1
	for <drbd-dev@lists.linbit.com>; Wed, 12 Sep 2018 03:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <4853c5b7-fc65-5499-a129-52bfc6c2851f@gmx.de>
In-Reply-To: <4853c5b7-fc65-5499-a129-52bfc6c2851f@gmx.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 12 Sep 2018 12:24:20 +0200
Message-ID: <CAK8P3a0KE+OEW2aSXd0Xgjd-1JeQC3+G+k6EdCdZQPRm+nFWmQ@mail.gmail.com>
To: 20170201165532.2605534-1-arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	David Miller <davem@davemloft.net>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: avoid clang warning about pointless
	switch statement
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

On Wed, Sep 12, 2018 at 12:01 PM Philipp Klocke <Phil_K97@gmx.de> wrote:
>
> Hello,
>
> I've also stumbled across the "warning: no case matching constant switch
> condition '0'" and wanted to fix it.
> As your suggestion is probably the best way, I wanted to ask why it
> didn't get merged yet.
>
> Maybe the patch got lost?

I think I never followed up on the patch when it didn't get merged the
first time around. If you have a copy at hand, could you add your
Signed-off-by and send a version that applies to the current kernel?

    Arnd
