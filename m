Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 24F22101E062
	for <drbd-dev@lists.linbit.com>; Wed, 24 Sep 2014 23:50:48 +0200 (CEST)
Date: Wed, 24 Sep 2014 23:50:47 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: PaX Team <pageexec@freemail.hu>
Message-ID: <20140924215047.GI7118@soda.linbit>
References: <20140919094909.GA21578@schiffbauer.net>
	<5422E9F6.18603.4C8D74DA@pageexec.freemail.hu>
	<20140924163106.GH7118@soda.linbit>
	<5423084F.5168.4D040014@pageexec.freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5423084F.5168.4D040014@pageexec.freemail.hu>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd 8.4.3: refcounter overflow on re-sync
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Sep 24, 2014 at 08:07:11PM +0200, PaX Team wrote:
> > > perhaps it's a consequence of the reaction from the kernel on the overflow
> > > which is equivalent to a SIGKILL with all that it implies (files and network
> > > connections get closed, etc).
> > 
> > That would be the result of the _ASM_EXTABLE()?
> > or what causes that "reaction"?
> 
> no, the extable mechanism is only used to re-enter the kernel in a known
> way to be able to report back on the detected refcount overflow. the actual
> reaction is in pax_report_refcount_overflow

Which is registered in the corresponding place in the exception table.
So yes.

> (you'll need a grsec or PaX tree

I browsed some PaX patch instead.

> to see its body, it's not in the upstream kernel). it basically logs details
> about the overflow (registers, process info, etc) then forces a SIGKILL into
> the task.
> 
> you can see its output in the original report in this thread in fact, this
> is what enabled me to figure out which atomic variable was involved and start
> a discussion about this case (FYI, i've since turned both variables into the
> 'unchecked' type).
> 
> > As the process in question in *this* case is a drbd kernel thread, it
> > does not much care about that KILL. It notices, clears it, and lives on.
> 
> grsecurity handles kernel tasks too via gr_handle_kernel_exploit but for
> the refcount overflow detection we specifically chose to ignore them for
> two reasons. first, in the typical exploit scenario of these kinds of bugs
> it's a userland process in whose context the refcount overflow triggers.

Then I guess Marc is a very lucky guy...
Otherwise you had killed the whole box just because
it managed to sync the first TiB ;-)

> second, since this is an early detection (i.e., before any damage could
> have been done by an attack), the kernel state isn't corrupted yet and is
> thus recoverable, so it's not urgent to halt the system (which is otherwise
> necessary when unrecoverable state change occurs, think various forms of
> memory corruption, etc).
> 
> > But how would KILL'ing an innocent userland process improve the overall
> > situation?  Being a user land process, it cannot possibly be blamed for
> > an in-kernel counter overflow, so why even kill it?
> 
> notwithstanding the very few false positives that arise due to our 'secure
> by default' choice in handling atomic_t accessors (i actually blame the
> kernel's lack of a proper abstraction layer on top atomic_t ;), an exploit
> is anything but an innocent userland process and the proper way to handle
> it is to kill it and also ban the user account (all this is a configurable
> choice in grsecurity).

Carefully crafter exploits may be able to exploit PaX for a nice DoS,
provoking it to kill someone else instead, no?

I predicted earlier that this would not be a fruitful discussion.

Because where you come from, a dead system is better than "suspicious
behavior", and anyone that even only happens to be in the vicinity of
"suspicious behavior" will get shot as a precautionary measure --
"collateral damage, should not have been there in the first place,
really his own fault, what was he thinking" ;-)

(For arbitrary values^W^W empirically sampled values of suspicious)

And even though I sure can flex my mind, go those places,
think that way, I rather not.

Anyways, if it helps make the world a better place...
At least it's all just bits and entropy :)

Cheers,

	Lars

