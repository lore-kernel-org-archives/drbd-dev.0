Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 01BC11028A41
	for <drbd-dev@lists.linbit.com>; Thu, 25 Sep 2014 01:41:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id EBCDE2A23D6
	for <drbd-dev@lists.linbit.com>; Thu, 25 Sep 2014 01:41:20 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id X5W11JF2qvE3 for <drbd-dev@lists.linbit.com>;
	Thu, 25 Sep 2014 01:41:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id D14412A247C
	for <drbd-dev@lists.linbit.com>; Thu, 25 Sep 2014 01:41:20 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LG0i9O_0kWlB for <drbd-dev@lists.linbit.com>;
	Thu, 25 Sep 2014 01:41:20 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id A623F2A23D6
	for <drbd-dev@lists.linbit.com>; Thu, 25 Sep 2014 01:41:20 +0200 (CEST)
Resent-Message-ID: <20140924234120.GA20814@soda.linbit>
Received: from r00tworld.com (r00tworld.com [212.85.137.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C3F901028A41
	for <drbd-dev@lists.linbit.com>; Thu, 25 Sep 2014 01:25:30 +0200 (CEST)
From: "PaX Team" <pageexec@freemail.hu>
To: Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Thu, 25 Sep 2014 01:25:04 +0200
MIME-Version: 1.0
Message-ID: <542352D0.5354.4E270879@pageexec.freemail.hu>
In-reply-to: <20140924215047.GI7118@soda.linbit>
References: <20140919094909.GA21578@schiffbauer.net>,
	<5423084F.5168.4D040014@pageexec.freemail.hu>,
	<20140924215047.GI7118@soda.linbit>
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Cc: spender@grsecurity.net, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd 8.4.3: refcounter overflow on re-sync
Reply-To: pageexec@freemail.hu
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

On 24 Sep 2014 at 23:50, Lars Ellenberg wrote:

> On Wed, Sep 24, 2014 at 08:07:11PM +0200, PaX Team wrote:
> > > > perhaps it's a consequence of the reaction from the kernel on the overflow
> > > > which is equivalent to a SIGKILL with all that it implies (files and network
> > > > connections get closed, etc).
> > > 
> > > That would be the result of the _ASM_EXTABLE()?
> > > or what causes that "reaction"?
> > 
> > no, the extable mechanism is only used to re-enter the kernel in a known
> > way to be able to report back on the detected refcount overflow. the actual
> > reaction is in pax_report_refcount_overflow
> 
> Which is registered in the corresponding place in the exception table.
> So yes.

no, what is registered in the exception table is the address of the continuation
address after the arch-specific insn that triggers on the overflow. then the arch
specific trap handler will call pax_report_refcount_overflow which does the actual
reaction. the reason i didn't just do a direct call to pax_report_refcount_overflow
from within atomic ops is that it'd bloat the code a lot more and would also make
it harder to report the register context, etc in an arch independent way. so no,
once again the extable mechanism is not an inherently needed mechanism for reaction,
it's an implementation choice only.

> > grsecurity handles kernel tasks too via gr_handle_kernel_exploit but for
> > the refcount overflow detection we specifically chose to ignore them for
> > two reasons. first, in the typical exploit scenario of these kinds of bugs
> > it's a userland process in whose context the refcount overflow triggers.
> 
> Then I guess Marc is a very lucky guy...
> Otherwise you had killed the whole box just because
> it managed to sync the first TiB ;-)

yes, that's the nature of both false positives and real life exploits as well.
it's called taking a risk and the world out there in general believes that an
owned box is a much worse case than a halted one.

> > notwithstanding the very few false positives that arise due to our 'secure
> > by default' choice in handling atomic_t accessors (i actually blame the
> > kernel's lack of a proper abstraction layer on top atomic_t ;), an exploit
> > is anything but an innocent userland process and the proper way to handle
> > it is to kill it and also ban the user account (all this is a configurable
> > choice in grsecurity).
> 
> Carefully crafted exploits may be able to exploit PaX for a nice DoS,
> provoking it to kill someone else instead, no?

given a refcount overflow bug they can already do that (remember they cause
a use-after-free bug which isn't hard to exploit for arbitrary code execution
or just trashing kernel memory in practical cases), so what's the issue? same
holds for any other kind of exploitation method that we catch, an attacker
already starts with some kind of arbitrary code execution (and privilege escalation)
capability on unprotected boxes, we improve (=downgrade) that in certain cases
to DoS. nobody has any better ways to handle this.

> I predicted earlier that this would not be a fruitful discussion.
> 
> Because where you come from, a dead system is better than "suspicious
> behavior", and anyone that even only happens to be in the vicinity of
> "suspicious behavior" will get shot as a precautionary measure --
> "collateral damage, should not have been there in the first place,
> really his own fault, what was he thinking" ;-)
> 
> (For arbitrary values^W^W empirically sampled values of suspicious)

you're conflating the general concept of reaction to exploits with very rare
cases of false positives in certain prevention techniques. the latter occur
for refcount overflow prevention only because the kernel hasn't provided an
API to separate out refcount uses from other cases where overflow is benign.

this is not my fault and we did our best to uncover these cases but manual and
static analysis can only go so far. there're also exploit prevention methods
that produce no false positives (e.g., preventing the kernel from executing
code from userland).

> And even though I sure can flex my mind, go those places,
> think that way, I rather not.
> 
> Anyways, if it helps make the world a better place...
> At least it's all just bits and entropy :)

every major operating system vendor and cpu manufacturer have adopted protection
techniques that were pioneered by us, i think that speaks more than a lone doubting
Thomas on the drbd list ;).

cheers,
  PaX Team

