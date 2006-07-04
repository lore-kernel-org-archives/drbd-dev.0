Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Tue, 4 Jul 2006 12:07:57 +0200
References: <342BAC0A5467384983B586A6B0B37671031FB31E@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B37671031FB31E@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200607041207.57710.philipp.reisner@linbit.com>
Cc: drbd-user@linbit.com
Subject: [Drbd-dev] Re: [DRBD-user] drbd_panic() in drbd_receiver.c
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Montag, 3. Juli 2006 19:03 schrieb Graham, Simon:
> I too have been looking into this -- I agree with Damian and think it's
> very important that DRBD never panic in cases like this if it is to be
> used in an HA system -- I think the final approach has to be one of
> fixing up underlying disk errors where possible and returning an error
> to the caller where it is not possible to fix up.
>
> In this specific case (NegDReply), it seems that it would be OK to
> simply remove the panic() and complete the original request with an EIO
> error or somesuch - this does mean adding a call to
> drbd_bio_endio(bio,0) in addition to removing the panic() though.
>
> Even if this is acceptable, there are a bunch of other places where
> panic is currently done that, I think, also need to be changed,
> including:
>
> 1. In drbd_set_state if the node is now Primary and does not have access
> to good data; I think this can simply be removed
>    since drbd_fail_request_early already returns a failure to the caller
> in this case.
>
> 2. Failure to write bitmap to disk; not sure what the right answer is
> here - any suggestions? (perhaps force the disk to be
>    inconsistent in some manner that will require a complete resync?)
>
> 3. Failure to write meta data to disk; ditto above only harder -- if you
> cant write to the meta-data area, you cant store data
>    that indicates the contents are bad...
>
> 4. Received NegRSDReply -- during resync, SyncTarget gets error from
> SyncSource; In this specific case, it seems to me that
>    a possible solution is to leave the block in question set in the
> bitmap, ensure that the state is never set consistent
>    on the current SyncTarget and ensure that no matter what happens, the
> current SyncSource remains the best source of data.
>    A potential issue with this is that the SyncTarget will continue to
> attempt to synchronize the block in question - since
>    it's still set in the bitmap it will eventually be found again when
> the syncer wraps round - maybe that's OK though (so
>    long as there is some sort of delay between attempts)?
>
> I am planning on implementing these, assuming there isn't any huge
> disagreement on the approach and assuming it isn't already in
> progress...
>
> Perhaps we should take this discussion to drvd-dev?
> Simon
>
> PS: Once the panics are gone, there is a second phase required which is
> to fix up underlying errors where possible -- for example, if the volume
> is consistent on both sides and a read on the primary fails, not only
> should the read be retried to the secondary but also the returned data
> should be rewritten on the primary -- for a class of errors, this will
> actually fix the problem as the disk will remap a bad block when the
> write is done; is anyone working on this?

Excellent ideas. In case you really start to work on this, please
base your work on the drbd-8.0 code, preferably the trunk.

PS: Moving this thread over to drbd-dev, is a good idea.

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
