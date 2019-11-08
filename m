Return-Path: <philipp.reisner@linbit.com>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 01D3C420342
	for <drbd-dev@lists.linbit.com>; Fri,  8 Nov 2019 11:51:41 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id z19so5709267wmk.3
	for <drbd-dev@lists.linbit.com>; Fri, 08 Nov 2019 02:51:41 -0800 (PST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, Jens Axboe <axboe@kernel.dk>
Date: Fri, 08 Nov 2019 11:46:00 +0100
Message-ID: <6906816.cRlsrm7Sor@fat-tyre>
In-Reply-To: <20191107074847.GA11695@mwanda>
References: <20191107074847.GA11695@mwanda>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Cc: linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] block: drbd: remove a stay unlock in
	__drbd_send_protocol()
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

Hi Dan,

yes, your patch it obviously correct. The comment you are
referring to is badly worded. We will remove it.

Jens,

are you taking this patch as it is?

best regards,
 Phil

Am Donnerstag, 7. November 2019, 08:48:47 CET schrieb Dan Carpenter:
> There are two callers of this function and they both unlock the mutex so
> this ends up being a double unlock.
>=20
> Fixes: 44ed167da748 ("drbd: rcu_read_lock() and rcu_dereference() for
> tconn->net_conf") Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Static analisys.  Not tested.  There is a comment about the lock next to
> the caller in drbd_nl.c that I didn't understand:
>=20
> drivers/block/drbd/drbd_nl.c
>   2509          crypto_free_shash(connection->integrity_tfm);
>   2510          connection->integrity_tfm =3D crypto.integrity_tfm;
>   2511          if (connection->cstate >=3D C_WF_REPORT_PARAMS &&
> connection->agreed_pro_version >=3D 100) 2512                  /* Do this
> without trying to take connection->data.mutex again.  */
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ What does th=
is
> mean?  We're already holding that lock.  We took it near the start of the
> function.
>=20
>   2513                  __drbd_send_protocol(connection, P_PROTOCOL_UPDAT=
E);
> 2514
>   2515          crypto_free_shash(connection->cram_hmac_tfm);
>   2516          connection->cram_hmac_tfm =3D crypto.cram_hmac_tfm;
>   2517
>   2518          mutex_unlock(&connection->resource->conf_update);
>   2519          mutex_unlock(&connection->data.mutex);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Unlocked here.
>=20
>  drivers/block/drbd/drbd_main.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_mai=
n.c
> index 5b248763a672..a18155cdce41 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -786,7 +786,6 @@ int __drbd_send_protocol(struct drbd_connection
> *connection, enum drbd_packet cm
>=20
>  	if (nc->tentative && connection->agreed_pro_version < 92) {
>  		rcu_read_unlock();
> -		mutex_unlock(&sock->mutex);
>  		drbd_err(connection, "--dry-run is not supported by peer");
>  		return -EOPNOTSUPP;
>  	}


=2D-=20
LINBIT | Keeping The Digital World Running

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.



