Return-Path: <jcmvbkbc@gmail.com>
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
	[209.85.208.49])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CCA0442179D
	for <drbd-dev@lists.linbit.com>; Thu,  3 Mar 2022 15:49:46 +0100 (CET)
Received: by mail-ed1-f49.google.com with SMTP id w4so4403199edc.7
	for <drbd-dev@lists.linbit.com>; Thu, 03 Mar 2022 06:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20220303111905.321089-1-hch@lst.de>
	<20220303111905.321089-2-hch@lst.de>
In-Reply-To: <20220303111905.321089-2-hch@lst.de>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 3 Mar 2022 06:48:34 -0800
Message-ID: <CAMo8BfKgtEVU2qpu3BQqQB7cxtPzF-Hmuifr4xEhe0TRiyJ=WQ@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Cc: Jens Axboe <axboe@kernel.dk>, Chris Zankel <chris@zankel.net>,
	Justin Sanders <justin@coraid.com>,
	"open list:TENSILICA XTENSA PORT \(xtensa\)"
	<linux-xtensa@linux-xtensa.org>, Vishal Verma <vishal.l.verma@intel.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Denis Efremov <efremov@linux.com>, Coly Li <colyli@suse.de>,
	linux-block@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Nitin Gupta <ngupta@vflare.org>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 01/10] iss-simdisk: use bvec_kmap_local in
	simdisk_submit_bio
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

On Thu, Mar 3, 2022 at 3:19 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Using local kmaps slightly reduces the chances to stray writes, and
> the bvec interface cleans up the code a little bit.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  arch/xtensa/platforms/iss/simdisk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
