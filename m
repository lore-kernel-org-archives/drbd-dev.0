Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wr0-f179.google.com (mail-wr0-f179.google.com
	[209.85.128.179])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B55881057FD4
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jul 2017 14:35:35 +0200 (CEST)
Received: by mail-wr0-f179.google.com with SMTP id 12so27455803wrb.1
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jul 2017 05:35:35 -0700 (PDT)
Date: Tue, 18 Jul 2017 14:35:32 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20170718123532.GD1453@rck.sh>
References: <20170718083536.13668-1-bwiedemann@suse.de>
	<20170718091350.16310-1-bwiedemann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170718091350.16310-1-bwiedemann@suse.de>
Subject: Re: [Drbd-dev] [PATCH] drbd: Allow to override build date (v2)
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

On Tue, Jul 18, 2017 at 11:13:50AM +0200, Bernhard M. Wiedemann wrote:
> and to not record build user and hostname if requested
> in order to allow for reproducible builds.
> See https://reproducible-builds.org/ for why this is good
> and https://reproducible-builds.org/specs/source-date-epoch/
> for the definition of this variable.
> ---
>  drbd/Kbuild | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drbd/Kbuild b/drbd/Kbuild
> index 2d1b4d0..9898e93 100644
> --- a/drbd/Kbuild
> +++ b/drbd/Kbuild
> @@ -134,5 +134,10 @@ $(obj)/drbd_buildtag.c: $(filter-out drbd_buildtag.o,$(drbd-y))
>  		echo >&2 "Your DRBD source tree is broken. Unpack again.";      \
>  		exit 1;								\
>  	fi ;									\
> -	echo -e "\t\t\" build by $$USER@$$HOSTNAME, `date "+%F %T"`\";\n}";	\
> +	if [ -z "${SOURCE_DATE_EPOCH}" ] ; then \
> +		buildinfo="build by $$USER@$$HOSTNAME, `date "+%F %T"`" ; \
> +	else \
> +		buildinfo="reproducible build, `date -u -d@${SOURCE_DATE_EPOCH} "+%F %T"`" ; \
> +	fi ; \
> +	echo -e "\t\t\" $$buildinfo\";\n}";	\
>  	mv -f $@.new $@
> -- 
> 2.12.3

No. What if setting SOURCE_DATE_EPOCH becomes the default in the future?
Maybe it already is for some of the distributions we as LINBIT build
packages for. Sorry for being the spoilsport here, but as it stands I
only see the potential of breaking the way we want it .

Regards, rck
