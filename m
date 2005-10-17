Return-Path: <Lars.Ellenberg@linbit.com>
Received: from barkeeper1 (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 959691431D
	for <drbd-dev@lists.linbit.com>; Mon, 17 Oct 2005 15:56:18 +0200 (CEST)
Date: Mon, 17 Oct 2005 15:56:18 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [DRBD-cvs] svn commit by phil - r1985 -
	branches/drbd-0.7/drbd - Fixed a self made SMP lockup;
	showing up in drbd_al_com
Message-ID: <20051017135618.GA32693@barkeeper1.linbit>
References: <20051017134012.CB1741431D@mail.linbit.com>
	<20051017134349.GT8354@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051017134349.GT8354@marowsky-bree.de>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2005-10-17 15:43:49 +0200
\ Lars Marowsky-Bree:
> On 2005-10-17T15:40:12, drbd-cvs@lists.linbit.com wrote:
> 
> > Author: phil
> > Date: 2005-10-17 15:40:11 +0200 (Mon, 17 Oct 2005)
> > New Revision: 1985
> > 
> > Modified:
> >    branches/drbd-0.7/drbd/drbd_bitmap.c
> > Log:
> > Fixed a self made SMP lockup; showing up in drbd_al_complete_io()
> > 
> >   With drbd-0.7.12 we moved the al_lock before the bm_clear_bit()
> >   in  __drbd_set_in_sync(). That by itself is okay, but 
> >   in bm_clear_bit() we used the spin_[un]lock_irq() functions,
> >   therefore reenabling interrupts...
> >   This is fixed now.
> 
> Hi Philipp, how critical is this bug, and how likely is it that it will
> be hit in practice?

depending on the actual timing...

once we started looking for it, we could reproduce it on our
test cluster within minutes.  it occurs on Primary/SyncSource which
is the typical case.

it will be hit. rating is CRITICAL (for smp).

there will be a 0.7.14 today, latest tomorrow, including this fix,
and the fix for not notifying the peer about "io-error on read".

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-0  :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
