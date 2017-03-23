Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 684B7105647D
	for <drbd-dev@lists.linbit.com>; Thu, 23 Mar 2017 23:53:11 +0100 (CET)
Received: by mail-wm0-f49.google.com with SMTP id u132so506062wmg.0
	for <drbd-dev@lists.linbit.com>; Thu, 23 Mar 2017 15:53:11 -0700 (PDT)
Date: Thu, 23 Mar 2017 23:53:09 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Mike Snitzer <snitzer@redhat.com>
Message-ID: <20170323225256.GK1138@soda.linbit>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323155410.GD1138@soda.linbit>
	<20170323170221.GA20854@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323170221.GA20854@redhat.com>
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	shli@kernel.org, Christoph Hellwig <hch@lst.de>, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] RFC: always use REQ_OP_WRITE_ZEROES for zeroing
	offload
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Mar 23, 2017 at 01:02:22PM -0400, Mike Snitzer wrote:
> On Thu, Mar 23 2017 at 11:54am -0400,
> Lars Ellenberg <lars.ellenberg@linbit.com> wrote:
> 
> > On Thu, Mar 23, 2017 at 10:33:18AM -0400, Christoph Hellwig wrote:
> > > This series makes REQ_OP_WRITE_ZEROES the only zeroing offload
> > > supported by the block layer, and switches existing implementations
> > > of REQ_OP_DISCARD that correctly set discard_zeroes_data to it,
> > > removes incorrect discard_zeroes_data, and also switches WRITE SAME
> > > based zeroing in SCSI to this new method.
> > > 
> > > I've done testing with ATA, SCSI and NVMe setups, but there are
> > > a few things that will need more attention:
> > > 
> > 
> > >  - The DRBD code in this area was very odd,
> > 
> > DRBD wants all replicas to give back identical data.
> > If what comes back after a discard is "undefined",
> > we cannot really use that.
> > 
> > We used to "stack" discard only if our local backend claimed
> > "discard_zeroes_data". We replicate that IO request to the peer
> > as discard, and if the peer cannot do discards itself, or has
> > discard_zeroes_data == 0, the peer will use zeroout instead.
> > 
> > One use-case for this is the device mapper "thin provisioning".
> > At the time I wrote those "odd" hacks, dm thin targets
> > would set discard_zeroes_data=0, NOT change discard granularity,
> > but only actually discard (drop from the tree) whole "chunks",
> > leaving partial start/end chunks in the mapping tree unchanged.
> > 
> > The logic of "only stack discard, if backend discard_zeroes_data"

That is DRBDs logic I just explained above.
And the "backend" (to DRBD) in that sentence would be thin, and not
the "real" hardware below thin, which may not even support discard.

> > would mean that we would not be able to accept and pass down discards
> > to dm-thin targets. But with data on dm-thin, you would really like
> > to do the occasional fstrim.
> 
> Are you sure you aren't thinking of MD raid?

Yes.

> To this day, dm-thin.c has: ti->discard_zeroes_data_unsupported = true

That is exactly what I was saying.

Thin does not claim to zero data on discard.  which is ok, and correct,
because it only punches holes on full chunks (or whatever you call
them), and leaves the rest in the mapping tree as is.

And that behaviour would prevent DRBD from exposing discards if
configured on top of thin. (see above)

But thin *could* easily guarantee zeroing, by simply punching holes
where it can, and zeroing out the not fully-aligned partial start and
end of the range.

Which is what I added as an option between DRBD and whatever is below,
with the use-case of dm-thin in mind.

And that made it possible for DRBD to
 a) expose "discard" to upper layers, even if we would usually only do
    if the DRBD Primary sits on top of a device that guarantees discard
    zeros data,
 b) still use discards on a secondary, without falling back to zero-out,
    which would unexpectedly fully allocate, instead of trim, a thinly
    provisioned device-mapper target.


Thanks,

    Lars

