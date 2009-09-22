Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D6CD810622A3
	for <drbd-dev@lists.linbit.com>; Tue, 22 Sep 2009 09:34:46 +0200 (CEST)
Resent-Message-ID: <20090922073446.GA8015@barkeeper1-xen.linbit>
Received: from mail-ew0-f215.google.com (mail-ew0-f215.google.com
	[209.85.219.215])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5EE7C1000254
	for <drbd-dev@lists.linbit.com>; Tue, 22 Sep 2009 02:58:03 +0200 (CEST)
Received: by ewy11 with SMTP id 11so3396897ewy.11
	for <drbd-dev@lists.linbit.com>; Mon, 21 Sep 2009 17:58:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090922072617U.fujita.tomonori@lab.ntt.co.jp>
References: <20090921144308.GG8072@barkeeper1-xen.linbit>
	<20090921165252.04e335b1@infradead.org>
	<20090921165321.GJ8072@barkeeper1-xen.linbit>
	<20090922072617U.fujita.tomonori@lab.ntt.co.jp>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Mon, 21 Sep 2009 20:51:32 -0400
Message-ID: <f73f7ab80909211751p4d797556lcce5e47c3241b5ef@mail.gmail.com>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Content-Type: text/plain; charset=UTF-8
Cc: bart.vanassche@gmail.com, sam@ravnborg.org, neilb@suse.de, knikanth@suse.de,
	gregkh@suse.de, linux-kernel@vger.kernel.org,
	philipp.reisner@linbit.com, hch@infradead.org,
	Mauelshagen@redhat.com, James.Bottomley@suse.de, lmb@suse.de,
	kosaki.motohiro@jp.fujitsu.com, jens.axboe@oracle.com,
	davej@redhat.com, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, arjan@infradead.org
Subject: Re: [Drbd-dev] [GIT PULL] DRBD for 2.6.32
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Sep 21, 2009 at 18:27, FUJITA Tomonori
<fujita.tomonori@lab.ntt.co.jp> wrote:
> On Mon, 21 Sep 2009 18:53:21 +0200 Lars Ellenberg <lars.ellenberg@linbit.com> wrote:
>> That's not what I meant, of course that is and needs to be stable.
>> Sorry, I exagerated to make a point.
>>
>> Point was:
>> mdadm configured md.
>> dmsetup configured dm.
>> drbdsetup configure drbd.
>>
>> If and when "something" is done to "unify" things on the implementation
>> level, it is likely to also unify the "kernel<->userspace" configuration
>> interface.
>>
>> If it happens, once that happens, that _will_ be an ABI break.
>
> You misunderstand the raid unification.
>
> We will not unify the kernel<->userspace configuration interface
> because we can't break the kernel<->userspace ABI.
>
> We plan to unify the multiple device frameworks, but the unified
> framework must support the all existing ABIs.
>
> So adding another 'drbd' ABI hurts us.

One major issue for me personally (and I don't think its been mentioned enough):

There is a *VAST* existing user-base for DRBD.  Basically every vendor
builds the modules for their kernels, ships the userspace tools, etc.
*Regardless* of when or how it gets merged, the existing user-base
will need kernel support for the existing tools.

You have to realize that this project is NOT a new one, it's been
around quite a decent number of years (since kernel 2.2-ish).  Yes,
the ABI is unique and has its warts, but there are a lot of things
that depend on it.

Think of it (in concept) like merging mainline support for an
architecture that has been forward-ported as patches since 2.2.  If
the architecture was a simple embedded-only one (like a few recent
ones have been), then you might just say "hell with it, everybody
needs to rebuild libc and the world".  That doesn't seem to be the
case with an enterprise-supported distributed block device.

IMHO, we should treat the kernel<=>userspace ABI as fixed... it's an
existing wart that will need to be supported for a while.  The
benefits of getting the stable and long-out-of-tree drbd modules into
the mainline kernel will far outweigh the pain of having to maintain
the existing ABI.

To put it another way:  Would you really keep a stable SCSI raid
driver for existing hardware out of mainline by claiming they need to
write a new raid-management abstraction first?  If not, then why the
pushback on DRBD?

Cheers,
Kyle Moffett
