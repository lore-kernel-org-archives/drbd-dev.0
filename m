Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9207F101E067
	for <drbd-dev@lists.linbit.com>; Wed, 24 Sep 2014 18:31:07 +0200 (CEST)
Date: Wed, 24 Sep 2014 18:31:06 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: PaX Team <pageexec@freemail.hu>
Message-ID: <20140924163106.GH7118@soda.linbit>
References: <20140919094909.GA21578@schiffbauer.net>
	<20140924101451.GC7118@soda.linbit>
	<20140924125022.GE7118@soda.linbit>
	<5422E9F6.18603.4C8D74DA@pageexec.freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5422E9F6.18603.4C8D74DA@pageexec.freemail.hu>
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

On Wed, Sep 24, 2014 at 05:57:42PM +0200, PaX Team wrote:
> On 24 Sep 2014 at 14:50, Lars Ellenberg wrote:
> 
> > So what PAX really is doing is redefine "atomic_add" and similar to
> > basically become a no-op, if it would overflow.
> 
> correct.

> > Might help with debugging.  Not with much else. 
> 
> not correct ;)

> so in short: this is not for debugging, this doesn't replace one bug
> with another, but it does prevent real life exploitation of refcount
> overflow bugs.

It won't make things "work".  It probably makes things crash in less
obscure ways, though, I give you that.

> > Anyways, now that I know PAX is really just keeping that counter
> > at a fixed value of INT_MAX in this case, and nothing else,
> > what would have caused DRBD to disconnect/reconnect?
> 
> perhaps it's a consequence of the reaction from the kernel on the overflow
> which is equivalent to a SIGKILL with all that it implies (files and network
> connections get closed, etc).

That would be the result of the _ASM_EXTABLE()?
or what causes that "reaction"?

As the process in question in *this* case is a drbd kernel thread, it
does not much care about that KILL. It notices, clears it, and lives on.

But how would KILL'ing an innocent userland process improve the overall
situation?  Being a user land process, it cannot possibly be blamed for
an in-kernel counter overflow, so why even kill it?

	Lars
