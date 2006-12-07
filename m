Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (unknown [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id E88312D9DC71
	for <drbd-dev@lists.linbit.com>; Thu,  7 Dec 2006 14:09:19 +0100 (CET)
Date: Thu, 7 Dec 2006 14:09:20 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] lock for reading device state
Message-ID: <20061207130920.GD7521@soda.linbit>
References: <4576FC63.704@dcs.gla.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4576FC63.704@dcs.gla.ac.uk>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-12-06 17:22:43 +0000
\ Cristian Zamfir:
> 
> 
> Hi,
> 
> I am using drbd to implement xen block device migration.  Right now I
> am parsing /proc/drbd to find out if the drives are synchronized and I
> can migrate them.

you talk about drbd state "Connected, Consistent",
or what exactly are you parsing?

> Is there a way to obtain a lock while reading and processing this
> information and prevent other writes to the primary device?

no. why?

> I need to be able to prevent writes while reading the state of
> the device from a script external to drbd.

does not make sense to me yet?

> In case there is no existing solution, can you please give me a few
> tips on how to start developing such a locking mechanism?

please give more details about your assumptions and reasoning,
maybe its just that you have wrong expectations?

could also be that I'm just mentally block right now...

	:)

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
