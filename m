Return-Path: <lmb@suse.de>
Date: Wed, 8 Sep 2004 17:11:30 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Another drbd race
Message-ID: <20040908151130.GK20844@marowsky-bree.de>
References: <20040819110202.GO9601@marowsky-bree.de>
	<200409071419.55799.philipp.reisner@linbit.com>
	<20040907122840.GA15272@marowsky-bree.de>
	<200409071447.45785.philipp.reisner@linbit.com>
	<20040908112001.GD20844@marowsky-bree.de>
	<20040908113110.GA10017@nudl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040908113110.GA10017@nudl>
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-09-08T13:31:10,
   Lars Ellenberg <lars.ellenberg@linbit.com> said:

> > So, why an explicit drbdadm fence operation? I'm missing what that would
> > catch.
> 
> we probably can cope without, but it is more "polite" if we have it.
> if we _can_ handle it explicit, why not?

We _need_ to handle it implicitly in case we lose the connection in that
scenario.

_Explicitly_ setting the outdated flag in some more scenarios may also
be appropriate, yes.

> implicit things are more easy to overlook...
> 
> and:
>   P --- S  
>   P xxx S        link breaks
> 
>   [ you can insert here even a complete cluster crash ]

That's a triple fault already!

>   X xxx S        N2 receives "Peer dead", but still is outdated.

That is a quad-fault!!! (Link lost, two nodes down, one node not coming
up)

Yes, and it knows that because of the implicit "lost connection to
primary or died while being connected" already, even if the crash then
happened even before the CRM could invoke the 'mark_outdated'
operation.

The mark_peer_dead in this case should not reset the the 'Outdated'
flag. It should only do so in case it's received after a connection loss
to the primary; the 'unclean reboot' should be taken into consideration
(and I think there's a flag for that already.)

A S-P should always consider itself outdated unless it receives the
mark_peer_dead under the right circumstances. 

But, we are already pretty far in lala land.

>   the point is: just receiving a "peer definetely dead" in S/?
>   is not enough to know that we are not outdated.

Right. But the fence doesn't help much either, for we need to set that
flag in that scenario even if the 'fence' event just isn't delivered.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	   \\\  /// 
SUSE Labs, Research and Development \honk/ 
SUSE LINUX AG - A Novell company     \\// 

