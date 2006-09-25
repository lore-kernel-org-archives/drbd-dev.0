Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 307432D99862
	for <drbd-dev@lists.linbit.com>; Mon, 25 Sep 2006 15:48:26 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8: crashes if role is changed to Secondary whilst
	disk state is Negotiating...
Date: Mon, 25 Sep 2006 15:48:26 +0200
References: <342BAC0A5467384983B586A6B0B37671039D46E3@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B37671039D46E3@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200609251548.26220.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Sonntag, 24. September 2006 17:35 schrieb Graham, Simon:
> The specific crash I saw was due to this code in drbd_set_role;
> drbd_set_role calls drbd_al_to_on_disk_bm() if the new role is secondary
> and the disk state is not diskless -- there are transitory states between
> diskless and attached where this is not valid.
>
> The specific lines of code are:
>
> =A0=A0=A0=A0if(mdev->state.disk > Diskless && (new_role & Secondary)) {
> =A0=A0=A0=A0=A0=A0=A0=A0drbd_al_to_on_disk_bm(mdev);
> =A0=A0=A0=A0}
>
> and the test should presumably be 'mdev->state.disk > Negotiating' -
> however, this routine presumably needs to use inc_local() to do this so I
> would propose the following:
>
> 	if ((new_role & Secondary) && inc_local(mdev)) {
> 		drbd_al_to_on_disk_bm(mdev);
>
> 		dec_local(mdev);
> 	}
>

Right.

=2DPhil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
