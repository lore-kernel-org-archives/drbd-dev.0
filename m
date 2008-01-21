Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 086932DEAC70
	for <drbd-dev@lists.linbit.com>; Mon, 21 Jan 2008 17:36:38 +0100 (CET)
Date: Mon, 21 Jan 2008 17:36:38 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Barrier assert failures with latest 8.0 sources
Message-ID: <20080121163638.GC7594@barkeeper1.linbit>
References: <342BAC0A5467384983B586A6B0B3767107E89B46@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B3767107E89B46@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sat, Jan 19, 2008 at 11:40:35AM -0500, Graham, Simon wrote:
> > I'm attempting to run with the latest 8.0 sources from Git (plus a
> > couple of patches - basically the ones I have submitted that have not
> > yet been applied) and am seeing a lot of assert failures in the
> barrier
> > code since the latest change to send barriers as early as possible. A
> > representative trace for a device is attached - you will see that the
> > device gets connected then pauses resync (not sure if this is really
> > relevant) and then we start streaming the assert failures --
> apparently
> > we are off by one barrier from this point on...
> 
> Hmm.. maybe not as hard to diagnose as I thought -- when the drbd
> connection is lost, we end up calling tl_clear which clears out the
> transfer list _but_ leaves a single barrier in the list with number 4711
> and req-cnt 0 (so oldest_barrier and newest_barrier both point to this
> pseudo-barrier entry). 
> 
> When we reconnect and start processing requests again, when the first
> barrier is needed, it will be number 4712 and will get added to the list
> and the BarrierRq will be sent with this number. When the BarrierAck is
> received, oldest_barrier is still 4711 though, leading to the assert
> failure...
> 
> I'm not sure why tl_clear leaves this pseudo-barrier in the list...
> shouldn't it simply leave the list completely empty just like tl_init
> does?

probably.
we have seen these ASSERTS, too, btw, also without this latest change in
the barrier code, so aparently it has been there all along.
unfortunately we are all sort of distracted right now.
but coding will resume shortly :)

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
