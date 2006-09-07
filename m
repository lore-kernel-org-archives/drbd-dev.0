Return-Path: <Lars.Ellenberg@linbit.com>
Date: Thu, 7 Sep 2006 18:40:41 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: "Graham, Simon" <Simon.Graham@stratus.com>
Subject: Re: [Drbd-dev] DRBD-8 - system hangs when NegDReply received
Message-ID: <20060907164041.GH13664@barkeeper1.linbit>
References: <342BAC0A5467384983B586A6B0B37671038AFC6A@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B37671038AFC6A@EXNA.corp.stratus.com>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-09-07 10:21:22 -0400
\ Graham, Simon:
> 
> > I am still working on a monster patch to consolidate all the
> > request functionality in one place, so it is more obvious what should
> > and should not happen.
> > I may be wrong here, but you cannot simply end the master request and
> > free the req because you get a NegDReply. the local part (submit_bio)
> > may still be on the fly.
> > you have to use drbd_end_req with appropriate flags...
> 
> I had the same thought when I started looking at this - however,
> currently reads do NOT use this approach since a read is only issued on
> one side - receive_DataReply does just complete the master bio for
> example; in fact, I mostly copied the code from this routine.

well, see my other post in this thread...

> Do you have any idea when your monster patch will be ready?

should have been done today...
unfortunately, while in the middle of implementing stuff,
I managed to lock me out of the flat I currently work in...
 :-/

anyways, thats that...
maybe I still get it done today, latest tomorrow.

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
