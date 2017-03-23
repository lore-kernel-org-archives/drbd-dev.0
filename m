Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A4E511056446
	for <drbd-dev@lists.linbit.com>; Thu, 23 Mar 2017 16:54:21 +0100 (CET)
Received: by mail-wm0-f50.google.com with SMTP id n11so64904149wma.1
	for <drbd-dev@lists.linbit.com>; Thu, 23 Mar 2017 08:54:21 -0700 (PDT)
Date: Thu, 23 Mar 2017 16:54:10 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20170323155410.GD1138@soda.linbit>
References: <20170323143341.31549-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323143341.31549-1-hch@lst.de>
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, martin.petersen@oracle.com,
	snitzer@redhat.com, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	linux-scsi@vger.kernel.org, shli@kernel.org, agk@redhat.com,
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

On Thu, Mar 23, 2017 at 10:33:18AM -0400, Christoph Hellwig wrote:
> This series makes REQ_OP_WRITE_ZEROES the only zeroing offload
> supported by the block layer, and switches existing implementations
> of REQ_OP_DISCARD that correctly set discard_zeroes_data to it,
> removes incorrect discard_zeroes_data, and also switches WRITE SAME
> based zeroing in SCSI to this new method.
> 
> I've done testing with ATA, SCSI and NVMe setups, but there are
> a few things that will need more attention:
> 

>  - The DRBD code in this area was very odd,

DRBD wants all replicas to give back identical data.
If what comes back after a discard is "undefined",
we cannot really use that.

We used to "stack" discard only if our local backend claimed
"discard_zeroes_data". We replicate that IO request to the peer
as discard, and if the peer cannot do discards itself, or has
discard_zeroes_data == 0, the peer will use zeroout instead.

One use-case for this is the device mapper "thin provisioning".
At the time I wrote those "odd" hacks, dm thin targets
would set discard_zeroes_data=0, NOT change discard granularity,
but only actually discard (drop from the tree) whole "chunks",
leaving partial start/end chunks in the mapping tree unchanged.

The logic of "only stack discard, if backend discard_zeroes_data"
would mean that we would not be able to accept and pass down discards
to dm-thin targets. But with data on dm-thin, you would really like
to do the occasional fstrim.

Also, IO backends on the peers do not have to have the same
characteristics.  You could have the DRBD Primary on some SSD,
and the Secondary on some thin-pool LV,
scheduling thin snapthots in intervals or on demand.

With the logic of "use zero-out instead", fstrim would cause it to
fully allocate what was supposed to be thinly provisioned :-(

So what I did there was optionally tell DRBD that
"discard_zeroes_data == 0" on that peer would actually mean
"discard_zeroes_data == 1,
 IF you zero-out the partial chunks of this granularity yourself".

And implemented this "discard aligned chunks of that granularity,
and zero-out partial start/end chunks, if any".

And then claim to upper layers that, yes, discard_zeroes_data=1,
in that case, if so configured, even if our backend (dm-thin)
would say discard_zeroes_data=0.

Does that make sense?  Can we still do that?  Has something like that
been done in block core or device mapper meanwhile?


> and will need an audit from the maintainers.

Will need to make some time for review and testing.

Thanks,

    Lars
