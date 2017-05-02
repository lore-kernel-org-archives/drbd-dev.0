Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B16F51056446
	for <drbd-dev@lists.linbit.com>; Tue,  2 May 2017 10:52:39 +0200 (CEST)
Received: by mail-wm0-f42.google.com with SMTP id w64so105197257wma.0
	for <drbd-dev@lists.linbit.com>; Tue, 02 May 2017 01:52:39 -0700 (PDT)
Date: Tue, 2 May 2017 10:44:16 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20170502084415.GA19200@rck.sh>
References: <mailman.1499.1493662700.15553.drbd-dev@lists.linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mailman.1499.1493662700.15553.drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH] drbd: Use seq_putc() once more in
 drbd_syncer_progress()
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

On Mon, May 01, 2017 at 08:18:20PM +0200, elfring@users.sourceforge.net wrote:
> From: SF Markus Elfring <elfring@users.sourceforge.net>
> Subject: [PATCH] drbd: Use seq_putc() once more in drbd_syncer_progress()
> Date: Mon, 1 May 2017 20:12:58 +0200
> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
>  Thunderbird/52.0.1
> 
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 1 May 2017 20:05:08 +0200
> 
> A single dot should be put into a sequence.
> Thus use the corresponding function "seq_putc".
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/block/drbd/drbd_proc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
> index 8378142f7a55..fc0f627567fd 100644
> --- a/drivers/block/drbd/drbd_proc.c
> +++ b/drivers/block/drbd/drbd_proc.c
> @@ -127,7 +127,7 @@ static void drbd_syncer_progress(struct drbd_device *device, struct seq_file *se
>  		seq_putc(seq, '=');
>  	seq_putc(seq, '>');
>  	for (i = 0; i < y; i++)
> -		seq_printf(seq, ".");
> +		seq_putc(seq, '.');
>  	seq_puts(seq, "] ");
>  
>  	if (state.conn == C_VERIFY_S || state.conn == C_VERIFY_T)

Thanks, applied internally, will be upstream eventually.

Regards, rck
