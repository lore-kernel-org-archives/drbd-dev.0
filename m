Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RFC] Handling of internal split-brain in multiple
	state resources
Date: Mon, 20 Sep 2004 17:09:36 +0200
References: <20040910185553.GU7359@marowsky-bree.de>
In-Reply-To: <20040910185553.GU7359@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200409201709.36849.philipp.reisner@linbit.com>
Cc: linux-ha-dev@lists.linux-ha.org
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

[ I am not subscribed to linux-ha-dev ]

Hi Lars,

[...]
> If we notice that N1 is crashed first, that's fine. Everything will
> happen just as always, and N2 can proceed as soon as it sees the
> post-fence/stop notification, which it will see before being promoted to
> master or even being asked about it.
>
> But, from the point of view of the replicated resource on N2, this is
> indistinguishable from the split-brain; all it knows is that it lost
> connection to it's peer. So it goes on to report this.
>
> If this event occurs before we have noticed a monitoring failure or full
> node failure on N1 and were using the recovery method explained so far,
> we are going to assume an internal split-brain, and tell N2 to mark
> itself outdated, and then try to tell N1 to resume.  Oops. No more
> talky-talky to N1, and we just told N2 it's supposed to refuse to become
> master.

So the algorithm in HB/CRM seems to be:

If I see that resource (drbd) got disconnected from its peer. then {
 If the resource is a replica (secondary) then {
  tell it that it should mark itself as "desync". 
 } else /* Resource is master (primary) */ {
  Wait for the post fence event and thaw the resource.
 }
}

> So, this requires special logic - whenever one incarnation reports an
> internal split-brain, we actively need to go and verify the status of
> the other incarnations first.
>
> In which case we'd notice that, ah, N1 is down or experiencing a local
> resource failure, and instead of outdating N2, would fence / stop N1 and
> then promote N2.
>
> This is the special logic I don't much like. As Rusty put it in his
> keynote, "Fear of complexity" is good for programmers. And this reeks of
> it - extending the monitor semantics, needing an additional command on
> the secondary, _and_ needing to talk to all incarnations and then
> figuring out what to do. (I don't want to think much about partitions
> with >2 resources involved.) Alas, the problem seems to be real.
>

What is about:

If I see that resource (drbd) got disconnected from its peer. then {
 If the resource is a replica (secondary) then {
  /* do nothing */
 } else /* Resource is master (primary) */ {
  Ask the other node to do the fencing.
 }
}

If I see a fence ack then {
 Thaw the resource.
}

There is no special case in there...

> Here's some other alternatives I've thought about which seem simpler,
> but which I then noticed don't solve the problem completely.
>
>
> A) Rely on the internal split-brain timeout being larger than our
> deadtime of N1 and the resource monitoring interval.
>
> This _seems_ to solve it - because then the problematic ordering does
> not occur, but relies quite a bit on timing. And if the resource on N2
> notices, for example, a connection loss immediately, this basically
> can't be made to work. Oh yeah, it can be worked around by adding delays
> etc, but that smells a bit dung-ish, too.
>

Right, ... 
Currently drbd's timeout needs to be smaller than heartbeat's deadtime,
making this the other way round asks for troubles I think...

[...]

BTW, from the text I realized that hearbeat will monitor the resource (drbd).
Probabely with calling the resource script with a new method. Basically
hearbeat polls DRBD for an change in the connection state.

Would you like to have an active notification from DRBD ? 

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
