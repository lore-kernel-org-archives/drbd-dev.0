Return-Path: <lars@linbit.com>
Date: Tue, 7 Sep 2004 17:45:57 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: drbd in linux-ha cvs
Message-ID: <20040907154557.GA12927@nudl>
References: <20040906135609.GT11820@marowsky-bree.de>
	<20040907104926.GA7387@nudl>
	<20040907120330.GH10035@marowsky-bree.de>
	<200409071456.19233.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409071456.19233.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Sep 07, 2004 at 02:56:19PM +0200, Philipp Reisner wrote:
> On Tuesday 07 September 2004 14:03, Lars Marowsky-Bree wrote:
> > On 2004-09-07T12:49:26,
> >
> >    Lars Ellenberg <lars.ellenberg@linbit.com> said:
> > > it is more clean to have one ioctl, get the full info, and output that.
> > > I feel uneasy about introducing additional races by using several ioctls
> > > in a row (even if they all finish within one second). of course, once we
> > > have that info it could be stale already, but at least we have the
> > > guarantee that at some point in time it was correct.
> >
> > Well, even if not correct, so at least it was consistent ;-)
> >
> > It's also much easier to maintain in the external script, and less
> > likely to be gotten wrong in the script.
> >
> > > as soon as we have a sane interface, I don't expect the internals to
> > > change so often, so the "maintenance trouble" is very low, either way.
> >
> > Well, even if eventually change and export more data, that's more
> > maintainable.
> >
> > I don't need writes to the generation counters, but getting at all that
> > information to know where to move things would be quite helpful.
> >
> 
> My initial understanding was that this read-generation counters
> operation would read it off the disk (== run while the DRBD 
> module is not loaded). Do you mean that ? Or do you want to have
> an ioctl to ask the module for the current value of the countes ?

I think both ways make sense.
yes, I already added __u32 gen_cnt[5] to get_config here, but
I won't commit that too soon, I have some more suggestions in the ioctl
area, so we should wait for end of September first...

	lge
