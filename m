Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 54AA414301
	for <drbd-dev@lists.linbit.com>; Mon,  4 Oct 2004 16:16:42 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] How Locking in GFS works...
Date: Mon, 4 Oct 2004 16:17:21 +0200
References: <200410041456.21841.philipp.reisner@linbit.com>
	<20041004134912.GY1542@marowsky-bree.de>
	<200410041609.23272.philipp.reisner@linbit.com>
In-Reply-To: <200410041609.23272.philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200410041617.21258.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Monday 04 October 2004 16:09, Philipp Reisner wrote:
> On Monday 04 October 2004 15:49, Lars Marowsky-Bree wrote:
> > On 2004-10-04T15:26:15, Philipp Reisner <philipp.reisner@linbit.com> 
wrote:
> > > If everything works (esp. the locking of the shared disk fs) no.
> > >
> > > But just consider that the locking of the shared disk FS on
> > > top of us is broken, and that it issues a write request to
> > > the same block number on both nodes.
> > >
> > > Then each node would write its copy first and the peers
> > > version of the data at second to that block number.
> > >
> > > => We would have different data in this block on our
> > >    two copies. - And we would event know about it!
> >
> > You would know the moment the replicated write from the remote end came
> > in, no?
> >
> > "Oh my, this is dirty locally too and unacked. We better arbitate now;
> > ie one side wins and the other one is silently discarded."
>
> This is what I like about mailinglists. This is a new idea, that
> certainly needs to be considered.
>
> Hmm, I just tooks a sheet of paper and drew a view diagrams of it.
>
> It works as long as writing the block takes longer than transmitting
> the block.
>
> The scheme simply fails if transmitting takes longer than writing.
>

No. It works... I will write a text describing it.

-Philipp

-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
