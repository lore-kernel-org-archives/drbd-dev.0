Return-Path: <lars@linbit.com>
Date: Tue, 7 Sep 2004 17:55:59 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Another drbd race
Message-ID: <20040907155559.GB12927@nudl>
References: <20040819110202.GO9601@marowsky-bree.de>
	<200409071139.29609.philipp.reisner@linbit.com>
	<20040907101343.GA5638@nudl>
	<200409071419.55799.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409071419.55799.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Sep 07, 2004 at 02:19:55PM +0200, Philipp Reisner wrote:
> 
> > > I do not want to "misuse" the Consistent Bit for this.
> > >
> > > !Consistent  .... means that we are in the middle of a sync.
> > >                    = data is not usable at all.
> > >  Fenced      .... our data is 100% okay, but not the latest copy.
> >
> > lets call it "Outdated"
> >
> > my idea is that a crashed Secondary will come up as !Primary|Connected, so
> > it can assume it is outdated. (similar to the choice about wfc-degr...)
> >
> > we can only possibly lose write transaction in the very moment we
> > promote a Secondary to Primary. until we do that, and the harddisk where
> > the transactions have been written to is still physically intact, the
> > data is still there, though maybe not available.
> >
> > we can try to make sure that we never promote a Secondary that possibly
> > (or knowingly) is outdated.
> >
> > see below.
> >
> 
> Let us assume that we have two boxes (N1 and N2) and that tese
> two boxes are connected by two networks (net and cnet [ clinets'-net ]).
> 
> Net is used by DRBD, while heartbeat uses both, net and cnet
> 
> I know that you are talking about fencing by STONITH, but DRBD is
> not limited to that. Here comes my understanding of how fencing
> (other tan STONITH) could work with DRBD-0.8 :
> 
>  N1  net   N2
>  P/S ---  S/P     everything up and running.
>  P/? - -  S/?     network breaks ; N1 freezes IO
>  P/? - -  S/?     N1 fences N2:
>                   In the Stonith case: turn off N2.
>                   In the "smart" case: 

>                   N1 asks N2 to fence itself from the storage via cnet.
>                   HB calls "drbdadm fence r0" on N2.
>                   N2 replies to N1 that fencins is done via cnet.
>                   N1 calls "drbdadm peer-dead r0".

the above lines are basically what happens in the recovery path of the
cluster resource manager. yes.

>  P/D - -  S/?     N1 thaws IO
> 
> N2 got the the "Outdated" flag set in its meta-data, by the "fence" 
> command. I am not sure if it should be called "fence", other ideas:
> "considered-dead","die","fence","outdate". What do you think ?
> 
> My question is:
>  Is it planed that heartbeat will be able to perform this kind of fencing ?

that is more or less what we are going to do.

the "fence" in the above "smart" case I'd call "drbdadm mark-outdated r0".
yes, heartbeat 2.x will do resource level fencing when possible.


	lge
