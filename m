Return-Path: <philipp.reisner@linbit.com>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
	[209.85.128.196])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 5484C1018D52
	for <drbd-dev@lists.linbit.com>; Mon, 18 Jun 2018 11:34:14 +0200 (CEST)
Received: by mail-wr0-f196.google.com with SMTP id k16-v6so16054149wro.0
	for <drbd-dev@lists.linbit.com>; Mon, 18 Jun 2018 02:34:14 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: johannes@johannesthoma.com
Date: Mon, 18 Jun 2018 11:26:34 +0200
Message-ID: <3455189.oDu6CKLEq0@fat-tyre>
In-Reply-To: <20180530153727.2334-1-johannes@johannesthoma.com>
References: <20180530153727.2334-1-johannes@johannesthoma.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] Added missing kref_debug_put()'s on failure
	path of drbd_create_device().
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

Hi Johannes,

the patch does not apply to the current master. Can you find out why, or
find out against which version/Git Hash this patch was created?

best regards,
 Phil

Am Mittwoch, 30. Mai 2018, 17:37:27 CEST schrieb johannes@johannesthoma.com:
> From: Johannes Thoma <johannes@johannesthoma.com>
>=20
> On failing late in drbd_create_device() some kref_debug_put()'s
> were missing, which lead to false positives on kref_debug_destroy().
>=20
> This patch adds the missing calls.
>=20
> Signed-off-by: Johannes Thoma <johannes@johannesthoma.com>
> ---
>  drbd/drbd_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
> index 04ec052..ba60e3b 100644
> --- a/drbd/drbd_main.c
> +++ b/drbd/drbd_main.c
> @@ -3762,11 +3762,14 @@ out_remove_peer_device:
>  		kfree(peer_device);
>  		kref_debug_put(&connection->kref_debug, 3);
>  		kref_put(&connection->kref, drbd_destroy_connection);
> +		kref_debug_put(&device->kref_debug, 1);
>  	}
>  	idr_remove(&resource->devices, vnr);
> +	kref_debug_put(&device->kref_debug, 1);
>=20
>  out_idr_remove_minor:
>  	idr_remove(&drbd_devices, minor);
> +	kref_debug_put(&device->kref_debug, 1);
>  out_no_minor_idr:
>  	if (locked)
>  		spin_unlock_irq(&resource->req_lock);
> @@ -3787,6 +3790,9 @@ out_no_disk:
>  	blk_cleanup_queue(q);
>  out_no_q:
>  	kref_put(&resource->kref, drbd_destroy_resource);
> +	kref_debug_put(&resource->kref_debug, 4);
> +		/* kref debugging wants an extra put, see has_refs() */
> +	kref_debug_put(&device->kref_debug, 4);
>  	kref_debug_destroy(&device->kref_debug);
>  	kfree(device);
>  	return err;


=2D-=20
LINBIT | Keeping The Digital World Running

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.



