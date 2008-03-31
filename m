Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
Subject: Re: [Drbd-dev] Stuck in WFBitMapS again
Date: Mon, 31 Mar 2008 16:43:51 +0200
References: <342BAC0A5467384983B586A6B0B3767107E8A3F8@EXNA.corp.stratus.com>
	<BD7042533C2F8943A6A4257A9E31C454F47AC0@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C454F47AC0@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200803311643.51501.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Mittwoch, 13. Februar 2008 00:55:51 schrieb Montrose, Ernest:
> It looks like we still have a race condition while finishing syncing and
> pausing/resuming syncing at the same time.
>
> What's happening is that we finish syncing.
> The secondary side goes to Connected at the end of
> drbd_resync_finished()
>
> The Primary side is still in drbd_resync_finished().  While still there,
>
> the syncer isp flag gets set and unset due to a higher priority device
> syncer getting paused/resumed.
>
> Now the Primary side sends "Inconsistent" state to the Secondary since
> we are still in drbd_resync_finished()
> and have not gone Connected and UptoDate yet. But the other side is
> connected and UpToDate though.
>
> The secondary goes WFBitMapS via drbd_sync_handshake()
>
> In the mean time the Primary finally goes Connected and UptoDate.
>
> The Secondary is stuck in WFBitMapS.
>
> I include a patch that may be the fix for this.  Any other ideas?
>
> Thanks.
> EM--


Hi Ernest,

I know it is quite some time now, but I had to remove this patch.
It breaks manual split brain resolution.
Commit ab7facf4e17d98558d2569ccf954f2c64eb7b650

That was the wrong way of fixing this.

Do you have something with logfiles of that event

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
