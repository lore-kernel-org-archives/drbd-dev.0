Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 6E3FC1028A41
	for <drbd-dev@lists.linbit.com>; Wed, 24 Sep 2014 23:53:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 4A8632A18AB
	for <drbd-dev@lists.linbit.com>; Wed, 24 Sep 2014 23:53:28 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id pPtCePPVT_P6 for <drbd-dev@lists.linbit.com>;
	Wed, 24 Sep 2014 23:53:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 2DB423D60C2
	for <drbd-dev@lists.linbit.com>; Wed, 24 Sep 2014 23:53:28 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id o4UYjwwT84es for <drbd-dev@lists.linbit.com>;
	Wed, 24 Sep 2014 23:53:28 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id EA4302A18AB
	for <drbd-dev@lists.linbit.com>; Wed, 24 Sep 2014 23:53:27 +0200 (CEST)
Resent-Message-ID: <20140924215327.GK7118@soda.linbit>
Received: from r00tworld.com (r00tworld.com [212.85.137.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 70622101AC7F
	for <drbd-dev@lists.linbit.com>; Wed, 24 Sep 2014 20:08:04 +0200 (CEST)
From: "PaX Team" <pageexec@freemail.hu>
To: Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Wed, 24 Sep 2014 20:07:11 +0200
MIME-Version: 1.0
Message-ID: <5423084F.5168.4D040014@pageexec.freemail.hu>
In-reply-to: <20140924163106.GH7118@soda.linbit>
References: <20140919094909.GA21578@schiffbauer.net>,
	<5422E9F6.18603.4C8D74DA@pageexec.freemail.hu>,
	<20140924163106.GH7118@soda.linbit>
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Cc: drbd-dev@lists.linbit.com
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

On 24 Sep 2014 at 18:31, Lars Ellenberg wrote:

> On Wed, Sep 24, 2014 at 05:57:42PM +0200, PaX Team wrote:
> > so in short: this is not for debugging, this doesn't replace one bug
> > with another, but it does prevent real life exploitation of refcount
> > overflow bugs.
> 
> It won't make things "work".  It probably makes things crash in less
> obscure ways, though, I give you that.

not sure what you mean by making things 'work' but the goal of exploit
prevention is to prevent the exploitation of (even unknown) bugs, not to
find or fix them (of course these are (desirable) sideeffects once an
attacker is unfortunate enough to try his exploit on a protected system.
see more below about the reaction part.

> > perhaps it's a consequence of the reaction from the kernel on the overflow
> > which is equivalent to a SIGKILL with all that it implies (files and network
> > connections get closed, etc).
> 
> That would be the result of the _ASM_EXTABLE()?
> or what causes that "reaction"?

no, the extable mechanism is only used to re-enter the kernel in a known
way to be able to report back on the detected refcount overflow. the actual
reaction is in pax_report_refcount_overflow (you'll need a grsec or PaX tree
to see its body, it's not in the upstream kernel). it basically logs details
about the overflow (registers, process info, etc) then forces a SIGKILL into
the task.

you can see its output in the original report in this thread in fact, this
is what enabled me to figure out which atomic variable was involved and start
a discussion about this case (FYI, i've since turned both variables into the
'unchecked' type).

> As the process in question in *this* case is a drbd kernel thread, it
> does not much care about that KILL. It notices, clears it, and lives on.

grsecurity handles kernel tasks too via gr_handle_kernel_exploit but for
the refcount overflow detection we specifically chose to ignore them for
two reasons. first, in the typical exploit scenario of these kinds of bugs
it's a userland process in whose context the refcount overflow triggers.

second, since this is an early detection (i.e., before any damage could
have been done by an attack), the kernel state isn't corrupted yet and is
thus recoverable, so it's not urgent to halt the system (which is otherwise
necessary when unrecoverable state change occurs, think various forms of
memory corruption, etc).

> But how would KILL'ing an innocent userland process improve the overall
> situation?  Being a user land process, it cannot possibly be blamed for
> an in-kernel counter overflow, so why even kill it?

notwithstanding the very few false positives that arise due to our 'secure
by default' choice in handling atomic_t accessors (i actually blame the
kernel's lack of a proper abstraction layer on top atomic_t ;), an exploit
is anything but an innocent userland process and the proper way to handle
it is to kill it and also ban the user account (all this is a configurable
choice in grsecurity).

cheers,
  PaX Team

