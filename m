Return-Path: <lars@linbit.com>
Date: Wed, 8 Sep 2004 13:31:10 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Another drbd race
Message-ID: <20040908113110.GA10017@nudl>
References: <20040819110202.GO9601@marowsky-bree.de>
	<200409071419.55799.philipp.reisner@linbit.com>
	<20040907122840.GA15272@marowsky-bree.de>
	<200409071447.45785.philipp.reisner@linbit.com>
	<20040908112001.GD20844@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908112001.GD20844@marowsky-bree.de>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Sep 08, 2004 at 01:20:01PM +0200, Lars Marowsky-Bree wrote:
> On 2004-09-07T14:47:45,
>    Philipp Reisner <philipp.reisner@linbit.com> said:
> 
> > No. It would be better to have a "drbdadm fence r0" operation on N2!
> > The "drbdadm fence r0" command would only set the "Outdated" flag.
> 
> Well, it's automatically supposed to assume it's outdated when it
> crashes in S-P mode.
> 
> When the secondary loses connection to the primary, a mark-peer-dead
> would prevent that flag from being set.
> 
> So, why an explicit drbdadm fence operation? I'm missing what that would
> catch.

we probably can cope without, but it is more "polite" if we have it.
if we _can_ handle it explicit, why not?
implicit things are more easy to overlook...

and:
  P --- S  
  P xxx S        link breaks

  [ you can insert here even a complete cluster crash ]

  X xxx S        N2 receives "Peer dead", but still is outdated.

 
  the point is: just receiving a "peer definetely dead" in S/?
  is not enough to know that we are not outdated.

	lge
