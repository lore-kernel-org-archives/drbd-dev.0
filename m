Return-Path: <lars.ellenberg@linbit.com>
Received: from racke.linbit (dslb-088-075-197-174.pools.arcor-ip.net
	[88.75.197.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 6CB332E05451
	for <drbd-dev@lists.linbit.com>; Sat, 16 Aug 2008 17:27:10 +0200 (CEST)
Date: Sat, 16 Aug 2008 17:27:09 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] too small timeout in drbdsetup
Message-ID: <20080816152709.GB11083@racke>
References: <1218700653.5281.26.camel@jaguar.home.zzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1218700653.5281.26.camel@jaguar.home.zzz>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Aug 14, 2008 at 09:57:33AM +0200, Jerome Martin wrote:
> Philip, Lars, please consider this request seriously and give it some
> thinking. I really think this is an issue that needs to be addressed
> because :

[a few valid points]

> I know you might feel I am over-emphasing this tiny little detail, but

absolutely not.

I had always just used a "stat" on /proc/drbd there,
and that is what we will do from now on.

-- 
: Lars Ellenberg                
: LINBIT HA-Solutions GmbH
: DRBD®/HA support and consulting    http://www.linbit.com

DRBD® and LINBIT® are registered trademarks
of LINBIT Information Technologies GmbH
__
please don't Cc me, but send to list   --   I'm subscribed
