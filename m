Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Re: drbd_panic() in drbd_receiver.c
Date: Wed, 5 Jul 2006 10:27:31 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671031FB441@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Thanks Philip,

I realize I will have to rework this for DRBD 8 - oh well!

One thing I think is important here is that when an error occurs in the =
middle of resyncing, I was thinking we should make sure we finish up as =
much as possible of the resync; this allows the disk to become sane =
again if the bad block in question is fixed up -- for example, if a =
subsequent write to the block is done to a bad block and it also allows =
most accesses to be local if we end up failing over primaryness -- so I =
was thinking we should not simply abandon the resync as soon as an error =
is detected...=20

On the other hand, perhaps this would be an easier way to handle the =
issue -- simply abandon the current resync as soon as an error is =
detected and live with the fact that there are potentially many =
following blocks that could be synchronized but which will not be -- I =
suspect this would be much easier to implement in both 7 and 8... I =
think the only remaining question would then be what the strategy for =
restarting the resync in this case -- it would be nice if the disk could =
eventually become consistent again...

I appreciate your guidance and time,
Simon

-----Original Message-----
From: Philipp Reisner [mailto:philipp.reisner@linbit.com]=20
Sent: Wednesday, July 05, 2006 4:26 AM
To: drbd-dev@linbit.com
Cc: Graham, Simon
Subject: Re: [Drbd-dev] Re: drbd_panic() in drbd_receiver.c

Am Dienstag, 4. Juli 2006 23:35 schrieb Graham, Simon:
> I'm now trying to work through the "internal dependencies and state
> changes that need to be adjusted" and it's proving tricky!
>

Hi Simon,

Pleas note that the way we do state changes has dramatically changed
from 0.7 to 8. In 8 we do it finally in a sane way.

> First things first though -- I'm assuming that in the case of a failed
> resync like this, we really want to end up back in Connected state =
(but
> still inconsistent) rather than simply staying in SyncTarget and
> continually trying to resync the affected block; do you agree with =
this
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

> Assuming that is the case, here's my problem (remember this is based =
on
> 0.7 at the moment) --

Hmm, oops, ok.

> right now, the check for end-of-resync is done in=20
> w_update_odbm based on the current weight of the bitmap; what's more,
> this worker routine is only scheduled from =
drbd_try_to_clean_on_disk_bm
> IF a complete extent is zeroed (and, of course, this routine is only
> called from drbd_set_in_sync) -- so simply modifying w_update_odbm to
> check if the weight is <=3D the number of failed blocks will miss a =
couple
> of important cases:
> 1. If the failure is in the very last block and
> 2. If the failure is somewhere in the last extent of the on-disk =
bitmap

I see the issue here. Have to think about it.

> Apologies for the detail below, but I want to make sure I'm going =
about
> this the right way - Here's what I'm thinking as a way to fix this --
> please comment; you know this code so much better than I do!
>

I will try to answer that part of the mail later today, currently
I am running out of time

-Philipp
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
