Return-Path: <axboe@kernel.dk>
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
	[209.85.215.171])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 861884201EA
	for <drbd-dev@lists.linbit.com>; Wed, 23 Nov 2022 14:49:22 +0100 (CET)
Received: by mail-pg1-f171.google.com with SMTP id r18so16772557pgr.12
	for <drbd-dev@lists.linbit.com>; Wed, 23 Nov 2022 05:49:22 -0800 (PST)
Message-ID: <5760ca74-002a-ee41-fa46-3d8bdd5b2afe@kernel.dk>
Date: Wed, 23 Nov 2022 06:49:18 -0700
MIME-Version: 1.0
Content-Language: en-US
To: Wang ShaoBo <bobo.shaobowang@huawei.com>
References: <20221123020355.2470160-1-bobo.shaobowang@huawei.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221123020355.2470160-1-bobo.shaobowang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, lars.ellenberg@linbit.com, liwei391@huawei.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v3 0/2] drbd bugfix and cleanup.
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

On 11/22/22 7:03 PM, Wang ShaoBo wrote:
> drbd bugfix and cleanup.
> 
> v3:
>   - add out_* label for destroy_workqueue().
> 
> v2:
>   - add new patch for removing useless memset().
> 
> 
> Wang ShaoBo (2):
>   drbd: remove call to memset before free device/resource/connection
>   drbd: destroy workqueue when drbd device was freed
> 
>  drivers/block/drbd/drbd_main.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 

Patch 2/2 doesn't apply to the for-6.2/block branch. Can you respin
it?

-- 
Jens Axboe


