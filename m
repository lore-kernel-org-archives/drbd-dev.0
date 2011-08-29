Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8E86010556B3
	for <drbd-dev@lists.linbit.com>; Mon, 29 Aug 2011 13:42:13 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Pawel Jakub Dawidek <pjd@freebsd.org>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Date: Mon, 29 Aug 2011 13:42:04 +0200
References: <1314284934-17999-1-git-send-email-philipp.reisner@linbit.com>
	<1314284934-17999-17-git-send-email-philipp.reisner@linbit.com>
	<20110825180244.GA1697@garage.freebsd.pl>
In-Reply-To: <20110825180244.GA1697@garage.freebsd.pl>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201108291342.05003.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 016/118] drbd: Add read_requests tree
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Donnerstag, 25. August 2011, 20:02:44 schrieb Pawel Jakub Dawidek:
> On Thu, Aug 25, 2011 at 05:07:12PM +0200, Philipp Reisner wrote:
> > From: Andreas Gruenbacher <agruen@linbit.com>
> >=20
> > We do not do collision detection for read requests, but we still need to
> > look up the request objects when we receive a package over the network.
> > Using the same data structure for read and write requests results in
> > simpler code once the tl_hash and app_reads_hash tables are removed.
> >=20
> > Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
> > Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
> > ---
> >=20
> >  drivers/block/drbd/drbd_int.h  |    1 +
> >  drivers/block/drbd/drbd_main.c |    1 +
> >  drivers/block/drbd/drbd_req.c  |   13 ++++++++++---
> >  3 files changed, 12 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/block/drbd/drbd_int.h
> > b/drivers/block/drbd/drbd_int.h index 0583713..fe15319 100644
> > --- a/drivers/block/drbd/drbd_int.h
> > +++ b/drivers/block/drbd/drbd_int.h
> > @@ -1020,6 +1020,7 @@ struct drbd_conf {
> >=20
> >  	unsigned int tl_hash_s;
> >  =09
> >  	/* Interval tree of pending local write requests */
> >=20
> > +	struct rb_root read_requests;
> >=20
> >  	struct rb_root write_requests;
>=20
> Looks like the comment needs updating.

Ok, new edition of the patch:

=46rom dac1389ccc273b5486f2931c64c8e1672f233727 Mon Sep 17 00:00:00 2001
=46rom: Andreas Gruenbacher <agruen@linbit.com>
Date: Fri, 21 Jan 2011 17:18:39 +0100
Subject: [PATCH 016/118] drbd: Add read_requests tree

We do not do collision detection for read requests, but we still need to
look up the request objects when we receive a package over the network.
Using the same data structure for read and write requests results in
simpler code once the tl_hash and app_reads_hash tables are removed.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
=2D--
 drivers/block/drbd/drbd_int.h  |    3 ++-
 drivers/block/drbd/drbd_main.c |    1 +
 drivers/block/drbd/drbd_req.c  |   13 ++++++++++---
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 0583713..46a4332 100644
=2D-- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1019,7 +1019,8 @@ struct drbd_conf {
        struct hlist_head *tl_hash;
        unsigned int tl_hash_s;
=20
=2D       /* Interval tree of pending local write requests */
+       /* Interval tree of pending local requests */
+       struct rb_root read_requests;
        struct rb_root write_requests;
=20
        /* blocks to resync in this run [unit BM_BLOCK_SIZE] */
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 4d85838..c0ea5ba 100644
=2D-- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3473,6 +3473,7 @@ struct drbd_conf *drbd_new_device(unsigned int minor)
        /* no need to lock access, we are still initializing this minor dev=
ice. */
        if (!tl_init(mdev))
                goto out_no_tl;
+       mdev->read_requests =3D RB_ROOT;
        mdev->write_requests =3D RB_ROOT;
=20
        mdev->app_reads_hash =3D kzalloc(APP_R_HSIZE*sizeof(void *), GFP_KE=
RNEL);
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 593576f..d2a78c4 100644
=2D-- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -260,10 +260,15 @@ void _req_may_be_done(struct drbd_request *req, struc=
t bio_and_error *m)
=20
                /* remove the request from the conflict detection
                 * respective block_id verification hash */
=2D               if (!hlist_unhashed(&req->collision)) {
+               if (!drbd_interval_empty(&req->i)) {
+                       struct rb_root *root;
+
                        hlist_del(&req->collision);
=2D                       if (!drbd_interval_empty(&req->i))
=2D                               drbd_remove_interval(&mdev->write_request=
s, &req->i);
+                       if (rw =3D=3D WRITE)
+                               root =3D &mdev->write_requests;
+                       else
+                               root =3D &mdev->read_requests;
+                       drbd_remove_interval(root, &req->i);
                } else
                        D_ASSERT((s & (RQ_NET_MASK & ~RQ_NET_DONE)) =3D=3D =
0);
=20
@@ -332,6 +337,7 @@ static int _req_conflicts(struct drbd_request *req)
        struct hlist_head *slot;
=20
        D_ASSERT(hlist_unhashed(&req->collision));
+       D_ASSERT(drbd_interval_empty(&req->i));
=20
        if (!get_net_conf(mdev))
                return 0;
@@ -493,6 +499,7 @@ int __req_mod(struct drbd_request *req, enum drbd_req_e=
vent what,
                /* so we can verify the handle in the answer packet
                 * corresponding hlist_del is in _req_may_be_done() */
                hlist_add_head(&req->collision, ar_hash_slot(mdev, req->i.s=
ector));
+               drbd_insert_interval(&mdev->read_requests, &req->i);
=20
                set_bit(UNPLUG_REMOTE, &mdev->flags);
=20
=2D-=20
1.7.4.1

=2D-=20
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.
