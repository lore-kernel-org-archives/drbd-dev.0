Return-Path: <BATV+169187331fd130129743+2228+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id EFD9510621C9
	for <drbd-dev@lists.linbit.com>; Tue, 29 Sep 2009 17:37:50 +0200 (CEST)
Date: Tue, 29 Sep 2009 11:37:47 -0400
From: Christoph Hellwig <hch@infradead.org>
To: Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <20090929153747.GA29621@infradead.org>
References: <20090925133830.1ba29584.sfr@canb.auug.org.au>
	<4ABD4C28.9070202@oracle.com>
	<200909291732.51383.philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200909291732.51383.philipp.reisner@linbit.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org,
	akpm <akpm@linux-foundation.org>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH -next] drbd: trace depends on TRACING
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Sep 29, 2009 at 05:32:50PM +0200, Philipp Reisner wrote:
> On Saturday 26 September 2009 01:03:04 Randy Dunlap wrote:
> > From: Randy Dunlap <randy.dunlap@oracle.com>
> >
> > DRBD_TRACE should depend on TRACING.
> > It's also possible that TRACEPOINTS should depend on TRACING.
> >
> 
> Hi Randy,
> 
> I tried to figure out in which way that should be done. By looking
> at "BLK_DEV_IO_TRACE" I got the impression that this should
> be done by adding "select GENERIC_TRACER".

Neither really.  The only way of tracing that should be used is the
TRACE_EVENT macros, which compile away to nothing if tracing is
disabled, so no dependency is needed at all.

