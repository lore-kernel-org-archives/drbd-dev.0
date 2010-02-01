Return-Path: <onestero@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0DEB1106DFEC
	for <drbd-dev@lists.linbit.com>; Mon,  1 Feb 2010 11:31:47 +0100 (CET)
Date: Mon, 1 Feb 2010 11:29:36 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Neil Horman <nhorman@tuxdriver.com>
Message-ID: <20100201102936.GA31611@redhat.com>
References: <20100121200806.GA29801@shamino.rdu.redhat.com>
	<20100129151024.GA19249@hmsreliant.think-freely.org>
	<20100129151458.GC19249@hmsreliant.think-freely.org>
	<20100131155000.GB13402@redhat.com>
	<20100131160030.GB1950@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100131160030.GB1950@localhost.localdomain>
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

On 01/31, Neil Horman wrote:
>
> On Sun, Jan 31, 2010 at 04:50:01PM +0100, Oleg Nesterov wrote:
> > On 01/29, Neil Horman wrote:
> > >
> > >  void do_coredump(long signr, int exit_code, struct pt_regs *regs)
> > >  {
> > > ...
> > > -		if (call_usermodehelper_pipe(helper_argv[0], helper_argv, NULL,
> > > -				&cprm.file)) {
> > > +		cprm.file = NULL;
> >
> > it is already NULL,
> >
> Are we sure, it was declared on the stack.

it must be NULL, or compiler is buggy. it was declared as "= { ... }".

> I think its safer to ensure that its
> NULL.

OK, agreed. I mentioned this just in case.

> > > +		if (call_usermodehelper_fns(helper_argv[0], helper_argv, NULL,
> > > +					    UMH_WAIT_EXEC, umh_pipe_setup,
> > > +					    NULL, &cprm)) {
> > > +			if (cprm.file)
> > > +				filp_close(cprm.file, NULL);
> >
> > Hmm. Looks like this change fixes the bug by accident.
> >
> > Before this patch, I think we leak info->stdin if kernel_thread() fails
> > in __call_usermodehelper() pathes.
> >
> I think we did that in call_usermodehelper_pipe.

Afaics, no. Well yes, call_usermodehelper_pipe() closes write_pipe,
but I meant nobody closes read_pipe, info->stdin, if we fail before
____call_usermodehelper() is called.

> > Completely off-topic, but I think __call_usermodehelper(UMH_NO_WAIT) is
> > buggy. if kernel_thread() failes it should do call_usermodehelper_freeinfo().
> > Also, UMH_WAIT_EXEC should set ->retval in this case.
> >
> I went down that path last time I changed this code, Andrew and I decided that
> yes it was buggy, but someone (can't recall how) smacked me around a bit and
> explained how it worked (some odd artifact behavior of the scheduler).  Its in
> the lkml archives if you want to get the whole story.

Hmm. I strongly believe this is buggy, and the scheduler can't help in any
way. Fortunately, kernel_thread() must "never" fail...

Oh. And in theory, it is better to change wait_for_helper(). It should
do allow_signal(SIGCHLD) after kernel_thread(). Otherwise, kernel_thread()
can fail if user-space sends SIGCHLD to the forking thread.

> > Cough. And why call_usermodehelper_exec() has this strange ->path[0] == '\0'
> > check?
> >
> That I can't explain.  I figured I'd let that sleeping dog lie until this got
> striaghtened out and fix it separately if it needed it
> Neil

Yes, yes, agreed. As I said, this has nothing to do with this series,
even if I am right these (minor) bugs should be fixed separately.

Oleg.

