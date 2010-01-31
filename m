Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 23909106E007
	for <drbd-dev@lists.linbit.com>; Mon,  1 Feb 2010 11:01:34 +0100 (CET)
Resent-Message-ID: <20100201100133.GC13031@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 16EBB106DFE9
	for <drbd-dev@lists.linbit.com>; Sun, 31 Jan 2010 16:51:13 +0100 (CET)
Date: Sun, 31 Jan 2010 16:50:01 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Neil Horman <nhorman@tuxdriver.com>
Message-ID: <20100131155000.GB13402@redhat.com>
References: <20100121200806.GA29801@shamino.rdu.redhat.com>
	<20100129151024.GA19249@hmsreliant.think-freely.org>
	<20100129151458.GC19249@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100129151458.GC19249@hmsreliant.think-freely.org>
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

On 01/29, Neil Horman wrote:
>
>  void do_coredump(long signr, int exit_code, struct pt_regs *regs)
>  {
> ...
> -		if (call_usermodehelper_pipe(helper_argv[0], helper_argv, NULL,
> -				&cprm.file)) {
> +		cprm.file = NULL;

it is already NULL,

> +		if (call_usermodehelper_fns(helper_argv[0], helper_argv, NULL,
> +					    UMH_WAIT_EXEC, umh_pipe_setup,
> +					    NULL, &cprm)) {
> +			if (cprm.file)
> +				filp_close(cprm.file, NULL);

Hmm. Looks like this change fixes the bug by accident.

Before this patch, I think we leak info->stdin if kernel_thread() fails
in __call_usermodehelper() pathes.



Completely off-topic, but I think __call_usermodehelper(UMH_NO_WAIT) is
buggy. if kernel_thread() failes it should do call_usermodehelper_freeinfo().
Also, UMH_WAIT_EXEC should set ->retval in this case.

Cough. And why call_usermodehelper_exec() has this strange ->path[0] == '\0'
check?

Oleg.

