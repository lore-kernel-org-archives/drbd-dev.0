Return-Path: <Lars.Ellenberg@linbit.com>
Date: Sat, 25 Sep 2004 11:50:04 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@linbit.com, linux-ha-dev@lists.linux-ha.org
Subject: Re: [Drbd-dev] Re: [Linux-ha-dev] [RFC] (CRM and) DRBD (0.8) states
	and transistions, recovery strategies
Message-ID: <Hk8L7YsCaLPZMUXM+NGHIHM=lge@web.de>
References: <yZEXPsg2gvkm1jq9tjYKNcg=lge@web.de>
	<20040924211133.GC3927@marowsky-bree.de>
	<qEu8Pd/NWgF9/2NlEKWF2r4=lge@web.de>
	<20040925085428.GA4267@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925085428.GA4267@marowsky-bree.de>
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-09-25 10:54:28 +0200
\ Lars Marowsky-Bree:
> On 2004-09-25T01:04:57,
>    Lars Ellenberg <Lars.Ellenberg@linbit.com> said:
> 
> > > I don't see any difference here between meta-data and backing store
> > > loss, actually, that complicates things unnecessarily.
> > 
> > well, DRBD needs to make a difference, because they meta-data storage
> > and data storage may be physically different devices, and therefore can
> > fail independently. (ok, single blocks can fail on the same physical
> > storage independently, too, but this is an other thing)
> 
> The point I was trying to make is that meta-data loss and backing
> storage loss can essentially be mapped to a generic local IO failure.
> 
> The special case where we only loss access to the backing store and not
> to the meta-data allows us to set a flag there (for whatever use it may
> be the next time we compare GCs), but then it amounts to the same: Loss
> of the local storage.
> 
> I don't see any benefit in keeping the two as distinct failure modes...

well. they are different events, and I must handle both of them.
there indeed is no benefit to it. but this is not about theoretically
descibing it, in the end I want to code a state machine from it,
and know that it is complete.

in any case, if you look at the listed states, all of them have the "M"
on, so I already "simplified" in so far...

currently in drbd it IS indeed both mapped to "local io error",
then "trying" (without further action on failure) to set the
"inconsistent, need full sync" bit in the meta-data.

but currently in drbd recovery code is distributed in small pieces all
over the code, and I want to try to put it all into one place,
and be sure I deal with every possible corner case.

and for example if we are the only remaining node (we have no
connection), we may rather chose to continue, passing on IO errors if
they happen, than to "detach" the partially broken storage.

appart from the fact that the local storage should never fail,
and should possibly be some sort of raid itself...

	lge
