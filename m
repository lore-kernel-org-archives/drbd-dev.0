Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4A814105ABC8
	for <drbd-dev@lists.linbit.com>; Fri, 31 Jan 2014 10:36:02 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Rashika Kheria <rashika.kheria@gmail.com>
Date: Fri, 31 Jan 2014 10:35:59 +0100
Message-ID: <2298701.IcU286R1nx@fat-tyre>
In-Reply-To: <2850430f20d631a56978de8884341521d2c3016a.1387445397.git.rashika.kheria@gmail.com>
References: <f460591345e87defe53122cf056991c7f2eefa10.1387445396.git.rashika.kheria@gmail.com>
	<2850430f20d631a56978de8884341521d2c3016a.1387445397.git.rashika.kheria@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Cc: josh@joshtriplett.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 12/13] drivers: block: Mark function as
	static in drbd_state.c
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

Am Donnerstag, 19. Dezember 2013, 15:18:37 schrieb Rashika Kheria:
> Mark functions conn_old_common_state() and conn_set_state() as static=
 in
> drbd/drbd_state.c because they are not used outside this file.
>=20
> This eliminates the following warnings in drbd/drbd_state.c:
> drivers/block/drbd/drbd_state.c:1585:6: warning: no previous prototyp=
e for
> =E2=80=98conn_old_common_state=E2=80=99 [-Wmissing-prototypes]
> drivers/block/drbd/drbd_state.c:1674:1: warning: no previous prototyp=
e for
> =E2=80=98conn_set_state=E2=80=99 [-Wmissing-prototypes]
>=20
> Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
> Reviewed-by: Josh Triplett <josh@joshtriplett.org>
[...]

Hi Rashika, Hi Josh,

I just realized that this patch series lingers on the drbd-dev mailing
list. I will add my Singed-off-by and queue it with my patch series
for inclusion into Jens' tree. Aiming at the 3.15 merge window.

Best,
 Phil

