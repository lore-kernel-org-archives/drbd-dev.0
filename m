Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 71CA62CF8293
	for <drbd-dev@lists.linbit.com>; Mon,  2 Oct 2006 14:59:06 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [DRBD-announce] drbd-8.0pre5.tar.gz
Date: Mon, 2 Oct 2006 14:59:06 +0200
References: <200610021114.55092.philipp.reisner@linbit.com>
	<87u02nj8ua.fsf@wide.bouthors.org>
In-Reply-To: <87u02nj8ua.fsf@wide.bouthors.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200610021459.06658.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> --- drbd8-8.0pre5.orig/scripts/drbd
> +++ drbd8-8.0pre5/scripts/drbd
> @@ -10,10 +10,10 @@
>  ### BEGIN INIT INFO
>  # Provides: drbd
>  # Required-Start: $network $syslog sshd
> -# Required-Stop:
> +# Required-Stop: $network $syslog sshd
>  # Default-Start:  3 5
>  # Default-Stop:   0 1 2 6
> -# Description:    Control drbd resources.
> +# Short-Description:    Control drbd resources.
>  ### END INIT INFO
>
[...]

> --- drbd-0.7.10.orig/scripts/drbd	2005-01-13 17:30:28.000000000 +0300
> +++ drbd-0.7.10/scripts/drbd	2005-04-17 18:18:16.166074586 +0300
> @@ -19,8 +19,8 @@
>  DEFAULTFILE=3D"/etc/default/drbd"
>  DRBDADM=3D"/sbin/drbdadm"
>  PROC_DRBD=3D"/proc/drbd"
> -MODPROBE=3D"modprobe"
> -RMMOD=3D"rmmod"
> +MODPROBE=3D"/sbin/modprobe"
> +RMMOD=3D"/sbin/rmmod"
>  UDEV_TIMEOUT=3D10
>  ADD_MOD_PARAM=3D""
>
> Would it be possible to commit them both into SVN?
>

Applied both paches.

=2DPhil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
