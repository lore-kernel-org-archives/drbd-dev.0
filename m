Return-Path: <axboe@kernel.dk>
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com
	[209.85.166.50])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7C05C42038D
	for <drbd-dev@lists.linbit.com>; Tue, 28 Sep 2021 01:24:01 +0200 (CEST)
Received: by mail-io1-f50.google.com with SMTP id r75so24994356iod.7
	for <drbd-dev@lists.linbit.com>; Mon, 27 Sep 2021 16:24:01 -0700 (PDT)
To: Max Filippov <jcmvbkbc@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>
References: <20210927220110.1066271-1-mcgrof@kernel.org>
	<20210927220110.1066271-7-mcgrof@kernel.org>
	<CAMo8BfLX84HBuVe=FyqWkVU5Ek-aKFk++omnqsmf9wO6fdVpMQ@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7889116c-c01a-a041-89f3-4390b16c6ac0@kernel.dk>
Date: Mon, 27 Sep 2021 17:24:00 -0600
MIME-Version: 1.0
In-Reply-To: <CAMo8BfLX84HBuVe=FyqWkVU5Ek-aKFk++omnqsmf9wO6fdVpMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
	hare@suse.de, Chris Zankel <chris@zankel.net>,
	philipp.reisner@linbit.com, chris.obbard@collabora.com,
	Tejun Heo <tj@kernel.org>, lars.ellenberg@linbit.com,
	thehajime@gmail.com, zhuyifei1999@gmail.com
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

On 9/27/21 4:50 PM, Max Filippov wrote:
> On Mon, Sep 27, 2021 at 3:01 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>
>> We never checked for errors on add_disk() as this function
>> returned void. Now that this is fixed, use the shiny new
>> error handling.
>>
>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>> ---
>>  arch/xtensa/platforms/iss/simdisk.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>

Applied, thanks.

-- 
Jens Axboe

