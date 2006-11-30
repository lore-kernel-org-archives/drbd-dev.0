Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda.linbit (unknown [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 3BC352CFEFC0
	for <drbd-dev@lists.linbit.com>; Thu, 30 Nov 2006 20:59:52 +0100 (CET)
Date: Thu, 30 Nov 2006 20:59:53 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: Stuck in WFBitMapS state even across reboot.
Message-ID: <20061130195953.GC7746@soda.linbit>
References: <BD7042533C2F8943A6A4257A9E31C45439C84F@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C84F@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-11-30 10:38:33 -0500
\ Montrose, Ernest:
> Phil,
> This involves Xen Vm's.  I would create one vm, I would then put an i/o
> load on there (Something that keeps reading and writing).  I would then
> go to the host and do an ifdown on the heartbeat interface in an attempt
> to force a split brain situation. I would then do an ifup. And every now
> and then this
> would happen (not all the time).  When it happens, it survives a reboot.
> I actually have not figured out how to get out of it.
> 
> I will try to find a more automatic way to reproduce it.

drbd_receiver.c, drbd_asb_recover_0p

| 	ch_peer = mdev->p_uuid[UUID_SIZE];
|       ch_self = drbd_bm_total_weight(mdev); ### <==

this ch_self may be different
from the one we communicated before, right?

|       switch ( mdev->net_conf->after_sb_0p ) {
|       ...
|
|       case DiscardZeroChg:

so, if we communicated ch_self == 0, but now ch_self is > 0,
and ch_peer is 0 (inactive peer sees this reversed), then

|                if( ch_peer == 0 && ch_self == 0) {

inactive peer does this, and may decide he is the source;

|                        rv=test_bit(DISCARD_CONCURRENT,&mdev->flags) ? -1 : 1;
|                        break;
|                } else {

active peer does this branch,
and decides he is the source.

|                        if ( ch_peer == 0 ) { rv =  1; break; }
|                        if ( ch_self == 0 ) { rv = -1; break; }
|                }
|                if( mdev->net_conf->after_sb_0p == DiscardZeroChg ) break;

doh. have to think about that...

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
