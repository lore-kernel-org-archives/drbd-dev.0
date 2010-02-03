Return-Path: <onestero@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E68BA105E7BA
	for <drbd-dev@lists.linbit.com>; Wed,  3 Feb 2010 21:10:44 +0100 (CET)
Date: Wed, 3 Feb 2010 21:09:54 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Neil Horman <nhorman@tuxdriver.com>
Message-ID: <20100203200954.GA15000@redhat.com>
References: <20100121200806.GA29801@shamino.rdu.redhat.com>
	<20100202191940.GB12697@hmsreliant.think-freely.org>
	<20100202192059.GC12697@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100202192059.GC12697@hmsreliant.think-freely.org>
Cc: jmoskovc@redhat.com, neilb@suse.de, benh@kernel.crashing.org,
	gregkh@suse.de, takedakn@nttdata.co.jp,
	linux-kernel@vger.kernel.org, spock@gentoo.org, mingo@redhat.com,
	viro@zeniv.linux.org.uk, mfasheh@suse.com,
	akpm@linux-foundation.org, t.sailer@alumni.ethz.ch,
	shemminger@linux-foundation.org, menage@google.com,
	abelay@mit.edu, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 1/2] exec: refactor how call_usermodehelper
	works, and	update the sense of the core_pipe recursion check (v3)
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 02/02, Neil Horman wrote:
>
> +void call_usermodehelper_setfns(struct subprocess_info *info,
> +		    int (*init)(struct subprocess_info *info),
> +		    void (*cleanup)(struct subprocess_info *info),
> +		    void *data);
> ...
> +call_usermodehelper_fns(char *path, char **argv, char **envp,
> +		    enum umh_wait wait,
> +		    int (*init)(struct subprocess_info *info),
> +		    void (*cleanup)(struct subprocess_info *), void *data)
> ...
> +	call_usermodehelper_setfns(info, init, cleanup, data);
>  	return call_usermodehelper_exec(info, wait);
>  }

Unless I misread the patch, this is the only caller of _setfns(), and
this helper is really trivial and probably deserves to be inline. But
this is very minor.

Personally I think these patches are nice. Not only this series adds
the new functionality, in my opinion it also cleanups and simplifies
the code.

Oleg.

