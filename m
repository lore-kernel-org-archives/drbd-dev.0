Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (dialin-145-254-065-009.arcor-ip.net [145.254.65.9])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 533571430E
	for <drbd-dev@lists.linbit.com>; Mon,  8 Nov 2004 17:19:47 +0100 (CET)
Date: Mon, 8 Nov 2004 17:14:25 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [DRBD-cvs] r1611 - branches/drbd-0.7/drbd
Message-ID: <OWkyYFI5+Vo0MyMiVIydDYY=lge@web.de>
References: <20041024112015.D1DD53BE6D@garcon.linbit.com>
	<200411081338.10061.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411081338.10061.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-11-08 13:38:09 +0100
\ Philipp Reisner:
> On Sunday 24 October 2004 13:20, svn@svn.drbd.org wrote:
> > Author: lars
> > Date: 2004-10-24 13:20:13 +0200 (Sun, 24 Oct 2004)
> > New Revision: 1611
> >
> > Modified:
> >    branches/drbd-0.7/drbd/drbd_receiver.c
> > Log:
> > * wake_up_interruptible did not wake up threads in wait_even(cstate)
> > * down_interruptible in drbd_send_handshake, just in case some drbdsetup
> > kills us
> >
> 
> 
> Lars,
> 
> One last DRBD related question before your get on the plain.
> Does this fix this "deadlock in WFConnection state", which was
> discussed on the list ? 

I have no idea.  it was a "just in case" fix. got no feedback on it, and
could not reproduce myself.

	lge
