Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 0779414328
	for <drbd-dev@lists.linbit.com>; Tue, 19 Oct 2004 12:38:57 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [DRBD-cvs] r1600 - branches/drbd-0.7/drbd
Date: Tue, 19 Oct 2004 12:40:10 +0200
References: <20041019091152.50E053BE6D@garcon.linbit.com>
	<200410191130.24197.philipp.reisner@linbit.com>
	<HcoFP6pnb8MI006txV+wpU0=lge@web.de>
In-Reply-To: <HcoFP6pnb8MI006txV+wpU0=lge@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200410191240.10467.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

[...]
> > Do you really think it is an good idea to put that tcp-stack pushing
> > into drbd-0.7 ??
[...]
> it is #if 0'ed in drbd 0.7
> I think we should #if 1 it in trunk,
> benchmark it, and drop it if it does not do any good.
>

Ok, I did not saw the #if 0 in drbd0.7

What's about posting it to the user list, maybe there is 
someone out there who wants to benchmark it...

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
