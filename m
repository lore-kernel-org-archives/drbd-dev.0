Return-Path: <arnd@arndb.de>
Received: from fhigh-a6-smtp.messagingengine.com
	(fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 4DA5C160904
	for <drbd-dev@lists.linbit.com>; Wed, 18 Mar 2026 16:39:18 +0100 (CET)
MIME-Version: 1.0
Date: Wed, 18 Mar 2026 16:31:31 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	"Arnd Bergmann" <arnd@kernel.org>,
	"Philipp Reisner" <philipp.reisner@linbit.com>,
	"Lars Ellenberg" <lars.ellenberg@linbit.com>,
	"Jens Axboe" <axboe@kernel.dk>
Message-Id: <c3daa9b5-3741-4a18-9bbc-7bad1a2e0c1b@app.fastmail.com>
In-Reply-To: <eeb73048-d5ae-4fbd-9920-1395a3ca51eb@linbit.com>
References: <20260318104858.1868731-1-arnd@kernel.org>
	<eeb73048-d5ae-4fbd-9920-1395a3ca51eb@linbit.com>
Subject: Re: [PATCH 1/2] drbd: fix rdma dependency
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
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

On Wed, Mar 18, 2026, at 16:24, Christoph B=C3=B6hmwalder wrote:
> Am 18.03.26 um 11:48 schrieb Arnd Bergmann:
>
> Seems like we raced here, I already (supposedly?) fixed this on the
> drbd-next branch.

Ok, I assume that will be in linux-next

> My fix is this Kconfig:
>
> config BLK_DEV_DRBD_RDMA
> 	tristate "DRBD RDMA transport"
> 	depends on BLK_DEV_DRBD && INFINIBAND_ADDR_TRANS
> 	help
>
> 	  RDMA transport support for DRBD. This enables DRBD replication
> 	  over RDMA-capable networks for lower latency and higher throughput.
>
> 	  If unsure, say N.
>
> And then just this in the Makefile:
>
> obj-$(CONFIG_BLK_DEV_DRBD_RDMA) +=3D drbd_transport_rdma.o
>
> That should be equivalent, right?

It's close but not the same:=20

- INFINIBAND_ADDR_TRANS is a 'bool' symbol that can still be =3Dy
  when CONFIG_INFINIBAND=3Dm, so you'd still fail to build
  BLK_DEV_DRBD_RDMA. You still need a dependency on INFINIBAND
  (the tristate symbol) itself, though you probably also
  need the INFINIBAND_ADDR_TRANS one that I missed

- I incorrectly assumed from the earlier Makefile logic
  that the rdma transport exports symbols that are used
  by the common drbd code, but I now see that the opposite
  is the case. The difference is that for the case of
  BLK_DEV_DRBD=3Dy, CONFIG_INFINIBAND=3Dm, my version force-disabled
  the RDMA transport, while it should be in a loadable module.

It seems both versions are wrong then, but just adding
'depends on INFINIBAND' on top of yours should fix it.

        Arnd
