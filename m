Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Re: drbd_panic() in drbd_receiver.c
Date: Wed, 5 Jul 2006 13:49:07 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671031FB4D2@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Thanks again for the review; I understand and agree with your comments =
on doing this in 8 versus 7 - anything I do on 7 will just be for =
prototyping (because as I said it's much easier for me to test with 7 =
right now).

I will take the approach of continuing with as much as possible of the =
resync (although as I suspected, it's MUCH easier to simply abort the =
resync as soon as any error is reported).

One question -- you said that DRBD disconnects from the disk on the =
first (local) error -- I think this is only true if you set on-io-error =
to "Detach" -- we actually run with the default value of PassOn in which =
case drbd_io_error does nothing; I think this is actually the best way =
to run since it keeps the disk accessible for those blocks that are OK =
and returns errors for those that are not.

/simgr

-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com] =
On Behalf Of Philipp Reisner
Sent: Wednesday, July 05, 2006 12:15 PM
To: drbd-dev@linbit.com
Subject: Re: [Drbd-dev] Re: drbd_panic() in drbd_receiver.c

> Apologies for the detail below, but I want to make sure I'm going =
about
> this the right way - Here's what I'm thinking as a way to fix this --
> please comment; you know this code so much better than I do!
>
> 1. Add a new field in the mdev - rs_failed - that counts the number of
> NegDSReply's received, init to zero
>    at start of resync

ack.

> 2. Move the code that checks for end of resync into a new routine -
> drbd_check_for_end_resync() and change it
>    to check if the bitmap weight is <=3D rs_failed.

ok.

> 3. Change drbd_try_to_clean_on_disk_bm to schedule w_update_odbm if
> _any_ bits are cleared on disk (perhaps it should
>    be some-bit-cleared AND (rs_failed!=3D0 || =
extent-now-completely-clear)
> - that wont change the current behavior if
>    no failures occur -- I'm just a bit worried about doing this too
> often...

I see the problem here... And I have am advice for you.
The bm_extent holds the number of dirty bit for the extent (rs_left).
Add a member there that holds the number of IO errors for that
sync extent (rs_failed).
... Do you know by now what I mean ?

> 4. Add a call to drbd_check_for_end_resync() in got_NegDSReply() to
> handle the case where the last block failed.

right.

> 5. Find all the places where rs_total, rs_mark_left and the bitmap
> weight are referenced and include rs_failed as
>    necessary (e.g. BM_PARANOIA_CHECK in drbd_bitmap.c).

-Philipp
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
_______________________________________________
drbd-dev mailing list
drbd-dev@lists.linbit.com
http://lists.linbit.com/mailman/listinfo/drbd-dev
