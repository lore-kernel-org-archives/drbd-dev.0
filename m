Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Re: drbd_panic() in drbd_receiver.c
Date: Tue, 4 Jul 2006 17:35:03 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671031FB37E@EXNA.corp.stratus.com>
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

I'm now trying to work through the "internal dependencies and state
changes that need to be adjusted" and it's proving tricky!

First things first though -- I'm assuming that in the case of a failed
resync like this, we really want to end up back in Connected state (but
still inconsistent) rather than simply staying in SyncTarget and
continually trying to resync the affected block; do you agree with this
as a goal?

Assuming that is the case, here's my problem (remember this is based on
0.7 at the moment) -- right now, the check for end-of-resync is done in
w_update_odbm based on the current weight of the bitmap; what's more,
this worker routine is only scheduled from drbd_try_to_clean_on_disk_bm
IF a complete extent is zeroed (and, of course, this routine is only
called from drbd_set_in_sync) -- so simply modifying w_update_odbm to
check if the weight is <=3D the number of failed blocks will miss a =
couple
of important cases:
1. If the failure is in the very last block and
2. If the failure is somewhere in the last extent of the on-disk bitmap

Apologies for the detail below, but I want to make sure I'm going about
this the right way - Here's what I'm thinking as a way to fix this --
please comment; you know this code so much better than I do!

1. Add a new field in the mdev - rs_failed - that counts the number of
NegDSReply's received, init to zero=20
   at start of resync
2. Move the code that checks for end of resync into a new routine -
drbd_check_for_end_resync() and change it
   to check if the bitmap weight is <=3D rs_failed.
3. Change drbd_try_to_clean_on_disk_bm to schedule w_update_odbm if
_any_ bits are cleared on disk (perhaps it should
   be some-bit-cleared AND (rs_failed!=3D0 || =
extent-now-completely-clear)
- that wont change the current behavior if
   no failures occur -- I'm just a bit worried about doing this too
often...
4. Add a call to drbd_check_for_end_resync() in got_NegDSReply() to
handle the case where the last block failed.
5. Find all the places where rs_total, rs_mark_left and the bitmap
weight are referenced and include rs_failed as
   necessary (e.g. BM_PARANOIA_CHECK in drbd_bitmap.c).

Thanks,
Simon

-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
On Behalf Of Lars Ellenberg
Sent: Tuesday, July 04, 2006 11:23 AM
To: drbd-dev@linbit.com; drbd-dev@linbit.com
Subject: Re: [Drbd-dev] Re: [DRBD-user] drbd_panic() in drbd_receiver.c

/ 2006-07-04 11:01:32 -0400
\ Graham, Simon:
> Thanks -- I'm actually starting with drbd 7 just because it's _much_
> easier for me to test (we have a complete build/install/test
> infrastructure currently based on using 0.7) however I will push the
> changes into the head of the trunk as soon as I can.
>=20
> FWIW, I have the set-state, NegDReply and NegDSReply stuff coded and
> running; I'm using a known bad disk and no panics so far!

great, send over a svn diff...

> -- the only
> issue I have now is that I think I need to kick the resync processing
> when a NegDSReply is received -- /proc/drbd always shows the resync as
> 100% and stalled;

there are several internal dependencies and state changes that need to
be adjusted...

> BTW: do you have any suggestions for handling the bitmap and meta-data
> write failures?

difficult. we probably need to have several "drbd super blocks" in
drbd8, so we at least have a much higher chance to get important flags
on stable storage _somewhere_. I guess we don't want to have several
bitmaps, but some means to store the "meta data is not reliable anymore"
flag in several places. updates to these blocks have to be
transactional. this is not yet done, but it is on the todo list...


> Also - let me know if you think you would incorporate these changes
into
> the 0.7 branch

unlikely. not impossible, though.

> - if so, I'll send patches (oh and let me know what the
> 'approved' mechanism for sending patches is please).

svn diff

cheers,

--=20
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
_______________________________________________
drbd-dev mailing list
drbd-dev@lists.linbit.com
http://lists.linbit.com/mailman/listinfo/drbd-dev
