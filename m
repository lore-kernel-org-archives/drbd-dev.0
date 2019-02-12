Return-Path: <axboe@kernel.dk>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EE25B103B4AE
	for <drbd-dev@lists.linbit.com>; Tue, 12 Feb 2019 23:01:06 +0100 (CET)
Received: by mail-pg1-f195.google.com with SMTP id r11so107937pgp.6
	for <drbd-dev@lists.linbit.com>; Tue, 12 Feb 2019 14:01:06 -0800 (PST)
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
References: <20190212212820.GA15942@embeddedor>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4a4429a8-56d4-b349-444c-282246537121@kernel.dk>
Date: Tue, 12 Feb 2019 14:36:20 -0700
MIME-Version: 1.0
In-Reply-To: <20190212212820.GA15942@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd_receiver: mark expected switch
	fall-throughs
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

On 2/12/19 2:28 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/block/drbd/drbd_receiver.c: In function ‘drbd_asb_recover_0p’:
> drivers/block/drbd/drbd_receiver.c:3093:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (self == 1 && peer == 0) {
>       ^
> drivers/block/drbd/drbd_receiver.c:3098:2: note: here
>   case ASB_DISCARD_OLDER_PRI:
>   ^~~~
> drivers/block/drbd/drbd_receiver.c:3120:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (after_sb_0p == ASB_DISCARD_ZERO_CHG)
>       ^
> drivers/block/drbd/drbd_receiver.c:3123:2: note: here
>   case ASB_DISCARD_LEAST_CHG:
>   ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> Notice that in some cases, the code comment is modified in
> accordance with what GCC is expecting to find.
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/block/drbd/drbd_receiver.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index c7ad88d91a09..78bb763a367d 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -3094,7 +3094,7 @@ static int drbd_asb_recover_0p(struct drbd_peer_device *peer_device) __must_hold
>  			rv =  1;
>  			break;
>  		}
> -		/* Else fall through to one of the other strategies... */
> +		/* Else fall through - to one of the other strategies... */
>  	case ASB_DISCARD_OLDER_PRI:
>  		if (self == 0 && peer == 1) {
>  			rv = 1;
> @@ -3119,7 +3119,7 @@ static int drbd_asb_recover_0p(struct drbd_peer_device *peer_device) __must_hold
>  		}
>  		if (after_sb_0p == ASB_DISCARD_ZERO_CHG)
>  			break;
> -		/* else: fall through */
> +		/* Else fall through */

This is getting really silly, as these two hunks both aptly demonstrate. Can
we please inject some sanity into this fall through witch hunt?

The last hunk is updating ANOTHER patch that also attempted to silence this
stuff.

-- 
Jens Axboe

