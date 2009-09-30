Return-Path: <BATV+3daa9655a1c8c11dee4c+2229+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 0853B100014D
	for <drbd-dev@lists.linbit.com>; Wed, 30 Sep 2009 18:00:12 +0200 (CEST)
Date: Wed, 30 Sep 2009 12:00:01 -0400
From: Christoph Hellwig <hch@infradead.org>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org,
	akpm <akpm@linux-foundation.org>, drbd-dev@lists.linbit.com,
	mingo@elte.hu, rostedt@goodmis.org
Message-ID: <20090930160001.GA3765@infradead.org>
References: <20090925133830.1ba29584.sfr@canb.auug.org.au>
	<4ABD4C28.9070202@oracle.com>
	<200909291732.51383.philipp.reisner@linbit.com>
	<20090929153747.GA29621@infradead.org>
	<20090930080221.GA8032@barkeeper1-xen.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090930080221.GA8032@barkeeper1-xen.linbit>
Subject: Re: [Drbd-dev] [PATCH -next] drbd: trace depends on TRACING
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Sep 30, 2009 at 10:02:21AM +0200, Lars Ellenberg wrote:
> TRACE_EVENT macros depend on, and use TRACE_POINTS.
> And those trace points are what compiles away if !CONFIG_TRACEPOINTS, no?

Everything compiles away when the right options are not selected.

> If using tracepoints directly, not using the (admittedly elegant)
> trace-events macro system, is in fact not wanted anymore, then
> Documentation/trace/* should be changed accordingly.

I could not find anything actively suggesting to use them.  And if you
look at current mainline there is in fact no user of raw tracepoints
left and none should be introduced.  If you add fancy new tracing it
might be a good idea to run it past Ingo and Steve, btw.

Ingo, now that we killed all raw tracepoints users, what do you think
about removing Documentation/trace/tracepoints.txt and
samples/tracepoints so that people have no easy way to use them?

Even better would be making their use really hard, which is not too easy
as they are used by TRACE_EVENT underneath.

> So what is the plan, going forward?

The plan is that all new tracing should use TRACE_EVENT.  If that
doesn't work for some reason bring it up with the tracing people
for discussion.

