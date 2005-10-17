Return-Path: <Lars.Ellenberg@linbit.com>
Received: from barkeeper1 (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id D7F0F1431D
	for <drbd-dev@lists.linbit.com>; Mon, 17 Oct 2005 16:15:43 +0200 (CEST)
Date: Mon, 17 Oct 2005 16:15:43 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [DRBD-cvs] svn commit by phil - r1985 -
	branches/drbd-0.7/drbd - Fixed a self made SMP lockup;
	showing up in drbd_al_com
Message-ID: <20051017141543.GB32693@barkeeper1.linbit>
References: <20051017134012.CB1741431D@mail.linbit.com>
	<20051017134349.GT8354@marowsky-bree.de>
	<20051017135618.GA32693@barkeeper1.linbit>
	<20051017135748.GU8354@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051017135748.GU8354@marowsky-bree.de>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2005-10-17 15:57:49 +0200
\ Lars Marowsky-Bree:
> On 2005-10-17T15:56:18, Lars Ellenberg <Lars.Ellenberg@linbit.com> wrote:
> 
> > it will be hit. rating is CRITICAL (for smp).
> > 
> > there will be a 0.7.14 today, latest tomorrow, including this fix,
> > and the fix for not notifying the peer about "io-error on read".
> 
> Great, thank you. I'll pull that into SLES9 then.

besser is das.

it is a race, and it will only trigger if you have seriously high
application io load during drbd resync on a Primary/SyncSource.

But yes, SLES9 SMP systems probably will match that description most of
the time, and if you then reconnect the secondary after some downtime ...

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-0  :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
