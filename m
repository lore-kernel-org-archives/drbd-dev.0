Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
Subject: Re: [Drbd-dev] DRBD8: incorrect state transition Connected
	->WFBitMapS and UpToDate->Inconsistent
Date: Mon, 26 Nov 2007 16:09:12 +0100
References: <793061.80135.qm@web30507.mail.mud.yahoo.com>
	<BD7042533C2F8943A6A4257A9E31C454F47A3D@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C454F47A3D@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711261609.13628.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Monday 26 November 2007 15:43:11 Montrose, Ernest wrote:
> Phil,
> Well as it turned out, my last idea did not completely fix the issue
> either.
> So it may be that my description and staging of it was not complete. I
> will try to completely describe the problem and then test your patch.  I
> will get back to you with the results as soon as I get them.
>
> FYI, your last idea also introduced an issue where a sync would stall
> for ever if paused and resumed quickly. If you checked it in somewhere,
> you might want to back out.
>

Oh, right. 
This makes it work also with quick pause-resume cycles:

--- a/drbd/drbd_main.c
+++ b/drbd/drbd_main.c
@@ -788,7 +788,7 @@ int _drbd_set_state(drbd_dev* mdev, drbd_state_t ns,enum chg_state_flags flags)
                INFO("Syncer continues.\n");
                mdev->rs_paused += (long)jiffies-(long)mdev->rs_mark_time;
                if (ns.conn == SyncTarget) {
-                       if (!test_bit(STOP_SYNC_TIMER,&mdev->flags)) {
+                       if (!test_and_clear_bit(STOP_SYNC_TIMER,&mdev->flags)) {
                                mod_timer(&mdev->resync_timer,jiffies);
                        }
                        /* This if (!test_bit) is only needed for the case


-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
