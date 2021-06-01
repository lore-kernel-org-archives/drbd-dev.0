Return-Path: <axboe@kernel.dk>
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
	[209.85.167.178])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 15C634205C9
	for <drbd-dev@lists.linbit.com>; Tue,  1 Jun 2021 15:48:10 +0200 (CEST)
Received: by mail-oi1-f178.google.com with SMTP id c3so15523482oic.8
	for <drbd-dev@lists.linbit.com>; Tue, 01 Jun 2021 06:48:10 -0700 (PDT)
To: Christoph Hellwig <hch@lst.de>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jim Paris <jim@jtan.com>,
	Joshua Morris <josh.h.morris@us.ibm.com>,
	Philip Kelleher <pjk1939@linux.ibm.com>, Minchan Kim <minchan@kernel.org>,
	Nitin Gupta <ngupta@vflare.org>, Matias Bjorling <mb@lightnvm.io>,
	Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
	Song Liu <song@kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>
References: <20210521055116.1053587-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a5d7127f-b422-5556-6810-cf4c98c038ac@kernel.dk>
Date: Tue, 1 Jun 2021 07:48:09 -0600
MIME-Version: 1.0
In-Reply-To: <20210521055116.1053587-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: linux-bcache@vger.kernel.org, linux-xtensa@linux-xtensa.org,
	linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-s390@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	linuxppc-dev@lists.ozlabs.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] simplify gendisk and request_queue allocation for
 bio based drivers
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

On 5/20/21 11:50 PM, Christoph Hellwig wrote:
> Hi all,
> 
> this series is the first part of cleaning up lifetimes and allocation of
> the gendisk and request_queue structure.  It adds a new interface to
> allocate the disk and queue together for bio based drivers, and a helper
> for cleanup/free them when a driver is unloaded or a device is removed.
> 
> Together this removes the need to treat the gendisk and request_queue
> as separate entities for bio based drivers.

Applied, thanks.

-- 
Jens Axboe

