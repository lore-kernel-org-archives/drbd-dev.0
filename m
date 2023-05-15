Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
	[209.85.128.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id C9AC64203AB
	for <drbd-dev@lists.linbit.com>; Mon, 15 May 2023 10:57:22 +0200 (CEST)
Received: by mail-wm1-f41.google.com with SMTP id
	5b1f17b1804b1-3f42c865534so66132545e9.2
	for <drbd-dev@lists.linbit.com>; Mon, 15 May 2023 01:57:22 -0700 (PDT)
Message-ID: <2ec28ec3-1e22-e772-fc9a-d59c6d176b7d@linbit.com>
Date: Mon, 15 May 2023 10:56:20 +0200
MIME-Version: 1.0
To: mirimmad@outlook.com
References: <CY5PR12MB64555F99E4FEF60569050F1FC67B9@CY5PR12MB6455.namprd12.prod.outlook.com>
	<CY5PR12MB64558DB2E8ACBD592F26E61AC67B9@CY5PR12MB6455.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <CY5PR12MB64558DB2E8ACBD592F26E61AC67B9@CY5PR12MB6455.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, skhan@linuxfoundation.org,
	lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com, mirimmad17@gmail.com
Subject: Re: [Drbd-dev] [PATCH v2] drdb: fix debugfs_create_dir and
 debugfs_create_symlink error handling
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

Am 14.05.23 um 16:10 schrieb mirimmad@outlook.com:
> From: Immad Mir <mirimmad17@gmail.com>
> 
> debugfs_create_dir and debugfs_create_symlink return ERR_PTR incase of
> a failure which must be checked with the inline function IS_ERR. This
> patch attempts to do the same.
> 
> Signed-off-by: Immad Mir <mirimmad17@gmail.com>
> ---
> Changes in v2:
>     - Fix indentation
>     - Fix potential memory leak
> 
>  drivers/block/drbd/drbd_debugfs.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
> index 12460b584..ab431a3f2 100644
> --- a/drivers/block/drbd/drbd_debugfs.c
> +++ b/drivers/block/drbd/drbd_debugfs.c
> @@ -781,6 +781,7 @@ void drbd_debugfs_device_add(struct drbd_device *device)
> 
>  	snprintf(vnr_buf, sizeof(vnr_buf), "%u", device->vnr);
>  	dentry = debugfs_create_dir(vnr_buf, vols_dir);
> +    if (IS_ERR(dentry)) goto fail;
>  	device->debugfs_vol = dentry;
> 
>  	snprintf(minor_buf, sizeof(minor_buf), "%u", device->minor);
> @@ -789,9 +790,15 @@ void drbd_debugfs_device_add(struct drbd_device *device)
>  	if (!slink_name)
>  		goto fail;
>  	dentry = debugfs_create_symlink(minor_buf, drbd_debugfs_minors, slink_name);
> -	device->debugfs_minor = dentry;
> -	kfree(slink_name);
> -	slink_name = NULL;
> +    if (!IS_ERR(dentry)) {
> +        device->debugfs_minor = dentry;
> +        kfree(slink_name);
> +        slink_name = NULL;
> +    } else {
> +        kfree(slink_name);
> +        slink_name = NULL;
> +        goto fail;
> +    }
> 
>  #define DCF(name)	do {					\
>  	dentry = debugfs_create_file(#name, 0440,	\
> --
> 2.40.0
> 
> 

Hi, thanks for the patch.

Please see this commit:

commit d27e84a305980ac61df0a6841059d0eb09b8283d
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Tue Jun 18 17:45:49 2019 +0200

    block: drbd: no need to check return value of debugfs_create functions

    When calling debugfs functions, there is no need to ever check the
    return value.  The function can work or not, but the code logic should
    never do something different based on this.

Also, it still looks like that whitespace is garbled.

NAK.

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
