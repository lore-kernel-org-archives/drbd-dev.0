Return-Path: <lars@linbit.com>
Date: Wed, 8 Sep 2004 17:22:42 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Another drbd race
Message-ID: <20040908152242.GA23749@nudl>
References: <20040819110202.GO9601@marowsky-bree.de>
	<200409071419.55799.philipp.reisner@linbit.com>
	<20040907122840.GA15272@marowsky-bree.de>
	<200409071447.45785.philipp.reisner@linbit.com>
	<20040908112001.GD20844@marowsky-bree.de>
	<20040908113110.GA10017@nudl>
	<20040908151130.GK20844@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908151130.GK20844@marowsky-bree.de>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Sep 08, 2004 at 05:11:30PM +0200, Lars Marowsky-Bree wrote:
> On 2004-09-08T13:31:10,
>    Lars Ellenberg <lars.ellenberg@linbit.com> said:
> 
> > > So, why an explicit drbdadm fence operation? I'm missing what that would
> > > catch.
> > 
> > we probably can cope without, but it is more "polite" if we have it.
> > if we _can_ handle it explicit, why not?
> 
> We _need_ to handle it implicitly in case we lose the connection in that
> scenario.
> 
> _Explicitly_ setting the outdated flag in some more scenarios may also
> be appropriate, yes.

that is what I said. :)

> 
> > implicit things are more easy to overlook...
> > 
> > and:
> >   P --- S  
> >   P xxx S        link breaks
> > 
> >   [ you can insert here even a complete cluster crash ]
> 
> That's a triple fault already!
> 
> >   X xxx S        N2 receives "Peer dead", but still is outdated.
> 
> That is a quad-fault!!! (Link lost, two nodes down, one node not coming
> up)

...

> But, we are already pretty far in lala land.

right :)

> 
> >   the point is: just receiving a "peer definetely dead" in S/?
> >   is not enough to know that we are not outdated.
> 
> Right. But the fence doesn't help much either, for we need to set that
> flag in that scenario even if the 'fence' event just isn't delivered.

what I want to hav in is just a cover-my-ass thingy to require explicit
confirmation before possibly losing (application-wise) confirmed data
transactions.

	Lars
