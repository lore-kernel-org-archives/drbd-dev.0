Return-Path: <dab21774@gmail.com>
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
	[209.85.166.67])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4A47C1028A66
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jun 2019 10:47:14 +0200 (CEST)
Received: by mail-io1-f67.google.com with SMTP id u13so28039786iop.0
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jun 2019 01:47:14 -0700 (PDT)
To: Robert Altnoeder <robert.altnoeder@linbit.com>, drbd-dev@lists.linbit.com
References: <e9d5ec6e-30e9-9af1-06c3-bcf8b1d92068@gmail.com>
	<20190612141149.GA5803@soda.linbit>
	<83e97127-9511-7899-e9e4-2b44a7932661@linbit.com>
From: David Butterfield <dab21774@gmail.com>
Message-ID: <f1bbf160-8496-dea5-3257-45859b20dfac@gmail.com>
Date: Tue, 18 Jun 2019 02:47:07 -0600
MIME-Version: 1.0
In-Reply-To: <83e97127-9511-7899-e9e4-2b44a7932661@linbit.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] running DRBD in usermode
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

On 6/14/19 3:49 AM, Robert Altnoeder wrote:
> Only changing errno to _errno to fix this is probaby not the best idea,
> so if we're going to change this, then I'd rather use a new variable
> name that does not even suggest being related to errno, otherwise
> whoever sees it the next time might be tempted to change it back to errno.

Sure.  I just thought I'd point out the few things I noticed along the way.
How (or if) they should be fixed isn't my aim.  There was remarkably little
trouble getting 50,000 lines of DRBD kernel code running in usermode (using
as a base the project I did a few years ago bringing SCST to usermode).

I compile the DRBD source nearly unmodified, providing a simulated 2.6.32
environment around it so it feels at home (using its kernel_compat stuff).
The only changes to DRBD source code are temporary #ifndef around rb_augment,
netlink multicast, and nested spinlocking, which I haven't written
emulations for yet, plus maybe another dozen places with 1-2 lines of
change, most of which I hope to eventually be able to clean out.

> While I'm at it, I am wondering a bit about the modification of DRBD to
> run in usermode. It's not that I couldn't see a whole lot of reasons why
> you'd want to do this, quite the opposite, but I believe it would make a
> lot more sense if you did that on top of a true microkernel OS such as
> e.g. Minix, seL4, Integrity or QNX. That might even turn the whole thing
> into a very useful project, as such a port of DRBD might be interesting
> for use in e.g. embedded systems running those OSs.

Any of that could be done.  The "platform" I ported to was "POSIX system
calls along with a few libraries like pthreads and libfuse and my multi-
threaded event engine".  (I probably use a couple of Linux-specific system
calls or options, but those should be isolated and easily replaceable.)

The "usermode_compat" ("UMC") code that (partially) emulates the Linux
kernel environment is in a separate layer (separate repository) from the
"Multithreaded Engine" ("MTE") layer that provides basic system services
(memory, timers, threads, socket event polling, debugging, etc), with MTE
services accessed through a "sys_service" ops vector (which was designed
*without* having in mind using it as a base to run Linux kernel code).
(I wrote MTE first, then got the idea to write UMC using MTE services and
use it to port SCST to usermode.)

The UMC "Linux kernel emulation" layer should be able to operate with any
"sys_service provider" that implements the functions behind the sys_service
ops vector.  The MTE is about 7500 lines of code that could probably be
re-implemented as a smaller shim to an alternative mem/time/threading
provider such as a microkernel, without disturbing the Linux kernel
emulation layer too much.

These are a couple of diagrams from the SCST project that show the layering:
https://davidbutterfield.github.io/SCST-Usermode-Adaptation/docs/SCST_usermode_service_map.pdf
https://davidbutterfield.github.io/SCST-Usermode-Adaptation/docs/SCST_usermode_includes.pdf

Regards,
David Butterfield
