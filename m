Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DE25F1057FDD
	for <drbd-dev@lists.linbit.com>; Fri,  5 May 2017 09:19:49 +0200 (CEST)
Received: by mail-wm0-f44.google.com with SMTP id w64so15916189wma.0
	for <drbd-dev@lists.linbit.com>; Fri, 05 May 2017 00:19:49 -0700 (PDT)
Date: Fri, 5 May 2017 09:19:45 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Message-ID: <20170505071945.GB6818@rck.sh>
References: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
	<1493928654-18768-4-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493928654-18768-4-git-send-email-Julia.Lawall@lip6.fr>
Cc: keescook@chromium.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 3/9] drbd: Drop unnecessary static
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

On Thu, May 04, 2017 at 10:10:48PM +0200, Julia Lawall wrote:
> Drop static on a local variable, when the variable is initialized before
> any use, on every possible execution path through the function.  The static
> has no benefit, and dropping it reduces the code size.
> 
> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @bad exists@
> position p;
> identifier x;
> type T;
> @@
> 
> static T x@p;
> ...
> x = <+...x...+>
> 
> @@
> identifier x;
> expression e;
> type T;
> position p != bad.p;
> @@
> 
> -static
>  T x@p;
>  ... when != x
>      when strict
> ?x = e;
> // </smpl>
> 
> The change in code size is indicates by the following output from the size
> command.
> 
> before:
>    text    data     bss     dec     hex filename
>   67299    2291    1056   70646   113f6 drivers/block/drbd/drbd_nl.o
> 
> after:
>    text    data     bss     dec     hex filename
>   67283    2291    1056   70630   113e6 drivers/block/drbd/drbd_nl.o
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  drivers/block/drbd/drbd_nl.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index 02255a0..ad0fcb4 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -2294,7 +2294,7 @@ static bool conn_ov_running(struct drbd_connection *connection)
>  static enum drbd_ret_code
>  check_net_options(struct drbd_connection *connection, struct net_conf *new_net_conf)
>  {
> -	static enum drbd_ret_code rv;
> +	enum drbd_ret_code rv;
>  	struct drbd_peer_device *peer_device;
>  	int i;

Yes, that already got dropped for drbd9 and is obviously correct for
in-tree drbd8.

Signed-off-by: Roland Kammerer <roland.kammerer@linbit.com>

Regards, rck
