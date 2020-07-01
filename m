Return-Path: <dan.j.williams@intel.com>
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
	[209.85.208.68])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A4F544203EA
	for <drbd-dev@lists.linbit.com>; Wed,  1 Jul 2020 18:08:28 +0200 (CEST)
Received: by mail-ed1-f68.google.com with SMTP id d16so13799441edz.12
	for <drbd-dev@lists.linbit.com>; Wed, 01 Jul 2020 09:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200701085947.3354405-1-hch@lst.de>
	<20200701085947.3354405-17-hch@lst.de>
In-Reply-To: <20200701085947.3354405-17-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 1 Jul 2020 09:08:17 -0700
Message-ID: <CAPcyv4hELsX=dnqppbL72Tg2k8xMm-5ZaEsxM98eQ7XPoG5NGg@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Cc: Jens Axboe <axboe@kernel.dk>, linux-xtensa@linux-xtensa.org,
	linux-nvdimm <linux-nvdimm@lists.01.org>,
	linux-s390 <linux-s390@vger.kernel.org>,
	linux-m68k@lists.linux-m68k.org, linux-nvme@lists.infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-raid <linux-raid@vger.kernel.org>,
	device-mapper development <dm-devel@redhat.com>,
	linux-bcache@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 16/20] block: move ->make_request_fn to
	struct block_device_operations
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

On Wed, Jul 1, 2020 at 2:01 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The make_request_fn is a little weird in that it sits directly in
> struct request_queue instead of an operation vector.  Replace it with
> a block_device_operations method called submit_bio (which describes much
> better what it does).  Also remove the request_queue argument to it, as
> the queue can be derived pretty trivially from the bio.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
[..]
>  drivers/nvdimm/blk.c                          |  5 +-
>  drivers/nvdimm/btt.c                          |  5 +-
>  drivers/nvdimm/pmem.c                         |  5 +-

For drivers/nvdimm

Acked-by: Dan Williams <dan.j.williams@intel.com>
