Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 495C010724F7
	for <drbd-dev@lists.linbit.com>; Wed, 27 Jan 2010 19:34:29 +0100 (CET)
Resent-Message-ID: <20100127183428.GG18961@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CD5F210724E4
	for <drbd-dev@lists.linbit.com>; Wed, 27 Jan 2010 18:48:00 +0100 (CET)
Date: Wed, 27 Jan 2010 18:47:06 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: akpm@linux-foundation.org
Message-ID: <20100127174706.GA6333@redhat.com>
References: <201001262354.o0QNsBiM029772@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201001262354.o0QNsBiM029772@imap1.linux-foundation.org>
Cc: jmoskovc@redhat.com, nhorman@tuxdriver.com, neilb@suse.de,
	benh@kernel.crashing.org, gregkh@suse.de, takedakn@nttdata.co.jp,
	linux-kernel@vger.kernel.org, spock@gentoo.org, mingo@redhat.com,
	viro@zeniv.linux.org.uk, mfasheh@suse.com, menage@google.com,
	t.sailer@alumni.ethz.ch, shemminger@linux-foundation.org,
	abelay@mit.edu, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev]
	+	exec-allow-core_pipe-recursion-check-to-look-for-a-value-of-1-rather	-than-0.patch
	added to -mm tree
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 01/26, Andrew Morton wrote:
>
> From: Neil Horman <nhorman@tuxdriver.com>
>
> What I've done is modify the
> call_usermodehelper() api such that an extra parameter is added, a
> function pointer which will be called by the user helper task, after it
> forks, but before it execs the required process.

Personally I agree, I think this fptr can be useful, not only for coredump.

> This will give the
> caller the opportunity to get a callback in the process's context,
> allowing it to do whatever it needs to to the process in the kernel

in this case it probably needs "void *data" argument, otherwise the
usage is very limited.

Currently only d_coredump() needs this new feature, but please note
that ____call_usermodehelper() was already "uglified" for the coredumping
over the pipe.

If we add sub_info->finit(), then probably we should move the code
under "if (sub_info->stdin)" from ____call_usermodehelper() to
core_pipe_setup() ?

> +/*
> + * This is used as a helper to set up the task that execs
> + * our user space core collector application
> + * Its called in the context of the task thats going to
> + * exec itself to be the helper, so we can modify current here
> + */

very minor nit, perhaps the comment should explain what is the meaning
of the magical rlim_cur = 1 value? It is not immediately obvious we
check cprm.limit == 1 below.

> +void core_pipe_setup(void)
> +{
> +	task_lock(current->group_leader);
> +	current->signal->rlim[RLIMIT_CORE].rlim_cur = 1;
> +	task_unlock(current->group_leader);
> +}

Well, this thread must be the kernel thread and thus it should be
->group_leader and I don't think we really need task_lock() her,
but this is minor and perhaps ->group_leader + task_lock() look
better even if not needed.

Oleg.

