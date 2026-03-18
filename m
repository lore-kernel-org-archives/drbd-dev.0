Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
	[209.85.128.53])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 947F6160904
	for <drbd-dev@lists.linbit.com>; Wed, 18 Mar 2026 16:24:42 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
	5b1f17b1804b1-48541edecf9so76300225e9.1
	for <drbd-dev@lists.linbit.com>; Wed, 18 Mar 2026 08:24:42 -0700 (PDT)
Message-ID: <eeb73048-d5ae-4fbd-9920-1395a3ca51eb@linbit.com>
Date: Wed, 18 Mar 2026 16:24:39 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] drbd: fix rdma dependency
To: Arnd Bergmann <arnd@kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>
References: <20260318104858.1868731-1-arnd@kernel.org>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <20260318104858.1868731-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	drbd-dev@lists.linbit.com
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



Am 18.03.26 um 11:48 schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The new rdma transport module uses a trick to only build support
> if infiniband/rdma is enabled. This seems to be done the wrong way
> around, as it gets built if RDMA is in a loadable module, but not
> if it's built-in.
> 
> However, this fails in configurations that have infiniband support
> in a loadable module but drbd built-in:
> 
> ERROR: modpost: "rdma_bind_addr" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
> ERROR: modpost: "rdma_listen" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
> ERROR: modpost: "rdma_destroy_id" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
> ERROR: modpost: "rdma_destroy_qp" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
> ERROR: modpost: "rdma_disconnect" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
> ERROR: modpost: "__rdma_create_kernel_id" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
> ERROR: modpost: "rdma_resolve_route" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
> ERROR: modpost: "rdma_reject" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
> ERROR: modpost: "rdma_accept" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
> ERROR: modpost: "rdma_create_qp" [drivers/block/drbd/drbd_transport_rdma.ko] undefined!
> 
> Address this by moving the logic from Makefile into Kconfig and
> describing the two conditions in which rdma transport can be used
> in drbd.
> 
> Fixes: 038cb6e644e4 ("drbd: add RDMA transport implementation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/block/drbd/Kconfig  | 5 +++++
>  drivers/block/drbd/Makefile | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
> index 377f0d040031..29ec6ed84251 100644
> --- a/drivers/block/drbd/Kconfig
> +++ b/drivers/block/drbd/Kconfig
> @@ -39,6 +39,11 @@ config BLK_DEV_DRBD
>  
>  	  If unsure, say N.
>  
> +config DRBD_TRANSPORT_RDMA
> +	tristate
> +	depends on RDMA=y || (BLK_DEV_DRBD=RDMA)
> +	default BLK_DEV_DRBD
> +
>  config DRBD_FAULT_INJECTION
>  	bool "DRBD fault injection"
>  	depends on BLK_DEV_DRBD
> diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
> index 99a1cfeed423..caf888235d53 100644
> --- a/drivers/block/drbd/Makefile
> +++ b/drivers/block/drbd/Makefile
> @@ -13,4 +13,4 @@ obj-$(CONFIG_BLK_DEV_DRBD)     += drbd.o
>  
>  obj-$(CONFIG_BLK_DEV_DRBD)     += drbd_transport_tcp.o
>  obj-$(CONFIG_BLK_DEV_DRBD)     += drbd_transport_lb-tcp.o
> -obj-$(if $(CONFIG_BLK_DEV_DRBD),$(if $(CONFIG_INFINIBAND),m)) += drbd_transport_rdma.o
> +obj-$(CONFIG_DRBD_TRANSPORT_RDMA) += drbd_transport_rdma.o

Seems like we raced here, I already (supposedly?) fixed this on the
drbd-next branch.

My fix is this Kconfig:

config BLK_DEV_DRBD_RDMA
	tristate "DRBD RDMA transport"
	depends on BLK_DEV_DRBD && INFINIBAND_ADDR_TRANS
	help

	  RDMA transport support for DRBD. This enables DRBD replication
	  over RDMA-capable networks for lower latency and higher throughput.

	  If unsure, say N.

And then just this in the Makefile:

obj-$(CONFIG_BLK_DEV_DRBD_RDMA) += drbd_transport_rdma.o

That should be equivalent, right?

Thanks,
Christoph

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage

