Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 1BA371056444
	for <drbd-dev@lists.linbit.com>; Wed,  4 May 2016 14:50:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id E89D73743F7
	for <drbd-dev@lists.linbit.com>; Wed,  4 May 2016 14:50:52 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id P123Kw9ko2wU for <drbd-dev@lists.linbit.com>;
	Wed,  4 May 2016 14:50:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C50553743F8
	for <drbd-dev@lists.linbit.com>; Wed,  4 May 2016 14:50:52 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Caf4q5p0vyeD for <drbd-dev@lists.linbit.com>;
	Wed,  4 May 2016 14:50:52 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 985C83743F7
	for <drbd-dev@lists.linbit.com>; Wed,  4 May 2016 14:50:52 +0200 (CEST)
Resent-Message-ID: <20160504125052.GO16459@soda.linbit>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BD9C81056444
	for <drbd-dev@lists.linbit.com>; Wed,  4 May 2016 14:49:04 +0200 (CEST)
Received: by mail-wm0-f51.google.com with SMTP id a17so92285132wme.0
	for <drbd-dev@lists.linbit.com>; Wed, 04 May 2016 05:49:04 -0700 (PDT)
References: <57286F49.8050107@6wind.com>
	<1462268358-19044-1-git-send-email-nicolas.dichtel@6wind.com>
	<20160503100644.GE16459@soda.linbit>
	<20160503.120556.1317913903199470646.davem@davemloft.net>
	<20160504090529.GJ16459@soda.linbit>
To: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
	philipp.reisner@linbit.com, drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <5729EFBC.7040002@6wind.com>
Date: Wed, 4 May 2016 14:49:00 +0200
MIME-Version: 1.0
In-Reply-To: <20160504090529.GJ16459@soda.linbit>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [PATCH net-next v2] block/drbd: use
	nla_put_u64_64bit()
Reply-To: nicolas.dichtel@6wind.com
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

Le 04/05/2016 11:05, Lars Ellenberg a =E9crit :
[snip]
> We don't have an "alignment problem" there, btw.
> Last time I checked, we did work fine without this alignment magic,
> we already take care of that, yes, even on affected architectures.
The code adds several consecutive u64 attributes. The nl attribute header=
 is 4
bytes, thus the full attribute length is 12 bytes. If the first u64 is al=
igned
on 8 (nla_data()), the next one is not aligned on 8: it starts 12 bytes (=
8 (u64)
+ 4 (nl attr hdr)) after the previous u64.
