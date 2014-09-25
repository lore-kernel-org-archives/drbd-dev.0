Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C7F43101E048
	for <drbd-dev@lists.linbit.com>; Thu, 25 Sep 2014 02:07:48 +0200 (CEST)
Date: Thu, 25 Sep 2014 02:07:48 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: PaX Team <pageexec@freemail.hu>
Message-ID: <20140925000748.GB20814@soda.linbit>
References: <20140919094909.GA21578@schiffbauer.net>
	<5423084F.5168.4D040014@pageexec.freemail.hu>
	<20140924215047.GI7118@soda.linbit>
	<542352D0.5354.4E270879@pageexec.freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <542352D0.5354.4E270879@pageexec.freemail.hu>
Cc: spender@grsecurity.net, drbd-dev@lists.linbit.com
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

On Thu, Sep 25, 2014 at 01:25:04AM +0200, PaX Team wrote:
> On 24 Sep 2014 at 23:50, Lars Ellenberg wrote:
> 
> > On Wed, Sep 24, 2014 at 08:07:11PM +0200, PaX Team wrote:
> > > > > perhaps it's a consequence of the reaction from the kernel on the overflow
> > > > > which is equivalent to a SIGKILL with all that it implies (files and network
> > > > > connections get closed, etc).
> > > > 
> > > > That would be the result of the _ASM_EXTABLE()?
> > > > or what causes that "reaction"?
> > > 
> > > no, the extable mechanism is only used to re-enter the kernel in a known
> > > way to be able to report back on the detected refcount overflow. the actual
> > > reaction is in pax_report_refcount_overflow
> > 
> > Which is registered in the corresponding place in the exception table.
> > So yes.
> 
> no, what is registered in the exception table is the address of the continuation
...
> it's an implementation choice only.

And that was what I wanted to know about. So yes ;-)

> > I predicted earlier that this would not be a fruitful discussion.

> you're conflating the general concept of reaction to exploits

Absolutely, yes, I do.

In this overflow case, I still don't see why it is supposed to help to
shoot the process that happens to be "current" when the overflow occurs,
respectively why it would be a valid assumption that this process would
be "the exploit", provoking the overflow on purpose...
But never mind, if you say that's so, fine.

> every major operating system vendor and cpu manufacturer have adopted protection
> techniques that were pioneered by us, i think that speaks more than a lone doubting
> Thomas on the drbd list ;).

I know. I'm not doubting. I get it.
I just don't like it (precautionary shooting in general), is all.

Though I dislike it even more that it (implementing protection
techniques) is even necessary, if you have to assume they are out to get
you.  Which is more a fact than an assumption, in more scenarios than
I'd like it to be.  So you keep preventing existing bugs elsewhere from
becoming exploitable, and I'll shut up :)

	Lars

