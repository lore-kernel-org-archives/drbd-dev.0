Return-Path: <axboe@kernel.dk>
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
	[209.85.214.193])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 73FCD42032F
	for <drbd-dev@lists.linbit.com>; Tue, 30 Jun 2020 15:54:50 +0200 (CEST)
Received: by mail-pl1-f193.google.com with SMTP id u9so4895748pls.13
	for <drbd-dev@lists.linbit.com>; Tue, 30 Jun 2020 06:54:49 -0700 (PDT)
To: Christoph Hellwig <hch@lst.de>
References: <20200629193947.2705954-1-hch@lst.de>
	<20200629193947.2705954-12-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <70e8de25-4e26-9c00-1492-e433ebfdbc90@kernel.dk>
Date: Tue, 30 Jun 2020 07:54:46 -0600
MIME-Version: 1.0
In-Reply-To: <20200629193947.2705954-12-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: linux-bcache@vger.kernel.org, linux-xtensa@linux-xtensa.org,
	linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org,
	dm-devel@redhat.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 11/20] fs: remove a weird comment in
	submit_bh_wbc
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

On 6/29/20 1:39 PM, Christoph Hellwig wrote:
> All bios can get remapped if submitted to partitions.  No need to
> comment on that.

I'm pretty sure that comment is from me, dating back to when the bio
code was introduced in 2001. The point wasn't the remapping, just
that from here on down the IO was purely bio based, not buffer_heads.
Anyway, totally agree that it should just die, it's not that
interesting or useful anymore.

-- 
Jens Axboe

