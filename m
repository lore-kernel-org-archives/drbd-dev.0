Return-Path: <jcmvbkbc@gmail.com>
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
	[209.85.208.52])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 87DBD42095C
	for <drbd-dev@lists.linbit.com>; Tue, 28 Sep 2021 00:50:48 +0200 (CEST)
Received: by mail-ed1-f52.google.com with SMTP id v10so71018197edj.10
	for <drbd-dev@lists.linbit.com>; Mon, 27 Sep 2021 15:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210927220110.1066271-1-mcgrof@kernel.org>
	<20210927220110.1066271-7-mcgrof@kernel.org>
In-Reply-To: <20210927220110.1066271-7-mcgrof@kernel.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 27 Sep 2021 15:50:36 -0700
Message-ID: <CAMo8BfLX84HBuVe=FyqWkVU5Ek-aKFk++omnqsmf9wO6fdVpMQ@mail.gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Ulf Hansson <ulf.hansson@linaro.org>, justin@coraid.com,
	LKML <linux-kernel@vger.kernel.org>, krisman@collabora.com,
	tim@cyberelk.net, drbd-dev@lists.linbit.com,
	Richard Weinberger <richard@nod.at>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	"open list:TENSILICA XTENSA PORT \(xtensa\)"
	<linux-xtensa@linux-xtensa.org>, johannes.berg@intel.com,
	Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
	linux-block@vger.kernel.org,
	"open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
	hare@suse.de, Jens Axboe <axboe@kernel.dk>,
	Chris Zankel <chris@zankel.net>, philipp.reisner@linbit.com,
	chris.obbard@collabora.com, Tejun Heo <tj@kernel.org>,
	lars.ellenberg@linbit.com, thehajime@gmail.com, zhuyifei1999@gmail.com
Subject: Re: [Drbd-dev] [PATCH v2 06/15] xtensa/platforms/iss/simdisk: add
 error handling support for add_disk()
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

On Mon, Sep 27, 2021 at 3:01 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  arch/xtensa/platforms/iss/simdisk.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
