Return-Path: <philipp.marek@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 14D85104B1A2
	for <drbd-dev@lists.linbit.com>; Fri, 20 Feb 2015 10:26:46 +0100 (CET)
Date: Fri, 20 Feb 2015 10:26:43 +0100
From: Philipp Marek <philipp.marek@linbit.com>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Message-ID: <20150220092643.GE12926@cacao.linbit>
References: <54E6C8BA.9090201@suse.de> <20150220074152.GC12926@cacao.linbit>
	<54E6FA84.2070306@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54E6FA84.2070306@suse.de>
Content-Transfer-Encoding: quoted-printable
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [bug] drbd 9: Receiver error
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

Hello Goldwyn,

> [  176.429715] block drbd0: tumbleweed1: bitmap overflow (e:8388342) wh=
ile
> decoding bm RLE packet
> [  176.429739] drbd r0 tumbleweed1: error receiving P_COMPRESSED_BITMAP=
, e:
> -5 l: 7!
> [  176.429763] drbd r0 tumbleweed1: conn( Connected -> ProtocolError ) =
peer(
> Secondary -> Unknown )
Hmmm, we've seen similar things with _old_ kernels, not with 3.18 yet.

Please try switching bitmap RLE compression off.


Regards,

Phil

--=20
: Ing. Philipp Marek
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting                 http://www.linbit.com :

DRBD=C2=AE and LINBIT=C2=AE are registered trademarks of LINBIT, Austria.
