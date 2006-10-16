Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 6FD4D2DF653F
	for <drbd-dev@lists.linbit.com>; Mon, 16 Oct 2006 15:59:15 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] FW: [DRBD-cvs] svn commit by phil - r2534 - trunk/drbd
	- Added missinginitialisations of rs_failed.
Date: Mon, 16 Oct 2006 15:59:15 +0200
References: <342BAC0A5467384983B586A6B0B3767103C3BAA6@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B3767103C3BAA6@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200610161559.15412.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Montag, 16. Oktober 2006 15:16 schrieb Graham, Simon:
> Thanks for finding/fixing my bugs! I do have one question on this change
> though:
>
> 		lc_put(mdev->resync,&ext->lce);
>  		// no race, we are within the al_lock!
>
> -		if (ext->rs_left <=3D ext->rs_failed) {
> -			ext->rs_left =3D ext->rs_failed =3D 0;
> +		if (ext->rs_left =3D=3D ext->rs_failed) {
> +			ext->rs_failed =3D 0;
>
> With this change, when rs_left=3D=3Drs_failed, you do not clear rs_left b=
ut
> only rs_failed -- I cleared both so that next time we used the extent we'd
> start from scratch again - was my understanding incorrect?

Yes, I just changed it from "cleanup after use" to "initialize before use" =
;)
The "cleanup after use" semantics is for all cases correct, but not for
the first use.

>
> Simon
>
> PS: FWIW, I chose to use <=3D rather than =3D=3D deliberately as I felt t=
his is
> more tolerant of problems elsewhere in the code -- yes in theory rs_left
> should never be less than rs_failed but <=3D works as well and actually
> better if there is a bug elsewhere that decrements rs_left when it
> shouldn't...

I can really follow that, and would have done it the same probably. But
with the bug that hit me today, that "<=3D" caused more trouble than a
"=3D=3D" does ;)

The "<" case is explicitly caught with the ERR("BAD!...) statement...

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
