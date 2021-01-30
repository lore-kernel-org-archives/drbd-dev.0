Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0065.hostedemail.com
	[216.40.44.65])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 40015420069
	for <drbd-dev@lists.linbit.com>; Sat, 30 Jan 2021 20:10:53 +0100 (CET)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
	[10.5.19.251])
	by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 673828009649
	for <drbd-dev@lists.linbit.com>; Sat, 30 Jan 2021 18:57:53 +0000 (UTC)
Message-ID: <5deee552f4bcfd81c6dc6ec3e8139c0c4ba27d31.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Jiri Kosina <trivial@kernel.org>, Philipp Reisner
	<philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Sat, 30 Jan 2021 10:57:48 -0800
In-Reply-To: <1c8081264d82101d7837220c5ee221c307da5d91.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
	<1c8081264d82101d7837220c5ee221c307da5d91.1598331148.git.joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 06/29] drbd: Avoid comma separated statements
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

On Mon, 2020-08-24 at 21:56 -0700, Joe Perches wrote:
> Use semicolons and braces.

ping?

> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/block/drbd/drbd_receiver.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index 422363daa618..87f732fb5456 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -111,8 +111,10 @@ static struct page *page_chain_tail(struct page *page, int *len)
>  {
>  	struct page *tmp;
>  	int i = 1;
> -	while ((tmp = page_chain_next(page)))
> -		++i, page = tmp;
> +	while ((tmp = page_chain_next(page))) {
> +		++i;
> +		page = tmp;
> +	}
>  	if (len)
>  		*len = i;
>  	return page;


