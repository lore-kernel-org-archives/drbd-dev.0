Return-Path: <philipp.reisner@linbit.com>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C0FB2101E041
	for <drbd-dev@lists.linbit.com>; Mon, 18 Jun 2018 11:50:06 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id e16-v6so12976713wmd.0
	for <drbd-dev@lists.linbit.com>; Mon, 18 Jun 2018 02:50:06 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: johannes@johannesthoma.com
Date: Mon, 18 Jun 2018 11:44:35 +0200
Message-ID: <2869321.M3EdEsDoU1@fat-tyre>
In-Reply-To: <3455189.oDu6CKLEq0@fat-tyre>
References: <20180530153727.2334-1-johannes@johannesthoma.com>
	<3455189.oDu6CKLEq0@fat-tyre>
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

Ok, I realized that you based it on the other path you sent on May 22.

Thanks for both, both applied!

best regards,
 phil


Am Montag, 18. Juni 2018, 11:26:34 CEST schrieb Philipp Reisner:
> Hi Johannes,
>=20
> the patch does not apply to the current master. Can you find out why, or
> find out against which version/Git Hash this patch was created?
>=20
> best regards,
>  Phil
>=20
> Am Mittwoch, 30. Mai 2018, 17:37:27 CEST schrieb johannes@johannesthoma.c=
om:
> > From: Johannes Thoma <johannes@johannesthoma.com>
> >=20
> > On failing late in drbd_create_device() some kref_debug_put()'s
> > were missing, which lead to false positives on kref_debug_destroy().
> >=20
> > This patch adds the missing calls.
> >=20
> > Signed-off-by: Johannes Thoma <johannes@johannesthoma.com>
> > ---
> >=20
> >  drbd/drbd_main.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
> > index 04ec052..ba60e3b 100644
> > --- a/drbd/drbd_main.c
> > +++ b/drbd/drbd_main.c
> >=20
> > @@ -3762,11 +3762,14 @@ out_remove_peer_device:
> >  		kfree(peer_device);
> >  		kref_debug_put(&connection->kref_debug, 3);
> >  		kref_put(&connection->kref, drbd_destroy_connection);
> >=20
> > +		kref_debug_put(&device->kref_debug, 1);
> >=20
> >  	}
> >  	idr_remove(&resource->devices, vnr);
> >=20
> > +	kref_debug_put(&device->kref_debug, 1);
> >=20
> >  out_idr_remove_minor:
> >  	idr_remove(&drbd_devices, minor);
> >=20
> > +	kref_debug_put(&device->kref_debug, 1);
> >=20
> >  out_no_minor_idr:
> >  	if (locked)
> >  =09
> >  		spin_unlock_irq(&resource->req_lock);
> >=20
> > @@ -3787,6 +3790,9 @@ out_no_disk:
> >  	blk_cleanup_queue(q);
> > =20
> >  out_no_q:
> >  	kref_put(&resource->kref, drbd_destroy_resource);
> >=20
> > +	kref_debug_put(&resource->kref_debug, 4);
> > +		/* kref debugging wants an extra put, see has_refs() */
> > +	kref_debug_put(&device->kref_debug, 4);
> >=20
> >  	kref_debug_destroy(&device->kref_debug);
> >  	kfree(device);
> >  	return err;


=2D-=20
LINBIT | Keeping The Digital World Running

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.



