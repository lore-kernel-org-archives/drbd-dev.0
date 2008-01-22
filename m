Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 935F92DEACD6
	for <drbd-dev@lists.linbit.com>; Tue, 22 Jan 2008 17:20:07 +0100 (CET)
Date: Tue, 22 Jan 2008 17:20:07 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Barrier assert failures with latest 8.0 sources
Message-ID: <20080122162007.GD7594@barkeeper1.linbit>
References: <342BAC0A5467384983B586A6B0B3767107E89B46@EXNA.corp.stratus.com>
	<342BAC0A5467384983B586A6B0B3767107E89D34@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B3767107E89D34@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Jan 21, 2008 at 09:29:02PM -0500, Graham, Simon wrote:
> > > I'm not sure why tl_clear leaves this pseudo-barrier in the list...
> > > shouldn't it simply leave the list completely empty just like
> tl_init
> > > does?
> > 
> > probably.
> > we have seen these ASSERTS, too, btw, also without this latest change
> > in
> > the barrier code, so aparently it has been there all along.
> > unfortunately we are all sort of distracted right now.
> > but coding will resume shortly :)
> 
> Well, I realize now that I completely misunderstood again;
> newest_barrier represents thenext barrier that will be sent, so of
> course there has to be one in the list at all times (and tl_init also
> sets up barrier 4711).
> 
> I think the problem is that tl_clear does NOT clear the CREATE_BARRIER
> bit from mdev->flags - so if we disconnect in the small window between
> setting this bit and creating the new barrier, then when we reconnect
> and send the first request, we'll end up creating a new barrier before
> sending the BarrierRq(4711) (processing the first request that has to go
> remote) and I think this gets us into the cycle of always being one
> barrier behind the remote system... this would also explain why the
> assert is intermittent since you have to disconnect in a small window...
> 
> Seem reasonable?

absolutely.

 :)

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
