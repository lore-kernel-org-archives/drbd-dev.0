Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Date: Mon, 04 Mar 2013 21:31:09 +0100
Message-ID: <9738633.yZ4agRkgQF@quad>
In-Reply-To: <1362173982-26454-1-git-send-email-khoroshilov@ispras.ru>
References: <1362173982-26454-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: ldv-project@linuxtesting.org, linux-kernel@vger.kernel.org,
	drbd-user@lists.linbit.com, Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH] drbd: add module_put() on error path in
	drbd_proc_open()
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Alexey,

Thanks a lot! I have put it into our tree.
http://git.drbd.org/gitweb.cgi?p=drbd-8.4.git

I intend to get it into the 3.10 merge window.

Best,
 Phil

> If single_open() fails in drbd_proc_open(), module refcount is left
> incremented. The patch adds module_put() on the error path.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
>  drivers/block/drbd/drbd_proc.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
> index 56672a6..30fe0a5 100644
> --- a/drivers/block/drbd/drbd_proc.c
> +++ b/drivers/block/drbd/drbd_proc.c
> @@ -313,8 +313,14 @@ static int drbd_seq_show(struct seq_file *seq, void *v)
> 
>  static int drbd_proc_open(struct inode *inode, struct file *file)
>  {
> -	if (try_module_get(THIS_MODULE))
> -		return single_open(file, drbd_seq_show, PDE(inode)->data);
> +	int err;
> +
> +	if (try_module_get(THIS_MODULE)) {
> +		err = single_open(file, drbd_seq_show, PDE(inode)->data);
> +		if (err)
> +			module_put(THIS_MODULE);
> +		return err;
> +	}
>  	return -ENODEV;
>  }
