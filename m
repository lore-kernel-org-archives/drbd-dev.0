Return-Path: <Lars.Ellenberg@linbit.com>
Date: Mon, 20 Sep 2004 17:36:15 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com, linux-ha-dev@lists.linux-ha.org
Subject: Re: [Drbd-dev] [RFC] Handling of internal split-brain in multiple
	state resources
Message-ID: <o3a8Ik5FnfB+NCJpV+pXpZY=lge@web.de>
References: <20040910185553.GU7359@marowsky-bree.de>
	<200409201709.36849.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409201709.36849.philipp.reisner@linbit.com>
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-09-20 17:09:36 +0200
\ Philipp Reisner:
> [ I am not subscribed to linux-ha-dev ]
> 
> Hi Lars,
> 
> [...]
> > If we notice that N1 is crashed first, that's fine. Everything will
> > happen just as always, and N2 can proceed as soon as it sees the
> > post-fence/stop notification, which it will see before being promoted to
> > master or even being asked about it.
> >
> > But, from the point of view of the replicated resource on N2, this is
> > indistinguishable from the split-brain; all it knows is that it lost
> > connection to it's peer. So it goes on to report this.
> >
> > If this event occurs before we have noticed a monitoring failure or full
> > node failure on N1 and were using the recovery method explained so far,
> > we are going to assume an internal split-brain, and tell N2 to mark
> > itself outdated, and then try to tell N1 to resume.  Oops. No more
> > talky-talky to N1, and we just told N2 it's supposed to refuse to become
> > master.
> 
> So the algorithm in HB/CRM seems to be:
> 
> If I see that resource (drbd) got disconnected from its peer. then {
>  If the resource is a replica (secondary) then {
>   tell it that it should mark itself as "desync". 
>  } else /* Resource is master (primary) */ {
>   Wait for the post fence event and thaw the resource.
>  }
> }
> 
> > So, this requires special logic - whenever one incarnation reports an
> > internal split-brain, we actively need to go and verify the status of
> > the other incarnations first.
> >
> > In which case we'd notice that, ah, N1 is down or experiencing a local
> > resource failure, and instead of outdating N2, would fence / stop N1 and
> > then promote N2.
> >
> > This is the special logic I don't much like. As Rusty put it in his
> > keynote, "Fear of complexity" is good for programmers. And this reeks of
> > it - extending the monitor semantics, needing an additional command on
> > the secondary, _and_ needing to talk to all incarnations and then
> > figuring out what to do. (I don't want to think much about partitions
> > with >2 resources involved.) Alas, the problem seems to be real.
> >
> 
> What is about:
> 
> If I see that resource (drbd) got disconnected from its peer. then {
>  If the resource is a replica (secondary) then {
>   /* do nothing */
>  } else /* Resource is master (primary) */ {
>   Ask the other node to do the fencing.
>  }
> }
> 
> If I see a fence ack then {
>  Thaw the resource.
> }
> 
> There is no special case in there...

and that is about what I meant when discussing with lmb...
I answer how this works out in an other followup on the original post.

> BTW, from the text I realized that hearbeat will monitor the resource (drbd).
> Probabely with calling the resource script with a new method. Basically
> hearbeat polls DRBD for an change in the connection state.
> 
> Would you like to have an active notification from DRBD ? 

now, I'd like to make active drbd event notification possible.
I see basically two ways to do so:
 a)
  provide a special read-only file like /proc/drbd/event or so, allow
  exactly one opener, and allow that to select on it.
  define some simple, say line-based, notification messages.

  one needs to write a daemon to dispatch on those.

 b)
  make some hooks within the drbd code itself, and upon certain
  events do an fork/execle with special arguments from the worker
  thread.

  one needs to provide some external script(s)/executable(s) that
  act appropriate on those events.

 and there is, of course,
 c)
  combination of both 
 
from the CRM point of view, this is about how the
replicated/multistate/multipeer resource can help
in monitoring itself. it is an optimisation and probably not a
substitute for regular monitoring polls.

	Lars Ellenberg
