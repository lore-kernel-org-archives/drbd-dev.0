Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 120E32CE783B
	for <drbd-dev@lists.linbit.com>; Thu, 17 Aug 2006 13:49:25 +0200 (CEST)
Date: Thu, 17 Aug 2006 13:49:25 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8: handling of concurrent writes with two
	primaries
Message-ID: <20060817114925.GC7402@soda.linbit>
References: <342BAC0A5467384983B586A6B0B3767103625529@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B3767103625529@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-08-16 16:54:03 -0400
\ Graham, Simon:
> OK, so I was slightly wrong here:
> 
> > 2. If the UNIQE flag is set, then I don't see how the partner node
> > will make any progress - you never send an Ack and do not disconnect
> > - if the partner also sees the conflict then he will do the Discard
> > msg processing, but I don't think this is guaranteed - I'm probably
> > missing something, but if the partner gets the request and _then_
> > issues a write to the same location, I don't think it will do the
> > right thing... the partner will simply discard and you are left
> > hanging...
> 
> Since I've found the code that checks for collision on the write side
> and adds the info to the list. I still think the other issue applies
> (Ack and Data can be re-ordered which means there are cases where you
> wont wait for the outstanding req to complete when you really should)...

hmmm.
did you read
 http://www.drbd.org/fileadmin/drbd/publications/drbd8_wpnr.pdf
can you point out what we were missing there?

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
