Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: incorrect state transition Connected
	->WFBitMapS and UpToDate->Inconsistent
Date: Mon, 26 Nov 2007 09:43:11 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F47A3D@EXNA.corp.stratus.com>
In-Reply-To: 200711261531.53793.philipp.reisner@linbit.com
References: <793061.80135.qm@web30507.mail.mud.yahoo.com>
	200711261531.53793.philipp.reisner@linbit.com
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
Well as it turned out, my last idea did not completely fix the issue
either.
So it may be that my description and staging of it was not complete. I
will try to completely describe the problem and then test your patch.  I
will get back to you with the results as soon as I get them.=20

FYI, your last idea also introduced an issue where a sync would stall
for ever if paused and resumed quickly. If you checked it in somewhere,
you might want to back out.

Thanks,

EM--

-----Original Message-----
From: Philipp Reisner [mailto:philipp.reisner@linbit.com]=20
Sent: Monday, November 26, 2007 9:32 AM
To: drbd-dev@linbit.com
Cc: Ernest Montrose; Montrose, Ernest
Subject: Re: [Drbd-dev] DRBD8: incorrect state transition Connected
->WFBitMapS and UpToDate->Inconsistent

On Friday 16 November 2007 03:36:19 Ernest Montrose wrote:
> Phil,
> I tested the patch and unfortunately it does not fix the race
condition
> though I believe it fixes the ASSERT issues.
> Essentially, when the resync is done and we are in
drbd_resync_finished()
> if we pause the device then we send the state to the peer.  The peer
is
> done syncing at that point.  He does a sync_hanshake() that sends its
state
> to WBItMapS and Pdsk=3DInconsistent (since the target has not changed
its
> state to connected and UptoDate yet. When resync_finished is done we
go
> Uptodate and connected and we're stuck.
>
> I tested yet another idea which seems to close the racy window.  I
turned
> drbd_resync_finished into two parts.  A cleanup part that the worker
can
> schedule to do the clean up and a done part that
> changes the state right away when the resync is done.  I include an
> untested patch to illustrate that idea.
>

Hi Ernest,

Finally the attached patch made it into the GIT repository
(see 3a57119417c46c51dd4bc720ab7dbf14228f05bb.git.txt)
It is slightly different from the patch I suggested at first

As you could not confirm that the bugs is closed for you I tried
to reproduce it here now (with the attached patch) and some
instrumentation code to make the call to drbd_resync_finished()
to last 10 seconds.

I tested pausing and continuing on the SyncTarget and on the
Sync Source side. I could not find any issues:

[42949590.920000] drbd0: conn( StartingSyncT -> WFSyncUUID )
[42949590.920000] drbd0: conn( WFSyncUUID -> SyncTarget )
[42949590.920000] drbd0: Began resync as SyncTarget (will sync 262244 KB
[65561 bits set]).
[42949590.920000] drbd0: Writing meta data super block now.
[42949669.270000] drbd0: Warn long sleep start
[42949672.120000] drbd0: conn( SyncTarget -> PausedSyncT ) user_isp( 0
-> 1 )
[42949672.120000] drbd0: Resync suspended
[42949678.610000] drbd0: conn( PausedSyncT -> SyncTarget ) user_isp( 1
-> 0 )
[42949678.610000] drbd0: Syncer continues.
[42949679.280000] drbd0: Warn long sleep stop
[42949679.280000] drbd0: Resync done (total 87 sec; paused 6 sec; 3236
K/sec)
[42949679.280000] drbd0: conn( SyncTarget -> Connected ) disk(
Inconsistent -> UpToDate )
[42949679.280000] drbd0: Writing meta data super block now.

Ernest, can you please confirm that this issue is solved for you with
that
patch, or provide logfile output of an failing test ?

Thanks!

-phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
