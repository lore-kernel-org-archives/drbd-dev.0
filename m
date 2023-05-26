Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
	[209.85.221.43])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3E41E420233
	for <drbd-dev@lists.linbit.com>; Fri, 26 May 2023 09:08:59 +0200 (CEST)
Received: by mail-wr1-f43.google.com with SMTP id
	ffacd0b85a97d-30a95ec7744so310007f8f.3
	for <drbd-dev@lists.linbit.com>; Fri, 26 May 2023 00:08:59 -0700 (PDT)
Date: Fri, 26 May 2023 09:08:57 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <ZHBbCdV/DnhOtvmF@rck.sh>
References: <20230525144915.9031-1-kvapss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525144915.9031-1-kvapss@gmail.com>
Subject: Re: [Drbd-dev] [PATCH] containers: add commands to correct SELinux
 context
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

On Thu, May 25, 2023 at 04:49:15PM +0200, Andrei Kvapil wrote:
> When running the entry.sh script with RAM-based module loading method, the
> generated modules acquire the 'var_lib_t' context by default on certain systems.
> 
> This patch adds commands to correct the context to 'modules_object_t'
> to allow seamless module loading on SELinux-enabled systems.
> 
> Co-developed-by: Vasily Oleynikov <vasily.oleynikov@flant.com>
> ---
>  docker/entry.sh | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/docker/entry.sh b/docker/entry.sh
> index 2c91734e6..978df6431 100644
> --- a/docker/entry.sh
> +++ b/docker/entry.sh
> @@ -217,6 +217,10 @@ load_from_ram() {
>  		find . -name "*.ko" -print0 | xargs -0 -n1 "/lib/modules/$(uname -r)/build/scripts/sign-file" "$CONFIG_MODULE_SIG_HASH" "${LB_SIGN}/signing_key.pem" "${LB_SIGN}/signing_key.x509" 
>  	fi
>  
> + 	chcon -t modules_object_t ./drbd.ko || true
> + 	chcon -t modules_object_t ./drbd_transport_tcp.ko || true
> + 	chcon -t modules_object_t ./drbd_transport_rdma.ko || true
> +
>  	insmod ./drbd.ko usermode_helper=disabled
>  	insmod ./drbd_transport_tcp.ko
>  	insmod ./drbd_transport_rdma.ko 2>/dev/null || true
> -- 
> 2.32.0 (Apple Git-132)

Thanks, I will queue that up for out of tree DRBD9.

Regards, rck
