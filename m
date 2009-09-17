Return-Path: <lmb@suse.de>
Received: from mx.in-addr.de (gate.in-addr.de [212.8.193.158])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D7A1E10623A3
	for <drbd-dev@lists.linbit.com>; Thu, 17 Sep 2009 10:50:32 +0200 (CEST)
Date: Thu, 17 Sep 2009 10:50:03 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Christoph Hellwig <hch@infradead.org>,
	Philipp Reisner <philipp.reisner@linbit.com>
Message-ID: <20090917085003.GR13069@suse.de>
References: <200909151645.14256.philipp.reisner@linbit.com>
	<20090915231931.GB7636@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20090915231931.GB7636@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [GIT PULL] DRBD for 2.6.32
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2009-09-15T19:19:31, Christoph Hellwig <hch@infradead.org> wrote:

Hi Christoph,

> > It has been discussed and reviewed on the list since March,
> > and Andrew has asked us to send a pull request for 2.6.32-rc1.
> 
> The last thing we need is another bloody raid-reimplementation, coupled
> with a propritary on the wire protocol.  NACK as far as I am concerned.

You know that several RAID implementations are my primary pet peeve, and
I would just love to agree with you here. However, reality isn't that
black-xor-white.

In reality, a significant number of deployments using this
implementation exist already. There is no alternative for them yet, much
less one which would allow them an online migration.  There might be one
day, if dm-replicator takes off, and the RAID engines between
md/dm/btrfs/drbd/dm-replicator etc get unified, but as it stands today,
this doesn't exist.

drbd is stable, the code has been significantly cleaned up during the
LKML dialogue so far. It is very well maintained and supported.

As a mid- to long-term goal, the unification should be pursued, and I
know that Lars Ellenberg _is_ talking with Heinz about dm-replicator and
that Neil/Heinz/Alasdair are also occasionally talking with each other.

Until this has happened though, the plurality of solutions exist.

drbd meets the technical/code quality requirements for merging; the
argument that we should only have one RAID implementation is valid, but
"should" is overruled by the normative power of facts.

Putting the burden of converging our RAID implementations on drbd is a bit
too much; this argument would have made sense when dm-raid* was merged,
but today, we're already carrying several.

Similarly, we support FCoE, AoE, iSCSI, nbd, and if someone proposed
iSCSI-over-USB, I'm sure we would merge even that abdomination. (I hope
I didn't give anyone ideas!) We also have several file systems.


Regards,
    Lars

-- 
Architect Storage/HA, OPS Engineering, Novell, Inc.
SUSE LINUX Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde

