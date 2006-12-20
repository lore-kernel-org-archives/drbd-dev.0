Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (unknown [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id D2AAE2CFF72A
	for <drbd-dev@lists.linbit.com>; Wed, 20 Dec 2006 15:14:18 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: failed to complete sync due to receiving bitmap
	in unexpected cstate
Date: Wed, 20 Dec 2006 15:14:19 +0100
References: <342BAC0A5467384983B586A6B0B376710446462E@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B376710446462E@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612201514.19459.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Dienstag, 19. Dezember 2006 20:36 schrieb Graham, Simon:
> > My theory was that there is a timing window relative to moving from
>
> the
>
> > PauseSync{T|S} state such that one side can get there first and
>
> restart
>
> > syncing before the other side.
>
> Not sure if you've had any thoughts on this, but I have a theory about
> this that was sparked by the problem I found today where we can still be
> in the PausedSyncX state when sync finishes...
>
> If you recall, the problem was what the sync source side would get into
> WFBitMapS and never exit and the target side would output:
>

Hi Simon, 

[Back from vacation]

I just read your mail from the 12th of December. I went through
the lines of the kernel logs line by line.

There is a bit called SYNC_STARTED. This is needed to determin if
we should clear bits in the bitmap upon the completion of
normal application writes.

Since I needed to introduce this during drbd-0.7 while the protocol
was frozen, I needed to introduce this bit without introducing a
new packet into the protocol.

I decided to set it with the first WriteAck sent from the SyncTarget
node to the SyncSource node.

  Before (with out the SYNC_STARTED bit) it could happen that one
  node considered an app-write to happen during the resync 
  (and drbd_set_in_sync() should be called) but the other node
  considered it to happen before the resync (therefore it did
  not call drbd_set_in_sync()). 


 Just an other thing I wanted to mention: 
 SyncPause only gets into effect after the exchange of the bitmaps
 finished.

I can reproduce here an issue where I disconnect two devices, r1 is
to sync after r0. 

1) I modify many blocks on r0, a few on r1.
2) When connecting them r0 does its resync, r1 goes into sync pause.
3) Then I rewrite the same blocks on r1, and in the end the 
   syncSource of r1 does not recognise that resync is finished.

I am working on this issue right now...

-phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
