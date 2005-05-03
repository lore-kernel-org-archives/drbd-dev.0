Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@linbit.com
Date: Tue, 3 May 2005 17:58:48 +0200
References: <mailman.387.1115057918.21568.drbd-user@lists.linbit.com>
In-Reply-To: <mailman.387.1115057918.21568.drbd-user@lists.linbit.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200505031758.48886.philipp.reisner@linbit.com>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Subject: [Drbd-dev] Fwd: Re: drbd-user post from paul.clements@steeleye.com
	requires approval
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>



=2D---------  Weitergeleitete Nachricht  ----------

Subject: Re: drbd-user post from paul.clements@steeleye.com requires approv=
al
Date: Dienstag, 3. Mai 2005 17:57
=46rom: Philipp Reisner <philipp.reisner@linbit.com>
To: Paul Clements <paul.clements@steeleye.com>

Am Montag, 2. Mai 2005 20:18 schrieben Sie:
> We've recently been trying to certify DRBD (we've tried both 0.7.5 and
> 0.7.10 with the same results) on ppc64 with RHEL3.
>
> Unfortunately, we have run into two fairly serious issues:
>
> 1) we had to hack up the source just to get it to build:
>
> The basic problem is that the adjust_drbd_config_h.sh script is not
> doing the right thing for RHEL3 on ppc64. RHEL3 has a find_next_bit()
> function, and on most architectures it's an inline function. However, on
> ppc64 it's not inline and it's not exported, which means drbd (being a
> module) can't use it. So we have to actually disable the
> HAVE_FIND_NEXT_BIT setting in drbd_config.h. Also, there is no
> arch-specific find_next_bit function for ppc64 in drbd_compat_types.h,
> so we have to use the generic find_next_bit function that's in that file
> (by defining USE_GENERIC_FIND_NEXT_BIT in drbd_config.h). Of course,
> when this function is defined, it conflicts with the previous
> find_next_bit function declaration from the kernel headers
> (asm-ppc64/bitops.h). So, we had to rename the generic function to
> generic_find_next_bit and change all calls in the drbd source (just one
> in drbd_bitmap.c) to use generic_find_next_bit instead of find_next_bit.
>
>
> 2) additionally, the driver appears to start up fine on both machines,
> but when the resync begins, it quickly stalls and never makes any progress

Hi Paul,

DRBD-0.7.10 works on Linux-2.6.x based distributions on ppc64.
I guess the way to go to get it to work on 2.4 is make it to use the
ppc64 specific find_next_bit() function.

I am ready to accept a patch, and to include this into 0.7.11, but
I do not have a ppc64 machine here to do it myself.

PS: The mailing lists only allows posts from subscribed addresses.

=2Dphilipp
=2D-

: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :

=2D------------------------------------------------------

=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
