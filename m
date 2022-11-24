Return-Path: <axboe@kernel.dk>
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
	[209.85.216.49])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1655742095E
	for <drbd-dev@lists.linbit.com>; Thu, 24 Nov 2022 14:42:43 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
	v3-20020a17090ac90300b00218441ac0f6so5859737pjt.0
	for <drbd-dev@lists.linbit.com>; Thu, 24 Nov 2022 05:42:42 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Wang ShaoBo <bobo.shaobowang@huawei.com>
In-Reply-To: <20221124015817.2729789-1-bobo.shaobowang@huawei.com>
References: <20221124015817.2729789-1-bobo.shaobowang@huawei.com>
Message-Id: <166929736095.99094.10688536519822817206.b4-ty@kernel.dk>
Date: Thu, 24 Nov 2022 06:42:40 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, lars.ellenberg@linbit.com, liwei391@huawei.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v4 0/2] drbd bugfix and cleanup.
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

On Thu, 24 Nov 2022 09:58:15 +0800, Wang ShaoBo wrote:
> drbd bugfix and cleanup.
> 
> v4:
>   - solve conflict in applying patch [2/2] to for-6.2/block branch
> 
> v3:
>   - add out_* label for destroy_workqueue().
> 
> [...]

Applied, thanks!

[1/2] drbd: remove call to memset before free device/resource/connection
      commit: 6e7b854e4c1b02dba00760dfa79d8dbf6cce561e
[2/2] drbd: destroy workqueue when drbd device was freed
      commit: 8692814b77ca4228a99da8a005de0acf40af6132

Best regards,
-- 
Jens Axboe


