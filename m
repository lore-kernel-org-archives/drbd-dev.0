Return-Path: <onestero@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5AEA31005416
	for <drbd-dev@lists.linbit.com>; Mon,  1 Feb 2010 15:20:50 +0100 (CET)
Date: Mon, 1 Feb 2010 15:18:56 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Neil Horman <nhorman@tuxdriver.com>
Message-ID: <20100201141856.GA9453@redhat.com>
References: <20100121200806.GA29801@shamino.rdu.redhat.com>
	<20100129151024.GA19249@hmsreliant.think-freely.org>
	<20100129151458.GC19249@hmsreliant.think-freely.org>
	<20100131155000.GB13402@redhat.com>
	<20100131160030.GB1950@localhost.localdomain>
	<20100201102936.GA31611@redhat.com>
	<20100201131627.GE25094@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100201131627.GE25094@hmsreliant.think-freely.org>
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

On 02/01, Neil Horman wrote:
>
> On Mon, Feb 01, 2010 at 11:29:36AM +0100, Oleg Nesterov wrote:
> >
> > > > Completely off-topic, but I think __call_usermodehelper(UMH_NO_WAIT) is
> > > > buggy. if kernel_thread() failes it should do call_usermodehelper_freeinfo().
> > > > Also, UMH_WAIT_EXEC should set ->retval in this case.
> > > >
> > > I went down that path last time I changed this code, Andrew and I decided that
> > > yes it was buggy, but someone (can't recall how) smacked me around a bit and
> > > explained how it worked (some odd artifact behavior of the scheduler).  Its in
> > > the lkml archives if you want to get the whole story.
> >
> > Hmm. I strongly believe this is buggy, and the scheduler can't help in any
> > way. Fortunately, kernel_thread() must "never" fail...
>
> Commit 95e0d86badc410d525ea7218fd32df7bfbf9c837 has the discussion from the
> previous time that I messed with this code.  Not sure how closely it relates,
> but...

The changelog correctly explains why it is OK to do complete() from
__call_usermodehelper() in UMH_WAIT_EXEC case: CLONE_VFORK guarantees
kernel_thread(CLONE_VFORK) won't return (see do_fork()) until
____call_usermodehelper() thread does exec or exits.

I meant a much more simple problem, I think we need something like this
patch:

	--- kernel/kmod.c
	+++ kernel/kmod.c
	@@ -266,15 +266,18 @@ static void __call_usermodehelper(struct
	 
		switch (wait) {
		case UMH_NO_WAIT:
	+		if (pid < 0)
	+			call_usermodehelper_freeinfo(sub_info);
			break;
	 
		case UMH_WAIT_PROC:
			if (pid > 0)
				break;
	-		sub_info->retval = pid;
			/* FALLTHROUGH */
	 
		case UMH_WAIT_EXEC:
	+		if (pid < 0)
	+			sub_info->retval = pid;
			complete(sub_info->complete);
		}
	 }

to fix 2 problems if kernel_thread() fails in __call_usermodehelper()

	- UMH_NO_WAIT should do call_usermodehelper_freeinfo()

	- UMH_WAIT_EXEC should set sub_info->retval to indicate
	  the error

> > Oh. And in theory, it is better to change wait_for_helper(). It should
> > do allow_signal(SIGCHLD) after kernel_thread().

I was wrong, of course we can't do this, the child can exit and reap
itself before we do sys_wait4().

> Otherwise, kernel_thread()
> > can fail if user-space sends SIGCHLD to the forking thread.

but this is still true. Fortunately this is very minor problem.

Oleg.

