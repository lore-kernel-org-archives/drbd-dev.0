Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: Resync stalled at 100% due to race condition
Date: Mon, 4 Jun 2007 14:15:08 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F47917@EXNA.corp.stratus.com>
In-Reply-To: 200706041108.59791.philipp.reisner@linbit.com
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Phil,
Thanks for the patch.  I tested the change and it appears to be fine so
far.
I am pretty confident this fixes it based on what I have tried before
when=20
I tried to stage the problem. Please check it in.

EM--=20

-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
On Behalf Of Philipp Reisner
Sent: Monday, June 04, 2007 5:09 AM
To: drbd-dev@linbit.com
Cc: Montrose, Ernest
Subject: Re: [Drbd-dev] DRBD8: Resync stalled at 100% due to race
condition

On Thursday 24 May 2007 14:41:53 Montrose, Ernest wrote:
> Hi all,
> We are seeing a problem where a resync hangs on the SyncSource at the
> end.  The SyncTarget finished OK and shows Connected. The signature on
> the SyncSource is:
>
[...]

I think you are right in saying that receive_state() is wrong, but
I have an other interpretation of the logs.

> What I think is happening is that there is a race condition where
> drbd_resync_finished() races receive_state() in this manner:
> 1)  The resync finished on drbd0 and we enter drbd_resync_finished().
> But before it can set the stated to Connected, drbd15 which is a
higher
> priority device starts syncing. This puts drbd0 in PausedSyncS from
> SyncSource.

Right.

> 2) Drbd_resync_finished() for drbd0 now tries to go to Connected from
> PausedSyncS.  The logs below prints this transition but the transition
> was not actually commited since we print before we actually assign the
> new values.

No, the log line "conn (PausedSyncS -> Connected)" is done by
_drbd_set_state() (with the PSC macros) which runs under the req_lock,=20
and there happens the assignment "mdev->state.i =3D ns.i;".=20
The log is okay.

I think we have a race betwen receive_state() assigning the=20
connection state to nconn=3DPausedSyncS, then the resync finishes
before we reach the call to spin_lock() (mdev->state.conn =3D =
Connected).
Now when receive_state() finally continues, it assigns (the now
obsolete value of) nconn to mdev->state.conn again by calling
_drbd_set_state().

> I include a patch that may at least help illustrate the issue if not
fix
> it as I am not sure the req_lock can be held this early without
causing
> a deadlock or other perfomance issues.
>

I considered the approach of making drbd_sync_handshake() to run
under the req_lock and to have a simple retry mechanism in
receive_state().

Since 8.0.x is not the stable branch I decided to go with that small
patch. (I did not do any testing of this, since I guess it is rather
hard to hit this exact timing...)

Ernest, thanks for pointing this out!
As soon as you agree, I will commit this patch...

-phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
