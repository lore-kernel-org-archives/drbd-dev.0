Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 033BD1430D
	for <drbd-dev@lists.linbit.com>; Wed, 25 Aug 2004 13:30:18 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: drbd Frage zu secondary vs primary;
	drbddisk status problem
Date: Wed, 25 Aug 2004 13:30:17 +0200
References: <20040819110202.GO9601@marowsky-bree.de>
	<200408251142.18807.philipp.reisner@linbit.com>
	<20040825102852.GS3125@marowsky-bree.de>
In-Reply-To: <20040825102852.GS3125@marowsky-bree.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200408251330.17324.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wednesday 25 August 2004 12:28, Lars Marowsky-Bree wrote:
> On 2004-08-25T11:42:18,
>
>    Philipp Reisner <philipp.reisner@linbit.com> said:
> > So, the current policy is:
> >  * The primary node refuses to connect to a peer with higher generation
> >    counts. This keeps the data intact. This is very related to the other
> >    after-split-brain-policy I want to make expclicit.
>
> Makes sense.
>
> > * Remeber the options so far: (for primary-after-split-brain)
> >
> >  - The node that was primary before split brain (current behaviour)
> >  - The node that became primary during split brain
> >  - The node that modified more of it's data during the split-brain
> >    situation  [ Do not think about implementation yet, just about
> >                 the policy ]
> >  - None, wait for operator's decission.  [suggested by LMB]
> >  - Node that is currently primary [see example above by LGE]
>
> Minor clarification: I think the question is not about "Who becomes
> primary", as the Sync* is decoupled from that status, but which side
> drbd deems to have the good data and thus the SyncMaster.
>

Right. It is really a shame that I have not yet fully realized
that drbd-7 is the current stable release :)

> Looking at it from this angle, we have two dimensions:
>
> - Node state after the split-brain heals. Each side can either be
>   primary or secondary.
>
> - The data state on each side.
>
[...]

I will post a new version of the "Summary" mail...

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
