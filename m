Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 126611019A68
	for <drbd-dev@lists.linbit.com>; Wed,  8 Feb 2012 15:10:18 +0100 (CET)
Date: Wed, 8 Feb 2012 15:03:33 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <20120208140333.GA3547@redhat.com>
References: <20120202173504.GA25528@redhat.com>
	<201202032254.GCJ30240.SLMOVFFHtJOFOQ@I-love.SAKURA.ne.jp>
	<20120203151534.GB32503@redhat.com>
	<201202041426.ICI23458.FFFtOMLOJOVSQH@I-love.SAKURA.ne.jp>
	<201202051415.JEB43260.SFMJOHLtOFVQOF@I-love.SAKURA.ne.jp>
	<201202072055.GEC05251.FFMSVHOLOFOQJt@I-love.SAKURA.ne.jp>
	<20120207171031.GA11215@redhat.com>
	<201202080227.q182RnCp077670@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201202080227.q182RnCp077670@www262.sakura.ne.jp>
Cc: john.johansen@canonical.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	fhrbata@redhat.com, rusty@rustcorp.com.au, apw@canonical.com,
	Michal Januszewski <spock@gentoo.org>, rientjes@google.com,
	tj@kernel.org, akpm@linux-foundation.org, arjan@linux.intel.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 0/1] usermodehelper: use UMH_WAIT_PROC
	consistently
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 02/08, Tetsuo Handa wrote:
>
> Oleg Nesterov wrote:
>
> > Subject: [PATCH 1/5] usermodehelper: kill umh_wait, renumber UMH_* constants
> >
> > No functional changes, preparation.
> >
> > umh_wait doesn't can't be used as a bitmask, and we do not want
> > to add another argument call_usermodehelper_* helpers.
> >
> > Kill this enum and redefine the UMH_* constants.
>
> There are several users that call call_usermodehelper() without using this
> enum. security/tomoyo/load_policy.c is one of such users

... and there are more.

Thanks a lot Tetsuo.

> and there will be some
> in out-of-tree code.

Well, they should be fixed imho.

> Since I think distro kernels want
> to backport this killable request_module() patchset, this patch should not
> change the constants in a way that makes impossible to detect kABI changes.

Good point, but I think the backporter should take care to not break
the KABI. I do not think we should defer the possible cleanups for
the sake of backporting.

It is possible to skip the first patch and add UMH_KILLABLE, just
call_usermodehelper_exec() needs the additional wait != UMH_NO_WAIT
check before testind/clearing UMH_KILLABLE. UMH_NO_WAIT | KILLABLE
is not possible.

>  #define UMH_WAIT_EXEC	 0	/* wait for the exec, but not the process */
>  #define UMH_WAIT_PROC	 1	/* wait for the process to complete */
>  #define UMH_KILLABLE	 2	/* wait for EXEC/PROC killable */
>  #define UMH_NO_WAIT     4	/* don't wait at all */
>
> might be acceptable because we can remap -1 -> UMH_NO_WAIT on
> call_usermodehelper_exec() side.

Yes... but I think it is better to fix the users.

Perhaps we can do something like

	#define UMH_NO_WAIT	0x8000
	#define UMH_WAIT_EXEC	0x8001
	#define UMH_WAIT_	0x8002

and then call_usermodehelper_exec() does

	/* catch the old buggy users */
	BUG_ON(!(wait & 0x8000) || (wait < 0))

In any case. Whatever we do, I think we should fix the current ab-users.

Andrew, could you take this patch? Or should I split this trivial change
by file/maintainer?

Oleg.

