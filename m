Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
	[209.85.128.48])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 35430160904
	for <drbd-dev@lists.linbit.com>; Wed, 18 Mar 2026 16:36:35 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
	5b1f17b1804b1-486507134e4so24073995e9.0
	for <drbd-dev@lists.linbit.com>; Wed, 18 Mar 2026 08:36:35 -0700 (PDT)
Message-ID: <faf5b12f-03a2-4d8c-b333-7fc275ec3191@linbit.com>
Date: Wed, 18 Mar 2026 16:36:32 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] drbd: fix rdma dependency
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>
References: <20260318104858.1868731-1-arnd@kernel.org>
	<eeb73048-d5ae-4fbd-9920-1395a3ca51eb@linbit.com>
	<c3daa9b5-3741-4a18-9bbc-7bad1a2e0c1b@app.fastmail.com>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <c3daa9b5-3741-4a18-9bbc-7bad1a2e0c1b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Am 18.03.26 um 16:31 schrieb Arnd Bergmann:
> On Wed, Mar 18, 2026, at 16:24, Christoph Böhmwalder wrote:
>> Am 18.03.26 um 11:48 schrieb Arnd Bergmann:
>>
>> Seems like we raced here, I already (supposedly?) fixed this on the
>> drbd-next branch.
> 
> Ok, I assume that will be in linux-next

Correct, should land there today.

> 
>> My fix is this Kconfig:
>>
>> config BLK_DEV_DRBD_RDMA
>> 	tristate "DRBD RDMA transport"
>> 	depends on BLK_DEV_DRBD && INFINIBAND_ADDR_TRANS
>> 	help
>>
>> 	  RDMA transport support for DRBD. This enables DRBD replication
>> 	  over RDMA-capable networks for lower latency and higher throughput.
>>
>> 	  If unsure, say N.
>>
>> And then just this in the Makefile:
>>
>> obj-$(CONFIG_BLK_DEV_DRBD_RDMA) += drbd_transport_rdma.o
>>
>> That should be equivalent, right?
> 
> It's close but not the same: 
> 
> - INFINIBAND_ADDR_TRANS is a 'bool' symbol that can still be =y
>   when CONFIG_INFINIBAND=m, so you'd still fail to build
>   BLK_DEV_DRBD_RDMA. You still need a dependency on INFINIBAND
>   (the tristate symbol) itself, though you probably also
>   need the INFINIBAND_ADDR_TRANS one that I missed
> 
> - I incorrectly assumed from the earlier Makefile logic
>   that the rdma transport exports symbols that are used
>   by the common drbd code, but I now see that the opposite
>   is the case. The difference is that for the case of
>   BLK_DEV_DRBD=y, CONFIG_INFINIBAND=m, my version force-disabled
>   the RDMA transport, while it should be in a loadable module.
> 
> It seems both versions are wrong then, but just adding
> 'depends on INFINIBAND' on top of yours should fix it.

Yes, ADDR_TRANS is needed because we need the infiniband "cm"
infrastructure (for rdma_connect et al).
Right, I did not catch that we need CONFIG_INFINIBAND separately as
well, but that seems logical.
I applied the combined fix now.

Thanks,
Christoph

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage

