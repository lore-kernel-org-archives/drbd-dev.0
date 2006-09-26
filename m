Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] FW: [DRBD-cvs] svn commit by phil - r2453 - in trunk:
	drbd drbd/linuxuser - * Removed some explicit calls to
	drbd_thread_ ... funct
Date: Tue, 26 Sep 2006 16:37:32 +0200
References: <342BAC0A5467384983B586A6B0B37671039D4967@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B37671039D4967@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200609261637.32462.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Montag, 25. September 2006 21:44 schrieb Graham, Simon:
> I think there may be a problem with this checkin (or I misunderstand) --
> this checkin includes the following change to drbd_nl_net_conf:
>
>
> Modified: trunk/drbd/drbd_nl.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- trunk/drbd/drbd_nl.c	2006-09-25 07:24:32 UTC (rev 2452)
> +++ trunk/drbd/drbd_nl.c	2006-09-25 11:32:44 UTC (rev 2453)
> @@ -934,8 +934,13 @@
>  	struct crypto_tfm* tfm =3D NULL;
>  	struct hlist_head *new_tl_hash =3D NULL;
>  	struct hlist_head *new_ee_hash =3D NULL;
> -	struct Drbd_Conf *odev;
> +	drbd_dev *odev;
>
> +	if (mdev->state.conn > StandAlone) {
> +		retcode=3DHaveNetConfig;
> +		goto fail;
> +	}
> +
>
> This has the unfortunate side effect of blocking 'drbdadm connect' reques=
ts
> in any state other than Standalone - so I cant manually cause the network
> to be reconnected anymore -- is this supposed to be something I never have
> to do? Because right now my system is WFConnection on one side and
> Unconnected on the other...
>

Hi Simon,

This was a bug somwhere else, I fixed today. That particular
code means that it is no longer possible to simply do

drbdadm connect r0
drbdadm connect r0
=2E..

to cause it to reconnect. Instead you have to do now:

drbdadm disconnect r0 ; drbdadm connect r0
drbdadm disconnect r0 ; drbdadm connect r0
=2E..

=2Dphil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
