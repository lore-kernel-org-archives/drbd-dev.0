Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D7A8D1057FCB
	for <drbd-dev@lists.linbit.com>; Tue, 25 Apr 2017 09:06:04 +0200 (CEST)
Received: by mail-wm0-f54.google.com with SMTP id u65so14359780wmu.1
	for <drbd-dev@lists.linbit.com>; Tue, 25 Apr 2017 00:06:04 -0700 (PDT)
Date: Tue, 25 Apr 2017 09:06:02 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Heloise <os@iscas.ac.cn>
Message-ID: <20170425070602.GA3987@soda.linbit>
References: <1493102118-8086-1-git-send-email-os@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493102118-8086-1-git-send-email-os@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, philipp.reisner@linbit.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drivers:block:drbd:drbd_state:fix
 null-pointer dereference
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

On Mon, Apr 24, 2017 at 11:35:18PM -0700, Heloise wrote:
> Signed-off-by: Heloise <os@iscas.ac.cn>
> 
> In is_valid_state(), there is NULL validation for the variable nc
> "if (nc)". However,the code will continue to execute when nc is NULL.
> nc->verify_alg[0] is used in subsequent code, which may cause
> null-pointer dereference, fix it.
> ---
>  drivers/block/drbd/drbd_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
> index eea0c4a..1963b83 100644
> --- a/drivers/block/drbd/drbd_state.c
> +++ b/drivers/block/drbd/drbd_state.c
> @@ -845,7 +845,7 @@ is_valid_state(struct drbd_device *device, union drbd_state ns)
>  		rv = SS_CONNECTED_OUTDATES;
>  
>  	else if ((ns.conn == C_VERIFY_S || ns.conn == C_VERIFY_T) &&
> -		 (nc->verify_alg[0] == 0))
> +		 (nc != NULL && nc->verify_alg[0] == 0))


What the static checker cannot know:
ns.conn != C_STANDALONE implies nc != NULL.

But if you feel like it, the additional check won't hurt.

Thanks,

    Lars

