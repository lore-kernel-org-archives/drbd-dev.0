Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Paul Clements <paul.clements@steeleye.com>
Date: Wed, 4 May 2005 10:17:33 +0200
References: <mailman.387.1115057918.21568.drbd-user@lists.linbit.com>
	<4277A20A.9020309@steeleye.com> <4277D801.1060605@steeleye.com>
In-Reply-To: <4277D801.1060605@steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200505041017.33356.philipp.reisner@linbit.com>
Cc: drbd-dev@linbit.com
Subject: [Drbd-dev] Re: drbd-user post from paul.clements@steeleye.com
	requires approval
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Dienstag, 3. Mai 2005 21:58 schrieben Sie:
> Hi again. I took your suggestion and copied the find_next_bit function
> from the kernel sources into the drbd header and used that. It worked. I
> guess the "generic" find_next_bit does not work correctly on ppc64.
>

Seems so.=20

> So how should we patch this? I can add the ppc64 find_next_bit into the
> drbd headers, but because the kernel declares find_next_bit also, we
> have problems...how would you prefer we work around that? I have worked
> around it by renaming the drbd find_next_bit to generic_find_next_bit
> and changing the one call that drbd makes to that function...
>

Hi Paul,

Hmmm, slowly I understand the problem:
1) The kernel headers have a prototype "extern find_next_bit()"
2) On the other architectures it is an inlined function, therefore
   the drbd_comapt_types.h expects it to be inlined.

* What's about appending the ppc64 variant of find_next_bit() to=20
  drbd_bitmap.c as global function, bracketed in #ifdef PPC64.
  And some tweaking to drbd_comapt_types.h so that it works ?

* I prefer this over renaming the find_next_bit() calls to=20
  something else, because find_next_bit() is a part of=20
  Linux-2.6's API.

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
