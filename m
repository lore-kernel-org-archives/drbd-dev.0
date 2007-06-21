Return-Path: <lars@linbit.com>
Date: Thu, 21 Jun 2007 15:26:06 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Running Protocol C with disk cache enabled
Message-ID: <20070621132606.GB22863@ogo.aicooma.com>
References: <342BAC0A5467384983B586A6B0B3767105DEB765@EXNA.corp.stratus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B3767105DEB765@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Jun 20, 2007 at 03:47:02PM -0400, Graham, Simon wrote:
> > > > acknowledged prior to the failure. Now, I think that the activity
> > log
> > > > maintained by the Primary actually includes the necessary
> > information
> > > > about blocks which should be resynchronized _but_ I don't see any
> > code
> > > > that would actually add these blocks to the bitmap when such a
> > failure
> > > > occurs.
> > > >
> > >
> > > Right we do not do this. The current opinion on this is: If the
> > > disk reported IO completion it has to be on disk. (actually a point
> > > of view of the Linux-2.2 and Linux-2.4 time).
> > 
> > Me and Phil had a few words about this.
> > 
> > Now, lying hardware is sooo broken :(
> > but, anyways.
> > 
> 
> Well, I look at this slightly differently; use of the on-disk cache is
> really the only way to get decent (i.e. competitive) performance out of
> rotating rust, so what we have to do is find ways to allow this and
> still be correct.

well, yes.
but when kernel asks disk to "get it to disk now, and tell me when it is
there", and the disk lies about it, this is bad.
in a perfect world, there would be no need to disable the cache,
when the disk just would tell the thruth.

> BTW: another case that is of interest to me is when you have a caching
> controller -- even though these have battery backup, there is still the
> case to worry about when the controller itself fails (something we have
> to worry about when building fault tolerant servers) -- in this case, it
> should be possible to repair/replace the failed controller and then
> reboot and have DRBD resync correctly...
> 
> > 
> > we would basically maintain the activity log on the secondary
> > as well, and introduce an additional "cleanly detached" flag.
> > 
> > whenever you attach it again, the extents covered would need to be
> > resynced.  obviously this behaviour should be configurable, you want
> to
> > disable it for good hardware and large activity log.
> > 
> > I can think of few possible optimizations, even...
> > but we should not over-engineer what is "just" a workaround.
> > 
> 
> I thought about this too -- however, I managed to convince myself that
> it isn't necessary to store the AL on both disks since we can use the AL
> from the disk that was primary (wouldn't they be identical?) -- maybe
> there's a case I'm not considering though.

as a side note, no, they are not necessarily identical at all times
(requests in flight to non-covered extent).

in the "allow-two-primaries" case I think we maintain it anyways.
it should not be too much overhead to maintain it always.
and it is the most generic solution: it would just work.

> Would it be enough to modify the code to add the current AL to the
> in-memory and on-disk bitmaps on the primary whenever you lose contact
> with the peer??? I realize this is different from how it is handled for
> the loss-of-primary case...

any implementation should not be half-assed.
but, provided that 
  we can prove that we, under all circumstances (protocol != C,
  small ativity log, many random writes etc.), still cover *at least*
  the area that might have been in the write cache of the remote disk,
then, yes, it should be sufficient.

the interessting part here is, that if we maintain a timestamp
(in the lru lists in memory), we could optimize for large activitly logs
(several GB covered extents), by flagging only those extents that have
seen activity during the last $seconds. Or we could maintain some
"throughput" statistic, and only flag those extents which the last
$megabytes targeted.

food for thought :)

-- 
: Lars Ellenberg                            Tel +43-1-8178292-0  :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
