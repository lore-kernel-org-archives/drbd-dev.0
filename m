Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher EXP1024-RC4-SHA (56/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 4563E2D99B65
	for <drbd-dev@lists.linbit.com>; Tue,  8 Aug 2006 17:48:27 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8: Disk I/O failure during processing of attach
	command causes panic in drbd_chk_io_error
Date: Tue, 8 Aug 2006 17:48:29 +0200
References: <342BAC0A5467384983B586A6B0B37671034713A9@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B37671034713A9@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200608081748.29382.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Dienstag, 8. August 2006 16:47 schrieb Graham, Simon:
> The drbd_ioctl_set_disk() routine allocates a new backing_dev structure
> but does not attach it to the mdev until after the meta data has been
> successfully read - if any disk error (such as a read of the meta data
> area failing) occurs during this process, the low level routines such as
> drbd_al_read_tr call drbd_chk_io_error which assumes that mdev->bc has
> been initialized, leading to a panic.
>
> Not sure what the right answer is here, but perhaps drbd_chk_io_error()
> and drbd_io_error() need to be passed the backing_dev* as a parameter
> instead of reading it from mdev->bc?
>

I think it is sufficient to fail the attach ioctl. This is done by the
return value of drbd_al_read_log(). calling drbd_chk_io_error() or
drbd_io_error() was completely missplaced there.

Thanks for pointing this out!

The mini patch:
http://lists.linbit.com/pipermail/drbd-cvs/2006-August/001181.html

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
