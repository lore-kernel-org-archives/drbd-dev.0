Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 1C6212CE6E48
	for <drbd-dev@lists.linbit.com>; Thu,  3 Aug 2006 10:20:36 +0200 (CEST)
Date: Thu, 3 Aug 2006 10:20:33 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20060803082033.GF4643@soda.linbit>
References: <mailman.93.1154590245.4693.drbd-dev@lists.linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mailman.93.1154590245.4693.drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Re: reboot notifier
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> From: Milind Dumbare <milind@linsyssoft.com>
> To: drbd-dev@lists.linbit.com
> Date: Thu, 03 Aug 2006 13:03:33 +0530
> Message-Id: <1154590413.2335.14.camel@shadowfox.linsyssoft.com>
> X-Mailer: Evolution 2.6.0 (2.6.0-1) 
> 
> Hi all,
> 	"drbd_cleanup" function can be called from "drbd_notify_sys" in default
> reboot case, for the sake of flow structuring. 
> 	Cleanup will be done when rebooting.
> 
> + 	switch(code) {
> +       case SYS_RESTART:
> +       default:
> +               drbd_cleanup();
> +	break
> +	}

yes of course it could.
what do we gain?

if it is an orderly shutdown, the init scripts would have down'ed drbd
already, so this notifier would never be called, because it is no longer
there. if the shutdown is not so orderly: we cannot "just call drbd_cleanup",
since we may still be primary, or connected or both or...

I probably just don't get your point?

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
