Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7DF9C1011BF5
	for <drbd-dev@lists.linbit.com>; Thu, 25 Apr 2019 12:49:47 +0200 (CEST)
Received: by mail-wm1-f68.google.com with SMTP id z6so1411114wmi.0
	for <drbd-dev@lists.linbit.com>; Thu, 25 Apr 2019 03:49:46 -0700 (PDT)
Date: Thu, 25 Apr 2019 12:43:21 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20190425104320.s2dahoydcw5oztbl@rck.sh>
References: <00660ec7-ef62-e376-2e2c-71e42f2f649b@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00660ec7-ef62-e376-2e2c-71e42f2f649b@i-love.sakura.ne.jp>
Subject: Re: [Drbd-dev] [PATCH] drbd: Avoid GFP_KERNEL allocation from
 alloc_send_buffer()
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

On Thu, Apr 25, 2019 at 06:29:11PM +0900, Tetsuo Handa wrote:
>  drbd/drbd_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
> index 80afdd8a..d48a5ea3 100644
> --- a/drbd/drbd_main.c
> +++ b/drbd/drbd_main.c
> @@ -966,7 +966,7 @@ static void new_or_recycle_send_buffer_page(struct drbd_send_buffer *sbuf)
>  		if (count == 1)
>  			goto have_page;
>  
> -		page = alloc_page(GFP_KERNEL);
> +		page = alloc_page(GFP_ATOMIC);
>  		if (page) {
>  			put_page(sbuf->page);
>  			sbuf->page = page;

Thanks for reporting and a proposed fix. By coincidence this was already
fixed by Phil in our internal tree like this:

> -		page = alloc_page(GFP_KERNEL);
> +		page = alloc_page(GFP_NOIP | __GFP_NOWARN);

Regards, rck
