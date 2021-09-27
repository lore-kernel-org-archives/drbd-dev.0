Return-Path: <axboe@kernel.dk>
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com
	[209.85.166.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 52CA4420626
	for <drbd-dev@lists.linbit.com>; Tue, 28 Sep 2021 00:29:35 +0200 (CEST)
Received: by mail-io1-f46.google.com with SMTP id 134so24786439iou.12
	for <drbd-dev@lists.linbit.com>; Mon, 27 Sep 2021 15:29:35 -0700 (PDT)
To: Luis Chamberlain <mcgrof@kernel.org>, justin@coraid.com,
	geert@linux-m68k.org, ulf.hansson@linaro.org, hare@suse.de, tj@kernel.org,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com, jdike@addtoit.com,
	richard@nod.at, anton.ivanov@cambridgegreys.com, johannes.berg@intel.com,
	chris.obbard@collabora.com, krisman@collabora.com, zhuyifei1999@gmail.com,
	thehajime@gmail.com, chris@zankel.net, jcmvbkbc@gmail.com, tim@cyberelk.net
References: <20210927220110.1066271-1-mcgrof@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ee2c245d-7190-b708-4c48-cbee28f56f9a@kernel.dk>
Date: Mon, 27 Sep 2021 16:29:33 -0600
MIME-Version: 1.0
In-Reply-To: <20210927220110.1066271-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v2 00/15] block: third batch of add_disk()
 error handling conversions
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

On 9/27/21 4:00 PM, Luis Chamberlain wrote:
> This is the 2nd version of the third batch of driver conversions for the
> add_disk() error handling. This and the entire 7th series of driver
> conversions can be found on my 20210927-for-axboe-add-disk-error-handling
> branch [0].

Applied 2, 4, 7, 8-15.

-- 
Jens Axboe

