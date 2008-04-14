Return-Path: <lars.ellenberg@linbit.com>
Received: from racke.linbit (office.linbit [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id C49572E089A8
	for <drbd-dev@lists.linbit.com>; Mon, 14 Apr 2008 23:59:30 +0200 (CEST)
Date: Mon, 14 Apr 2008 23:59:59 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Perf issues with DRBD when doing a lot of random I/O
Message-ID: <20080414215959.GC11768@racke.local>
References: <342BAC0A5467384983B586A6B0B3767108F030CD@EXNA.corp.stratus.com>
	<342BAC0A5467384983B586A6B0B3767108F03209@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B3767108F03209@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Apr 14, 2008 at 03:21:14PM -0400, Graham, Simon wrote:
> This is a follow on to the earlier conversation on the issues with the
> drbd_merge_bvec function  - having modified this, I am still seeing
> performance  with DRBD of about 66% of what I see with no DRBD. 
> 
> The specific workload is quite vicious and does a lot of random I/O
> across the entire disk, so I experimented with bumping the AL cache size
> up to the max; this got my performance up to 72% of 'native' - better
> but still no great.
> 
> Then I started thinking about the change I submitted a while back to
> make meta data updates be barrier requests - given that this random
> workload causes a lot of AL cache turns, it's also causing a lot of
> meta-data activity, so a barrier request is likely to cause a lot of
> stalls.
> 
> Now, thinking more about this, I'm not so sure that a barrier is
> appropriate here -- when we update the on-disk AL, we are actually
> throwing away information that a given block is modified,

we are throwing away information that a given block _may_ be modified,
and we are _adding_ information that an other given block may be
modified.

> so we need to
> be sure THAT block has been committed to the disk, however, it has
> nothing to do with the current set of outstanding I/O to the disk (at
> least, it seems so to me).
> 
> I then tried a little test of simply commenting out the barrier in the
> meta data update path and voila I was up to 88% of native perf - finally
> within striking range of acceptable!
> 
> So... the big question is whether or not having a barrier set on
> meta-data updates to the on disk AL is required for correctness

there is certainly room for improvement, we may be able to reduce the
number of single meta data requests.  but for volatile write cache,
is there an other way than barrier requests for us to get FUA?

I think the semantics we need for the typical al transaction, i.e.
expiring one al-extent, and reusing its slot for an other one, are:
 - we have to be sure that all io to the region we expire has not only
   been "completed" (reached the volatile cache) but also "reached
   stable storage" (the disk itself)
 - we need to be sure that the al transaction reached stable storage
   before we start the real io to the corresponding new region
which is perfectly expressed by a barrier request.

note that in 8.0.12, we made the use of barriers/cache flushes
configurable, you can switch it off, if you know and trust your
hardware (non-volatile cache).

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
