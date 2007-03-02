Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: Resync of device PauseSync state does not
	resume after an I/O error.
Date: Fri, 2 Mar 2007 08:35:21 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C90C@EXNA.corp.stratus.com>
In-reply-to: 200703021433.05214.philipp.reisner@linbit.com
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
No problem...I will test it and let you know.

EM--

-----Original Message-----
From: Philipp Reisner [mailto:philipp.reisner@linbit.com]=20
Sent: Friday, March 02, 2007 8:33 AM
To: drbd-dev@linbit.com
Cc: Montrose, Ernest
Subject: Re: [Drbd-dev] DRBD8: Resync of device PauseSync state does not
resume after an I/O error.

Am Montag, 26. Februar 2007 22:30 schrieb Montrose, Ernest:
> Hi all,
> Looks like what's going on is that on an I/O error during resync (on
the
> sync source), the io error handler set the new state to
> "Connected" and after_state_ch() is not called but scheduled it seems.
> Next time after_state_ch()
> is called the conn state is "Connected" for both old and new and the
> disk state is Diskless.
> We do not cal resume_next_sg() for this combination of state.  Could
it
> be as simple as this patch?

Hi Ernest,

Ok, I now understand what was going on there. The __drbd_chk_io_error()
functions sets the disk to failed.
As a consequence in _drbd_set_state:

	if( ns.conn > Connected && (ns.disk <=3D Failed || ns.pdsk <=3D
Failed )) {
		warn_sync_abort=3D1;
		ns.conn =3D Connected;
	}

The ns gets set to Connected. But the after_state_ch() is not called nor
scheduled...


I propose to fix it with this patch. Could you please test this patch?
If this patches fixes the issue as well ?

--- drbd_int.h  (revision 2773)
+++ drbd_int.h  (working copy)
@@ -1473,7 +1473,8 @@
        case Detach:
        case CallIOEHelper:
                if (mdev->state.disk > Failed) {
-
_drbd_set_state(_NS(mdev,disk,Failed),ChgStateHard);
+                       _drbd_set_state(_NS(mdev,disk,Failed),
+                                       ChgStateHard|ScheduleAfter);
                        ERR("Local IO failed. Detaching...\n");
                }
                break;

In case it does, I will commit this, since it is the more generic fix=20
to the issue.=20

-Phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
