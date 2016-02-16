Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 313701056333
	for <drbd-dev@lists.linbit.com>; Tue, 16 Feb 2016 10:08:53 +0100 (CET)
Date: Tue, 16 Feb 2016 10:08:51 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Insu Yun <wuninsu@gmail.com>
Message-ID: <20160216090851.GS29699@soda.linbit>
References: <1455589585-7275-1-git-send-email-wuninsu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455589585-7275-1-git-send-email-wuninsu@gmail.com>
Cc: yeongjin.jang@gatech.edu, taesoo@gatech.edu, insu@gatech.edu,
	linux-kernel@vger.kernel.org, philipp.reisner@linbit.com,
	changwoo@gatech.edu, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: correctly handling failed
	crypto_alloc_hash
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

On Mon, Feb 15, 2016 at 09:26:25PM -0500, Insu Yun wrote:
> crypto_alloc_hash returns an error code, not NULL.

You are correct, of course. Was broken since its introduction
five years ago. Strange though, we have a helper function further
down in that file, and other, even much older, call sites as well,
which are doing the IS_ERR() correctly.
Apparently no-one ever requested a non-supported alg.

> Signed-off-by: Insu Yun <wuninsu@gmail.com>
> ---
>  drivers/block/drbd/drbd_receiver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index 1957fe8..9063462 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -3403,7 +3403,7 @@ static int receive_protocol(struct drbd_connection *connection, struct packet_in
>  		 */
>  
>  		peer_integrity_tfm = crypto_alloc_hash(integrity_alg, 0, CRYPTO_ALG_ASYNC);
> -		if (!peer_integrity_tfm) {
> +		if (IS_ERR(peer_integrity_tfm)) {
>  			drbd_err(connection, "peer data-integrity-alg %s not supported\n",
>  				 integrity_alg);
>  			goto disconnect;

Your patch is incomplete, though:
the first action in the "disconnect" cleanup path is
 crypto_free_hash(peer_integrity_tfm);
so we better make sure it is not trying to free an error pointer:

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index c097909..6054c53 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3376,7 +3376,8 @@ static int receive_protocol(struct drbd_connection *connection, struct packet_in
 		 */
 
 		peer_integrity_tfm = crypto_alloc_hash(integrity_alg, 0, CRYPTO_ALG_ASYNC);
-		if (!peer_integrity_tfm) {
+		if (IS_ERR(peer_integrity_tfm)) {
+			peer_integrity_tfm = NULL;
 			drbd_err(connection, "peer data-integrity-alg %s not supported\n",
 				 integrity_alg);
 			goto disconnect;

Thanks,

   Lars

