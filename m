Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (dialin-145-254-052-037.arcor-ip.net
	[145.254.52.37])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id B6657142FF
	for <drbd-dev@lists.linbit.com>; Wed, 29 Sep 2004 19:10:26 +0200 (CEST)
Date: Wed, 29 Sep 2004 19:07:42 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RFC] (CRM and) DRBD (0.8) states and transistions,
	recovery strategies
Message-ID: <gp+4keo9JvnjO0Q6qwMw9f0=lge@web.de>
References: <yZEXPsg2gvkm1jq9tjYKNcg=lge@web.de>
	<200409271652.10284.philipp.reisner@linbit.com>
	<200409291458.47753.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409291458.47753.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-09-29 14:58:47 +0200
\ Philipp Reisner:
> > [...]
> > >     Currently this covers only the states, and outlines the transitions.
> > > It should help to define the actions to be taken on every possible
> > > "input" to the DRBD internal "state machine".
> >
> > While reading through this giant e-mail I lost my confidence that it
> > could be a good idea to have a "central" state switching function in
> > DRBD, but of course I will see what this discussions gives...
> 
> Thought about this a bit more... and came to the conclusion that it 
> would be a good idea. What do you think of this skeleton -
> pseude code (it compiles actually).

I think it probably should come out more like a real state machine,
with a defined set of possible INPUTS,
a defined set of states (which should not have the same detail depth as
the actual drbd internal state set with all its different attributes),
a set of actions, and a defined state[INPUT] => action => newstate
matrix.

maybe that is overkill.
it may as well be that this turns out to be the easier and cleaner way.
I'm not yet sure. the back of my head is still busy and did not give me
a "completion event" on it yet ...

	lge
