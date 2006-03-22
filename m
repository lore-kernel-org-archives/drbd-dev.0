Return-Path: <Lars.Ellenberg@linbit.com>
Received: from barkeeper1 (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 88C7316AE1
	for <drbd-dev@lists.linbit.com>; Wed, 22 Mar 2006 23:35:02 +0100 (CET)
Date: Wed, 22 Mar 2006 23:35:02 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] freeze under postmark io bench
Message-ID: <20060322223502.GB6223@barkeeper1.linbit>
References: <6ed4c8790602101017l48d1b24s9fd684c82998e34f@mail.gmail.com>
	<20060311163505.GC3816@soda.linbit>
	<6ed4c8790603221046w6fedd871p8786bc427eafd8b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ed4c8790603221046w6fedd871p8786bc427eafd8b@mail.gmail.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-03-22 19:46:13 +0100
\ Laurent Denel:
> > please try with latest svn
> >  svn co http://svn.drbd.org/drbd/branches/drbd-0.7
> >
> > I just checked in a one line change where we used GFP_KERNEL where we
> > should have used GFP_NOIO...
> 
> Thanks a lot for the answer, I wondered if my bug report wasn't too
> stupid to reach the mass audiences ;).
> 
> I've just tried today with kernel 2.6.16 (sorry for that kernel are
> evolving fast here ;), if needed I can test with the 2.6.15.4 we had)
> and Monday's latest svn.
> 
> Postmark 200k files creation completed successfully but the
> transaction part crashed again the host. Could there be the same bug
> elsewhere in the code ?

No.
I think.
I reviewed all places with GFP_somthing,
and I did not see any other memory allocation
without NOIO in the io path. But I may have overlooked something.

what do you mean by "crashed the host"?
any output anywhere?
any reaction to ping, keyboard, numlock-led-toggle, sysrq keys?
nmi-watchdog enabled? does it trigger?
are you comfortable to recompile the kernel with the kernel debugger enabled,
and go into the kernel debugger when it "crashes" again, and see what it
thinks it does, where it thinks it is stuck?

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
