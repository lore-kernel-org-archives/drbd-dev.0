Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (unknown [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 105FC2CFFBB0
	for <drbd-dev@lists.linbit.com>; Tue, 19 Dec 2006 17:13:48 +0100 (CET)
Date: Tue, 19 Dec 2006 17:13:48 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8: Patch to fix incorrect split-brain occurrence.
Message-ID: <20061219161348.GA8069@soda.linbit>
References: <342BAC0A5467384983B586A6B0B3767104464575@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B3767104464575@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-12-19 10:45:04 -0500
\ Graham, Simon:
> In testing, we have run into a case where we unexpectedly get a
> split-brain situation - after some investigation I think I have found
> the reason - at the end of syncing, the SyncTarget side finishes up by
> setting it's UUID info to the same as the Source (in
> drbd_resync_finished) - the code that does this checks for connection
> state SyncTarget before doing this. 
> 
> Now, I have seen that sometimes the resync completes when in PausedSyncT
> state - for example, if the last set of blocks is already under way when
> we decide to go into the PausedSyncT state 

right, or "resync" "just happens" by application writes.

> - thus it's entirely possible
> to enter drbd_resync_finished with connection state PausedSyncT in which
> case we do finish up the resync but do not copy the UUID info - this
> means that the next time we need to resync, the code determines that we
> have a split-brain situation.
> 
> In other places in the code, checks are made for either SyncTarget or
> PausedSyncT so I propose fixing this (patch attached) the same way -
> have drbd_resync_finished check for either SyncTarget OR PausedSyncT.

right.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
