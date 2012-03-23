Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B4481106DCC4
	for <drbd-dev@lists.linbit.com>; Fri, 23 Mar 2012 11:04:32 +0100 (CET)
Date: Fri, 23 Mar 2012 11:04:32 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20120323100432.GH3743@barkeeper1-xen.linbit>
References: <1332420276-29946-1-git-send-email-florian@hastexo.com>
	<1332420276-29946-2-git-send-email-florian@hastexo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1332420276-29946-2-git-send-email-florian@hastexo.com>
Subject: Re: [Drbd-dev] [PATCH] udev rules file: skip if invoked for a
 subsystem other than block
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, Mar 22, 2012 at 01:44:36PM +0100, Florian Haas wrote:
> ---
>  scripts/drbd.rules |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/scripts/drbd.rules b/scripts/drbd.rules
> index 080635f..18708b7 100644
> --- a/scripts/drbd.rules
> +++ b/scripts/drbd.rules
> @@ -1,5 +1,7 @@
>  # This file contains the rules to create named DRBD devices.
>  
> +SUBSYSTEM!="block", GOTO="drbd_end"

I see what it does, and it probably is good practice,
or at least "polite" to do so.

Does this actually fix anything?

Do you have seen other devices with kernel provided device names
matching "drbd*" ?

"What's the point?"
Am I missing something?

> +
>  # DO NOT WRAP THIS LINE
>  #
>  # old udev does not understand some of it,
> @@ -13,3 +15,5 @@
>  #
>  # DO NOT WRAP THIS LINE
>  KERNEL=="drbd*", IMPORT{program}="/sbin/drbdadm sh-udev minor-%m", NAME="$env{DEVICE}", SYMLINK="drbd/by-res/$env{RESOURCE} drbd/by-disk/$env{DISK}"
> +
> +LABEL="drbd_end"
