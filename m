Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9297810724E5
	for <drbd-dev@lists.linbit.com>; Wed, 27 Jan 2010 19:34:24 +0100 (CET)
Resent-Message-ID: <20100127183424.GF18961@soda.linbit>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 6DC8710724E4
	for <drbd-dev@lists.linbit.com>; Wed, 27 Jan 2010 19:00:07 +0100 (CET)
Date: Wed, 27 Jan 2010 18:58:52 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: akpm@linux-foundation.org
Message-ID: <20100127175852.GA7511@redhat.com>
References: <201001262354.o0QNsBiM029772@imap1.linux-foundation.org>
	<20100127174706.GA6333@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100127174706.GA6333@redhat.com>
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

On 01/27, Oleg Nesterov wrote:
>
> Currently only d_coredump() needs this new feature, but please note
> that ____call_usermodehelper() was already "uglified" for the coredumping
> over the pipe.
>
> If we add sub_info->finit(), then probably we should move the code
> under "if (sub_info->stdin)" from ____call_usermodehelper() to
> core_pipe_setup() ?

And, perhaps, we should not change call_usermodehelper() and all its
callers? If the caller needs ->finit() it can customize subprocess_info
like call_usermodehelper_pipe() already does?

To clarify, I don't have a "strong" opinion, I am just asking.

Oleg.

