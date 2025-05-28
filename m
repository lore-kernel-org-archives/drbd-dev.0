Return-Path: <roland.kammerer@linbit.com>
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
	[209.85.167.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 779DB160650
	for <drbd-dev@lists.linbit.com>; Wed, 28 May 2025 10:03:39 +0200 (CEST)
Received: by mail-lf1-f46.google.com with SMTP id
	2adb3069b0e04-55324587a53so793631e87.0
	for <drbd-dev@lists.linbit.com>; Wed, 28 May 2025 01:03:39 -0700 (PDT)
Date: Wed, 28 May 2025 10:03:37 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [PATCH v2 1/2] build: changing SUSE release file
Message-ID: <aDbDWc6dB05icJgO@arm64>
References: <20250515024817.25717-1-heming.zhao@suse.com>
	<20250515024817.25717-2-heming.zhao@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515024817.25717-2-heming.zhao@suse.com>
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, May 15, 2025 at 10:48:14AM +0800, Heming Zhao wrote:
> This commit changes /etc/SuSe-release to /etc/os-release.
> The SuSe-release file disappeared a long time ago.
> 
> Signed-off-by: Heming Zhao <heming.zhao@suse.com>
> ---
>  configure.ac | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 282fdf1584e3..883fe3e5cdb3 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -402,7 +402,7 @@ else
>     if test -z $DISTRO; then
>        AC_CHECK_FILE(/etc/redhat-release, [DISTRO="redhat"])
>        AC_CHECK_FILE(/etc/debian_version, [DISTRO="debian"])
> -      AC_CHECK_FILE(/etc/SuSE-release, [DISTRO="suse"])
> +      AC_CHECK_FILE(/etc/os-release, [DISTRO="suse"])

Hi,

everything that has a /etc/os-release (which by now is basically every
distribution on this planet) is suse? No.

This (not only this) part of the automagic in drbd-utils is a mess and
I'm currently in the process of cleaning that up a bit. I will not take
this patch as is, IMO it is just wrong, please just wait, this should
improve in a week or two.

Regards, rck
