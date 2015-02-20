Return-Path: <philipp.marek@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7B837100EBF0
	for <drbd-dev@lists.linbit.com>; Fri, 20 Feb 2015 08:41:54 +0100 (CET)
Date: Fri, 20 Feb 2015 08:41:52 +0100
From: Philipp Marek <philipp.marek@linbit.com>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Message-ID: <20150220074152.GC12926@cacao.linbit>
References: <54E6C8BA.9090201@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54E6C8BA.9090201@suse.de>
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

Hi Goldwyn,

> I compiled drbd-9.0 against Opensuse Tumbleweed and installed it [1].
> I applied Linux kernel commit f730c848affc05fb7262574b06e0cd7e1fa96096 =
to
> get it to compile against the latest (factory) kernels and should be th=
e
> same for the tumbleweed kernel (3.18.3 based) I am using to test.
>=20
> I am getting the following receiver errors in the kernel log when I try=
 to
> start the drbd service:
...
> Please let me know if you need any more information to debug this or if=
 I am
> doing something wrong.
how many nodes did you connect, which DRBD versions were they running?
Can you show the configuration, and some more log lines - from all nodes,=
=20
and starting quite a bit earlier?


And then the DRBD 9 git HEAD has already moved again...


Regards,

Phil

--=20
: Ing. Philipp Marek
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting                 http://www.linbit.com :

DRBD=C2=AE and LINBIT=C2=AE are registered trademarks of LINBIT, Austria.
