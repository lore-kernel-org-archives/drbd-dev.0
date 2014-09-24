Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 73272101E062
	for <drbd-dev@lists.linbit.com>; Wed, 24 Sep 2014 23:53:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 65EBA2A18AB
	for <drbd-dev@lists.linbit.com>; Wed, 24 Sep 2014 23:53:21 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id qf_yK1ggH-xN for <drbd-dev@lists.linbit.com>;
	Wed, 24 Sep 2014 23:53:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 48B5E2AFA7B
	for <drbd-dev@lists.linbit.com>; Wed, 24 Sep 2014 23:53:21 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BzeWTLrvb-My for <drbd-dev@lists.linbit.com>;
	Wed, 24 Sep 2014 23:53:21 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 1A9582A18AB
	for <drbd-dev@lists.linbit.com>; Wed, 24 Sep 2014 23:53:21 +0200 (CEST)
Resent-Message-ID: <20140924215320.GJ7118@soda.linbit>
Received: from r00tworld.com (r00tworld.com [212.85.137.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 0FF521028A43
	for <drbd-dev@lists.linbit.com>; Wed, 24 Sep 2014 18:51:46 +0200 (CEST)
From: "PaX Team" <pageexec@freemail.hu>
To: drbd-dev@lists.linbit.com, Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Wed, 24 Sep 2014 17:57:42 +0200
MIME-Version: 1.0
Message-ID: <5422E9F6.18603.4C8D74DA@pageexec.freemail.hu>
In-reply-to: <20140924125022.GE7118@soda.linbit>
References: <20140919094909.GA21578@schiffbauer.net>,
	<20140924101451.GC7118@soda.linbit>,
	<20140924125022.GE7118@soda.linbit>
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
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

On 24 Sep 2014 at 14:50, Lars Ellenberg wrote:

> So what PAX really is doing is redefine "atomic_add" and similar to
> basically become a no-op, if it would overflow.

correct.

> typedef struct { int counter } atomic_t;
> void atomic_add(int i, atomic_t *v)
> {
> 	v->counter += i;
> 	if (that_caused_a_counter_wrap_in_any_direction) {
> 		/* oops, overflow */
> 		SCREAM("help me, overflow...");
> 		v->counter -= i;

first, to reduce the window of exploitation, the refcount operation
is undone *before* the reaction (which is more than just a log btw).
second, on many archs (pretty much all but x86) the operation isn't
even committed to memory (hence doesn't need to be undone).

> 	}
> }
> 
> If that *is* really an object refcount,
> and somewhere would be
> 	if (atomic_dec_and_test(that_count))
> 		free(some_object);
> then ok, you have replace one bug
> with an error message and different bug.
> Might help with debugging.  Not with much else. 

not correct ;). first of all, some stats based on 3.16.3 (not exact
counts, e.g., only a few archs are included as that's what i had in
my gtags database):

func          call-count
-----------------------------
           normal   unchecked
inc          2100     300
add           180      45
add_return     80      35
kref_get      380     n/a
long_inc       60      50
long_add       30      20

so the overwhelming majority of atomic_t users is refcounts in fact,
not stats and other exceptional cases where overflow is normal and
acceptable.

second, for the refcount case any code path which leaves the refcount
unbalanced tends to be an exploitable security bug since it directly
ends up in a use-after-free situation when the refcount wraps around
0 and back (or whatever the trigger value for freeing is, 0 is typical).

stopping the refcount halfway means that such bugs are not exploitable.
the price you pay is a memory leak but you already pay that without the
overflow protection *and* get a nice root hole at the same time. clearly
this is not a debugging aid but a very efficient runtime exploit prevention
measure. in fact in practice this protection triggers on actual attacks
only, the refcount leaking paths don't get executed nearly enough (we
had some false positives that were only detected after some 200 days of
uptime, unfortunately finding them by static analysis is a hard problem).

so in short: this is not for debugging, this doesn't replace one bug
with another, but it does prevent real life exploitation of refcount
overflow bugs.

> But really.
> Precautionary changing (x + y) to be silently identical to (x + 0),
> "just in case", will surely generally improve program flow...  D'oh.

'just in case' you didn't know, signed overflow is undefined behaviour
in C.

> Anyways, now that I know PAX is really just keeping that counter
> at a fixed value of INT_MAX in this case, and nothing else,
> what would have caused DRBD to disconnect/reconnect?

perhaps it's a consequence of the reaction from the kernel on the overflow
which is equivalent to a SIGKILL with all that it implies (files and network
connections get closed, etc).

cheers,
  PaX Team

