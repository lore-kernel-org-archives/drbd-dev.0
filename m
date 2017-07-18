Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wr0-f176.google.com (mail-wr0-f176.google.com
	[209.85.128.176])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EDE2E1057FCE
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jul 2017 09:25:45 +0200 (CEST)
Received: by mail-wr0-f176.google.com with SMTP id 12so15680967wrb.1
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jul 2017 00:25:45 -0700 (PDT)
Date: Tue, 18 Jul 2017 09:25:43 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20170718072542.GB1453@rck.sh>
References: <20170717194958.22787-1-bwiedemann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717194958.22787-1-bwiedemann@suse.de>
Subject: Re: [Drbd-dev] [PATCH] [RFC] drbd: do not record build details
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

On Mon, Jul 17, 2017 at 09:49:58PM +0200, Bernhard M. Wiedemann wrote:
> such as user, hostname and build date
> to allow reproducible builds
> 
> See https://reproducible-builds.org/ for why this matters.
> 
> ---
> Note: There are plenty alternatives to this patch
> but this one was the easiest to write for me
> to have a fully reproducible build
> and is meant as a base for discussing how to fix this part.
> E.g. it could involve a [ -z "${SOURCE_DATE_EPOCH" ] || ...
> ---
>  drbd/Kbuild | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drbd/Kbuild b/drbd/Kbuild
> index 2d1b4d0..08def4e 100644
> --- a/drbd/Kbuild
> +++ b/drbd/Kbuild
> @@ -134,5 +134,5 @@ $(obj)/drbd_buildtag.c: $(filter-out drbd_buildtag.o,$(drbd-y))
>  		echo >&2 "Your DRBD source tree is broken. Unpack again.";      \
>  		exit 1;								\
>  	fi ;									\
> -	echo -e "\t\t\" build by $$USER@$$HOSTNAME, `date "+%F %T"`\";\n}";	\
> +	echo -e "\t\t\" reproducible build\";\n}";	\
>  	mv -f $@.new $@

Okay, we are talking about oot drbd, right?

I'm a big fan of reproducible builds, but only as long as it does not
break very useful information for us when we actually look at customer
installations. In that case it IMO does break that.

Again, I totally understand what the reproducible build project tries to
achieve, and it is important, but why isn't that just a vendor-patch for
the distribution you care about like the Debian guys do it?

Regards, rck
