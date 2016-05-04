Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 05E9F1056447
	for <drbd-dev@lists.linbit.com>; Fri,  6 May 2016 10:40:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id CB7443ED3EA
	for <drbd-dev@lists.linbit.com>; Fri,  6 May 2016 10:40:19 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Zt1PMlNx6Vui for <drbd-dev@lists.linbit.com>;
	Fri,  6 May 2016 10:40:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id A21723ED76C
	for <drbd-dev@lists.linbit.com>; Fri,  6 May 2016 10:40:19 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 41mIJM_hRRAR for <drbd-dev@lists.linbit.com>;
	Fri,  6 May 2016 10:40:19 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 44E683ED3EA
	for <drbd-dev@lists.linbit.com>; Fri,  6 May 2016 10:40:19 +0200 (CEST)
Resent-Message-ID: <20160506084017.GR16459@soda.linbit>
Received: from mail-pf0-f173.google.com (mail-pf0-f173.google.com
	[209.85.192.173]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 425ED1056312
	for <drbd-dev@lists.linbit.com>; Wed,  4 May 2016 16:34:51 +0200 (CEST)
Received: by mail-pf0-f173.google.com with SMTP id 206so26140600pfu.0
	for <drbd-dev@lists.linbit.com>; Wed, 04 May 2016 07:34:51 -0700 (PDT)
Message-ID: <1462372026.5535.344.camel@edumazet-glaptop3.roam.corp.google.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
To: nicolas.dichtel@6wind.com
Date: Wed, 04 May 2016 07:27:06 -0700
In-Reply-To: <5729EFBC.7040002@6wind.com>
References: <57286F49.8050107@6wind.com>
	<1462268358-19044-1-git-send-email-nicolas.dichtel@6wind.com>
	<20160503100644.GE16459@soda.linbit>
	<20160503.120556.1317913903199470646.davem@davemloft.net>
	<20160504090529.GJ16459@soda.linbit> <5729EFBC.7040002@6wind.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: netdev@vger.kernel.org, drbd-dev@lists.linbit.com,
	David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
	philipp.reisner@linbit.com
Subject: Re: [Drbd-dev] [PATCH net-next v2] block/drbd: use
	nla_put_u64_64bit()
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

On Wed, 2016-05-04 at 14:49 +0200, Nicolas Dichtel wrote:
> Le 04/05/2016 11:05, Lars Ellenberg a =C3=A9crit :
> [snip]
> > We don't have an "alignment problem" there, btw.
> > Last time I checked, we did work fine without this alignment magic,
> > we already take care of that, yes, even on affected architectures.
> The code adds several consecutive u64 attributes. The nl attribute head=
er is 4
> bytes, thus the full attribute length is 12 bytes. If the first u64 is =
aligned
> on 8 (nla_data()), the next one is not aligned on 8: it starts 12 bytes=
 (8 (u64)
> + 4 (nl attr hdr)) after the previous u64.

As I mentioned earlier ( https://lkml.org/lkml/2016/4/22/706 ), if both
kernel and user land do not blindly use *(u64 *)ptr to put/get these
values, there was no issue.

kernel was fine, and most user land apps were fine as well.

Only for compound struct  like tcp_info this was nice to get alignment
for performance reason (it removed one memcpy(), or the use of
put_unaligned() helpers)




