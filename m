Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: drbd_panic() in drbd_receiver.c
Date: Wed, 5 Jul 2006 10:25:42 +0200
References: <342BAC0A5467384983B586A6B0B37671031FB37E@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B37671031FB37E@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200607051025.43122.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Dienstag, 4. Juli 2006 23:35 schrieb Graham, Simon:
> I'm now trying to work through the "internal dependencies and state
> changes that need to be adjusted" and it's proving tricky!
>

Hi Simon,

Pleas note that the way we do state changes has dramatically changed
from 0.7 to 8. In 8 we do it finally in a sane way.

> First things first though -- I'm assuming that in the case of a failed
> resync like this, we really want to end up back in Connected state (but
> still inconsistent) rather than simply staying in SyncTarget and
> continually trying to resync the affected block; do you agree with this
> as a goal?
>

Look out for pre_state_checks() in drbd-8. Currently it probably=20
does not allow that state.

I have to add that there is a gracefull way of changing state
[ reuqest_state() ] , and a forcefull way [ force_state() ] .

request_state() is usually used by actions that are initiated by=20
on operator, while force_state() is used if something fails...

So, if the disk fails during resync you could use force_state()
to go into Connected/Inconsistent, although this is not a valid
state as expressed by the constraints of pre_state_checks().

We need to check that there are no local requests issued to
the not-yet-synced areas. As far as I recall from the back of
my head, drbd-8 drbd_req.c already checks the local disk status
instead of the connection status, but we need to check this.

> Assuming that is the case, here's my problem (remember this is based on
> 0.7 at the moment) --

Hmm, oops, ok.

> right now, the check for end-of-resync is done in=20
> w_update_odbm based on the current weight of the bitmap; what's more,
> this worker routine is only scheduled from drbd_try_to_clean_on_disk_bm
> IF a complete extent is zeroed (and, of course, this routine is only
> called from drbd_set_in_sync) -- so simply modifying w_update_odbm to
> check if the weight is <=3D the number of failed blocks will miss a couple
> of important cases:
> 1. If the failure is in the very last block and
> 2. If the failure is somewhere in the last extent of the on-disk bitmap

I see the issue here. Have to think about it.

> Apologies for the detail below, but I want to make sure I'm going about
> this the right way - Here's what I'm thinking as a way to fix this --
> please comment; you know this code so much better than I do!
>

I will try to answer that part of the mail later today, currently
I am running out of time

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
