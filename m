Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 27FA8106DFFC
	for <drbd-dev@lists.linbit.com>; Mon,  1 Feb 2010 11:01:20 +0100 (CET)
Resent-Message-ID: <20100201100119.GB13031@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5D2B71011BE1
	for <drbd-dev@lists.linbit.com>; Sun, 31 Jan 2010 15:47:46 +0100 (CET)
Date: Sun, 31 Jan 2010 15:46:06 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Neil Horman <nhorman@tuxdriver.com>
Message-ID: <20100131144606.GA13402@redhat.com>
References: <20100121200806.GA29801@shamino.rdu.redhat.com>
	<20100129151024.GA19249@hmsreliant.think-freely.org>
	<20100129151351.GB19249@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100129151351.GB19249@hmsreliant.think-freely.org>
Cc: jmoskovc@redhat.com, neilb@suse.de, benh@kernel.crashing.org,
	gregkh@suse.de, takedakn@nttdata.co.jp,
	linux-kernel@vger.kernel.org, spock@gentoo.org, mingo@redhat.com,
	viro@zeniv.linux.org.uk, mfasheh@suse.com,
	akpm@linux-foundation.org, t.sailer@alumni.ethz.ch,
	shemminger@linux-foundation.org, menage@google.com,
	abelay@mit.edu, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 1/2] exec: allow core_pipe recursion check to
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
> Add init function to usermodehelper
>
> Convert call_usermodehelper_cleanup to usermodehelper_fns and allow it to assign
> both an init function and a cleanup function.

Can't apply this patch, I guess -mm tree has other changes which
this patch depends on. However afaics this series is fine, just
a couple of nits.

> @@ -154,7 +155,9 @@ struct subprocess_info {
>  	enum umh_wait wait;
>  	int retval;
>  	struct file *stdin;
> -	void (*cleanup)(char **argv, char **envp);
> +	int (*init)(void *data);
> +	void (*cleanup)(char **argv, char **envp, void *data);
> +	void *data;

OK, we add *data. But why this patch changes the prototype of ->cleanup() ?
OTOH, I completely agree, it should be changed, and it should lose the
ugly argv/envp arguments.

Since we add subprocess_info->data ptr, I think both ->init and ->cleanup
funcs should have the single arg, "subprocess_info *info". argv, envp, data
they all can be accessed via *info.

Also. It is not clear why this patch changes call_usermodehelper_setup()
to set info->data. Unless the caller uses call_usermodehelper_setinit()
or call_usermodehelper_setcleanup() info->data is not used. Perhaps
it is better to have a single helper which takes (init, cleanup, data)
args.

What do you think?

In any case, I believe you should fix the subjects ;)

Oleg.

