Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 2637C1432B
	for <drbd-dev@lists.linbit.com>; Mon, 11 Oct 2004 14:40:07 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] How Locking in GFS works...
Date: Mon, 11 Oct 2004 14:41:00 +0200
References: <200410041456.21841.philipp.reisner@linbit.com>
	<b3ps7nO6Oe58Cm5jpp38mxU=lge@web.de>
	<200410111428.49231.philipp.reisner@linbit.com>
In-Reply-To: <200410111428.49231.philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200410111441.00278.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


> > not sure yet ...
> >
> > especially what exactly should happen in failure cases.
> > need to think about it some more.
>
> Right, I thought about that too, and came to the conclusion,
> that everything is covered by the AL nicely.
>

Ahhh... I think I know what you mean ... Hmmm...

-Philipp

-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
