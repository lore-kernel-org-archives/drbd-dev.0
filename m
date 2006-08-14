Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 1DEB22CE7575
	for <drbd-dev@lists.linbit.com>; Mon, 14 Aug 2006 18:35:34 +0200 (CEST)
Date: Mon, 14 Aug 2006 18:35:36 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd 0.7 with recent kernels?
Message-ID: <20060814163536.GF7226@soda.linbit>
References: <20060814131554.GC15779@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060814131554.GC15779@marowsky-bree.de>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-08-14 15:15:54 +0200
\ Lars Marowsky-Bree:
> Hi,
> 
> did anyone already rip out the devfs support from drbd 0.7 to make it
> compile with the latest kernels from upstream again, so I can avoid
> doing it myself? ;-)

"latest kernels" ...
well, we still compile against 2.6.17 as is.

I'm happy to rip it out in trunk completely.

but since we support even 2.4 kernels in drbd 0.7,
there you probably have to do it yourself, in case it is neccessary.
maybe you could just ifdef some empty defines in drbd_compat*.h ?

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
