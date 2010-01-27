Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 1DF0D10724E5
	for <drbd-dev@lists.linbit.com>; Wed, 27 Jan 2010 22:34:20 +0100 (CET)
Date: Wed, 27 Jan 2010 13:34:08 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Neil Horman <nhorman@tuxdriver.com>
Message-Id: <20100127133408.9d8f72fe.akpm@linux-foundation.org>
In-Reply-To: <20100127212239.GA15052@hmsreliant.think-freely.org>
References: <201001262354.o0QNsBiM029772@imap1.linux-foundation.org>
	<20100127174706.GA6333@redhat.com>
	<20100127175852.GA7511@redhat.com>
	<20100127212239.GA15052@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: jmoskovc@redhat.com, neilb@suse.de, benh@kernel.crashing.org,
	gregkh@suse.de, takedakn@nttdata.co.jp,
	Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
	spock@gentoo.org, mingo@redhat.com, viro@zeniv.linux.org.uk,
	mfasheh@suse.com, menage@google.com, t.sailer@alumni.ethz.ch,
	shemminger@linux-foundation.org, abelay@mit.edu, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] +
 exec-allow-core_pipe-recursion-check-to-look-for-a-value-of-1-rather
 -than-0.patch added to -mm tree
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, 27 Jan 2010 16:22:39 -0500
Neil Horman <nhorman@tuxdriver.com> wrote:

> On Wed, Jan 27, 2010 at 06:58:52PM +0100, Oleg Nesterov wrote:
> > On 01/27, Oleg Nesterov wrote:
> > >
> > > Currently only d_coredump() needs this new feature, but please note
> > > that ____call_usermodehelper() was already "uglified" for the coredumping
> > > over the pipe.
> > >
> > > If we add sub_info->finit(), then probably we should move the code
> > > under "if (sub_info->stdin)" from ____call_usermodehelper() to
> > > core_pipe_setup() ?
> > 
> > And, perhaps, we should not change call_usermodehelper() and all its
> > callers? If the caller needs ->finit() it can customize subprocess_info
> > like call_usermodehelper_pipe() already does?
> > 
> > To clarify, I don't have a "strong" opinion, I am just asking.
> > 
> I'm not opposed to that, Since Andew has already taken these patches, I'll
> tinkier to see how such an implementation change looks, and post some follow on
> patches if it seems good.  I'll clean up the comments while I'm at it.
> 

The patch conflicts a bit with Andi's
sysctl-add-call_usermodehelper_cleanup.patch so I dropped v1 of
exec-allow-core_pipe-recursion-check-to-look-for-a-value-of-1-rather-than-0.patch
