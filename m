Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 42D9F2CE7641
	for <drbd-dev@lists.linbit.com>; Fri, 11 Aug 2006 20:45:59 +0200 (CEST)
Date: Fri, 11 Aug 2006 20:45:59 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8: recent regression causing corruption and
	crashes
Message-ID: <20060811184559.GG7373@soda.linbit>
References: <342BAC0A5467384983B586A6B0B3767103624F3C@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B3767103624F3C@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-08-11 12:01:23 -0400
\ Graham, Simon:
> Quick update:
> 

How exactly do you "test"?
Kernel and hardware?
(sorry, if you posted that earlier, just point me to it)

I triggered a full sync (drbdadm invalidate),
and while that was running, access the Primary(SyncSource)
(cp -av /somethinghuge/ /mnt/drbd-mount-point/)

> > 1. I get errors during initial synchronization of a volume like this
> > that cause the resync to be aborted:
> > 
> > drbd15: tl_verify: failed to find req e51a4da0, sector 0 in list

I don't see those here.

> DRBD, Cmd: WriteAck, BlkId: SYNCER Sector: 0, AckLen: 8000

I don't see these either.

> > 2. I get panics with the following signature:- these look like they
> are
> > happening when a local write
> >     on the primary (which this node is) completes.
> 
> The panic signature seems to change - for example, I just got one like
> this in the receiver thread:
> 
> drbd15: ASSERT( drbd_req_get_sector(i) == sector ) in
> /sandbox/sgraham/sn/trunk/platform/drbd/8.0/drbd/drbd_main.c:313
> drbd15: tl_verify: found req e63d0240 but it has wrong sector (8 versus
> 0)

nor these.

> drbd15: in tl_clear_barrier:374: ap_pending_cnt = -1 < 0 !

this is bad...

What I do see here is: "ap_pending > 0" still too often, when I
disconnect during resync + write activity, effectively blocking the
Primary's io subsystem.  seemingly we still got bugs in tl_clear :(
need to look into that further.

> Code:  Bad EIP value.
>  <0>Fatal exception: panic in 5 seconds

outch.

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
