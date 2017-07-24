Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wr0-f171.google.com (mail-wr0-f171.google.com
	[209.85.128.171])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 6B18D1057FD4
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jul 2017 07:16:48 +0200 (CEST)
Received: by mail-wr0-f171.google.com with SMTP id 33so44738661wrz.4
	for <drbd-dev@lists.linbit.com>; Sun, 23 Jul 2017 22:16:48 -0700 (PDT)
Date: Mon, 24 Jul 2017 07:16:46 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20170724051646.GA29081@rck.sh>
References: <20170718124813.31529-1-bwiedemann@suse.de>
	<20170723155751.16226-1-bwiedemann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170723155751.16226-1-bwiedemann@suse.de>
Subject: Re: [Drbd-dev] [PATCH] drbd-utils: Allow to override build date
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

On Sun, Jul 23, 2017 at 05:57:51PM +0200, Bernhard M. Wiedemann wrote:
> and to not record build user and hostname if requested
> in order to allow for reproducible builds.
> See https://reproducible-builds.org/ for why this is good
> and https://reproducible-builds.org/specs/source-date-epoch/
> for the definition of this variable.
> ---
>  user/shared/Makefile.in | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/user/shared/Makefile.in b/user/shared/Makefile.in
> index cce7c1bc..596bcf81 100644
> --- a/user/shared/Makefile.in
> +++ b/user/shared/Makefile.in
> @@ -84,7 +84,12 @@ drbd_buildtag.c:
>  	else									\
>  		grep return $@ ;						\
>  	fi ;									\
> -	echo -e "\t\t\" build by $$USER@$$HOSTNAME, `date "+%F %T"`\";\n}";	\
> +	if [ -z "${WANT_DRBD_REPRODUCIBLE_BUILD}" ] || [ -z "${SOURCE_DATE_EPOCH}" ] ; then \
> +		buildinfo="build by $$USER@$$HOSTNAME, `date "+%F %T"`" ; \
> +	else \
> +		buildinfo="reproducible build, `date -u -d@${SOURCE_DATE_EPOCH} "+%F %T"`" ; \
> +	fi ; \
> +	echo -e "\t\t\" $$buildinfo\";\n}";	\
>  	mv -f $@.new $@
>  

Hi Bernhard,

recently, but only visible internally so far, that changed and I split
out parts into a drbd_buildtag.h. Therefore, that patch did not apply
anymore, but I committed an equivalent version with you as author.

Regards, rck
