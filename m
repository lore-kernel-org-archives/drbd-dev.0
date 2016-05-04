Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 703C11056444
	for <drbd-dev@lists.linbit.com>; Wed,  4 May 2016 14:52:54 +0200 (CEST)
Date: Wed, 4 May 2016 14:52:53 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <20160504125253.GP16459@soda.linbit>
References: <57286F49.8050107@6wind.com>
	<1462268358-19044-1-git-send-email-nicolas.dichtel@6wind.com>
	<20160503100644.GE16459@soda.linbit>
	<20160503.120556.1317913903199470646.davem@davemloft.net>
	<20160504090529.GJ16459@soda.linbit> <5729EFBC.7040002@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5729EFBC.7040002@6wind.com>
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

On Wed, May 04, 2016 at 02:49:00PM +0200, Nicolas Dichtel wrote:
> Le 04/05/2016 11:05, Lars Ellenberg a =E9crit :
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

Yes.  Which in our case is not a problem.
But I don't object to the padding per se,
if that is how things "should be".

I try to understand why you so much object to using 0 as pad.

    Lars

