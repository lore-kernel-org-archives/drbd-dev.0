Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 15C1B1432B
	for <drbd-dev@lists.linbit.com>; Mon, 11 Oct 2004 14:27:56 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] How Locking in GFS works...
Date: Mon, 11 Oct 2004 14:28:49 +0200
References: <200410041456.21841.philipp.reisner@linbit.com>
	<200410110912.02760.philipp.reisner@linbit.com>
	<b3ps7nO6Oe58Cm5jpp38mxU=lge@web.de>
In-Reply-To: <b3ps7nO6Oe58Cm5jpp38mxU=lge@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200410111428.49231.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Monday 11 October 2004 12:11, Lars Ellenberg wrote:
> / 2004-10-11 09:12:02 +0200
>
> \ Philipp Reisner:
> > > but, yes, I will have a look at the arbitration logic, too.
> >
> > Hi Lars,
> >
> > Did you find any loose ends in my description of the
> > arbitration logic ? -- If we do not find any loose ends
> > I vote goes for it.
>
> not sure yet ...
>
> especially what exactly should happen in failure cases.
> need to think about it some more.
>

Right, I thought about that too, and came to the conclusion,
that everything is covered by the AL nicely.

-philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
