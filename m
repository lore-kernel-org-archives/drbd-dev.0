Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 2E4482CE72ED
	for <drbd-dev@lists.linbit.com>; Fri, 11 Aug 2006 21:57:16 +0200 (CEST)
Date: Fri, 11 Aug 2006 21:57:16 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8: recent regression causing corruption andcrashes
Message-ID: <20060811195716.GI7373@soda.linbit>
References: <342BAC0A5467384983B586A6B0B3767103624F87@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B3767103624F87@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-08-11 15:11:38 -0400
\ Graham, Simon:
> > / 2006-08-11 12:01:23 -0400
> > \ Graham, Simon:
> > > Quick update:
> > >
> > 
> > How exactly do you "test"?
> > Kernel and hardware?
> > (sorry, if you posted that earlier, just point me to it)
> 
> In this case, this happens only when I install a pair of systems from
> scratch and it is doing initial synchronization of one specific DRBD
> partition which is also being written to by our applications at the same
> time. I did post the sequence at the end of a previous message, but it's
> basically:
> 
> 1. on both systems use drbdmeta to wipe the meta data with no network
> connection established
> 2. on one system, mount the drbd disk, make a file system and untar some
> stuff on to it (still with no network connection)
> 3. reboot both systems - when they come up, resync starts. On one
> system, mount the file system (which causes reads/writes
>    at the same time as the resync)
> 
> Once I'm in this state (and have had the crash which happens everytime),
> I'm not able to manually resync the disks -- I suspect I don't
> understand enough about this yet, but it always says there is a
> split-brain and it's not able to fix it even if I set the after-sb-xpri
> options.
> 
> The hardware is a pair of Dell servers, software is 2.6.16.13 with Xen
> 3.0.2 patches; this all worked fine until about 1 week ago when I
> upgraded to the latest trunk version of drbd 8.

ok...
so there is badness somewhere in our recent commits?
you remember (look it up in the kernel logs) which
revision did work last?

did you change the file system?

> Simon
> 
> BTW: I have also checked carefully that I'm running the latest trunk
> version (as of last night).

Also, I'm up to some serious bug in the alloc_ee function:
we do not handle bio_add_page "errors" yet, but they _do_ occur.
may or may not be related to those strange WriteAck sector == 0.

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
