Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [drbd-dev] Trunk version incompatible with SATA
Date: Thu, 28 Jul 2005 16:10:59 +0200
References: <42E7DC38.2020009@free.fr>
In-Reply-To: <42E7DC38.2020009@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200507281611.00068.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Mittwoch, 27. Juli 2005 21:10 schrieb lumiere2002:
> Hello,
>
>
> I have tested the Trunk version of the CVS on 2 machines (one AMD and
> one Intel) with differents disks (sata and ide)
>
> drbd refuse to create meta data on SATA device
>
> error is
>
> [root@amd ~]# /sbin/drbdmeta /dev/drbd0 v08 /dev/sda4 -1 create-md
> ioctl(,BLKFLSBUF,) failed: Operation not supported
>

Well, seems that libata does not yet export cache-flushing to userspace...
No problem for us, we will simply stop treating this as an error, but
only print a warning.

=2Dphilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
