Return-Path: <axboe@kernel.dk>
Received: from mail-it1-f196.google.com (mail-it1-f196.google.com
	[209.85.166.196])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3C5511013836
	for <drbd-dev@lists.linbit.com>; Wed, 10 Oct 2018 22:19:57 +0200 (CEST)
Received: by mail-it1-f196.google.com with SMTP id l127-v6so16954293ith.1
	for <drbd-dev@lists.linbit.com>; Wed, 10 Oct 2018 13:19:57 -0700 (PDT)
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <CGME20181009144103eucas1p1dbf48b04c923877cdbdcf2197725ccd1@eucas1p1.samsung.com>
	<20181009144103eucas1p1dbf48b04c923877cdbdcf2197725ccd1~b97cjWjY10058900589eucas1p1n@eucas1p1.samsung.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e8e215f7-5ab3-9293-3a86-7a935ff78a3b@kernel.dk>
Date: Wed, 10 Oct 2018 14:12:02 -0600
MIME-Version: 1.0
In-Reply-To: <20181009144103eucas1p1dbf48b04c923877cdbdcf2197725ccd1~b97cjWjY10058900589eucas1p1n@eucas1p1.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Minchan Kim <minchan@kernel.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Nitin Gupta <ngupta@vflare.org>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drivers/block: remove redundant 'default n'
 from Kconfig-s
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 10/9/18 8:41 AM, Bartlomiej Zolnierkiewicz wrote:
> 'default n' is the default value for any bool or tristate Kconfig
> setting so there is no need to write it explicitly.
> 
> Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
> is not set' for visible symbols") the Kconfig behavior is the same
> regardless of 'default n' being present or not:
> 
>     ...
>     One side effect of (and the main motivation for) this change is making
>     the following two definitions behave exactly the same:
>     
>         config FOO
>                 bool
>     
>         config FOO
>                 bool
>                 default n
>     
>     With this change, neither of these will generate a
>     '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
>     That might make it clearer to people that a bare 'default n' is
>     redundant.
>     ...

Applied, thanks.

-- 
Jens Axboe

