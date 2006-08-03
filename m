Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id E15382CE6E4E
	for <drbd-dev@lists.linbit.com>; Thu,  3 Aug 2006 12:33:12 +0200 (CEST)
Date: Thu, 3 Aug 2006 12:33:14 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: reboot notifier
Message-ID: <20060803103314.GG4643@soda.linbit>
References: <mailman.93.1154590245.4693.drbd-dev@lists.linbit.com>
	<20060803082033.GF4643@soda.linbit>
	<1154593867.2335.20.camel@shadowfox.linsyssoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154593867.2335.20.camel@shadowfox.linsyssoft.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-08-03 14:01:07 +0530
\ Milind Dumbare:
> 	My point was code structuring. As this is the way reboot notifiers are
> written. But for doing interesting things in notify functions, it will
> be nice to have switch cases structured, rather than writing function
> which is doing nothing.

great. having switch statements which do the wrong thing is good,
because the code is more nicely structured. wow.
don't get me wrong. I put that function there, so once we know something
"interessting" that we want/need to do on reboot, I don't need to
remember how to implement those notifiers.

but before we put some functional code in there, maybe we should first
figure out what those "interesting things" are, that we want/need to do
on notification.

I'm open for suggestions.
however, just calling drbd_cleanup there unconditionally is not useful.

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
