Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (unknown [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id C771E2D9E38A
	for <drbd-dev@lists.linbit.com>; Tue, 12 Dec 2006 11:19:36 +0100 (CET)
Date: Tue, 12 Dec 2006 11:19:37 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: failed to complete sync due to receiving bitmap
	in unexpected state
Message-ID: <20061212101937.GD7967@soda.linbit>
References: <BD7042533C2F8943A6A4257A9E31C45439C877@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C877@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-12-11 17:16:50 -0500
\ Montrose, Ernest:
> Hi all,
> Were are seeing a case where a Sync happened, data is marked consistent
> on both sides, target went to Connected
>   state, source DID NOT CHANGE FROM WFBitMapS state. The clock on the
> two systems seem to be not quite synchronized, but it seems that:
> 
> 1. The two nodes connected, realised they needed to resync and worked
> out that one node had the
>   good data.
> 2. Because other syncing was going on, the sync process was paused
> 3. Later on, sync resumed, good side connection went to WFBitmapS, bad
> side WFBitmapT
> 4. Sync happened, data was marked consistent on both sides, target went
> to Connected
>   state, source DID NOT CHANGE FROM WFBitMapS.
> 
> Now, the only oddity I see is on the target side where we see:
> 
> Dec 10 04:52:52 george kernel: drbd1: unexpected cstate (PausedSyncT) in
> receive_bitmap
> 
> This did NOT stop the resync, but I would suspect it meant that a
> critical message was never sent which left the source side in WFBitmapS.
> 
> Presumably there is a window where one side is out of the paused state
> before the other.
>  
> Simon Grham actually did a bit of analysis of this and think that the
> problem might be a race condition in drbd_receive.c:receive_bitmap().
> Any ideas, because I cannot reproduce this at reliably at this time.

Not yet...
is any state change Secondary->Primary involved,
or are the only (re)connecting?

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
