Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id C12602CFBDFA
	for <drbd-dev@lists.linbit.com>; Fri, 27 Oct 2006 11:04:27 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: The last few changes appears to have broken St
	state machine.
Date: Fri, 27 Oct 2006 11:04:28 +0200
References: <BD7042533C2F8943A6A4257A9E31C45439C817@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C817@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200610271104.28514.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Mittwoch, 25. Oktober 2006 21:33 schrieb Montrose, Ernest:
> Hi all:
> I am using the same configuration I have always used. With the latest
> changes (I would say a couple of days worth but don't quote me).
> A look at /proc/drbd on Node 1 yields:
> St: Secondary/Primary
> A look at /proc/drbd on Node 2 yields:
> St: Secondary/Secondary <----- Which is not true.
>
> I go on node 2 and try to set it to Primary, since node 1 thinks it is
> anyway:
> # drbdadm primary shared.fs
> **Thinks about it for a few*** then get:
> No response from the DRBD driver! Is the module loaded?
> Error code 102200106 unknown.
> You should update the drbd userland tools.
> Command 'drbdsetup /dev/drbd15 primary' teminated with exit code 20
> Drbdadm aborting.
>
> Puts in older driver, reboot and all is fine now....
>

Oops!

Just fixed in SVN.=20

=2DPhil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
