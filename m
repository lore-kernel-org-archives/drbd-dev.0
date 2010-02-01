Return-Path: <onestero@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 38039106DFEC
	for <drbd-dev@lists.linbit.com>; Mon,  1 Feb 2010 11:40:21 +0100 (CET)
Date: Mon, 1 Feb 2010 11:39:33 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Neil Horman <nhorman@tuxdriver.com>
Message-ID: <20100201103933.GA32188@redhat.com>
References: <20100121200806.GA29801@shamino.rdu.redhat.com>
	<20100129151024.GA19249@hmsreliant.think-freely.org>
	<20100129151458.GC19249@hmsreliant.think-freely.org>
	<20100131155000.GB13402@redhat.com>
	<20100131160030.GB1950@localhost.localdomain>
	<20100201102936.GA31611@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100201102936.GA31611@redhat.com>
Cc: jmoskovc@redhat.com, neilb@suse.de, benh@kernel.crashing.org,
	gregkh@suse.de, takedakn@nttdata.co.jp,
	linux-kernel@vger.kernel.org, spock@gentoo.org, mingo@redhat.com,
	viro@zeniv.linux.org.uk, mfasheh@suse.com,
	akpm@linux-foundation.org, t.sailer@alumni.ethz.ch,
	shemminger@linux-foundation.org, menage@google.com,
	abelay@mit.edu, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 2/2] exec: allow core_pipe recursion check to
	look for	a value of 1 rather than 0 (v2)
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 02/01, Oleg Nesterov wrote:
>
> Oh. And in theory, it is better to change wait_for_helper(). It should
> do allow_signal(SIGCHLD) after kernel_thread(). Otherwise, kernel_thread()
> can fail if user-space sends SIGCHLD to the forking thread.

Well ;) And since allow_signal(SIGCHLD) was called, in theory we should
call sys_wait4() + clear_thread_flag(TIF_SIGPENDING) in a loop to protect
against the false SIGCHLD.

> > > Cough. And why call_usermodehelper_exec() has this strange ->path[0] == '\0'
> > > check?
> > >
> > That I can't explain.  I figured I'd let that sleeping dog lie until this got
> > striaghtened out and fix it separately if it needed it
> > Neil
>
> Yes, yes, agreed. As I said, this has nothing to do with this series,
> even if I am right these (minor) bugs should be fixed separately.

Yes.

Oleg.

