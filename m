Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wr0-f175.google.com (mail-wr0-f175.google.com
	[209.85.128.175])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8359E1057FCE
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jul 2017 09:20:03 +0200 (CEST)
Received: by mail-wr0-f175.google.com with SMTP id a10so15662678wrd.0
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jul 2017 00:20:03 -0700 (PDT)
Date: Tue, 18 Jul 2017 09:20:01 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20170718072001.GA1453@rck.sh>
References: <20170717192930.21694-1-bwiedemann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717192930.21694-1-bwiedemann@suse.de>
Subject: Re: [Drbd-dev] [PATCH] drbd: sort file list
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Jul 17, 2017 at 09:29:30PM +0200, Bernhard M. Wiedemann wrote:
> because it influences the ordering of entries in compat.h
> which influences srcversion= checksum

"srcversion" is for in tree drbd.

> which prevents drbd.ko from building reproducibly.
> 
> See https://reproducible-builds.org/ for why this matters.
> ---
>  drbd/Kbuild | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drbd/Kbuild b/drbd/Kbuild
> index 2d1b4d0..c5787a6 100644
> --- a/drbd/Kbuild
> +++ b/drbd/Kbuild
> @@ -70,7 +70,7 @@ COMPAT_FORCE := FORCE
>  endif
>  
>  ifneq ($(KBUILD_STAGE),modpost)
> -TEST_C := $(wildcard $(src)/drbd-kernel-compat/tests/*.c)
> +TEST_C := $(sort $(wildcard $(src)/drbd-kernel-compat/tests/*.c))
>  TEST_R := $(TEST_C:$(src)/drbd-kernel-compat/tests/%.c=$(obj)/.compat_test.%.result)
>  $(obj)/.compat_test.%.result: $(src)/drbd-kernel-compat/tests/%.c $(COMPAT_FORCE)
>  	$(call cmd,compat_test_result)

which is for out of tree drbd, like the whole compat checks and compat.h.

so what are you actually talking about?

Regards, rck
