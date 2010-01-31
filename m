Return-Path: <nhorman@tuxdriver.com>
Received: from smtp.tuxdriver.com (charlotte.tuxdriver.com [70.61.120.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 186641011BEC
	for <drbd-dev@lists.linbit.com>; Sun, 31 Jan 2010 18:42:09 +0100 (CET)
Date: Sun, 31 Jan 2010 12:41:48 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: Oleg Nesterov <oleg@redhat.com>
Message-ID: <20100131160030.GB1950@localhost.localdomain>
References: <20100121200806.GA29801@shamino.rdu.redhat.com>
	<20100129151024.GA19249@hmsreliant.think-freely.org>
	<20100129151458.GC19249@hmsreliant.think-freely.org>
	<20100131155000.GB13402@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100131155000.GB13402@redhat.com>
Cc: jmoskovc@redhat.com, neilb@suse.de, benh@kernel.crashing.org,
	gregkh@suse.de, takedakn@nttdata.co.jp,
	linux-kernel@vger.kernel.org, spock@gentoo.org, mingo@redhat.com,
	viro@zeniv.linux.org.uk, mfasheh@suse.com,
	akpm@linux-foundation.org, t.sailer@alumni.ethz.ch,
	shemminger@linux-foundation.org, menage@google.com,
	abelay@mit.edu, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 2/2] exec: allow core_pipe recursion check to
 look for a value of 1 rather than 0 (v2)
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sun, Jan 31, 2010 at 04:50:01PM +0100, Oleg Nesterov wrote:
> On 01/29, Neil Horman wrote:
> >
> >  void do_coredump(long signr, int exit_code, struct pt_regs *regs)
> >  {
> > ...
> > -		if (call_usermodehelper_pipe(helper_argv[0], helper_argv, NULL,
> > -				&cprm.file)) {
> > +		cprm.file = NULL;
> 
> it is already NULL,
> 
Are we sure, it was declared on the stack.  I think its safer to ensure that its
NULL.
 
> > +		if (call_usermodehelper_fns(helper_argv[0], helper_argv, NULL,
> > +					    UMH_WAIT_EXEC, umh_pipe_setup,
> > +					    NULL, &cprm)) {
> > +			if (cprm.file)
> > +				filp_close(cprm.file, NULL);
> 
> Hmm. Looks like this change fixes the bug by accident.
> 
> Before this patch, I think we leak info->stdin if kernel_thread() fails
> in __call_usermodehelper() pathes.
> 
I think we did that in call_usermodehelper_pipe.

> 
> 
> Completely off-topic, but I think __call_usermodehelper(UMH_NO_WAIT) is
> buggy. if kernel_thread() failes it should do call_usermodehelper_freeinfo().
> Also, UMH_WAIT_EXEC should set ->retval in this case.
> 
I went down that path last time I changed this code, Andrew and I decided that
yes it was buggy, but someone (can't recall how) smacked me around a bit and
explained how it worked (some odd artifact behavior of the scheduler).  Its in
the lkml archives if you want to get the whole story.

> Cough. And why call_usermodehelper_exec() has this strange ->path[0] == '\0'
> check?
> 
That I can't explain.  I figured I'd let that sleeping dog lie until this got
striaghtened out and fix it separately if it needed it
Neil

> Oleg.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
