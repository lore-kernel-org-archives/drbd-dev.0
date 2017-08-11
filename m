Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 14B131057FE2
	for <drbd-dev@lists.linbit.com>; Fri, 11 Aug 2017 09:45:59 +0200 (CEST)
Received: by mail-wm0-f42.google.com with SMTP id i66so40655030wmg.0
	for <drbd-dev@lists.linbit.com>; Fri, 11 Aug 2017 00:45:59 -0700 (PDT)
Date: Fri, 11 Aug 2017 09:45:57 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: Nick Wang <nwang@suse.com>
Message-ID: <20170811074557.GD15992@rck.sh>
References: <20170811042610.3956-1-nwang@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170811042610.3956-1-nwang@suse.com>
Cc: jfehlig@suse.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] block-drbd: Fix block-drbd remove command
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

On Fri, Aug 11, 2017 at 12:26:10PM +0800, Nick Wang wrote:
> Similar to a previous fix for the add command, strip any 'drbd:'
> prefix from the resource identifier read from xenstore. Otherwise
> the remove command can fail, leaving the resource in Primary role.
> This presents a data hazard if a VM is migrated to another host,
> where the resource will also be placed in Primary role.
> 
> Signed-off-by: Jim Fehlig <jfehlig@suse.com>
> Signed-off-by: Nick Wang <nwang@suse.com>
> CC: Lars Ellenberg <lars.ellenberg@linbit.com>
> CC: Roland Kammerer <roland.kammerer@linbit.com>
> CC: drbd-dev@lists.linbit.com
> 
> ---
>  scripts/block-drbd | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/block-drbd b/scripts/block-drbd
> index 11ec057f..23364cd6 100755
> --- a/scripts/block-drbd
> +++ b/scripts/block-drbd
> @@ -284,7 +284,7 @@ case "$command" in
>      case $t in 
>        drbd|phy)
>          p=$(xenstore_read "$XENBUS_PATH/params")
> -        drbd_resource=$p
> +        drbd_resource=${p#drbd:}
>          drbd_role="$(drbdadm role $drbd_resource)"
>          drbd_lrole="${drbd_role%%/*}"
>          drbd_dev="$(drbdadm sh-dev $drbd_resource)"

I squashed that with your previous one.

Thanks, rck
